# geometry - volume (easy)
# Generated: 2026-03-08T20:10:34.179871

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/volume")
    
    shape_type = choice([:cube, :rectangular_prism, :cylinder, :sphere, :cone])
    
    if shape_type == :cube
        side = randint(3, 15)
        volume = side^3
        
        d = DiagramObj(width=300, height=300)
        s = 120
        offset_x = 50
        offset_y = 40
        
        # Draw cube in isometric view
        polygon!(d, [
            (offset_x, offset_y + s),
            (offset_x + s, offset_y + s),
            (offset_x + s + offset_x, offset_y + s - offset_y),
            (offset_x + offset_x, offset_y + s - offset_y)
        ], stroke="black", fill="lightblue", stroke_width=2)
        
        polygon!(d, [
            (offset_x + s, offset_y + s),
            (offset_x + s, offset_y),
            (offset_x + s + offset_x, offset_y - offset_y),
            (offset_x + s + offset_x, offset_y + s - offset_y)
        ], stroke="black", fill="lightsteelblue", stroke_width=2)
        
        polygon!(d, [
            (offset_x, offset_y + s),
            (offset_x, offset_y),
            (offset_x + s, offset_y),
            (offset_x + s, offset_y + s)
        ], stroke="black", fill="skyblue", stroke_width=2)
        
        text!(d, offset_x + s/2, offset_y + s + 20, "$(side)", font_size=16)
        
        problem(
            question="Find the volume of the cube shown in the diagram.",
            answer=volume,
            difficulty=(700, 900),
            solution=steps(
                "The side length of the cube is $(side)",
                sol("Volume formula", "V = s^3"),
                sol("V", "$(side)^3 = $(volume)")
            ),
            image=render(d),
            time=60
        )
        
    elseif shape_type == :rectangular_prism
        length = randint(4, 12)
        width = randint(3, 10)
        height = randint(3, 10)
        volume = length * width * height
        
        d = DiagramObj(width=350, height=300)
        
        # Isometric rectangular prism
        l_scale = 100
        w_scale = 60
        h_scale = 80
        ox = 60
        oy = 50
        
        polygon!(d, [
            (ox, oy + h_scale),
            (ox + l_scale, oy + h_scale),
            (ox + l_scale + w_scale/2, oy + h_scale - w_scale/2),
            (ox + w_scale/2, oy + h_scale - w_scale/2)
        ], stroke="black", fill="lightblue", stroke_width=2)
        
        polygon!(d, [
            (ox + l_scale, oy + h_scale),
            (ox + l_scale, oy),
            (ox + l_scale + w_scale/2, oy - w_scale/2),
            (ox + l_scale + w_scale/2, oy + h_scale - w_scale/2)
        ], stroke="black", fill="lightsteelblue", stroke_width=2)
        
        polygon!(d, [
            (ox, oy + h_scale),
            (ox, oy),
            (ox + l_scale, oy),
            (ox + l_scale, oy + h_scale)
        ], stroke="black", fill="skyblue", stroke_width=2)
        
        text!(d, ox + l_scale/2, oy + h_scale + 25, "$(length)", font_size=14)
        text!(d, ox + l_scale + w_scale/2 + 20, oy + h_scale/2 - w_scale/4, "$(width)", font_size=14)
        text!(d, ox - 25, oy + h_scale/2, "$(height)", font_size=14)
        
        problem(
            question="Find the volume of the rectangular prism shown in the diagram.",
            answer=volume,
            difficulty=(750, 950),
            solution=steps(
                "The dimensions are: length = $(length), width = $(width), height = $(height)",
                sol("Volume formula", "V = l \\times w \\times h"),
                sol("V", "$(length) \\times $(width) \\times $(height) = $(volume)")
            ),
            image=render(d),
            time=75
        )
        
    elseif shape_type == :cylinder
        radius = randint(3, 10)
        height = randint(5, 15)
        volume_expr = rationalize(π * radius^2 * height)
        
        d = DiagramObj(width=300, height=350)
        
        cx = 150
        cy_top = 80
        cy_bottom = 260
        r_draw = 70
        h_draw = cy_bottom - cy_top
        
        # Top ellipse
        circle!(d, cx, cy_top, r_draw, r_draw/3, stroke="black", fill="lightblue", stroke_width=2)
        
        # Side lines
        line!(d, cx - r_draw, cy_top, cx - r_draw, cy_bottom, stroke="black", stroke_width=2)
        line!(d, cx + r_draw, cy_top, cx + r_draw, cy_bottom, stroke="black", stroke_width=2)
        
        # Bottom ellipse (arc only visible part)
        arc!(d, cx, cy_bottom, r_draw, r_draw/3, 0, 180, stroke="black", fill="none", stroke_width=2)
        
        # Fill sides
        polygon!(d, [
            (cx - r_draw, cy_top),
            (cx + r_draw, cy_top),
            (cx + r_draw, cy_bottom),
            (cx - r_draw, cy_bottom)
        ], stroke="none", fill="lightsteelblue", opacity=0.5)
        
        text!(d, cx + r_draw + 30, (cy_top + cy_bottom)/2, "h = $(height)", font_size=14)
        text!(d, cx, cy_top - 15, "r = $(radius)", font_size=14)
        
        problem(
            question="Find the volume of the cylinder shown in the diagram. Leave your answer in terms of π.",
            answer="$(radius^2 * height)π",
            difficulty=(850, 1050),
            solution=steps(
                "The radius is $(radius) and the height is $(height)",
                sol("Volume formula", "V = \\pi r^2 h"),
                sol("V", "\\pi \\cdot $(radius)^2 \\cdot $(height) = $(radius^2 * height)\\pi")
            ),
            image=render(d),
            time=90
        )
        
    elseif shape_type == :sphere
        radius = randint(3, 12)
        volume_coef = (4 * radius^3) // 3
        
        d = DiagramObj(width=300, height=300)
        
        cx = 150
        cy = 150
        r_draw = 80
        
        circle!(d, cx, cy, r_draw, r_draw, stroke="black", fill="lightblue", stroke_width=2, opacity=0.7)
        
        # Equator
        circle!(d, cx, cy, r_draw, r_draw/4, stroke="black", fill="none", stroke_width=1, stroke_dasharray="5,5")
        
        # Radius line
        line!(d, cx, cy, cx + r_draw, cy, stroke="black", stroke_width=2)
        text!(d, cx + r_draw/2, cy - 10, "r = $(radius)", font_size=14)
        
        problem(
            question="Find the volume of the sphere shown in the diagram. Leave your answer in terms of π.",
            answer="$(volume_coef)π",
            difficulty=(900, 1100),
            solution=steps(
                "The radius is $(radius)",
                sol("Volume formula", "V = \\frac{4}{3}\\pi r^3"),
                sol("V", "\\frac{4}{3}\\pi \\cdot $(radius)^3 = \\frac{4 \\cdot $(radius^3)}{3}\\pi = $(volume_coef)\\pi")
            ),
            image=render(d),
            time=100
        )
        
    else  # cone
        radius = randint(4, 10)
        height = randint(6, 15)
        volume_coef = (radius^2 * height) // 3
        
        d = DiagramObj(width=300, height=350)
        
        cx = 150
        cy_top = 60
        cy_base = 280
        r_draw = 80
        
        # Base ellipse
        circle!(d, cx, cy_base, r_draw, r_draw/3, stroke="black", fill="lightblue", stroke_width=2)
        
        # Cone sides
        line!(d, cx - r_draw, cy_base, cx, cy_top, stroke="black", stroke_width=2)
        line!(d, cx + r_draw, cy_base, cx, cy_top, stroke="black", stroke_width=2)
        
        # Fill cone
        polygon!(d, [
            (cx, cy_top),
            (cx - r_draw, cy_base),
            (cx + r_draw, cy_base)
        ], stroke="none", fill="lightsteelblue", opacity=0.6)
        
        # Height line
        line!(d, cx, cy_top, cx, cy_base, stroke="black", stroke_width=1, stroke_dasharray="5,5")
        text!(d, cx - 30, (cy_top + cy_base)/2, "h = $(height)", font_size=14)
        
        # Radius line
        line!(d, cx, cy_base, cx + r_draw, cy_base, stroke="black", stroke_width=1)
        text!(d, cx + r_draw/2, cy_base + 20, "r = $(radius)", font_size=14)
        
        problem(
            question="Find the volume of the cone shown in the diagram. Leave your answer in terms of π.",
            answer="$(volume_coef)π",
            difficulty=(950, 1150),
            solution=steps(
                "The radius is $(radius) and the height is $(height)",
                sol("Volume formula", "V = \\frac{1}{3}\\pi r^2 h"),
                sol("V", "\\frac{1}{3}\\pi \\cdot $(radius)^2 \\cdot $(height) = \\frac{$(radius^2 * height)}{3}\\pi = $(volume_coef)\\pi")
            ),
            image=render(d),
            time=100
        )
    end
end