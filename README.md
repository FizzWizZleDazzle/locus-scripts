# locus-scripts

Math problem generation scripts for [Locus](https://locusmath.org).

## Pre-generated databases

Ready-to-use SQLite databases with 200,000+ problems are published as [GitHub Releases](https://github.com/FizzWizZleDazzle/locus-scripts/releases).

```bash
# Download the latest release
gh release download --repo FizzWizZleDazzle/locus-scripts -p '*.db'

# Or a specific version
gh release download problems-v1 --repo FizzWizZleDazzle/locus-scripts -p '*.db'
```

## Structure

```
src/               # 324 generation scripts (easy/medium/hard per topic)
problem_utils.py   # shared helpers (problem builder, formatters, SymPy re-exports)
svg_utils.py       # SVG diagram builders (Diagram, Graph)
```

## Usage

Each script in `src/` prints a single JSON problem to stdout:

```bash
cd src
python3 algebra1_linear_equations_easy.py
```

Scripts import shared utilities from the repo root:

```python
from problem_utils import *
from svg_utils import Diagram, Graph  # optional
```

Set `PYTHONPATH` to this repo's root so the imports resolve:

```bash
PYTHONPATH=/path/to/locus-scripts python3 src/algebra1_linear_equations_easy.py
```

## License

MIT
