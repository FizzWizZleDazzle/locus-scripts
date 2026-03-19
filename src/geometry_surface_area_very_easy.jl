# geometry - surface_area (very_easy)
# Generated: 2026-03-08T20:09:12.750938

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/surface_area")
    
    shape_type = choice([:cube, :rectangular_prism, :cylinder, :sphere])
    
    if shape_type == :cube
        side = randint(2, 12)
        sa = 6 * side^2
        
        d = DiagramObj(width=300, height=300)
        
        # Draw cube in isometric view
        # Front face
        polygon!(d, [100, 200], [150, 150], [150, 100], [100, 100], stroke="black", fill="lightblue", stroke_width=2)
        # Top face
        polygon!(d, [100, 100], [150, 100], [200, 130], [150, 130], stroke="black", fill="skyblue", stroke_width=2)
        # Right face
        polygon!(d, [150, 150], [200, 180], [200, 130], [150, 100], stroke="black", fill="steelblue", stroke_width=2)
        
        # Label side length
        text!(d, 75, 125, "s = $side", font_size=16)
        
        problem(
            question="Find the surface area of the cube shown in the diagram.",
            answer=sa,
            difficulty=(200, 400),
            solution=steps(
                "A cube has 6 identical square faces",
                sol("Area of one face", side^2),
                sol("Total surface area = 6 × $(side^2)", sa)
            ),
            image=render(d),
            time=60
        )
        
    elseif shape_type == :rectangular_prism
        l = randint(3, 10)
        w = randint(3, 10)
        h = randint(3, 10)
        sa = 2*(l*w + l*h + w*h)
        
        d = DiagramObj(width=350, height=300)
        
        # Draw rectangular prism in isometric view
        # Front face
        polygon!(d, [80, 220], [80+l*10, 220], [80+l*10, 220-h*10], [80, 220-h*10], stroke="black", fill="lightcoral", stroke_width=2)
        # Top face
        polygon!(d, [80, 220-h*10], [80+l*10, 220-h*10], [80+l*10+w*8, 220-h*10-w*5], [80+w*8, 220-h*10-w*5], stroke="black", fill="salmon", stroke_width=2)
        # Right face
        polygon!(d, [80+l*10, 220], [80+l*10+w*8, 220-w*5], [80+l*10+w*8, 220-h*10-w*5], [80+l*10, 220-h*10], stroke="black", fill="indianred", stroke_width=2)
        
        # Labels
        text!(d, 80+l*5-10, 235, "l = $l", font_size=14)
        text!(d, 55, 220-h*5, "h = $h", font_size=14)
        text!(d, 80+l*10+w*4+5, 220-w*2.5, "w = $w", font_size=14)
        
        problem(
            question="Find the surface area of the rectangular prism shown in the diagram.",
            answer=sa,
            difficulty=(300, 500),
            solution=steps(
                "Surface area formula: SA = 2(lw + lh + wh)",
                sol("SA = 2($l × $w + $l × $h + $w × $h)"),
                sol("SA = 2($(l*w) + $(l*h) + $(w*h)) = 2($(l*w + l*h + w*h))", sa)
            ),
            image=render(d),
            time=90
        )
        
    elseif shape_type == :cylinder
        r = randint(2, 8)
        h = randint(4, 12)
        sa_expr = 2*r^2 + 2*r*h
        sa = round(Int, 3.14159 * sa_expr)
        
        d = DiagramObj(width=300, height=350)
        
        # Draw cylinder
        # Top ellipse
        arc!(d, 150, 100, r*15, r*6, 0, 360, stroke="black", fill="lightgreen", stroke_width=2)
        # Bottom ellipse
        arc!(d, 150, 100+h*15, r*15, r*6, 0, 360, stroke="black", fill="lightgreen", stroke_width=2)
        # Side lines
        line!(d, [150-r*15, 100], [150-r*15, 100+h*15], stroke="black", stroke_width=2)
        line!(d, [150+r*15, 100], [150+r*15, 100+h*15], stroke="black", stroke_width=2)
        # Fill sides
        polygon!(d, [150-r*15, 100], [150+r*15, 100], [150+r*15, 100+h*15], [150-r*15, 100+h*15], stroke="none", fill="mediumseagreen")
        # Redraw top
        arc!(d, 150, 100, r*15, r*6, 0, 360, stroke="black", fill="lightgreen", stroke_width=2)
        
        # Labels
        text!(d, 150+r*15+10, 100+h*7.5, "h = $h", font_size=14)
        text!(d, 150-r*7.5, 85, "r = $r", font_size=14)
        line!(d, [150, 100], [150+r*15, 100], stroke="black", stroke_width=1, stroke_dasharray="3,3")
        
        problem(
            question="Find the surface area of the cylinder shown in the diagram. Use π ≈ 3.14159.",
            answer=sa,
            difficulty=(400, 600),
            solution=steps(
                "Surface area formula: SA = 2πr² + 2πrh",
                sol("SA = 2π($r)² + 2π($r)($h) = 2π($(r^2)) + 2π($(r*h))"),
                sol("SA = π($(2*r^2) + $(2*r*h)) = $(sa_expr)π ≈ $sa")
            ),
            image=render(d),
            time=120
        )
        
    else  # sphere
        r = randint(3, 10)
        sa_expr = 4*r^2
        sa = round(Int, 3.14159 * sa_expr)
        
        d = DiagramObj(width=300, height=300)
        
        # Draw sphere
        circle!(d, 150, 150, r*15, stroke="black", fill="lavender", stroke_width=2)
        # Great circle
        arc!(d, 150, 150, r*15, r*4, 0, 360, stroke="black", fill="none", stroke_width=1, stroke_dasharray="3,3")
        # Radius
        line!(d, [150, 150], [150+r*15, 150], stroke="black", stroke_width=1.5)
        point!(d, 150, 150, radius=3, fill="black")
        
        # Label
        text!(d, 150+r*7.5, 140, "r = $r", font_size=14)
        
        problem(
            question="Find the surface area of the sphere shown in the diagram. Use π ≈ 3.14159.",
            answer=sa,
            difficulty=(500, 700),
            solution=steps(
                "Surface area formula for a sphere: SA = 4πr²",
                sol("SA = 4π($r)² = 4π($(r^2))"),
                sol("SA = $(sa_expr)π ≈ $sa")
            ),
            image=render(d),
            time=90
        )
    end
end