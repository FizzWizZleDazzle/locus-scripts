# geometry - volume (medium)
# Generated: 2026-03-08T20:10:44.056156

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/volume")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Rectangular prism volume (1200-1400)
        length = randint(5, 15)
        width = randint(4, 12)
        height = randint(6, 20)
        volume = length * width * height
        
        d = DiagramObj(width=400, height=300)
        
        # Draw a 3D rectangular prism
        x0, y0 = 100, 200
        w, h, depth = 120, 80, 60
        
        # Front face
        polygon!(d, [x0, y0], [x0+w, y0], [x0+w, y0-h], [x0, y0-h], fill="lightblue", stroke="black", stroke_width=2)
        # Top face
        polygon!(d, [x0, y0-h], [x0+w, y0-h], [x0+w+depth, y0-h-depth], [x0+depth, y0-h-depth], fill="skyblue", stroke="black", stroke_width=2)
        # Right face
        polygon!(d, [x0+w, y0], [x0+w, y0-h], [x0+w+depth, y0-h-depth], [x0+w+depth, y0-depth], fill="steelblue", stroke="black", stroke_width=2)
        
        # Labels
        text!(d, x0+w/2, y0+15, "$(length)", font_size=14)
        text!(d, x0-20, y0-h/2, "$(height)", font_size=14)
        text!(d, x0+w+depth+25, y0-depth-h/2, "$(width)", font_size=14)
        
        problem(
            question="Find the volume of the rectangular prism shown in the diagram.",
            answer=volume,
            difficulty=(1200, 1400),
            solution=steps(
                "Volume of rectangular prism = length × width × height",
                sol("V = $(length) × $(width) × $(height)"),
                sol("Answer", "V = $(volume) \\text{ cubic units}")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Cylinder volume (1300-1500)
        radius = randint(3, 10)
        height = randint(8, 20)
        volume_exact = radius^2 * height
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cylinder
        cx, cy = 200, 250
        r_draw = 60
        h_draw = 120
        
        # Bottom ellipse
        circle!(d, cx, cy, r_draw, fill="lightcoral", stroke="black", stroke_width=2, aspect_ratio=0.3)
        # Top ellipse
        circle!(d, cx, cy-h_draw, r_draw, fill="salmon", stroke="black", stroke_width=2, aspect_ratio=0.3)
        # Sides
        line!(d, [cx-r_draw, cy], [cx-r_draw, cy-h_draw], stroke="black", stroke_width=2)
        line!(d, [cx+r_draw, cy], [cx+r_draw, cy-h_draw], stroke="black", stroke_width=2)
        
        # Labels
        line!(d, [cx, cy], [cx+r_draw, cy], stroke="blue", stroke_width=2)
        text!(d, cx+r_draw/2, cy-10, "r = $(radius)", font_size=14, fill="blue")
        text!(d, cx+r_draw+40, cy-h_draw/2, "h = $(height)", font_size=14, fill="blue")
        
        problem(
            question="Find the volume of the cylinder shown in the diagram. Express your answer in terms of π.",
            answer="$(volume_exact)π",
            difficulty=(1300, 1500),
            answer_type="expression",
            solution=steps(
                "Volume of cylinder = πr²h",
                sol("V = π($(radius))^2($(height))"),
                sol("V = π($(radius^2))($(height))"),
                sol("Answer", "V = $(volume_exact)π \\text{ cubic units}")
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 3
        # Cone volume (1400-1600)
        radius = randint(4, 12)
        height = randint(9, 24)
        volume_exact_num = radius^2 * height
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cone
        cx, cy = 200, 280
        r_draw = 70
        h_draw = 150
        
        # Base circle
        circle!(d, cx, cy, r_draw, fill="lightyellow", stroke="black", stroke_width=2, aspect_ratio=0.3)
        # Sides
        line!(d, [cx-r_draw, cy], [cx, cy-h_draw], stroke="black", stroke_width=2)
        line!(d, [cx+r_draw, cy], [cx, cy-h_draw], stroke="black", stroke_width=2)
        
        # Apex point
        point!(d, cx, cy-h_draw, color="black", radius=4)
        
        # Labels
        line!(d, [cx, cy], [cx+r_draw, cy], stroke="blue", stroke_width=2)
        text!(d, cx+r_draw/2, cy+15, "r = $(radius)", font_size=14, fill="blue")
        line!(d, [cx, cy], [cx, cy-h_draw], stroke="red", stroke_width=2, stroke_dasharray="5,5")
        text!(d, cx-30, cy-h_draw/2, "h = $(height)", font_size=14, fill="red")
        
        problem(
            question="Find the volume of the cone shown in the diagram. Express your answer in terms of π.",
            answer="$(volume_exact_num)π/3",
            difficulty=(1400, 1600),
            answer_type="expression",
            solution=steps(
                "Volume of cone = (1/3)πr²h",
                sol("V = \\frac{1}{3}π($(radius))^2($(height))"),
                sol("V = \\frac{1}{3}π($(radius^2))($(height))"),
                sol("Answer", "V = \\frac{$(volume_exact_num)π}{3} \\text{ cubic units}")
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 4
        # Sphere volume (1500-1700)
        radius = randint(3, 9)
        volume_exact_num = 4 * radius^3
        
        d = DiagramObj(width=400, height=350)
        
        # Draw sphere
        cx, cy = 200, 175
        r_draw = 80
        
        # Main circle
        circle!(d, cx, cy, r_draw, fill="lightgreen", stroke="black", stroke_width=2)
        # Horizontal ellipse (equator)
        circle!(d, cx, cy, r_draw, fill="none", stroke="darkgreen", stroke_width=1.5, stroke_dasharray="4,4", aspect_ratio=0.25)
        
        # Radius line
        line!(d, [cx, cy], [cx+r_draw, cy], stroke="blue", stroke_width=2)
        text!(d, cx+r_draw/2, cy-15, "r = $(radius)", font_size=14, fill="blue")
        point!(d, cx, cy, color="black", radius=4)
        
        problem(
            question="Find the volume of the sphere shown in the diagram. Express your answer in terms of π.",
            answer="$(volume_exact_num)π/3",
            difficulty=(1500, 1700),
            answer_type="expression",
            solution=steps(
                "Volume of sphere = (4/3)πr³",
                sol("V = \\frac{4}{3}π($(radius))^3"),
                sol("V = \\frac{4}{3}π($(radius^3))"),
                sol("Answer", "V = \\frac{$(volume_exact_num)π}{3} \\text{ cubic units}")
            ),
            image=render(d),
            time=150
        )
        
    else
        # Composite figure: cylinder with hemisphere on top (1600-1800)
        radius = randint(4, 8)
        cyl_height = randint(10, 18)
        
        # Volume = πr²h + (2/3)πr³
        cyl_vol_num = radius^2 * cyl_height
        hemisphere_vol_num = 2 * radius^3
        
        d = DiagramObj(width=400, height=400)
        
        cx, cy = 200, 320
        r_draw = 60
        h_draw = 100
        
        # Cylinder bottom
        circle!(d, cx, cy, r_draw, fill="lavender", stroke="black", stroke_width=2, aspect_ratio=0.3)
        # Cylinder sides
        line!(d, [cx-r_draw, cy], [cx-r_draw, cy-h_draw], stroke="black", stroke_width=2)
        line!(d, [cx+r_draw, cy], [cx+r_draw, cy-h_draw], stroke="black", stroke_width=2)
        # Cylinder top (base of hemisphere)
        circle!(d, cx, cy-h_draw, r_draw, fill="lavender", stroke="black", stroke_width=1, aspect_ratio=0.3)
        
        # Hemisphere on top
        arc!(d, cx, cy-h_draw, r_draw, 0, 180, stroke="black", stroke_width=2, fill="plum")
        
        # Labels
        text!(d, cx+r_draw+50, cy-h_draw/2, "h = $(cyl_height)", font_size=14, fill="blue")
        line!(d, [cx, cy-h_draw], [cx+r_draw, cy-h_draw], stroke="red", stroke_width=2)
        text!(d, cx+r_draw/2, cy-h_draw-15, "r = $(radius)", font_size=14, fill="red")
        
        problem(
            question="A solid consists of a cylinder with height $(cyl_height) and radius $(radius), topped with a hemisphere of the same radius. Find the total volume. Express your answer in terms of π.",
            answer="$(cyl_vol_num + hemisphere_vol_num)π/3",
            difficulty=(1600, 1800),
            answer_type="expression",
            solution=steps(
                "Volume = Volume of cylinder + Volume of hemisphere",
                sol("V_{cylinder} = πr^2h = π($(radius))^2($(cyl_height)) = $(cyl_vol_num)π"),
                sol("V_{hemisphere} = \\frac{2}{3}πr^3 = \\frac{2}{3}π($(radius))^3 = \\frac{$(hemisphere_vol_num)π}{3}"),
                sol("Total", "V = $(cyl_vol_num)π + \\frac{$(hemisphere_vol_num)π}{3} = \\frac{$(3*cyl_vol_num)π + $(hemisphere_vol_num)π}{3} = \\frac{$(cyl_vol_num + hemisphere_vol_num)π}{3}")
            ),
            image=render(d),
            time=180
        )
    end
end