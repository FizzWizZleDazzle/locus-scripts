# geometry - circle_theorems (competition)
# Generated: 2026-03-08T20:06:29.992067

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/circle_theorems")
    
    # Generate an Olympiad/Research-adjacent circle geometry problem (3500-5000 ELO)
    # We'll create a configuration with multiple circles and prove a sophisticated property
    
    problem_type = choice(1:3)
    
    if problem_type == 1
        # Radical axis and power of a point problem
        # Two circles with centers O1, O2 and radii r1, r2
        r1 = randint(3, 7)
        r2 = randint(3, 7)
        distance = randint(max(abs(r1-r2)+1, 8), r1+r2-1)
        
        # Point P on radical axis
        px = distance // 2
        py = randint(4, 10)
        
        # Calculate power of point P with respect to both circles
        # Circle 1 centered at origin
        power1 = px^2 + py^2 - r1^2
        # Circle 2 centered at (distance, 0)
        power2 = (px - distance)^2 + py^2 - r2^2
        
        # These should be equal (radical axis property)
        # For visualization, we'll show the configuration
        
        d = DiagramObj((-2, distance+3), (-2, py+4))
        
        # Draw first circle
        circle!(d, 0, 0, r1, stroke="blue", fill="none", stroke_width=2)
        point!(d, 0, 0, "O_1", color="blue")
        
        # Draw second circle
        circle!(d, distance, 0, r2, stroke="red", fill="none", stroke_width=2)
        point!(d, distance, 0, "O_2", color="red")
        
        # Draw point P on radical axis
        point!(d, px, py, "P", color="green")
        
        # Draw tangent segments from P to both circles (if P is outside)
        if power1 > 0
            tangent_length1 = sqrt(power1)
            tangent_length2 = sqrt(power2)
            
            # Mark the equal tangent lengths
            text!(d, px-1, py+1.5, "PT_1 = $(round(tangent_length1, digits=2))", font_size=12, color="green")
            text!(d, px-1, py-1.5, "PT_2 = $(round(tangent_length2, digits=2))", font_size=12, color="green")
        end
        
        # Draw line connecting centers
        line!(d, 0, 0, distance, 0, stroke="gray", stroke_width=1, stroke_dasharray="5,5")
        
        # Draw radical axis (vertical line through px)
        line!(d, px, -1, px, py+2, stroke="purple", stroke_width=2, stroke_dasharray="3,3")
        text!(d, px+0.5, -1, "Radical Axis", font_size=11, color="purple")
        
        question_text = "Two circles ω₁ and ω₂ have centers O₁ and O₂ with radii $(r1) and $(r2) respectively, and |O₁O₂| = $(distance). Point P lies on the radical axis of the two circles at distance $(py) from the line O₁O₂. Prove that the tangent segments from P to both circles have equal length, and compute this common length."
        
        answer_val = power1 > 0 ? sqrt(power1) : "Point is inside both circles"
        
        solution_text = steps(
            "The radical axis is the locus of points having equal power with respect to both circles.",
            sol("Power of P with respect to ω₁", "d(P,O_1)^2 - r_1^2 = $(px)^2 + $(py)^2 - $(r1)^2 = $(power1)"),
            sol("Power of P with respect to ω₂", "d(P,O_2)^2 - r_2^2 = ($(px)-$(distance))^2 + $(py)^2 - $(r2)^2 = $(power2)"),
            "Since P lies on the radical axis, these powers are equal.",
            "The tangent length from P to each circle equals √(power).",
            sol("Common tangent length", power1 > 0 ? "\\sqrt{$(power1)} = $(round(sqrt(power1), digits=4))" : "Not applicable (P inside circles)")
        )
        
        problem(
            question=question_text,
            answer=power1 > 0 ? round(sqrt(power1), digits=4) : 0,
            difficulty=(3500, 4200),
            solution=solution_text,
            image=render(d),
            time=480
        )
        
    elseif problem_type == 2
        # Simson line problem - given triangle and point on circumcircle
        # Triangle vertices
        ax, ay = 0, 0
        bx, by = randint(8, 14), 0
        cx, cy = randint(3, 7), randint(6, 12)
        
        # Circumcenter
        D = 2*(ax*(by - cy) + bx*(cy - ay) + cx*(ay - by))
        if abs(D) < 1
            D = 10  # avoid degenerate case
        end
        ux = ((ax^2 + ay^2)*(by - cy) + (bx^2 + by^2)*(cy - ay) + (cx^2 + cy^2)*(ay - by)) / D
        uy = ((ax^2 + ay^2)*(cx - bx) + (bx^2 + by^2)*(ax - cx) + (cx^2 + cy^2)*(bx - ax)) / D
        
        # Circumradius
        R = sqrt((ax - ux)^2 + (ay - uy)^2)
        
        # Point P on circumcircle
        angle_p = randint(100, 260) * π / 180
        px = ux + R * cos(angle_p)
        py = uy + R * sin(angle_p)
        
        d = DiagramObj((-2, max(bx, cx)+3), (-2, max(cy, py)+3))
        
        # Draw circumcircle
        circle!(d, ux, uy, R, stroke="purple", fill="none", stroke_width=2)
        
        # Draw triangle
        polygon!(d, [ax, bx, cx], [ay, by, cy], stroke="black", fill="none", stroke_width=2)
        point!(d, ax, ay, "A", color="black")
        point!(d, bx, by, "B", color="black")
        point!(d, cx, cy, "C", color="black")
        
        # Point P on circumcircle
        point!(d, px, py, "P", color="red")
        
        # Draw perpendiculars from P to sides (conceptual)
        text!(d, px-1, py+1.5, "P on circumcircle", font_size=11, color="red")
        
        question_text = "Let ABC be a triangle with vertices A($(ax),$(ay)), B($(bx),$(by)), and C($(cx),$(cy)). Point P lies on the circumcircle of triangle ABC. The feet of the perpendiculars from P to the sides AB, BC, and CA are collinear (forming the Simson line). Prove this classical result and determine the circumradius R of triangle ABC."
        
        answer_val = round(R, digits=4)
        
        solution_text = steps(
            "First compute the circumcenter of triangle ABC using the perpendicular bisector method.",
            sol("Circumcenter coordinates", "($(round(ux, digits=2)), $(round(uy, digits=2)))"),
            sol("Distance from circumcenter to A", "\\sqrt{($(ax)-$(round(ux,digits=2)))^2 + ($(ay)-$(round(uy,digits=2)))^2}"),
            sol("Circumradius R", "$(round(R, digits=4))"),
            "The Simson line theorem: For any point P on the circumcircle, the feet of perpendiculars to the three sides are collinear.",
            "Proof sketch: Use angle chasing with cyclic quadrilaterals formed by P and pairs of triangle vertices."
        )
        
        problem(
            question=question_text,
            answer=answer_val,
            difficulty=(3800, 4500),
            solution=solution_text,
            image=render(d),
            time=600
        )
        
    else
        # Apollonius circle problem - sophisticated variant
        # Given two points A and B, find locus of points P such that PA/PB = k
        
        ax, ay = 0, 0
        bx, by = randint(10, 16), 0
        k_num = randint(2, 5)
        k_den = 1
        k = k_num // k_den
        
        # The locus is a circle (Apollonius circle)
        # Center and radius can be computed from the formula
        
        # For k ≠ 1, center is at ((bx*k^2 - ax)/(k^2 - 1), 0)
        # Radius is |k*|AB|/(k^2-1)|
        
        if k != 1
            cx_val = (bx * k^2 - ax) / (k^2 - 1)
            cy_val = 0
            radius = abs(k * bx) / abs(k^2 - 1)
        else
            # k=1 gives perpendicular bisector
            cx_val = bx / 2
            cy_val = 0
            radius = 10  # arbitrary for visualization
        end
        
        d = DiagramObj((-3, max(bx, cx_val+radius)+3), (-radius-2, radius+2))
        
        # Draw points A and B
        point!(d, ax, ay, "A", color="blue")
        point!(d, bx, by, "B", color="red")
        
        # Draw the Apollonius circle
        if k != 1
            circle!(d, cx_val, cy_val, radius, stroke="green", fill="none", stroke_width=2)
            point!(d, cx_val, cy_val, "O", color="green")
            text!(d, cx_val, cy_val-radius-1, "Apollonius Circle", font_size=12, color="green")
        end
        
        # Mark a sample point on the circle
        if k != 1
            sample_angle = π / 4
            sample_x = cx_val + radius * cos(sample_angle)
            sample_y = cy_val + radius * sin(sample_angle)
            point!(d, sample_x, sample_y, "P", color="purple")
            
            # Draw segments PA and PB
            line!(d, ax, ay, sample_x, sample_y, stroke="purple", stroke_width=1, stroke_dasharray="3,3")
            line!(d, bx, by, sample_x, sample_y, stroke="purple", stroke_width=1, stroke_dasharray="3,3")
        end
        
        question_text = "Points A($(ax), $(ay)) and B($(bx), $(by)) are given in the plane. Find the locus of all points P such that PA/PB = $(k_num)/$(k_den). Prove that this locus is a circle, and determine both its center and radius."
        
        answer_val = round(radius, digits=4)
        
        solution_text = steps(
            "Let P(x,y) be a point satisfying PA/PB = k where k = $(k_num)/$(k_den).",
            sol("Equation", "\\sqrt{x^2 + y^2} = $(k_num) \\cdot \\sqrt{(x-$(bx))^2 + y^2}"),
            "Square both sides and expand to obtain a circle equation.",
            sol("After algebraic manipulation", "(x - $(round(cx_val, digits=2)))^2 + y^2 = $(round(radius^2, digits=2))"),
            sol("Center of Apollonius circle", "($(round(cx_val, digits=2)), 0)"),
            sol("Radius", "$(round(radius, digits=4))")
        )
        
        problem(
            question=question_text,
            answer=answer_val,
            difficulty=(3600, 4300),
            solution=solution_text,
            image=render(d),
            time=540
        )
    end
end