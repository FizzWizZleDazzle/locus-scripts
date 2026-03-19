# geometry - area_of_polygons (competition)
# Generated: 2026-03-08T20:08:16.598124

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("geometry/area_of_polygons")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Olympiad: Complex polygon with algebraic constraints
        # A cyclic quadrilateral with given side lengths, find area
        a = randint(8, 20)
        b = randint(8, 20)
        c = randint(8, 20)
        d = randint(8, 20)
        
        # Use Brahmagupta's formula for cyclic quadrilateral
        s = (a + b + c + d) / 2
        area_squared = (s - a) * (s - b) * (s - c) * (s - d)
        
        # Ensure valid area
        if area_squared <= 0
            a, b, c, d = 13, 14, 15, 12
            s = (a + b + c + d) / 2
            area_squared = (s - a) * (s - b) * (s - c) * (s - d)
        end
        
        area = sqrt(area_squared)
        
        d = DiagramObj(500, 400)
        
        # Draw cyclic quadrilateral inscribed in circle
        center_x, center_y = 250, 200
        radius = 120
        
        # Position vertices on circle
        angles = [0, 80, 170, 260]
        pts = [(center_x + radius * cos(deg2rad(θ)), center_y + radius * sin(deg2rad(θ))) for θ in angles]
        
        circle!(d, center_x, center_y, radius, stroke="gray", stroke_width=1.5, stroke_dasharray="5,5")
        
        polygon!(d, pts, fill="lightblue", fill_opacity=0.3, stroke="navy", stroke_width=2)
        
        point!(d, pts[1]..., label="A", label_pos="right")
        point!(d, pts[2]..., label="B", label_pos="top")
        point!(d, pts[3]..., label="C", label_pos="left")
        point!(d, pts[4]..., label="D", label_pos="bottom")
        
        # Add side labels
        text!(d, (pts[1][1] + pts[2][1])/2 + 15, (pts[1][2] + pts[2][2])/2 - 10, "$a", font_size=14)
        text!(d, (pts[2][1] + pts[3][1])/2 - 15, (pts[2][2] + pts[3][2])/2 - 10, "$b", font_size=14)
        text!(d, (pts[3][1] + pts[4][1])/2 - 15, (pts[3][2] + pts[4][2])/2 + 10, "$c", font_size=14)
        text!(d, (pts[4][1] + pts[1][1])/2 + 15, (pts[4][2] + pts[1][2])/2 + 10, "$d", font_size=14)
        
        problem(
            question="A cyclic quadrilateral ABCD is inscribed in a circle with consecutive sides AB = $a, BC = $b, CD = $c, and DA = $d. Find the exact area of the quadrilateral.",
            answer=area,
            difficulty=(3500, 3800),
            solution=steps(
                "For a cyclic quadrilateral with sides a=$a, b=$b, c=$c, d=$d",
                sol("Semiperimeter", "s = \\frac{$a + $b + $c + $d}{2} = $s"),
                "Apply Brahmagupta's formula: \$K = \\sqrt{(s-a)(s-b)(s-c)(s-d)}\$",
                sol("Area", "K = \\sqrt{$(s-a) \\cdot $(s-b) \\cdot $(s-c) \\cdot $(s-d)} = \\sqrt{$area_squared} = $area")
            ),
            image=render(d),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Polygon with vertices satisfying algebraic constraint
        n = randint(5, 8)
        r = randint(6, 12)
        
        # Regular n-gon inscribed in circle of radius r
        area = (n * r^2 * sin(2π/n)) / 2
        
        d = DiagramObj(500, 400)
        center_x, center_y = 250, 200
        
        circle!(d, center_x, center_y, r * 15, stroke="gray", stroke_width=1.5, stroke_dasharray="5,5")
        
        pts = [(center_x + r * 15 * cos(2π * i / n), center_y + r * 15 * sin(2π * i / n)) for i in 0:n-1]
        
        polygon!(d, pts, fill="lightgreen", fill_opacity=0.3, stroke="darkgreen", stroke_width=2)
        
        for (i, pt) in enumerate(pts)
            point!(d, pt..., label="P$i")
        end
        
        # Draw radius
        line!(d, center_x, center_y, pts[1]..., stroke="red", stroke_width=1.5)
        text!(d, (center_x + pts[1][1])/2, (center_y + pts[1][2])/2 - 15, "r=$r", font_size=14, fill="red")
        
        problem(
            question="A regular $n-gon is inscribed in a circle of radius $r. Find the exact area of the polygon. Express your answer in the form \$k\\sin(\\theta)\$ where \$k\$ and \$\\theta\$ involve \$\\pi\$.",
            answer=area,
            difficulty=(3600, 3900),
            solution=steps(
                "For a regular $n-gon inscribed in a circle of radius r=$r",
                "Divide into $n congruent isosceles triangles from center",
                "Each central angle: \$\\theta = \\frac{2\\pi}{$n}\$",
                sol("Area of one triangle", "A_1 = \\frac{1}{2}r^2\\sin\\theta = \\frac{1}{2} \\cdot $r^2 \\cdot \\sin\\left(\\frac{2\\pi}{$n}\\right)"),
                sol("Total area", "A = $n \\cdot \\frac{$(r^2)}{2} \\sin\\left(\\frac{2\\pi}{$n}\\right) = $area")
            ),
            image=render(d),
            time=280
        )
        
    elseif problem_type == 3
        # Olympiad: Triangle with algebraic area constraint
        a = randint(10, 25)
        b = randint(10, 25)
        angle_deg = choice([30, 45, 60, 120, 135, 150])
        
        area = (a * b * sin(deg2rad(angle_deg))) / 2
        
        d = DiagramObj(500, 400)
        
        # Draw triangle
        A = (100, 300)
        B = (400, 300)
        C = (100 + b * cos(deg2rad(angle_deg)), 300 - b * sin(deg2rad(angle_deg)))
        
        polygon!(d, [A, B, C], fill="lightyellow", fill_opacity=0.3, stroke="darkorange", stroke_width=2)
        
        point!(d, A..., label="A", label_pos="left")
        point!(d, B..., label="B", label_pos="right")
        point!(d, C..., label="C", label_pos="top")
        
        # Add side labels
        text!(d, (A[1] + C[1])/2 - 20, (A[2] + C[2])/2, "$b", font_size=14)
        text!(d, (A[1] + B[1])/2, A[2] + 20, "$a", font_size=14)
        
        angle_arc!(d, A..., B, C, 40, label="$(angle_deg)°")
        
        problem(
            question="In triangle ABC, side AB = $a and side AC = $b. The angle at vertex A measures $(angle_deg)°. Find the exact area of triangle ABC.",
            answer=area,
            difficulty=(3400, 3700),
            solution=steps(
                "Given: AB = $a, AC = $b, ∠BAC = $(angle_deg)°",
                "Use the formula: \$K = \\frac{1}{2}ab\\sin C\$",
                sol("Substitution", "K = \\frac{1}{2} \\cdot $a \\cdot $b \\cdot \\sin($(angle_deg)°)"),
                sol("Area", "K = $(area)")
            ),
            image=render(d),
            time=240
        )
        
    else
        # Research-adjacent: Lattice polygon with Pick's theorem
        interior_pts = randint(8, 20)
        boundary_pts = randint(8, 16)
        
        # Ensure boundary points is even for valid polygon
        if boundary_pts % 2 == 1
            boundary_pts += 1
        end
        
        # Pick's theorem: A = i + b/2 - 1
        area = interior_pts + boundary_pts/2 - 1
        
        d = DiagramObj(500, 400)
        
        # Draw grid
        for i in 0:10
            line!(d, 50 + i*40, 50, 50 + i*40, 350, stroke="lightgray", stroke_width=0.5)
            line!(d, 50, 50 + i*30, 450, 50 + i*30, stroke="lightgray", stroke_width=0.5)
        end
        
        # Draw a sample lattice polygon
        pts = [(150, 100), (350, 120), (380, 250), (250, 320), (100, 280)]
        polygon!(d, pts, fill="lavender", fill_opacity=0.4, stroke="purple", stroke_width=2)
        
        # Mark some interior and boundary points
        for i in 1:min(5, interior_pts)
            x = randint(180, 320)
            y = randint(150, 280)
            point!(d, x, y, fill="blue", radius=3)
        end
        
        text!(d, 250, 370, "Interior points: $interior_pts, Boundary points: $boundary_pts", font_size=14, text_anchor="middle")
        
        problem(
            question="A polygon is drawn on a square lattice grid. The polygon has exactly $interior_pts lattice points in its interior and exactly $boundary_pts lattice points on its boundary. Use Pick's theorem to find the area of the polygon.",
            answer=area,
            difficulty=(3800, 4200),
            solution=steps(
                "Pick's Theorem states: \$A = I + \\frac{B}{2} - 1\$",
                "where I = interior points, B = boundary points",
                sol("Given", "I = $interior_pts, B = $boundary_pts"),
                sol("Apply formula", "A = $interior_pts + \\frac{$boundary_pts}{2} - 1"),
                sol("Area", "A = $interior_pts + $(boundary_pts/2) - 1 = $area")
            ),
            image=render(d),
            time=270
        )
    end
end