module Replicate

    using Mustache
    import Pkg

    export hello, domath

    """
        hello(who::String)

    Return "Hello, `who`".
    """
    hello(who::String) = "Hello, $who"

    """
        domath(x::Number)

    Return `x + 5`.
    """
    domath(x::Number) = x + 5

    """
        bootstrap(gh_user::String,pkgname::String; path::String = joinpath(@__DIR__,"..",".."))

    Creates a new julia package using the current package as a template. This function
    will replace write a full julia package, including `tests` and `docs` to folder `path` - defaults to 
    the directory below the root of this repo.

    ## Details

    copies also:
    * `.github/worklows/ci.yml` setup to run tests and build docs
    * `.gitignore` 
    * `docs` Project.toml file for Documenter.jl

    """
    function bootstrap(gh_user::String,pkgname::String; path::String = joinpath(@__DIR__,"..",".."))
        if !contains(pkgname,".jl") error("please supply pkgname.jl with .jl") end
        @info "We'll create your package $pkgname now"
        modname = split(pkgname,".")[1]
        pkgpath = joinpath(path,modname)

        tpl_src = mt"""
            module {{name}}
            export hello, domath

            \"\"\"
                hello(who::String)

            Return "Hello, `who`".
            \"\"\"
            hello(who::String) = "Hello, $who"

            \"\"\"
                domath(x::Number)

            Return `x + 5`.
            \"\"\"
            domath(x::Number) = x + 5

            end
            """

        src = render(tpl_src, Dict("name" => modname))

        tpl_test = mt"""
            using Test, {{name}}

            @test hello("Julia") == "Hello, Julia"
            @test domath(2.0) ≈ 7.0
            """
        
        test = render(tpl_test, Dict("name" => modname))

        tpl_make = mt"""
            push!(LOAD_PATH,"../src/")
            using Documenter, {{name}}

            makedocs(modules = [{{name}}], sitename = "{{name}}.jl")

            deploydocs(repo = "github.com/{{user}}/{{name}}.jl.git", devbranch = "main")
            """
        
        makejl = render(tpl_make, Dict("name" => modname, "user" => gh_user))

        tpl_docs = mt"""
            # My Replication of xyz

            > This replication study was part of my evaluation for the course [Numerical Methods](https://floswald.github.io/NumericalMethods/) at SciencesPo Paris in Spring 2021

            In this replication study, we do ...

            ```@autodocs
            Modules = [{{name}}]
            ```


            end
            """

        docs = render(tpl_docs, Dict("name" => modname))
        # return (src = src, test = test, makejl = makejl, docs = docs)

        @info "Writing source code for new package $pkgname to folder $pkgpath"
        Pkg.generate(pkgpath)
        # dirs = [joinpath(path,"src"),joinpath(path,"test"),joinpath(path,"docs","src")]
        paths = [joinpath(pkgpath,"src",pkgname),joinpath(pkgpath,"test","runtests.jl"),joinpath(pkgpath,"docs","make.jl"),
                joinpath(pkgpath,"docs","src","index.md")]
        files = Dict(zip(paths, [src, test, makejl, docs]))

        # create directories
        mkpath(joinpath(pkgpath,"docs","src"))
        mkpath(joinpath(pkgpath,"test"))

        # return files

        # write files
        for (k,v) in files
            open(k, "w") do io
                print(io, v)
            end
        end

        @info "copying .github/workflow and other scaffold code"

        Pkg.activate(joinpath(pkgpath,"test"))
        Pkg.add("Test")

        root = joinpath(@__DIR__,"..")
        cp(joinpath(root,".gitignore"), joinpath(pkgpath,".gitignore"))
        mkpath(joinpath(pkgpath,".github","workflows"))
        cp(joinpath(root,".github","workflows","ci.yml"), joinpath(pkgpath,".github","workflows","ci.yml"))
        cp(joinpath(root,"docs","Project.toml"), joinpath(pkgpath,"docs","Project.toml"))

        @info "done."

    end

end # module


