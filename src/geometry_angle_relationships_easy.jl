# geometry - angle_relationships (easy)
# Generated: 2026-03-08T20:01:42.679848

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/angle_relationships")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complementary angles
        angle1 = randint(15, 75)
        angle2 = 90 - angle1
        
        d = DiagramObj(300, 200)
        point!(d, 50, 150, "A")
        point!(d, 150, 150, "B")
        point!(d, 150, 50, "C")
        line!(d, 50, 150, 150, 150)
        line!(d, 150, 150, 150, 50)
        right_angle!(d, 150, 150, 20)
        text!(d, 100, 160, "$(angle1)°", 14)
        text!(d, 160, 100, "?", 14)
        
        problem(
            question="Two angles are complementary. If one angle measures $(angle1)°, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(700, 900),
            solution=steps(
                "Complementary angles sum to 90°",
                sol("Equation", "$(angle1)° + x = 90°"),
                "Subtract $(angle1)° from both sides",
                sol("Answer", "x = $(angle2)°")
            ),
            time=60,
            image=render(d)
        )
        
    elseif problem_type == 2
        # Supplementary angles
        angle1 = randint(40, 140)
        angle2 = 180 - angle1
        
        d = DiagramObj(350, 150)
        point!(d, 50, 75, "A")
        point!(d, 300, 75, "B")
        point!(d, 175, 30, "C")
        line!(d, 50, 75, 300, 75)
        line!(d, 175, 75, 175, 30)
        text!(d, 120, 85, "$(angle1)°", 14)
        text!(d, 230, 85, "?", 14)
        
        problem(
            question="Two angles are supplementary. If one angle measures $(angle1)°, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(700, 900),
            solution=steps(
                "Supplementary angles sum to 180°",
                sol("Equation", "$(angle1)° + x = 180°"),
                "Subtract $(angle1)° from both sides",
                sol("Answer", "x = $(angle2)°")
            ),
            time=60,
            image=render(d)
        )
        
    elseif problem_type == 3
        # Vertical angles
        angle1 = randint(35, 145)
        
        d = DiagramObj(300, 300)
        line!(d, 50, 150, 250, 150)
        line!(d, 150, 50, 150, 250)
        text!(d, 190, 120, "$(angle1)°", 14)
        text!(d, 110, 180, "?", 14)
        
        problem(
            question="Two lines intersect forming vertical angles. If one angle measures $(angle1)°, what is the measure of its vertical angle?",
            answer=angle1,
            difficulty=(700, 850),
            solution=steps(
                "Vertical angles are congruent",
                "Vertical angles have equal measures",
                sol("Answer", "x = $(angle1)°")
            ),
            time=45,
            image=render(d)
        )
        
    elseif problem_type == 4
        # Linear pair with algebraic expression
        a = nonzero(2, 8)
        b = randint(10, 50)
        # ax + b + (180 - ax - b) = 180
        # Solve for specific x that gives reasonable angle
        x_val = randint(5, 15)
        angle1 = a * x_val + b
        angle2 = 180 - angle1
        
        d = DiagramObj(350, 150)
        point!(d, 50, 75, "A")
        point!(d, 300, 75, "B")
        point!(d, 175, 30, "C")
        line!(d, 50, 75, 300, 75)
        line!(d, 175, 75, 175, 30)
        text!(d, 100, 85, "$(a)x + $(b)", 14)
        text!(d, 230, 85, "$(angle2)°", 14)
        
        problem(
            question="Two angles form a linear pair. One angle measures \$($(a)x + $(b))°\$ and the other measures $(angle2)°. Find the value of \$x\$.",
            answer=x_val,
            difficulty=(900, 1100),
            solution=steps(
                "Linear pairs are supplementary (sum to 180°)",
                sol("Equation", "($(a)x + $(b)) + $(angle2) = 180"),
                "Simplify: \$$(a)x + $(b + angle2) = 180\$",
                "Subtract $(b + angle2) from both sides: \$$(a)x = $(180 - b - angle2)\$",
                sol("Answer", "x = $(x_val)")
            ),
            time=90,
            image=render(d)
        )
        
    else
        # Complementary angles with algebraic expressions
        a = nonzero(2, 6)
        b = randint(5, 25)
        # ax + (bx + c) = 90
        c = randint(5, 20)
        total_coeff = a + b
        x_val = div(90 - c, total_coeff)
        if x_val < 2
            x_val = randint(5, 10)
            c = 90 - total_coeff * x_val
        end
        angle1 = a * x_val
        angle2 = b * x_val + c
        
        d = DiagramObj(300, 200)
        point!(d, 50, 150, "A")
        point!(d, 150, 150, "B")
        point!(d, 150, 50, "C")
        line!(d, 50, 150, 150, 150)
        line!(d, 150, 150, 150, 50)
        right_angle!(d, 150, 150, 20)
        text!(d, 100, 160, "$(a)x", 14)
        text!(d, 160, 100, "$(b)x + $(c)", 14)
        
        problem(
            question="Two angles are complementary. One angle measures \$($(a)x)°\$ and the other measures \$($(b)x + $(c))°\$. Find the value of \$x\$.",
            answer=x_val,
            difficulty=(1000, 1200),
            solution=steps(
                "Complementary angles sum to 90°",
                sol("Equation", "$(a)x + ($(b)x + $(c)) = 90"),
                "Combine like terms: \$$(total_coeff)x + $(c) = 90\$",
                "Subtract $(c) from both sides: \$$(total_coeff)x = $(90 - c)\$",
                sol("Answer", "x = $(x_val)")
            ),
            time=120,
            image=render(d)
        )
    end
end