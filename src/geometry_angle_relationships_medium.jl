# geometry - angle_relationships (medium)
# Generated: 2026-03-08T20:01:54.954045

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/angle_relationships")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complementary angles problem (1200-1400)
        x_val = randint(15, 75)
        angle1 = x_val
        angle2 = 90 - x_val
        
        # Create diagram
        d = DiagramObj(width=400, height=300)
        # Draw two complementary angles
        line!(d, 50, 250, 200, 250)  # horizontal base
        line!(d, 50, 250, 50, 100)   # vertical line
        line!(d, 50, 250, 150, 150)  # angle bisector
        
        angle_arc!(d, 50, 250, 40, 0, angle1, label="$(angle1)°")
        angle_arc!(d, 50, 250, 50, angle1, 90, label="$(angle2)°")
        
        text!(d, 200, 50, "Complementary Angles", fontsize=16)
        
        problem(
            question="Two angles are complementary. If one angle measures $(angle1)°, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(1200, 1400),
            solution=steps(
                "Complementary angles sum to 90°",
                sol("Setup", "$(angle1)° + x = 90°"),
                sol("Solve", "x = 90° - $(angle1)° = $(angle2)°")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == 2
        # Supplementary angles with algebra (1300-1500)
        k = randint(2, 8)
        x_val = randint(10, 25)
        angle1_expr = k * x_val + randint(-20, 20)
        angle2 = 180 - angle1_expr
        
        # Create diagram
        d = DiagramObj(width=450, height=250)
        line!(d, 50, 150, 400, 150)
        line!(d, 225, 150, 300, 50)
        
        angle_arc!(d, 225, 150, 50, 0, 180 - atan((150-50)/(300-225))*180/π, label="$(angle1_expr)°")
        angle_arc!(d, 225, 150, 60, 180 - atan((150-50)/(300-225))*180/π, 180, label="$(angle2)°")
        
        text!(d, 200, 220, "Supplementary Angles", fontsize=16)
        
        problem(
            question="Two angles are supplementary. If one angle measures $(angle1_expr)°, find the measure of the other angle.",
            answer=angle2,
            difficulty=(1300, 1500),
            solution=steps(
                "Supplementary angles sum to 180°",
                sol("Setup", "$(angle1_expr)° + x = 180°"),
                sol("Solve", "x = 180° - $(angle1_expr)° = $(angle2)°")
            ),
            image=render(d),
            time=75
        )
        
    elseif problem_type == 3
        # Vertical angles (1200-1400)
        angle_measure = randint(35, 145)
        
        # Create diagram with intersecting lines
        d = DiagramObj(width=400, height=400)
        line!(d, 50, 200, 350, 200)  # horizontal
        line!(d, 120, 50, 280, 350)  # diagonal
        
        point!(d, 200, 200, label="", size=4)
        
        angle_arc!(d, 200, 200, 40, 0, atan((200-50)/(280-120))*180/π, label="$(angle_measure)°")
        angle_arc!(d, 200, 200, 40, 180, 180 + atan((200-50)/(280-120))*180/π, label="x")
        
        text!(d, 200, 380, "Find x (vertical angles)", fontsize=16)
        
        problem(
            question="Two lines intersect forming vertical angles. If one angle measures $(angle_measure)°, find the measure of its vertical angle x.",
            answer=angle_measure,
            difficulty=(1200, 1400),
            solution=steps(
                "Vertical angles are congruent",
                sol("Property", "Vertical angles have equal measures"),
                sol("Answer", "x = $(angle_measure)°")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == 4
        # Linear pair with algebra (1400-1600)
        coef = randint(2, 6)
        x_val = randint(15, 30)
        const_term = randint(-15, 15)
        
        angle1 = coef * x_val + const_term
        angle2 = 180 - angle1
        
        # Create diagram
        d = DiagramObj(width=450, height=250)
        line!(d, 50, 150, 400, 150)
        line!(d, 225, 150, 300, 50)
        
        angle_arc!(d, 225, 150, 50, 0, atan((150-50)/(300-225))*180/π, label="($(coef)x$(const_term >= 0 ? "+" : "")$(const_term))°")
        angle_arc!(d, 225, 150, 60, atan((150-50)/(300-225))*180/π, 180, label="$(angle2)°")
        
        text!(d, 180, 220, "Linear Pair - Find x", fontsize=16)
        
        problem(
            question="Two angles form a linear pair. One angle measures ($(coef)x $(const_term >= 0 ? "+" : "") $(const_term))° and the other measures $(angle2)°. Find the value of x.",
            answer=x_val,
            difficulty=(1400, 1600),
            solution=steps(
                "Linear pairs sum to 180°",
                sol("Equation", "($(coef)x $(const_term >= 0 ? "+" : "") $(const_term)) + $(angle2) = 180"),
                sol("Simplify", "$(coef)x = $(180 - angle2 - const_term)"),
                sol("Answer", "x = $(x_val)")
            ),
            image=render(d),
            time=90
        )
        
    else
        # Angles around a point (1500-1700)
        x_val = randint(12, 35)
        angle1 = randint(40, 80)
        angle2 = randint(50, 90)
        coef1 = randint(2, 4)
        coef2 = randint(2, 4)
        
        angle3 = coef1 * x_val
        angle4 = coef2 * x_val
        
        # Adjust to make sure sum is 360
        total_known = angle1 + angle2
        total_var = coef1 + coef2
        x_val = (360 - total_known) ÷ total_var
        
        angle3 = coef1 * x_val
        angle4 = coef2 * x_val
        
        # Create diagram
        d = DiagramObj(width=400, height=400)
        point!(d, 200, 200, label="", size=5)
        
        # Draw four rays from center
        line!(d, 200, 200, 350, 200)  # 0°
        line!(d, 200, 200, 280, 80)   # angle1
        line!(d, 200, 200, 120, 120)  # angle1 + angle2
        line!(d, 200, 200, 120, 280)  # remaining
        
        angle_arc!(d, 200, 200, 40, 0, 40, label="$(angle1)°")
        angle_arc!(d, 200, 200, 50, 50, 110, label="$(angle2)°")
        angle_arc!(d, 200, 200, 45, 120, 180, label="$(coef1)x°")
        angle_arc!(d, 200, 200, 55, 190, 300, label="$(coef2)x°")
        
        text!(d, 200, 380, "Angles around a point - Find x", fontsize=16)
        
        problem(
            question="Four angles meet at a point. The angles measure $(angle1)°, $(angle2)°, $(coef1)x°, and $(coef2)x°. Find the value of x.",
            answer=x_val,
            difficulty=(1500, 1700),
            solution=steps(
                "Angles around a point sum to 360°",
                sol("Equation", "$(angle1) + $(angle2) + $(coef1)x + $(coef2)x = 360"),
                sol("Simplify", "$(angle1 + angle2) + $(coef1 + coef2)x = 360"),
                sol("Solve", "$(coef1 + coef2)x = $(360 - angle1 - angle2)"),
                sol("Answer", "x = $(x_val)")
            ),
            image=render(d),
            time=120
        )
    end
end