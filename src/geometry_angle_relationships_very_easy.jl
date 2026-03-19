# geometry - angle_relationships (very_easy)
# Generated: 2026-03-08T20:01:36.917952

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/angle_relationships")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Complementary angles (100-300 ELO)
        angle1 = randint(15, 75)
        angle2 = 90 - angle1
        
        d = DiagramObj(300, 200)
        point!(d, 150, 150, "A")
        point!(d, 250, 150, "B")
        point!(d, 150, 50, "C")
        line!(d, 150, 150, 250, 150)
        line!(d, 150, 150, 150, 50)
        right_angle!(d, 250, 150, 150, 150, 150, 50)
        text!(d, 200, 160, "$(angle1)°", font_size=14)
        text!(d, 140, 100, "?", font_size=16)
        
        problem(
            question="Two angles are complementary. If one angle measures $(angle1)°, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(200, 400),
            solution=steps(
                "Complementary angles add up to 90°",
                sol("Equation", "$(angle1)° + x = 90°"),
                sol("Answer", "x = $(angle2)°")
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == 2
        # Supplementary angles (100-300 ELO)
        angle1 = randint(40, 140)
        angle2 = 180 - angle1
        
        d = DiagramObj(350, 150)
        point!(d, 50, 75, "A")
        point!(d, 175, 75, "B")
        point!(d, 300, 75, "C")
        line!(d, 50, 75, 300, 75)
        line!(d, 175, 75, 175, 30)
        text!(d, 140, 60, "$(angle1)°", font_size=14)
        text!(d, 210, 60, "?", font_size=16)
        
        problem(
            question="Two angles form a linear pair. If one angle measures $(angle1)°, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(200, 400),
            solution=steps(
                "Linear pairs (supplementary angles) add up to 180°",
                sol("Equation", "$(angle1)° + x = 180°"),
                sol("Answer", "x = $(angle2)°")
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == 3
        # Vertical angles (300-500 ELO)
        angle = randint(25, 155)
        
        d = DiagramObj(300, 300)
        line!(d, 50, 150, 250, 150)
        line!(d, 150, 50, 150, 250)
        text!(d, 190, 130, "$(angle)°", font_size=14)
        text!(d, 110, 170, "?", font_size=16)
        
        problem(
            question="Two lines intersect as shown in the diagram. If one angle measures $(angle)°, what is the measure of the angle marked with '?'?",
            answer=angle,
            difficulty=(300, 500),
            solution=steps(
                "The marked angles are vertical angles",
                "Vertical angles are congruent (equal in measure)",
                sol("Answer", "$(angle)°")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == 4
        # Adjacent angles on a line (400-600 ELO)
        angle1 = randint(40, 90)
        angle2 = randint(30, 80)
        angle3 = 180 - angle1 - angle2
        
        d = DiagramObj(400, 150)
        point!(d, 50, 75, "A")
        point!(d, 350, 75, "D")
        point!(d, 200, 75, "B")
        line!(d, 50, 75, 350, 75)
        line!(d, 200, 75, 150, 25)
        line!(d, 200, 75, 270, 30)
        text!(d, 160, 60, "$(angle1)°", font_size=13)
        text!(d, 230, 60, "$(angle2)°", font_size=13)
        text!(d, 195, 95, "?", font_size=16)
        
        problem(
            question="Three angles form a straight line as shown. If two of the angles measure $(angle1)° and $(angle2)°, what is the measure of the third angle?",
            answer=angle3,
            difficulty=(400, 600),
            solution=steps(
                "Angles on a straight line add up to 180°",
                sol("Equation", "$(angle1)° + $(angle2)° + x = 180°"),
                sol("Simplify", "$(angle1 + angle2)° + x = 180°"),
                sol("Answer", "x = $(angle3)°")
            ),
            image=render(d),
            time=75
        )
        
    elseif problem_type == 5
        # Angle pair identification (200-400 ELO)
        angle = randint(35, 85)
        angle_comp = 90 - angle
        
        d = DiagramObj(300, 200)
        point!(d, 150, 150, "B")
        point!(d, 250, 150, "C")
        point!(d, 150, 50, "A")
        line!(d, 150, 150, 250, 150)
        line!(d, 150, 150, 150, 50)
        right_angle!(d, 250, 150, 150, 150, 150, 50)
        angle_arc!(d, 250, 150, 150, 150, 150, 80, 30)
        text!(d, 190, 120, "$(angle)°", font_size=14)
        
        problem(
            question="In the diagram, angle ABC is a right angle. If angle ABD measures $(angle)°, what is the measure of angle DBC?",
            answer=angle_comp,
            difficulty=(300, 500),
            solution=steps(
                "Angle ABC is a right angle, so it measures 90°",
                "Angles ABD and DBC are adjacent and together form angle ABC",
                sol("Equation", "$(angle)° + x = 90°"),
                sol("Answer", "x = $(angle_comp)°")
            ),
            image=render(d),
            time=60
        )
        
    else
        # Finding unknown angle given relationship (500-700 ELO)
        coef = rand(2:4)
        const_term = randint(5, 25)
        angle1_measure = randint(30, 70)
        angle2_measure = coef * angle1_measure + const_term
        
        if angle1_measure + angle2_measure <= 180
            relationship = "supplementary"
            total = 180
        else
            relationship = "complementary"
            total = 90
            # Recalculate to fit
            angle1_measure = randint(10, 25)
            angle2_measure = coef * angle1_measure + const_term
            for _attempt in 1:1000
                angle1_measure + angle2_measure > 90 || break
                const_term = randint(-10, 10)
                angle2_measure = coef * angle1_measure + const_term
            end
        end
        
        d = DiagramObj(350, 150)
        if relationship == "supplementary"
            point!(d, 50, 75, "A")
            point!(d, 175, 75, "B")
            point!(d, 300, 75, "C")
            line!(d, 50, 75, 300, 75)
            line!(d, 175, 75, 175, 30)
            text!(d, 140, 60, "x°", font_size=14)
            text!(d, 210, 60, "($(coef)x$(const_term >= 0 ? "+" : "")$(const_term))°", font_size=13)
        else
            point!(d, 150, 150, "B")
            point!(d, 250, 150, "C")
            point!(d, 150, 50, "A")
            line!(d, 150, 150, 250, 150)
            line!(d, 150, 150, 150, 50)
            right_angle!(d, 250, 150, 150, 150, 150, 50)
            text!(d, 190, 160, "x°", font_size=14)
            text!(d, 130, 100, "($(coef)x$(const_term >= 0 ? "+" : "")$(const_term))°", font_size=13)
        end
        
        problem(
            question="Two angles are $(relationship). One angle measures x° and the other measures ($(coef)x$(const_term >= 0 ? "+" : "")$(const_term))°. Find the value of x.",
            answer=angle1_measure,
            difficulty=(500, 700),
            solution=steps(
                "$(relationship == "supplementary" ? "Supplementary" : "Complementary") angles add up to $(total)°",
                sol("Equation", "x + ($(coef)x $(const_term >= 0 ? "+" : "") $(const_term)) = $(total)"),
                sol("Combine like terms", "$(coef + 1)x $(const_term >= 0 ? "+" : "") $(const_term) = $(total)"),
                sol("Solve", "$(coef + 1)x = $(total - const_term)"),
                sol("Answer", "x = $(angle1_measure)°")
            ),
            image=render(d),
            time=90
        )
    end
end