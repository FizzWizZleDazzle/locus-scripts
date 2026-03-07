#!/usr/bin/env julia
"""
Test script for SvgUtils.jl — exercises every new function and struct.
Run: julia --project=factory/backend/scripts/julia test_svg.jl
"""

push!(LOAD_PATH, joinpath(@__DIR__, "src"))
include(joinpath(@__DIR__, "src", "ProblemUtils.jl"))
using .ProblemUtils

passed = 0
failed = 0

macro test(name, expr)
    quote
        try
            result = $(esc(expr))
            if result
                global passed += 1
            else
                global failed += 1
                println("FAIL: ", $(esc(name)))
            end
        catch e
            global failed += 1
            println("ERROR: ", $(esc(name)), " — ", e)
        end
    end
end

# ========== DiagramObj basics ==========
println("--- DiagramObj ---")

d = DiagramObj()
polygon!(d, [(0,0), (4,0), (2,3)]; labels=["A", "B", "C"])
angle_arc!(d, (0,0), (4,0), (2,3); label="60°")
right_angle!(d, (4,0), (0,0), (4,3))
segment_label!(d, (0,0), (4,0), "4 cm")
tick_marks!(d, (0,0), (2,3); count=2)
text!(d, 2, -0.5, "base")
point!(d, 2, 1.5; label="M")
line!(d, (0,0), (4,3); dashed=true)
arrow!(d, (2,3), (4,3))
circle!(d, (2, 1.5), 0.5; fill="#3b82f6")
arc!(d, (2, 1.5), 1.0, 0, 180)
svg1 = render(d)
@test "DiagramObj renders SVG" startswith(svg1, "<svg")
@test "DiagramObj has polygon" contains(svg1, "<polygon")
@test "DiagramObj has arrow marker" contains(svg1, "marker")
@test "DiagramObj has text" contains(svg1, "base")

# ========== DiagramObj styling kwargs ==========
println("--- DiagramObj styling ---")

d2 = DiagramObj()
line!(d2, (0,0), (5,0); stroke_width=3, color="#ff0000", opacity=0.5)
polygon!(d2, [(0,0), (3,0), (1.5,2)]; fill="#00ff00", stroke_width=1, font_size=16, labels=["X","Y","Z"])
circle!(d2, (1,1), 0.5; stroke_width=3, color="#0000ff")
arc!(d2, (2,2), 1, 0, 90; stroke_width=3)
point!(d2, 0, 0; color="#ef4444", font_size=15, label="O")
angle_arc!(d2, (0,0), (3,0), (1.5,2); label="α", font_size=14)
segment_label!(d2, (0,0), (3,0), "5"; font_size=15, color="#10b981")
text!(d2, 1, -1, "styled"; font_size=16, color="#f59e0b")
svg2 = render(d2)
@test "Styling: custom color in line" contains(svg2, "#ff0000")
@test "Styling: custom stroke-width" contains(svg2, "stroke-width=\"3\"")
@test "Styling: opacity" contains(svg2, "stroke-opacity=\"0.5\"")

# ========== DiagramObj convenience primitives ==========
println("--- Convenience primitives ---")

d3 = DiagramObj()
rect!(d3, 0, 0, 4, 3; fill="#3b82f6")
ellipse!(d3, (2, 1.5), 1.5, 1.0; fill="#ef4444")
midpoint_label!(d3, (0,0), (4,0), "mid")
distance_marker!(d3, (0,3), (4,3); label="4 cm", offset=16)
parallel_marks!(d3, (0,0), (0,3); count=2)
svg3 = render(d3)
@test "rect! renders polygon" contains(svg3, "<polygon")
@test "ellipse! renders" contains(svg3, "<ellipse")
@test "distance_marker! renders label" contains(svg3, "4 cm")

# ========== GraphObj basics ==========
println("--- GraphObj ---")

@variables x
g = GraphObj(; x_range=(-5, 5), y_range=(-5, 5))
plot!(g, x^2 - 3; name="parabola")
point!(g, 0, -3; label="vertex")
vline!(g, 2)
hline!(g, -1)
svg4 = render(g)
@test "GraphObj renders SVG" startswith(svg4, "<svg")
@test "GraphObj has polyline" contains(svg4, "<polyline")
@test "GraphObj has grid class" contains(svg4, "class=\"g\"")

# ========== GraphObj extensions ==========
println("--- GraphObj extensions ---")

g2 = GraphObj(; x_range=(-3, 3), y_range=(-3, 3), grid_step=0.5,
               axis_labels=("x", "y"), show_legend=true)
plot!(g2, x^2; name="x²")
plot!(g2, 2x - 1; dashed=true, name="2x-1")
asymptote!(g2, -2.5)
label!(g2, 1, 1, "intersection")
svg5 = render(g2)
@test "GraphObj grid_step 0.5 many gridlines" count("class=\"g\"", svg5) > 10
@test "GraphObj axis labels" contains(svg5, ">x<")
@test "GraphObj legend" contains(svg5, "x²")
@test "GraphObj asymptote label" contains(svg5, "x = -2.5")
@test "GraphObj label!" contains(svg5, "intersection")

# ========== GraphObj parametric ==========
println("--- Parametric plots ---")

