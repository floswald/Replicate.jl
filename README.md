# Starter package for Replication Study

<!-- [![](https://img.shields.io/badge/docs-stable-blue.svg)](https://floswald.github.io/Replicate.jl/stable) -->
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://floswald.github.io/Replicate.jl/dev)

GitHub Actions : [![Build Status](https://github.com/floswald/Replicate.jl/workflows/CI/badge.svg)](https://github.com/floswald/Replicate.jl/actions?query=workflow%3ACI+branch%3Amaster)


[![Coverage Status](https://coveralls.io/repos/floswald/Replicate.jl/badge.svg?branch=master)](https://coveralls.io/r/floswald/Replicate.jl?branch=master)
[![codecov.io](http://codecov.io/github/floswald/Replicate.jl/coverage.svg?branch=master)](http://codecov.io/github/floswald/Replicate.jl?branch=master)


This repo is the starter kit for your replication study for the [Numerical Methods](https://floswald.github.io/NumericalMethods/) course. Please check back with the requirements on the [course website](https://floswald.github.io/NumericalMethods/#term_project)

## Automatic Setup

1. clone this repo to your computer. *clone*, not *fork*. Let's say you clone it into your home directory:
    ```
    cd
    git clone https://github.com/floswald/Replicate.jl Replicate
    ```
2. choose a suitable name for your replication package. Some reference to the original author's name is probably a good idea. I will call it `your_package_name` for now. 
4. Open `~/Replicate` in VScode
5. Do this:
    ```
    ] 
    activate .
    instantiate .
    ```
6. Then, back in julia command mode
    ```
    using Replicate
    Replicate.bootstrap("your_github_user","your_package_name.jl")
    ```
    You should then see something like this:
    ``` 
    Replicate.bootstrap("pinkie","Cool.jl")
    [ Info: We'll create your package Cool.jl now
    [ Info: Writing source code for new package Cool.jl to folder /Users/74097/git/Replicate.jl/src/../../Cool
    Generating  project Cool:
        ~/git/Cool/Project.toml
        ~/git/Cool/src/Cool.jl
    [ Info: copying .github/workflow and other scaffold code
    Activating new environment at `~/git/Cool/test/Project.toml`
    Resolving package versions...
    Updating `~/git/Cool/test/Project.toml`
    [8dfed614] + Test
    Updating `~/git/Cool/test/Manifest.toml`
    [2a0f44e3] + Base64
    [8ba89e20] + Distributed
    [b77e0a4c] + InteractiveUtils
    [56ddb016] + Logging
    [d6f4376e] + Markdown
    [9a3f8284] + Random
    [9e88b42a] + Serialization
    [6462fe0b] + Sockets
    [8dfed614] + Test
    [ Info: done.
    ```
7. Open a new VScode window and open the folder `~/your_package_name`.
8. Start working on it!
9. You can deleted `~/Replicate` now.



## How to setup on your computer MANUALLY

1. clone this repo to your computer. *clone*, not *fork*.
2. choose a suitable name for your replication package. Some reference to the original author's name is probably a good idea. I will call it `your_package_name` for now.
3. start julia in your home directoy. go into package mode with `]`, then type `generate your_package_name`
4. From `~/your_package_name/Project.toml` copy the first four lines and replace the four lines below in the file [`Project.toml`](Project.toml) at the root of *this* repo:
    ```
    name = "Replicate"
    uuid = "e32155d0-cde9-4b54-81dd-56ea588185fd"
    authors = ["florian oswald <florian.oswald@gmail.com>"]
    version = "0.1.0"
    ```
5. delete the folder `your_package_name` in your home directory.
5. In *this repo*, change all occurences of `Replicate` in `src` and `test` with `your_package_name`
6. Change the name of the folder containing *this repo* to `your_package_name`.

## How to set up local documentation

1. Our documentation lives in folder [`docs/`](docs)
2. You can edit the file [`docs/index.md`](docs/index.md) and of course add further `.md` pages. Check the Documenter.jl website on all the details.
3. To build the documentation locally:
    ```
    cd docs  # go into the docs folder
    julia --project=. make.jl   # type this in your terminal
    ```

    you should see this output:
    
    ```
    [ Info: SetupBuildDirectory: setting up build directory.
    [ Info: Doctest: running doctests.
    [ Info: ExpandTemplates: expanding markdown templates.
    [ Info: CrossReferences: building cross-references.
    [ Info: CheckDocument: running document checks.
    [ Info: Populate: populating indices.
    [ Info: RenderDocument: rendering document.
    [ Info: HTMLWriter: rendering HTML pages.
    ??? Warning: Documenter could not auto-detect the building environment Skipping deployment.
    ??? @ Documenter ~/.julia/packages/Documenter/6vUwN/src/deployconfig.jl:75
    ```
4. There is now a new folder `docs/build` which contains the produced documentation. **never commit** this folder to git!
5. Look at the docs by typing in folder `docs`
    ```
    open build/index.html
    ```
    or by just double clicking on this html file in your file browser.



## How to setup up online documentation

1. Create a repo on github.com called `your_package_name.jl`. (the `.jl` is important!)
2. ~Change the relevant entries in `docs/make.jl` by replacing `Replicate.jl` with your package name.~ (only relevant if you did not use the automatic setup)
3. Open the folder `your_package_name` in VScode and start julia.
4. Activate the package in `]` mode by typing `activate .`
5. type
    ```
    using DocumenterTools
    using your_package_name  # this will work only if you activated your project (see 4.)
    DocumenterTools.genkeys(user="MyUser", repo="git@github.com:MyUser/MyPackage.jl.git")
    ```
    which will return two long encrypted strings
5. Go to https://github.com/your_user/your_package_name.jl/settings/keys and click _add deploy key_ . call it `DOCUMENTER_PUBLIC` and paste the first string into it, tick _read/write access_
6. go to https://github.com/your_user/your_package_name.jl/settings/secrets/actions and click *new repository secret*
7. Give as *Secrete name*: `DOCUMENTER_KEY`, and paste the second long string into it.
8. Prepare commit. For example
    ```
    cd your_package_name
    git init
    git add .  # adds everyting
    git commit -m 'your_package_name first commit'
    git branch -M main
    ```
9. add a remote:
    ```
    git remote add origin https://github.com/your_user/your_package_name.jl  # adds your remote
    ```
10. push: `git push -u origin main`
11. Wait until the machines at github actions finished testing and deploying your website. click on the blue badge to see your live docs!
12. If you want to _avoid building the docs_ for a given commit, just include `[skip docs]` in your git commit message.
13. If you want to _avoid running the unit tests_ for a given commit, just include `[skip ci]` in your git commit message.

