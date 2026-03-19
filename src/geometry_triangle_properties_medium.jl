# geometry - triangle_properties (medium)
# Generated: 2026-03-08T20:02:55.848360

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_properties")
    
    # Choose problem type randomly
    problem_type = choice([:angle_sum, :exterior_angle, :isosceles, :similar_triangles, :pythagorean_extended])
    
    if problem_type == :angle_sum
        # Basic angle sum with algebraic expression
        # Pick the three angles such that they sum to 180
        angle1_coeff = randint(2, 5)
        angle2_coeff = randint(2, 5)
        angle3_const = randint(20, 50)
        
        # We want angle1_coeff*x + angle2_coeff*x + angle3_const = 180
        # So x = (180 - angle3_const) / (angle1_coeff + angle2_coeff)
        ans = (180 - angle3_const) // (angle1_coeff + angle2_coeff)
        
        angle1 = angle1_coeff * ans
        angle2 = angle2_coeff * ans
        angle3 = angle3_const
        
        d = DiagramObj(300, 250)
        polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightblue", stroke="black", stroke_width=2)
        point!(d, 50, 200, "A", :left)
        point!(d, 250, 200, "B", :right)
        point!(d, 150, 50, "C", :top)
        text!(d, 60, 180, "$(angle1_coeff)x", font_size=14)
        text!(d, 230, 180, "$(angle2_coeff)x", font_size=14)
        text!(d, 150, 70, "$(angle3_const)°", font_size=14)
        
        problem(
            question="In triangle ABC, angle A = $(angle1_coeff)x, angle B = $(angle2_coeff)x, and angle C = $(angle3_const)°. Find the value of x.",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "The sum of angles in a triangle equals 180°",
                sol("Equation", "$(angle1_coeff)x + $(angle2_coeff)x + $(angle3_const) = 180"),
                sol("Simplify", "$(angle1_coeff + angle2_coeff)x = $(180 - angle3_const)"),
                sol("Answer", "x = $(ans)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == :exterior_angle
        # Exterior angle theorem with algebra
        remote1_coeff = randint(2, 4)
        remote2_const = randint(25, 55)
        exterior_coeff = randint(3, 6)
        
        # remote1_coeff*x + remote2_const = exterior_coeff*x
        # So (exterior_coeff - remote1_coeff)*x = remote2_const
        ans = remote2_const // (exterior_coeff - remote1_coeff)
        
        remote1 = remote1_coeff * ans
        remote2 = remote2_const
        exterior = exterior_coeff * ans
        adjacent = 180 - exterior
        
        d = DiagramObj(350, 250)
        polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightyellow", stroke="black", stroke_width=2)
        line!(d, 250, 200, 320, 200, stroke="black", stroke_width=2, dash="5,5")
        point!(d, 50, 200, "A", :left)
        point!(d, 250, 200, "B", :bottom)
        point!(d, 150, 50, "C", :top)
        text!(d, 60, 180, "$(remote1_coeff)x", font_size=14)
        text!(d, 150, 70, "$(remote2_const)°", font_size=14)
        text!(d, 280, 210, "$(exterior_coeff)x", font_size=14)
        arc!(d, 250, 200, 20, 0, 25, stroke="blue", stroke_width=1.5)
        
        problem(
            question="In triangle ABC, the exterior angle at B measures $(exterior_coeff)x. The remote interior angles at A and C measure $(remote1_coeff)x and $(remote2_const)° respectively. Find x.",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "By the Exterior Angle Theorem, an exterior angle equals the sum of the two remote interior angles",
                sol("Equation", "$(exterior_coeff)x = $(remote1_coeff)x + $(remote2_const)"),
                sol("Simplify", "$(exterior_coeff - remote1_coeff)x = $(remote2_const)"),
                sol("Answer", "x = $(ans)")
            ),
            image=render(d),
            time=100
        )
        
    elseif problem_type == :isosceles
        # Isosceles triangle with perimeter constraint
        base = randint(8, 20)
        perimeter = randint(40, 80)
        
        # 2x + base = perimeter, so x = (perimeter - base)/2
        ans = (perimeter - base) // 2
        
        d = DiagramObj(300, 280)
        polygon!(d, [(100, 230), (200, 230), (150, 80)], fill="lightgreen", stroke="black", stroke_width=2)
        point!(d, 100, 230, "A", :left)
        point!(d, 200, 230, "B", :right)
        point!(d, 150, 80, "C", :top)
        text!(d, 150, 250, "$(base)", font_size=14)
        text!(d, 115, 150, "x", font_size=14)
        text!(d, 185, 150, "x", font_size=14)
        tick_marks!(d, 125, 155, 175, 155, count=1)
        tick_marks!(d, 175, 155, 200, 230, count=1)
        
        problem(
            question="Triangle ABC is isosceles with AC = BC = x. The base AB = $(base), and the perimeter is $(perimeter). Find x.",
            answer=ans,
            difficulty=(1100, 1300),
            solution=steps(
                "Perimeter = sum of all sides",
                sol("Equation", "x + x + $(base) = $(perimeter)"),
                sol("Simplify", "2x = $(perimeter - base)"),
                sol("Answer", "x = $(ans)")
            ),
            image=render(d),
            time=80
        )
        
    elseif problem_type == :similar_triangles
        # Similar triangles with proportions
        scale = randint(2, 4)
        small_side1 = randint(5, 12)
        small_side2 = randint(6, 15)
        
        large_side1 = scale * small_side1
        # We know one side of large triangle, find x (another side)
        ans = scale * small_side2
        
        d = DiagramObj(400, 280)
        # Small triangle
        polygon!(d, [(30, 240), (130, 240), (80, 180)], fill="none", stroke="blue", stroke_width=2)
        text!(d, 80, 260, "$(small_side1)", font_size=12, fill="blue")
        text!(d, 45, 210, "$(small_side2)", font_size=12, fill="blue")
        point!(d, 30, 240, "A", :left)
        point!(d, 130, 240, "B", :right)
        point!(d, 80, 180, "C", :top)
        
        # Large triangle
        polygon!(d, [(200, 240), (360, 240), (280, 120)], fill="none", stroke="red", stroke_width=2)
        text!(d, 280, 260, "$(large_side1)", font_size=12, fill="red")
        text!(d, 220, 180, "x", font_size=12, fill="red")
        point!(d, 200, 240, "D", :left)
        point!(d, 360, 240, "E", :right)
        point!(d, 280, 120, "F", :top)
        
        text!(d, 80, 30, "△ABC ~ △DEF", font_size=14)
        
        problem(
            question="Triangles ABC and DEF are similar. In △ABC, AB = $(small_side1) and AC = $(small_side2). In △DEF, DE = $(large_side1) and DF = x. Find x.",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                "For similar triangles, corresponding sides are proportional",
                sol("Proportion", "\\frac{AB}{DE} = \\frac{AC}{DF}"),
                sol("Substitute", "\\frac{$(small_side1)}{$(large_side1)} = \\frac{$(small_side2)}{x}"),
                sol("Cross multiply", "$(small_side1) \\cdot x = $(large_side1) \\cdot $(small_side2)"),
                sol("Answer", "x = $(ans)")
            ),
            image=render(d),
            time=120
        )
        
    else  # pythagorean_extended
        # Right triangle with Pythagorean theorem and algebra
        leg1_coeff = randint(3, 8)
        leg2_coeff = randint(4, 9)
        hyp_const = randint(15, 35)
        
        # (leg1_coeff*x)^2 + (leg2_coeff*x)^2 = hyp_const^2
        # x^2 * (leg1_coeff^2 + leg2_coeff^2) = hyp_const^2
        sum_sq = leg1_coeff^2 + leg2_coeff^2
        ans_sq = hyp_const^2 // sum_sq
        ans = isqrt(ans_sq)
        
        # Only generate if perfect square
        if ans^2 == ans_sq && ans > 0
            leg1 = leg1_coeff * ans
            leg2 = leg2_coeff * ans
            
            d = DiagramObj(320, 280)
            polygon!(d, [(50, 230), (250, 230), (50, 80)], fill="lightcoral", stroke="black", stroke_width=2)
            right_angle!(d, 50, 230, 250, 230, 50, 80, size=15)
            point!(d, 50, 230, "A", :left)
            point!(d, 250, 230, "B", :right)
            point!(d, 50, 80, "C", :top)
            text!(d, 150, 250, "$(leg1_coeff)x", font_size=14)
            text!(d, 30, 155, "$(leg2_coeff)x", font_size=14)
            text!(d, 150, 140, "$(hyp_const)", font_size=14)
            
            problem(
                question="In right triangle ABC with right angle at A, AB = $(leg1_coeff)x, AC = $(leg2_coeff)x, and hypotenuse BC = $(hyp_const). Find x.",
                answer=ans,
                difficulty=(1500, 1700),
                solution=steps(
                    "Apply the Pythagorean theorem: a² + b² = c²",
                    sol("Equation", "($(leg1_coeff)x)^2 + ($(leg2_coeff)x)^2 = $(hyp_const)^2"),
                    sol("Expand", "$(leg1_coeff^2)x^2 + $(leg2_coeff^2)x^2 = $(hyp_const^2)"),
                    sol("Simplify", "$(sum_sq)x^2 = $(hyp_const^2)"),
                    sol("Solve", "x^2 = $(ans_sq)"),
                    sol("Answer", "x = $(ans)")
                ),
                image=render(d),
                time=150
            )
        else
            # Fallback to simpler angle sum problem
            angle1 = randint(35, 65)
            angle2 = randint(40, 70)
            ans = 180 - angle1 - angle2
            
            d = DiagramObj(300, 250)
            polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightblue", stroke="black", stroke_width=2)
            point!(d, 50, 200, "A", :left)
            point!(d, 250, 200, "B", :right)
            point!(d, 150, 50, "C", :top)
            text!(d, 60, 180, "$(angle1)°", font_size=14)
            text!(d, 230, 180, "$(angle2)°", font_size=14)
            text!(d, 150, 70, "x", font_size=14)
            
            problem(
                question="In triangle ABC, angle A = $(angle1)°, angle B = $(angle2)°, and angle C = x. Find x.",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "The sum of angles in a triangle equals 180°",
                    sol("Equation", "$(angle1) + $(angle2) + x = 180"),
                    sol("Simplify", "x = 180 - $(angle1) - $(angle2)"),
                    sol("Answer", "x = $(ans)")
                ),
                image=render(d),
                time=90
            )
        end
    end
end