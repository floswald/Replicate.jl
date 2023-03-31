# Starter package for Replication Study

This repo is the starter kit for your replication study for the [Numerical Methods](https://floswald.github.io/NumericalMethods/) course. Please check back with the requirements on the [course website](https://floswald.github.io/NumericalMethods/#term_project)

## Automatic Setup with `PkgTemplates.jl`

1. Make sure you have a working `git` setup on your computer and an active account on Github.com:
    ```
    # type ; to go into shell mode
    shell> git config --global user.name
    Florian Oswald

    shell> git config --global user.email
    florian.oswald@gmail.com

    # if those return nothing, set with
    git config --global user.name "Mona Lisa"
    ```
2. clone this repo to your computer. *clone*, not *fork*. Let's say you clone it into your home directory under the name `Replicate`, like so:
    ```
    cd
    git clone https://github.com/floswald/Replicate.jl Replicate
    ```
3. choose a suitable name for your replication package. Some reference to the original author's/paper's name is probably a good idea. I will call it `your_package_name` for now. 
4. Open `~/Replicate` in VScode
5. Do this:
    ```
    ] 
    activate .
    instantiate
    ```
6. Then, back in julia command mode
    ```
    include("template.jl")
    ```
7. Create your template with
    ```
    my_template = make_template(your_gh_user,your_location)
    ```
    where `your_gh_user` is your github.com username and `your_location` is the directory on your computer where you want to create the new package (defaults to your home at `"~/"`). For example, I used it like so:
    ```
    julia> my_template = make_template("floswald", "/Users/floswald/SomeFolder")
    ```
8. Choose your package name, and create it!
    ```
    my_template("MyNewPackage")
    ```
9.  You should see something like this:
    ```
    julia> my_template("MyNewPackage")
    [ Info: Running prehooks
    [ Info: Running hooks
    Activating project at `~/SomeFolder/MyNewPackage`
        Updating registry at `~/.julia/registries/General.toml`
    No Changes to `~/SomeFolder/MyNewPackage/Project.toml`
    No Changes to `~/SomeFolder/MyNewPackage/Manifest.toml`
    Precompiling environment...
    1 dependency successfully precompiled in 1 seconds
    Activating project at `~/Replicate`
    Activating new project at `~/SomeFolder/MyNewPackage/docs`
    Resolving package versions...
        Updating `~/SomeFolder/MyNewPackage/docs/Project.toml`
    [e30172f5] + Documenter v0.27.24
        Updating `~/SomeFolder/MyNewPackage/docs/Manifest.toml`
    [a4c015fc] + ANSIColoredPrinters v0.0.1
    [ffbed154] + DocStringExtensions v0.9.3
    [e30172f5] + Documenter v0.27.24
    [b5f81e59] + IOCapture v0.2.2
    [682c06a0] + JSON v0.21.3
    [69de0a69] + Parsers v2.5.8
    [21216c6a] + Preferences v1.3.0
    [66db9d55] + SnoopPrecompile v1.0.3
    [2a0f44e3] + Base64
    [ade2ca70] + Dates
    [b77e0a4c] + InteractiveUtils
    [76f85450] + LibGit2
    [56ddb016] + Logging
    [d6f4376e] + Markdown
    [a63ad114] + Mmap
    [ca575930] + NetworkOptions v1.2.0
    [de0858da] + Printf
    [3fa0cd96] + REPL
    [9a3f8284] + Random
    [ea8e919c] + SHA v0.7.0
    [9e88b42a] + Serialization
    [6462fe0b] + Sockets
    [fa267f1f] + TOML v1.0.3
    [8dfed614] + Test
    [4ec0a83e] + Unicode
    Resolving package versions...
        Updating `~/SomeFolder/MyNewPackage/docs/Project.toml`
    [4689695f] + MyNewPackage v1.0.0-DEV `..`
        Updating `~/SomeFolder/MyNewPackage/docs/Manifest.toml`
    [4689695f] + MyNewPackage v1.0.0-DEV `..`
    Activating project at `~/Replicate`
    [ Info: Running posthooks
    [ Info: New package is at /Users/floswald/SomeFolder/MyNewPackage
    ```
9. You can `Cmd+click` on this 👆 link to start working on your new package now in VSCode!
10. Finally, you need to create a repository called `MyNewPackage.jl` (don't forget the `.jl`!) on `github.com`.
11. After that is done, you can immediately from the console of your new package do
    ```
    git push -u origin main
    ```
    (this works only if there are some commits to push.)
12. Notice that this will run your tests in `test` as well as build the package documentation from the doc strings you have added to your functions.
13. You need to tell the github repo to deploy the docs from the `gh-pages` branch. I did on on this website https://github.com/floswald/MyNewPackage.jl/settings/pages (select _deploy from branch_ and then select the _gh-pages_ branch).
14. After a couple of minutes, you should be able to view your documentation online under your user space on github spaces, i.e. for me the repo looks like [this](https://github.com/floswald/MyNewPackage.jl) and the docs look like [that](https://floswald.github.io/MyNewPackage.jl/dev/). Notice that only the `dev` version of the docs is deployed.