g3 = GraphObj(; x_range=(-2, 2), y_range=(-2, 2))
plot_parametric!(g3, t -> (cos(t), sin(t)), 0, 2π; name="circle")
svg6 = render(g3)
@test "Parametric renders polyline" contains(svg6, "<polyline")

# ========== GraphObj sub-pixel precision ==========
println("--- Sub-pixel precision ---")

g4 = GraphObj(; x_range=(-1, 1), y_range=(-1, 1))
plot!(g4, x^3)
svg7 = render(g4)
# Should NOT have Int-rounded coordinates like "35," without decimal
# polyline points should have decimal points
polyline_match = match(r"<polyline points=\"([^\"]+)\"", svg7)
@test "Sub-pixel: polyline exists" polyline_match !== nothing
if polyline_match !== nothing
    pts = polyline_match.captures[1]
    @test "Sub-pixel: has decimal coords" contains(pts, ".")
end

# ========== GraphObj fill_between ==========
println("--- fill_between ---")

g5 = GraphObj(; x_range=(-3, 3), y_range=(-5, 10))
plot!(g5, x^2)
fill_between!(g5, x^2; color="#3b82f6", opacity=0.2)
svg8 = render(g5)
@test "fill_between renders polygon" contains(svg8, "<polygon")
@test "fill_between sub-pixel" !contains(svg8, r"points=\"\d+,\d+ ")  # shouldn't be pure ints

# ========== NumberLine ==========
println("--- NumberLine ---")

nl = NumberLine(; x_range=(-5, 5))
closed_point!(nl, -3)
open_point!(nl, 2)
shade!(nl, -3, 2)
shade_left!(nl, -3)
shade_right!(nl, 2)
svg9 = render(nl)
@test "NumberLine renders SVG" startswith(svg9, "<svg")
@test "NumberLine has marker defs" contains(svg9, "<defs>")
@test "NumberLine has tick labels" contains(svg9, "text-anchor=\"middle\"")

# ========== VennDiagram ==========
println("--- VennDiagram ---")

vd2 = VennDiagram(; sets=2)
label_set!(vd2, 1, "A")
label_set!(vd2, 2, "B")
label_region!(vd2, [1], "3")
label_region!(vd2, [2], "7")
label_region!(vd2, [1, 2], "5")
svg10 = render(vd2)
@test "Venn2 renders SVG" startswith(svg10, "<svg")
@test "Venn2 has 2 circles" count("<circle", svg10) == 2
@test "Venn2 has set labels" contains(svg10, ">A<")

vd3 = VennDiagram(; sets=3)
label_set!(vd3, 1, "X")
label_set!(vd3, 2, "Y")
label_set!(vd3, 3, "Z")
label_region!(vd3, [1, 2, 3], "1")
svg11 = render(vd3)
@test "Venn3 renders SVG" startswith(svg11, "<svg")
@test "Venn3 has 3 circles" count("<circle", svg11) == 3

# ========== BarChart ==========
println("--- BarChart ---")

bc = BarChart(; width=300, height=200)
bar!(bc, "Mon", 5)
bars!(bc, ["Tue", "Wed", "Thu"], [8, 3, 6])
svg12 = render(bc)
@test "BarChart renders SVG" startswith(svg12, "<svg")
@test "BarChart has rects" count("<rect", svg12) >= 4
@test "BarChart has category labels" contains(svg12, "Mon")
@test "BarChart has value labels" contains(svg12, ">5<")

# ========== PieChart ==========
println("--- PieChart ---")

pc = PieChart(; width=200, height=200)
slice!(pc, "Red", 30)
slice!(pc, "Blue", 50)
slice!(pc, "Green", 20)
svg13 = render(pc)
@test "PieChart renders SVG" startswith(svg13, "<svg")
@test "PieChart has 3 paths" count("<path", svg13) == 3
@test "PieChart has labels" contains(svg13, "Red")

# ========== unit_circle ==========
println("--- unit_circle ---")

svg14 = unit_circle(; angles=[0, 30, 45, 60, 90], show_coordinates=true, highlight=45)
@test "unit_circle renders SVG" startswith(svg14, "<svg")
@test "unit_circle has circle" contains(svg14, "<circle")
@test "unit_circle has angle labels" contains(svg14, "45°")

svg15 = unit_circle(; angles=[0, 90, 180, 270], show_coordinates=false)
@test "unit_circle no-coords renders" startswith(svg15, "<svg")

# ========== Compression roundtrip ==========
println("--- Compression ---")

for (name, svg) in [("diagram", svg1), ("graph", svg4), ("numberline", svg9),
                     ("venn", svg10), ("barchart", svg12), ("piechart", svg13)]
    compressed = compress_svg(svg)
    decompressed = decompress_svg(compressed)
    @test "Compression roundtrip: $(name)" decompressed == svg
    @test "Compressed smaller: $(name)" length(compressed) < length(svg)
end

# ========== Empty renders ==========
println("--- Edge cases ---")

d_empty = DiagramObj()
@test "Empty DiagramObj renders" render(d_empty) == """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""

bc_empty = BarChart()
@test "Empty BarChart renders" startswith(render(bc_empty), "<svg")

pc_empty = PieChart()
@test "Empty PieChart renders" startswith(render(pc_empty), "<svg")

# ========== Summary ==========
println()
println("=" ^ 40)
println("Results: $(passed) passed, $(failed) failed")
println("=" ^ 40)

exit(failed > 0 ? 1 : 0)
