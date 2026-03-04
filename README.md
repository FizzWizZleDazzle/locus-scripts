# locus-scripts

Math problem generation scripts for [Locus](https://locusmath.org). Fully standalone — clone this repo and generate problems without the factory backend.

## Pre-generated databases

Ready-to-use SQLite databases with 200,000+ problems are published as [GitHub Releases](https://github.com/FizzWizZleDazzle/locus-scripts/releases).

```bash
gh release download --repo FizzWizZleDazzle/locus-scripts -p '*.db'
```

### Working with the database

```python
import sqlite3, sys; sys.path.insert(0, "python")
from problem_utils import decompress_svg

conn = sqlite3.connect("problems-v1.db")
for row in conn.execute("SELECT * FROM problems LIMIT 10"):
    problem = dict(row)
    if problem["question_image"]:
        problem["question_image"] = decompress_svg(problem["question_image"])
    print(problem["question_latex"], "→", problem["answer_key"])
```

## Structure

```
src/               324+ generation scripts (.py, .jl)
python/            Python utilities
  problem_utils.py   shared helpers (problem builder, formatters, SymPy re-exports)
  svg_utils.py       SVG diagram builders (Diagram, Graph)
julia/             Julia project (Symbolics.jl CAS)
  Project.toml       runtime deps (Symbolics, Latexify, JSON, Random)
  src/
    ProblemUtils.jl  shared utilities for Julia scripts
    SvgUtils.jl      SVG diagram builders (DiagramObj, GraphObj)
  build/
    Project.toml     build deps (adds PackageCompiler)
    build_sysimage.jl
    precompile_workload.jl
run.sh             standalone runner (sets PYTHONPATH / --project)
```

## Quick Start

### Python scripts

```bash
# Run a single script
./run.sh src/algebra1_linear_equations_easy.py

# Or manually
PYTHONPATH=python python3 src/algebra1_linear_equations_easy.py
```

### Julia scripts

```bash
# First-time setup: install Julia packages
julia --project=julia -e 'using Pkg; Pkg.instantiate()'

# Run a script
./run.sh src/some_script.jl

# Batch: generate 5 problems
./run.sh src/some_script.jl --count 5
```

### Julia Sysimage (optional, speeds up startup)

Pre-built sysimages are published to GitHub Releases on every push to `julia/`:

```bash
# Download pre-built sysimage
gh release download sysimage-latest --repo FizzWizZleDazzle/locus-scripts -p 'sysimage.so' -D julia/

# Or build locally (~2 min)
julia --project=julia/build -e 'using Pkg; Pkg.instantiate()'
julia --project=julia/build julia/build/build_sysimage.jl
```

With the sysimage, Julia startup drops from ~3s to ~0.3s.

## Script API

### Python

```python
from problem_utils import *
from svg_utils import Diagram, Graph  # optional

def generate():
    n = randint(2, 7)
    coeff = nonzero(-12, 12)
    expr = coeff * x**n
    ans = diff(expr, x)
    return problem(
        question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
        answer=ans,
        difficulty=(1000, 1200),
        topic="calculus/derivatives",
        solution=steps(f"Apply power rule to ${latex(expr)}$", f"${latex(ans)}$"),
    )

emit(generate())
```

### Julia

```julia
include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

function generate()
    @variables x
    n = randint(2, 7)
    coeff = nonzero(-12, 12)
    expr = coeff * x^n
    ans = diff(expr, x)
    return problem(
        question="\\frac{d}{dx}\\left[$(tex(expr))\\right]",
        answer=ans,
        difficulty=(1000, 1200),
        topic="calculus/derivatives",
        solution=steps("Apply power rule to \$$(tex(expr))\$", "\$$(tex(ans))\$"),
    )
end

run_batch(generate)
```

## SVG Diagrams

Both Python and Julia provide SVG builders for geometry and graphing problems. SVGs use `currentColor` for dark-mode compatibility.

### Python: `Diagram` / `Graph`

```python
from svg_utils import Diagram, Graph

d = Diagram()
d.polygon([(0,0), (4,0), (2,3)], labels=['A', 'B', 'C'])
d.angle_arc((0,0), (4,0), (2,3), label='60°')
svg = d.render()

g = Graph(x_range=(-5, 5), y_range=(-5, 5))
g.plot(x**2 - 3)
svg = g.render()
```

### Julia: `DiagramObj` / `GraphObj`

```julia
d = DiagramObj()
polygon!(d, [(0,0), (4,0), (2,3)]; labels=["A", "B", "C"])
angle_arc!(d, (0,0), (4,0), (2,3); label="60°")
svg = render(d)

g = GraphObj(; x_range=(-5, 5), y_range=(-5, 5))
@variables x
plot!(g, x^2 - 3)
svg = render(g)
```

Pass the SVG to `problem(..., image=svg)` — it's auto-compressed for storage.

## License

MIT
