# geometry - surface_area (competition)
# Generated: 2026-03-08T20:10:12.139029

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/surface_area")
    
    # Generate a complex polyhedral surface area problem at Olympiad/Research level
    # We'll create a truncated pyramid (frustum) with a twist: remove several smaller pyramids from vertices
    
    # Base dimensions
    base_large = randint(8, 15)
    base_small = randint(4, 7)
    height_main = randint(6, 12)
    
    # Number of corner pyramids to remove (tetrahedral cuts)
    n_cuts = randint(3, 4)
    cut_depth = randint(2, 4)
    
    # Calculate surface area
    # Main frustum lateral surface area (4 trapezoidal faces)
    slant_height = sqrt(height_main^2 + ((base_large - base_small)/2)^2)
    lateral_trapezoid = (base_large + base_small) * slant_height / 2
    total_lateral = 4 * lateral_trapezoid
    
    # Top and bottom squares
    area_top = base_small^2
    area_bottom = base_large^2
    
    # Each corner cut removes a triangular face from bottom and adds 3 new triangular faces
    # Removed area from bottom corners
    corner_tri_base = cut_depth
    corner_tri_height = cut_depth
    area_removed_per_cut = corner_tri_base * corner_tri_height / 2
    
    # Each cut adds 3 new faces (tetrahedron sides)
    # Calculate edge length for tetrahedral cut
    tet_edge = cut_depth * sqrt(2)
    tet_face_area = (sqrt(3) / 4) * tet_edge^2
    area_added_per_cut = 3 * tet_face_area
    
    # Net change per cut
    net_change_per_cut = area_added_per_cut - area_removed_per_cut
    
    # Total surface area
    total_sa = total_lateral + area_top + area_bottom + n_cuts * net_change_per_cut
    total_sa_simplified = simplify(total_sa)
    
    # Create diagram
    d = DiagramObj(width=400, height=400)
    
    # Draw frustum in isometric view
    # Bottom square vertices (projected)
    scale = 15
    offset_x = 200
    offset_y = 300
    iso_x(x, y) = offset_x + (x - y) * cos(π/6) * scale
    iso_y(x, y, z) = offset_y - z * scale - (x + y) * sin(π/6) * scale
    
    # Bottom vertices
    b1 = (iso_x(-base_large/2, -base_large/2), iso_y(-base_large/2, -base_large/2, 0))
    b2 = (iso_x(base_large/2, -base_large/2), iso_y(base_large/2, -base_large/2, 0))
    b3 = (iso_x(base_large/2, base_large/2), iso_y(base_large/2, base_large/2, 0))
    b4 = (iso_x(-base_large/2, base_large/2), iso_y(-base_large/2, base_large/2, 0))
    
    # Top vertices
    t1 = (iso_x(-base_small/2, -base_small/2), iso_y(-base_small/2, -base_small/2, height_main))
    t2 = (iso_x(base_small/2, -base_small/2), iso_y(base_small/2, -base_small/2, height_main))
    t3 = (iso_x(base_small/2, base_small/2), iso_y(base_small/2, base_small/2, height_main))
    t4 = (iso_x(-base_small/2, base_small/2), iso_y(-base_small/2, base_small/2, height_main))
    
    # Draw frustum faces
    polygon!(d, [b1, b2, b3, b4], fill="#E8E8F0", stroke="#000080", stroke_width=2)
    polygon!(d, [t1, t2, t3, t4], fill="#D0D0E8", stroke="#000080", stroke_width=2)
    polygon!(d, [b1, b2, t2, t1], fill="#C8C8E0", stroke="#000080", stroke_width=1.5)
    polygon!(d, [b2, b3, t3, t2], fill="#B8B8D8", stroke="#000080", stroke_width=1.5)
    
    # Draw vertical edges
    line!(d, b1, t1, stroke="#000080", stroke_width=1.5)
    line!(d, b4, t4, stroke="#000080", stroke_width=1.5, dash="4,2")
    
    # Mark corner cuts with small triangles
    for i in 1:n_cuts
        if i == 1
            cut_pt = (b1[1] + 8, b1[2] - 8)
            polygon!(d, [b1, (b1[1] + 15, b1[2]), (b1[1], b1[2] - 15)], fill="#FF6B6B", stroke="#8B0000", stroke_width=1.5)
        elseif i == 2
            polygon!(d, [b2, (b2[1] - 15, b2[2]), (b2[1], b2[2] - 15)], fill="#FF6B6B", stroke="#8B0000", stroke_width=1.5)
        elseif i == 3
            polygon!(d, [b3, (b3[1] - 15, b3[2]), (b3[1], b3[2] + 15)], fill="#FF6B6B", stroke="#8B0000", stroke_width=1.5)
        elseif i == 4
            polygon!(d, [b4, (b4[1] + 15, b4[2]), (b4[1], b4[2] + 15)], fill="#FF6B6B", stroke="#8B0000", stroke_width=1.5)
        end
    end
    
    # Labels
    text!(d, offset_x - 120, 50, "Frustum with $(n_cuts) tetrahedral", font_size=14, fill="#000080")
    text!(d, offset_x - 120, 70, "corner cuts removed", font_size=14, fill="#000080")
    text!(d, b1[1] - 40, b1[2] + 20, "Base: $(base_large)×$(base_large)", font_size=11, fill="#000000")
    text!(d, t1[1] - 40, t1[2] - 20, "Top: $(base_small)×$(base_small)", font_size=11, fill="#000000")
    text!(d, offset_x + 100, offset_y - height_main*scale/2, "h=$(height_main)", font_size=11, fill="#000000")
    text!(d, b1[1] + 20, b1[2] - 30, "cut=$(cut_depth)", font_size=10, fill="#8B0000")
    
    image = render(d)
    
    problem(
        question="A square frustum has a base edge length of $(base_large) units and a top edge length of $(base_small) units, with height $(height_main) units. At $(n_cuts) corners of the base, regular tetrahedral cuts of edge length $(cut_depth) units are removed (each tetrahedron has one vertex at the corner and three edges of length $(cut_depth) units along the base edges). Find the exact total surface area of the resulting solid. Express your answer in simplest radical form.",
        answer=total_sa_simplified,
        difficulty=(3500, 4500),
        solution=steps(
            sol("Frustum slant height", "s = \\sqrt{h^2 + \\left(\\frac{a-b}{2}\\right)^2} = \\sqrt{$(height_main)^2 + \\left(\\frac{$(base_large)-$(base_small)}{2}\\right)^2} = $(tex(slant_height))"),
            sol("Lateral area (4 trapezoids)", "A_L = 4 \\cdot \\frac{(a+b)s}{2} = 4 \\cdot \\frac{($(base_large)+$(base_small)) \\cdot $(tex(slant_height))}{2} = $(tex(total_lateral))"),
            sol("Base areas", "A_{bottom} = $(base_large)^2 = $(area_bottom), \\quad A_{top} = $(base_small)^2 = $(area_top)"),
            "Each tetrahedral cut with edge $(cut_depth): removes base triangle area $(tex(area_removed_per_cut)), adds 3 equilateral faces",
            sol("Tetrahedron edge", "e = $(cut_depth)\\sqrt{2} = $(tex(tet_edge))"),
            sol("Each tet face area", "A_{tet} = \\frac{\\sqrt{3}}{4}e^2 = $(tex(tet_face_area))"),
            sol("Net change per cut", "\\Delta A = 3 \\cdot $(tex(tet_face_area)) - $(tex(area_removed_per_cut)) = $(tex(net_change_per_cut))"),
            sol("Total surface area", "$(tex(total_lateral)) + $(area_top) + $(area_bottom) + $(n_cuts) \\cdot $(tex(net_change_per_cut)) = $(tex(total_sa_simplified))")
        ),
        time=480,
        image=image
    )
end