# geometry - volume (very_easy)
# Generated: 2026-03-08T20:10:14.130610

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/volume")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Rectangular prism volume (ELO 200-400)
        len = randint(2, 12)
        width = randint(2, 12)
        height = randint(2, 12)
        vol = len * width * height
        
        d = DiagramObj(width=400, height=300)
        
        # Draw a 3D rectangular prism
        base_x, base_y = 50, 200
        w_scale = 20
        h_scale = 15
        depth_x = 12
        depth_y = -12
        
        # Front face
        polygon!(d, [
            (base_x, base_y),
            (base_x + len*w_scale, base_y),
            (base_x + len*w_scale, base_y - height*h_scale),
            (base_x, base_y - height*h_scale)
        ], fill="#87CEEB", stroke="black", stroke_width=2)
        
        # Top face
        polygon!(d, [
            (base_x, base_y - height*h_scale),
            (base_x + len*w_scale, base_y - height*h_scale),
            (base_x + len*w_scale + width*depth_x, base_y - height*h_scale + width*depth_y),
            (base_x + width*depth_x, base_y - height*h_scale + width*depth_y)
        ], fill="#B0E0E6", stroke="black", stroke_width=2)
        
        # Right face
        polygon!(d, [
            (base_x + len*w_scale, base_y),
            (base_x + len*w_scale + width*depth_x, base_y + width*depth_y),
            (base_x + len*w_scale + width*depth_x, base_y - height*h_scale + width*depth_y),
            (base_x + len*w_scale, base_y - height*h_scale)
        ], fill="#ADD8E6", stroke="black", stroke_width=2)
        
        # Labels
        text!(d, base_x + len*w_scale/2, base_y + 20, "$len", font_size=16)
        text!(d, base_x - 20, base_y - height*h_scale/2, "$height", font_size=16)
        text!(d, base_x + len*w_scale + width*depth_x + 20, base_y + width*depth_y/2, "$width", font_size=16)
        
        problem(
            question="Find the volume of the rectangular prism shown below.",
            answer=vol,
            difficulty=(200, 400),
            solution=steps(
                "Volume of rectangular prism = length × width × height",
                sol("V = $len × $width × $height"),
                sol("Answer", vol)
            ),
            image=render(d),
            time=45
        )
        
    elseif prob_type == 2
        # Cube volume (ELO 150-350)
        side = randint(2, 10)
        vol = side^3
        
        d = DiagramObj(width=400, height=300)
        
        # Draw a cube
        base_x, base_y = 80, 220
        s = 25 * side / 5
        dx, dy = 12, -12
        
        # Front face
        polygon!(d, [
            (base_x, base_y),
            (base_x + s, base_y),
            (base_x + s, base_y - s),
            (base_x, base_y - s)
        ], fill="#FFB6C1", stroke="black", stroke_width=2)
        
        # Top face
        polygon!(d, [
            (base_x, base_y - s),
            (base_x + s, base_y - s),
            (base_x + s + dx*side/3, base_y - s + dy*side/3),
            (base_x + dx*side/3, base_y - s + dy*side/3)
        ], fill="#FFC0CB", stroke="black", stroke_width=2)
        
        # Right face
        polygon!(d, [
            (base_x + s, base_y),
            (base_x + s + dx*side/3, base_y + dy*side/3),
            (base_x + s + dx*side/3, base_y - s + dy*side/3),
            (base_x + s, base_y - s)
        ], fill="#FFD4D4", stroke="black", stroke_width=2)
        
        # Label
        text!(d, base_x + s/2, base_y + 20, "$side", font_size=18, font_weight="bold")
        
        problem(
            question="Find the volume of the cube with side length $side.",
            answer=vol,
            difficulty=(150, 350),
            solution=steps(
                "Volume of cube = side³",
                sol("V = $side³"),
                sol("Answer", vol)
            ),
            image=render(d),
            time=40
        )
        
    elseif prob_type == 3
        # Cylinder volume (ELO 400-600)
        radius = randint(2, 8)
        height = randint(3, 12)
        vol_expr = "$(radius^2 * height)π"
        vol_numeric = round(π * radius^2 * height, digits=2)
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cylinder
        cx, cy = 200, 200
        r_scale = 15
        h_scale = 20
        
        # Top ellipse
        for i in 1:100
            angle1 = 2π * (i-1) / 100
            angle2 = 2π * i / 100
            x1 = cx + r_scale * radius * cos(angle1)
            y1 = cy - h_scale * height - r_scale * radius * 0.3 * sin(angle1)
            x2 = cx + r_scale * radius * cos(angle2)
            y2 = cy - h_scale * height - r_scale * radius * 0.3 * sin(angle2)
        end
        
        circle!(d, cx, cy - h_scale * height, r_scale * radius, r_scale * radius * 0.3, fill="#90EE90", stroke="black", stroke_width=2, type=:ellipse)
        
        # Side rectangles
        line!(d, cx - r_scale * radius, cy - h_scale * height, cx - r_scale * radius, cy, stroke="black", stroke_width=2)
        line!(d, cx + r_scale * radius, cy - h_scale * height, cx + r_scale * radius, cy, stroke="black", stroke_width=2)
        
        # Bottom ellipse (front arc only)
        for i in 1:50
            angle = π + π * i / 50
            x = cx + r_scale * radius * cos(angle)
            y = cy + r_scale * radius * 0.3 * sin(angle)
        end
        arc!(d, cx, cy, r_scale * radius, r_scale * radius * 0.3, 180, 360, stroke="black", stroke_width=2, fill="none")
        
        # Fill body
        polygon!(d, [
            (cx - r_scale * radius, cy - h_scale * height),
            (cx + r_scale * radius, cy - h_scale * height),
            (cx + r_scale * radius, cy),
            (cx - r_scale * radius, cy)
        ], fill="#98FB98", stroke="none")
        
        # Redraw outlines
        line!(d, cx - r_scale * radius, cy - h_scale * height, cx - r_scale * radius, cy, stroke="black", stroke_width=2)
        line!(d, cx + r_scale * radius, cy - h_scale * height, cx + r_scale * radius, cy, stroke="black", stroke_width=2)
        arc!(d, cx, cy, r_scale * radius, r_scale * radius * 0.3, 180, 360, stroke="black", stroke_width=2, fill="none")
        circle!(d, cx, cy - h_scale * height, r_scale * radius, r_scale * radius * 0.3, fill="none", stroke="black", stroke_width=2, type=:ellipse)
        
        # Labels
        text!(d, cx, cy - h_scale * height/2 - 30, "h = $height", font_size=16)
        line!(d, cx, cy - h_scale * height, cx + r_scale * radius, cy - h_scale * height, stroke="black", stroke_width=1, stroke_dasharray="5,5")
        text!(d, cx + r_scale * radius/2, cy - h_scale * height - 15, "r = $radius", font_size=16)
        
        problem(
            question="Find the volume of the cylinder with radius $radius and height $height. Leave your answer in terms of π.",
            answer=vol_expr,
            difficulty=(400, 600),
            solution=steps(
                "Volume of cylinder = πr²h",
                sol("V = π($radius)²($height)"),
                sol("Answer", vol_expr)
            ),
            image=render(d),
            time=60
        )
        
    else
        # Cone volume (ELO 500-700)
        radius = randint(3, 9)
        height = randint(4, 12)
        vol_expr = "$(div(radius^2 * height, 3))π"
        if (radius^2 * height) % 3 != 0
            num = radius^2 * height
            vol_expr = "\\frac{$(num)π}{3}"
        end
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cone
        cx, cy = 200, 250
        r_scale = 12
        h_scale = 18
        
        # Base ellipse
        circle!(d, cx, cy, r_scale * radius, r_scale * radius * 0.3, fill="#FFE4B5", stroke="black", stroke_width=2, type=:ellipse)
        
        # Cone sides
        line!(d, cx - r_scale * radius, cy, cx, cy - h_scale * height, stroke="black", stroke_width=2)
        line!(d, cx + r_scale * radius, cy, cx, cy - h_scale * height, stroke="black", stroke_width=2)
        
        # Fill cone
        polygon!(d, [
            (cx, cy - h_scale * height),
            (cx - r_scale * radius, cy),
            (cx + r_scale * radius, cy)
        ], fill="#FFEFD5", stroke="none")
        
        # Redraw edges
        line!(d, cx - r_scale * radius, cy, cx, cy - h_scale * height, stroke="black", stroke_width=2)
        line!(d, cx + r_scale * radius, cy, cx, cy - h_scale * height, stroke="black", stroke_width=2)
        arc!(d, cx, cy, r_scale * radius, r_scale * radius * 0.3, 180, 360, stroke="black", stroke_width=2, fill="none")
        
        # Labels
        line!(d, cx, cy, cx, cy - h_scale * height, stroke="black", stroke_width=1, stroke_dasharray="5,5")
        text!(d, cx - 25, cy - h_scale * height/2, "h = $height", font_size=16)
        line!(d, cx, cy, cx + r_scale * radius, cy, stroke="black", stroke_width=1.5)
        text!(d, cx + r_scale * radius/2, cy + 20, "r = $radius", font_size=16)
        
        problem(
            question="Find the volume of the cone with radius $radius and height $height. Leave your answer in terms of π.",
            answer=vol_expr,
            difficulty=(500, 700),
            solution=steps(
                "Volume of cone = \\frac{1}{3}πr²h",
                sol("V = \\frac{1}{3}π($radius)²($height)"),
                sol("Answer", vol_expr)
            ),
            image=render(d),
            time=75
        )
    end
end