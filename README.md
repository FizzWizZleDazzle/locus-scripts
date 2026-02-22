# locus-scripts

Math problem generation scripts for [Locus](https://locusmath.org).

## Structure

```
src/           # 150 generation scripts (one per topic/difficulty)
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
