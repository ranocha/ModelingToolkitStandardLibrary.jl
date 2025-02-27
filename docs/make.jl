using Documenter, ModelingToolkitStandardLibrary
using ModelingToolkitStandardLibrary.Blocks
using ModelingToolkitStandardLibrary.Mechanical
using ModelingToolkitStandardLibrary.Mechanical.Rotational
using ModelingToolkitStandardLibrary.Magnetic
using ModelingToolkitStandardLibrary.Magnetic.FluxTubes
using ModelingToolkitStandardLibrary.Electrical
using ModelingToolkitStandardLibrary.Thermal

cp("./docs/Manifest.toml", "./docs/src/assets/Manifest.toml", force = true)
cp("./docs/Project.toml", "./docs/src/assets/Project.toml", force = true)

ENV["GKSwstype"] = "100"

include("pages.jl")

makedocs(sitename = "ModelingToolkitStandardLibrary.jl",
         authors = "Julia Computing",
         clean = true,
         doctest = false,
         linkcheck = true,
         strict = [
             :linkcheck,
             :doctest,
             :example_block,
         ],
         modules = [ModelingToolkitStandardLibrary,
             ModelingToolkitStandardLibrary.Blocks,
             ModelingToolkitStandardLibrary.Mechanical,
             ModelingToolkitStandardLibrary.Mechanical.Rotational,
             ModelingToolkitStandardLibrary.Magnetic,
             ModelingToolkitStandardLibrary.Magnetic.FluxTubes,
             ModelingToolkitStandardLibrary.Electrical,
             ModelingToolkitStandardLibrary.Thermal],
         format = Documenter.HTML(assets = ["assets/favicon.ico"],
                                  canonical = "https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/"),
         pages = pages)

deploydocs(repo = "github.com/SciML/ModelingToolkitStandardLibrary.jl";
           push_preview = true)
