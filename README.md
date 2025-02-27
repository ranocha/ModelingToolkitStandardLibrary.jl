# ModelingToolkitStandardLibrary.jl

[![Join the chat at https://julialang.zulipchat.com #sciml-bridged](https://img.shields.io/static/v1?label=Zulip&message=chat&color=9558b2&labelColor=389826)](https://julialang.zulipchat.com/#narrow/stream/279055-sciml-bridged)
[![Global Docs](https://img.shields.io/badge/docs-SciML-blue.svg)](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/)

[![codecov](https://codecov.io/gh/SciML/ModelingToolkitStandardLibrary.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/SciML/ModelingToolkitStandardLibrary.jl)
[![Build Status](https://github.com/SciML/ModelingToolkitStandardLibrary.jl/workflows/CI/badge.svg)](https://github.com/SciML/ModelingToolkitStandardLibrary.jl/actions?query=workflow%3ACI)

[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor%27s%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
[![SciML Code Style](https://img.shields.io/static/v1?label=code%20style&message=SciML&color=9558b2&labelColor=389826)](https://github.com/SciML/SciMLStyle)

The ModelingToolkit Standard Library is a standard library of components to model the world and beyond.

![](https://user-images.githubusercontent.com/1814174/172000112-3579f5cf-c370-48c2-8047-558fbc46aeb6.png)

## Installation

Assuming that you already have Julia correctly installed, it suffices to import
ModelingToolkitStandardLibrary.jl in the standard way:

```julia
import Pkg;
Pkg.add("ModelingToolkitStandardLibrary");
```

## Tutorials and Documentation

For information on using the package,
[see the stable documentation](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/). Use the
[in-development documentation](https://docs.sciml.ai/ModelingToolkitStandardLibrary/dev/) for the version of
the documentation, which contains the unreleased features.

## Libraries

The following are the constituant libraries of the ModelingToolkit Standard Library.

  - [Basic Blocks](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/API/blocks/)
  - [Mechanical Components](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/API/mechanical/)
  - [Electrical Components](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/API/electrical/)
  - [Magnetic Components](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/API/magnetic/)
  - [Thermal Components](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/API/thermal/)

## Example

The following is the [RC Circuit Demonstration](https://docs.sciml.ai/ModelingToolkitStandardLibrary/stable/tutorials/rc_circuit/):

```julia
using ModelingToolkit, OrdinaryDiffEq, Plots
using ModelingToolkitStandardLibrary.Electrical
using ModelingToolkitStandardLibrary.Blocks: Constant

R = 1.0
C = 1.0
V = 1.0
@variables t
@named resistor = Resistor(R = R)
@named capacitor = Capacitor(C = C)
@named source = Voltage()
@named constant = Constant(k = V)
@named ground = Ground()

rc_eqs = [connect(constant.output, source.V)
          connect(source.p, resistor.p)
          connect(resistor.n, capacitor.p)
          connect(capacitor.n, source.n, ground.g)]

@named rc_model = ODESystem(rc_eqs, t,
                            systems = [resistor, capacitor, constant, source, ground])
sys = structural_simplify(rc_model)
prob = ODEProblem(sys, Pair[], (0, 10.0))
sol = solve(prob, Tsit5())
plot(sol, idxs = [capacitor.v, resistor.i],
     title = "RC Circuit Demonstration",
     labels = ["Capacitor Voltage" "Resistor Current"])
savefig("plot.png")
```

![](https://user-images.githubusercontent.com/1814174/164912983-c3f73628-0e19-4e42-b085-4f62ba6f23d1.png)
