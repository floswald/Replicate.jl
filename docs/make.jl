push!(LOAD_PATH,"../src/")
using Documenter, Replicate

makedocs(modules = [Replicate], sitename = "Replicate.jl")

deploydocs(repo = "github.com/floswald/Replicate.jl.git", devbranch = "main")
