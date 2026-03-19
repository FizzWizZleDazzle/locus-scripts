# geometry - pythagorean_theorem (competition)
# Generated: 2026-03-08T20:12:44.426796

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("geometry/pythagorean_theorem")
    
    problem_type = choice([
        :apollonius_circle,
        :pedal_triangle,
        :pythagorean_triple_locus,
        :fermat_point_variant,
        :mixed_dimensional
    ])
    
    if problem_type == :apollonius_circle
        # Olympiad: Find locus of points with constrained distance ratios
        a = randint(8, 20)
        b = randint(8, 20)
        k = choice([2, 3, 4])
        
        # Locus is a circle (Apollonius circle)
        # Distance from P to (0,0) vs distance to (a,0) has ratio k:1
        # Center and radius calculation
        c_x = (a * k^2) // (k^2 - 1)
        r_sq = (a^2 * k^2) // (k^2 - 1)^2
        r = sqrt(float(r_sq))
        
        d = DiagramObj(width=500, height=400, grid=true)
        point!(d, 0, 0, "A", :below)
        point!(d, a, 0, "B", :below)
        circle!(d, float(c_x), 0, r, stroke="blue", stroke_width=2)
        point!(d, float(c_x), 0, "O", :below)
        text!(d, 250, 30, "Locus: |PA|/|PB| = $k", font_size=16)
        
        problem(
            question="Let A = (0,0) and B = ($a, 0). Find the equation of the locus of all points P(x,y) such that the ratio |PA|/|PB| = $k. Express your answer as the equation of a circle in the form (x-h)^2 + (y-k)^2 = r^2.",
            answer="(x - $(c_x))^2 + y^2 = $(r_sq)",
            difficulty=(3500, 3800),
            solution=steps(
                "Let P = (x,y). We need |PA|/|PB| = $k",
                sol("Distance formula", "\\sqrt{x^2 + y^2} / \\sqrt{(x-$a)^2 + y^2} = $k"),
                "Square both sides: x^2 + y^2 = $(k^2)[(x-$a)^2 + y^2]",
                "Expand: x^2 + y^2 = $(k^2)[x^2 - $(2a)x + $(a^2) + y^2]",
                "Simplify: x^2 + y^2 = $(k^2)x^2 - $(2a*k^2)x + $(a^2*k^2) + $(k^2)y^2",
                "Rearrange: $(1 - k^2)x^2 + $(1 - k^2)y^2 + $(2a*k^2)x - $(a^2*k^2) = 0",
                "Divide by $(1 - k^2): x^2 + y^2 - $(2a*k^2 // (1 - k^2))x + $(a^2*k^2 // (1 - k^2)) = 0",
                "Complete the square: (x - $(c_x))^2 + y^2 = $(r_sq)",
                sol("Circle center", "($(c_x), 0), radius = $(tex(sqrt(r_sq)))")
            ),
            image=render(d),
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == :pedal_triangle
        # Research-adjacent: Pedal triangle with Pythagorean constraint
        a = randint(10, 25)
        b = randint(10, 25)
        c_val = sqrt(float(a^2 + b^2))
        
        # Height from right angle to hypotenuse
        h = (a * b) // sqrt(a^2 + b^2)
        
        d = DiagramObj(width=500, height=400, grid=true)
        polygon!(d, [0, a, 0, 0], [0, 0, b, 0], stroke="black", stroke_width=2, fill="none")
        point!(d, 0, 0, "A", :below_left)
        point!(d, a, 0, "B", :below_right)
        point!(d, 0, b, "C", :above_left)
        
        # Foot of altitude
        foot_x = (a * a) / (a^2 + b^2) * a
        foot_y = (a * a) / (a^2 + b^2) * b
        line!(d, 0, 0, foot_x, foot_y, stroke="red", stroke_width=1.5, dash="5,5")
        point!(d, foot_x, foot_y, "D", :right)
        right_angle!(d, 0, 0, 15, 0)
        
        text!(d, 250, 30, "Right triangle ABC with altitude to hypotenuse", font_size=14)
        
        problem(
            question="In right triangle ABC with right angle at A, let AB = $a and AC = $b. Let D be the foot of the altitude from A to hypotenuse BC. Prove that AD^2 = BD · DC, and find the exact value of AD in terms of $a and $b. Express your answer in simplest radical form.",
            answer="$(a*b)/sqrt($(a^2 + b^2))",
            difficulty=(3800, 4200),
            solution=steps(
                "First find BC using Pythagorean theorem: BC^2 = $a^2 + $b^2 = $(a^2 + b^2)",
                sol("BC", "\\sqrt{$(a^2 + b^2)}"),
                "Let BD = x, then DC = BC - x = \\sqrt{$(a^2 + b^2)} - x",
                "In right triangle ABD: AD^2 + x^2 = $(a^2)",
                "In right triangle ACD: AD^2 + (BC - x)^2 = $(b^2)",
                "Subtract equations: x^2 - (BC - x)^2 = $(a^2 - b^2)",
                "Expand: 2x·BC - BC^2 = $(a^2 - b^2)",
                "Solve for x: x = \\frac{$(a^2)}{\\sqrt{$(a^2 + b^2)}}",
                "Therefore DC = \\frac{$(b^2)}{\\sqrt{$(a^2 + b^2)}}",
                "From AD^2 = BD · DC: AD^2 = \\frac{$(a^2) \\cdot $(b^2)}{$(a^2 + b^2)}",
                sol("AD", "\\frac{$(a*b)}{\\sqrt{$(a^2 + b^2)}}")
            ),
            image=render(d),
            time=360,
            calculator="none"
        )
        
    elseif problem_type == :pythagorean_triple_locus
        # IMO-style: Points forming Pythagorean triples
        n = randint(5, 12)
        m = randint(n+1, 15)
        
        # Pythagorean triple (2mn, m^2-n^2, m^2+n^2)
        leg1 = 2*m*n
        leg2 = m^2 - n^2
        hyp = m^2 + n^2
        
        d = DiagramObj(width=500, height=400, grid=true)
        polygon!(d, [0, leg1, 0, 0], [0, 0, leg2, 0], stroke="black", stroke_width=2, fill="lightblue", fill_opacity=0.3)
        point!(d, 0, 0, "O", :below_left)
        point!(d, leg1, 0, "A($leg1, 0)", :below)
        point!(d, 0, leg2, "B(0, $leg2)", :left)
        line!(d, leg1, 0, 0, leg2, stroke="red", stroke_width=2)
        right_angle!(d, 0, 0, 20, 0)
        
        segment_label!(d, leg1/2, -15, "$leg1")
        segment_label!(d, -20, leg2/2, "$leg2")
        segment_label!(d, leg1/2 + 10, leg2/2 + 10, "c = ?")
        
        problem(
            question="A right triangle has legs of length $leg1 and $leg2. Find the exact length of the hypotenuse c. Then verify that ($leg1, $leg2, c) forms a primitive Pythagorean triple by showing it can be generated by the formula (2mn, m²-n², m²+n²) for coprime integers m > n with opposite parity. What are the values of m and n?",
            answer="m = $m, n = $n, c = $hyp",
            difficulty=(3600, 4000),
            solution=steps(
                sol("Pythagorean theorem", "c^2 = $(leg1)^2 + $(leg2)^2"),
                "Calculate: c^2 = $(leg1^2) + $(leg2^2) = $(leg1^2 + leg2^2)",
                sol("c", "$hyp"),
                "Now identify the parametrization. Note $leg1 = 2mn is even",
                "So $leg1 = 2mn ⟹ mn = $(leg1 ÷ 2)",
                "And $leg2 = |m^2 - n^2| and $hyp = m^2 + n^2",
                "From m^2 + n^2 = $hyp and m^2 - n^2 = $leg2:",
                "Add: 2m^2 = $(hyp + leg2) ⟹ m^2 = $(div(hyp + leg2, 2))",
                sol("m", "$m"),
                "Subtract: 2n^2 = $(hyp - leg2) ⟹ n^2 = $(div(hyp - leg2, 2))",
                sol("n", "$n"),
                "Verify: gcd($m, $n) = 1 and opposite parity ✓"
            ),
            image=render(d),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == :fermat_point_variant
        # Research-adjacent: Minimize sum of squared distances
        a = randint(8, 20)
        b = randint(8, 20)
        
        # Centroid minimizes sum of squared distances
        cx = a // 3
        cy = b // 3
        
        d = DiagramObj(width=500, height=400, grid=true)
        polygon!(d, [0, a, 0, 0], [0, 0, b, 0], stroke="black", stroke_width=2, fill="lightyellow", fill_opacity=0.3)
        point!(d, 0, 0, "O(0,0)", :below_left)
        point!(d, a, 0, "A($a,0)", :below_right)
        point!(d, 0, b, "B(0,$b)", :above_left)
        point!(d, float(cx), float(cy), "P*", :right)
        circle!(d, float(cx), float(cy), 3, fill="red")
        
        text!(d, 250, 30, "Point minimizing Σ(distances²)", font_size=14)
        
        problem(
            question="Find the point P(x,y) inside or on the triangle with vertices O(0,0), A($a, 0), and B(0, $b) that minimizes the sum S = |PO|² + |PA|² + |PB|². Express your answer as an ordered pair.",
            answer="($(cx), $(cy))",
            difficulty=(4000, 4400),
            solution=steps(
                "Let P = (x, y). We minimize S = x^2 + y^2 + (x-$a)^2 + y^2 + x^2 + (y-$b)^2",
                "Expand: S = x^2 + y^2 + x^2 - $(2a)x + $(a^2) + y^2 + x^2 + y^2 - $(2b)y + $(b^2)",
                sol("Simplify", "S = 3x^2 + 3y^2 - $(2a)x - $(2b)y + $(a^2 + b^2)"),
                "Take partial derivatives and set to zero:",
                "\\frac{\\partial S}{\\partial x} = 6x - $(2a) = 0 ⟹ x = $(a//3)",
                "\\frac{\\partial S}{\\partial y} = 6y - $(2b) = 0 ⟹ y = $(b//3)",
                "Second derivative test: \\frac{\\partial^2 S}{\\partial x^2} = 6 > 0, confirming minimum",
                sol("Critical point (centroid)", "($(cx), $(cy))"),
                "Verify point is inside triangle: $(cx) ≥ 0, $(cy) ≥ 0, and $(cx)/$(a) + $(cy)/$(b) = 1/3 + 1/3 < 1 ✓"
            ),
            image=render(d),
            time=300,
            calculator="none"
        )
        
    else  # :mixed_dimensional
        # Research-adjacent: 3D Pythagorean theorem with projection
        a = randint(6, 15)
        b = randint(6, 15)
        c_val = randint(6, 15)
        
        space_diag_sq = a^2 + b^2 + c_val^2
        space_diag = sqrt(float(space_diag_sq))
        
        # Face diagonal
        face_diag_sq = a^2 + b^2
        
        d = DiagramObj(width=500, height=400, grid=false)
        # Draw a 3D box projection
        polygon!(d, [50, 250, 250, 50, 50], [300, 300, 100, 100, 300], stroke="black", stroke_width=2, fill="none")
        polygon!(d, [50, 200, 400, 250, 50], [300, 350, 350, 300, 300], stroke="black", stroke_width=2, fill="none")
        polygon!(d, [250, 400, 400, 250, 250], [300, 350, 150, 100, 300], stroke="black", stroke_width=2, fill="none")
        line!(d, 250, 100, 400, 150, stroke="black", stroke_width=2)
        line!(d, 50, 100, 200, 350, stroke="red", stroke_width=2, dash="5,5")
        
        text!(d, 250, 30, "Box with dimensions $a × $b × $c_val", font_size=16)
        text!(d, 20, 310, "$a", font_size=12)
        text!(d, 260, 320, "$b", font_size=12)
        text!(d, 420, 250, "$c_val", font_size=12)
        
        problem(
            question="A rectangular box has dimensions $(a), $(b), and $(c_val). Find the square of the length of the space diagonal.",
            answer=space_diag_sq,
            difficulty=(3000, 3400),
            solution=steps(
                "Space diagonal squared = a^2 + b^2 + c^2",
                "= $(a^2) + $(b^2) + $(c_val^2) = $(space_diag_sq)",
                sol("Answer", space_diag_sq)
            ),
            image=render(d),
            time=300
        )
    end
end
