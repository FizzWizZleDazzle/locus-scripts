#=
SVG diagram builders for geometry and graphing problems.
Pure-Julia — manual SVG string construction, no external graphics libraries.

Structs:
  DiagramObj  — geometry diagrams (polygons, angles, circles, etc.)
  GraphObj    — function plots on a coordinate grid
  NumberLine  — number line with points and shading
  VennDiagram — overlapping circles for set theory
  BarChart    — vertical bar chart with auto-scaled y-axis
  PieChart    — pie/donut chart with arc paths

All produce compact, dark-mode-compatible SVG strings using currentColor.
=#

include(joinpath(@__DIR__, "svg", "core.jl"))       # _BBox, _CoordTransform, markers, palette
include(joinpath(@__DIR__, "svg", "diagram.jl"))     # DiagramObj + render
include(joinpath(@__DIR__, "svg", "graph.jl"))       # GraphObj + render
include(joinpath(@__DIR__, "svg", "numberline.jl"))  # NumberLine + render
include(joinpath(@__DIR__, "svg", "charts.jl"))      # VennDiagram, BarChart, PieChart + render
include(joinpath(@__DIR__, "svg", "unit_circle.jl")) # unit_circle()
