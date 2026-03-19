# geometry - perimeter (hard)
# Generated: 2026-03-08T20:09:00.622066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("geometry/perimeter")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Perimeter optimization with constraint (1800-2000)
        width = randint(8, 20)
        total_fence = randint(60, 120)
        
        d = DiagramObj(400, 300)
        house_y = 50
        rect_height = 150
        rect_width = 200
        
        # Draw house (top border)
        line!(d, 50, house_y, 350, house_y, stroke="black", stroke_width=3)
        text!(d, 200, house_y - 15, "House", font_size=16, text_anchor="middle")
        
        # Draw rectangular enclosure
        line!(d, 50, house_y, 50, house_y + rect_height, stroke="blue", stroke_width=2)
        line!(d, 350, house_y, 350, house_y + rect_height, stroke="blue", stroke_width=2)
        line!(d, 50, house_y + rect_height, 350, house_y + rect_height, stroke="blue", stroke_width=2)
        
        # Labels
        segment_label!(d, 50, house_y + rect_height/2, 30, house_y + rect_height/2, "w", :left)
        segment_label!(d, 200, house_y + rect_height + 20, 200, house_y + rect_height + 40, "L", :bottom)
        
        text!(d, 200, 270, "Fence: $(total_fence) ft (3 sides)", font_size=14, text_anchor="middle")
        
        # 2w + L = total_fence, Area = w*L = w*(total_fence - 2w)
        # max at w = total_fence/4
        optimal_w = total_fence // 4
        optimal_L = total_fence - 2*optimal_w
        max_area = optimal_w * optimal_L
        
        question = "A farmer wants to fence a rectangular garden against a straight house wall. The house forms one side (no fence needed there). He has $(total_fence) feet of fencing for the other three sides. What is the maximum area (in square feet) he can enclose?"
        
        problem(
            question=question,
            answer=max_area,
            difficulty=(1800, 2000),
            solution=steps(
                "Let width = w, length = L (parallel to house)",
                sol("Constraint", "2w + L = $(total_fence)"),
                sol("Area", "A = w \\cdot L = w($(total_fence) - 2w) = $(total_fence)w - 2w^2"),
                "This is a quadratic with maximum at w = $(total_fence)/(2·2) = $(optimal_w)",
                sol("Then", "L = $(total_fence) - 2($(optimal_w)) = $(optimal_L)"),
                sol("Maximum Area", "$(optimal_w) \\times $(optimal_L) = $(max_area) \\text{ ft}^2")
            ),
            image=render(d),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Perimeter of composite shape (1900-2100)
        r = randint(5, 15)
        side = randint(10, 25)
        
        d = DiagramObj(400, 400)
        cx, cy = 200, 200
        
        # Draw square
        polygon!(d, [
            (cx - side*5, cy - side*5),
            (cx + side*5, cy - side*5),
            (cx + side*5, cy + side*5),
            (cx - side*5, cy + side*5)
        ], fill="lightblue", stroke="black", stroke_width=2)
        
        # Draw four semicircles on each side
        arc!(d, cx, cy - side*5, r*5, 0, 180, stroke="red", stroke_width=2, fill="none")
        arc!(d, cx + side*5, cy, r*5, 90, 270, stroke="red", stroke_width=2, fill="none")
        arc!(d, cx, cy + side*5, r*5, 180, 360, stroke="red", stroke_width=2, fill="none")
        arc!(d, cx - side*5, cy, r*5, 270, 450, stroke="red", stroke_width=2, fill="none")
        
        # Labels
        text!(d, cx, cy - side*5 - r*5 - 15, "r = $(r)", font_size=14, text_anchor="middle", fill="red")
        segment_label!(d, cx - side*5, cy + side*5 + 20, cx + side*5, cy + side*5 + 20, "s = $(side)", :bottom)
        
        # Perimeter = 4 * πr (four semicircles = 2 full circles)
        perimeter_exact = 4 * r
        
        question = "A square with side length $(side) has semicircles constructed outward on each of its four sides, each with radius $(r). What is the perimeter of the entire figure? Give your answer in the form a\\pi where a is an integer."
        
        problem(
            question=question,
            answer="$(perimeter_exact)π",
            difficulty=(1900, 2100),
            solution=steps(
                "The perimeter consists only of the four semicircular arcs",
                "Each semicircle has arc length = πr = $(r)π",
                sol("Four semicircles", "4 \\times $(r)\\pi = $(perimeter_exact)\\pi"),
                "The square's sides are internal boundaries, not part of the perimeter",
                sol("Answer", "$(perimeter_exact)\\pi")
            ),
            image=render(d),
            time=180,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Track perimeter problem (2000-2200)
        straight = randint(80, 120)
        r = randint(30, 50)
        
        d = DiagramObj(500, 300)
        
        # Draw track
        line!(d, 100, 100, 100 + straight*2, 100, stroke="black", stroke_width=3)
        line!(d, 100, 200, 100 + straight*2, 200, stroke="black", stroke_width=3)
        
        # Semicircles
        arc!(d, 100, 150, 50, 90, 270, stroke="black", stroke_width=3, fill="none")
        arc!(d, 100 + straight*2, 150, 50, 270, 450, stroke="black", stroke_width=3, fill="none")
        
        # Labels
        segment_label!(d, 100, 80, 100 + straight*2, 80, "$(straight) m", :top)
        text!(d, 100, 150, "r=$(r)m", font_size=12, text_anchor="middle")
        
        # Perimeter = 2*straight + 2πr
        perimeter_num = 2 * straight
        perimeter_pi = 2 * r
        
        question = "A running track consists of two straight sections, each $(straight) meters long, connected by semicircular ends with radius $(r) meters. What is the total perimeter of the track? Express your answer in the form a + b\\pi where a and b are integers."
        
        problem(
            question=question,
            answer="$(perimeter_num) + $(perimeter_pi)π",
            difficulty=(2000, 2200),
            solution=steps(
                sol("Two straight sections", "2 \\times $(straight) = $(perimeter_num) \\text{ m}"),
                "Two semicircles form one complete circle with radius $(r)",
                sol("Circular part", "2\\pi r = 2\\pi($(r)) = $(perimeter_pi)\\pi \\text{ m}"),
                sol("Total perimeter", "$(perimeter_num) + $(perimeter_pi)\\pi \\text{ m}")
            ),
            image=render(d),
            time=150,
            calculator="none"
        )
        
    else
        # Inscribed/circumscribed perimeter ratio (2100-2300)
        n = choice([3, 4, 6])  # triangle, square, or hexagon
        R = randint(8, 16)
        
        d = DiagramObj(400, 400)
        cx, cy = 200, 200
        
        # Draw circle
        circle!(d, cx, cy, R*12, fill="none", stroke="blue", stroke_width=2)
        
        # Draw inscribed polygon
        angles = [360/n * i for i in 0:n-1]
        points = [(cx + R*12*cosd(a), cy - R*12*sind(a)) for a in angles]
        polygon!(d, points, fill="none", stroke="red", stroke_width=2)
        
        for p in points
            point!(d, p[1], p[2], radius=4, fill="red")
        end
        
        text!(d, cx, cy, "R=$(R)", font_size=14, text_anchor="middle")
        text!(d, cx, cy + R*12 + 30, "Regular $(n)-gon inscribed in circle", font_size=12, text_anchor="middle")
        
        # Side length of inscribed regular n-gon: s = 2R*sin(π/n)
        # For exact answer we need symbolic
        if n == 3
            side_factor = 1  # coefficient of R√3
            perimeter_desc = "$(3*R)\\sqrt{3}"
            answer_val = 3*R
            answer_str = "$(3*R)√3"
        elseif n == 4
            side_factor = 1  # coefficient of R√2
            perimeter_desc = "$(4*R)\\sqrt{2}"
            answer_val = 4*R
            answer_str = "$(4*R)√2"
        else  # n == 6
            perimeter_desc = "$(6*R)"
            answer_val = 6*R
            answer_str = "$(6*R)"
        end
        
        question = "A regular $(n)-gon is inscribed in a circle of radius $(R). What is the perimeter of the $(n)-gon? " * 
                   (n == 6 ? "Give your answer as an integer." : "Express in the form a\\sqrt{b} where a and b are integers and b is square-free.")
        
        if n == 3
            sol_steps = steps(
                "For a regular triangle (equilateral) inscribed in a circle of radius R,",
                "the side length s = R\\sqrt{3}",
                sol("Side length", "s = $(R)\\sqrt{3}"),
                sol("Perimeter", "P = 3s = 3 \\times $(R)\\sqrt{3} = $(3*R)\\sqrt{3}")
            )
        elseif n == 4
            sol_steps = steps(
                "For a square inscribed in a circle of radius R,",
                "the diagonal equals 2R, so side length s = 2R/\\sqrt{2} = R\\sqrt{2}",
                sol("Side length", "s = $(R)\\sqrt{2}"),
                sol("Perimeter", "P = 4s = 4 \\times $(R)\\sqrt{2} = $(4*R)\\sqrt{2}")
            )
        else
            sol_steps = steps(
                "For a regular hexagon inscribed in a circle of radius R,",
                "the side length equals R (hexagon property)",
                sol("Side length", "s = $(R)"),
                sol("Perimeter", "P = 6s = 6 \\times $(R) = $(6*R)")
            )
        end
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(2100, 2300),
            solution=sol_steps,
            image=render(d),
            time=200,
            calculator="none"
        )
    end
end