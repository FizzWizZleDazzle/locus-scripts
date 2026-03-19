# calculus - volumes_of_revolution (very_easy)
# Generated: 2026-03-08T20:48:25.162405

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/volumes_of_revolution")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Basic disk method - constant function rotated about x-axis
        # ELO 200-400: Recognition/identification
        h = randint(2, 8)
        r = randint(2, 8)
        volume = π * h^2 * r
        
        problem(
            question="A rectangle with height \\($(h)\\) and width \\($(r)\\) is rotated about the x-axis. What is the volume of the resulting cylinder? (Leave answer in terms of \\(\\pi\\))",
            answer=volume,
            difficulty=(200, 400),
            solution=steps(
                "For a cylinder, \\(V = \\pi r^2 h\\)",
                "The radius is \\(r = $(h)\\) and height is \\(h = $(r)\\)",
                sol("Volume", volume)
            ),
            time=60,
            calculator="scientific"
        )
        
    elseif prob_type == 2
        # Identify the correct integral setup
        # ELO 400-600: Recognition of method
        a = randint(1, 5)
        b = randint(a + 1, a + 6)
        c = randint(1, 4)
        
        func_str = "f(x) = $(c)"
        correct = "\\int_{$(a)}^{$(b)} \\pi ($(c))^2 \\, dx"
        
        problem(
            question="Which integral represents the volume when the region under \\($(func_str)\\) from \\(x = $(a)\\) to \\(x = $(b)\\) is rotated about the x-axis using the disk method?",
            answer=correct,
            difficulty=(400, 600),
            solution=steps(
                "The disk method formula is \\(V = \\int_a^b \\pi [f(x)]^2 \\, dx\\)",
                "Here \\(f(x) = $(c)\\), \\(a = $(a)\\), \\(b = $(b)\\)",
                sol("Integral", correct)
            ),
            time=75,
            answer_type="expression"
        )
        
    elseif prob_type == 3
        # Evaluate a simple disk integral (constant or linear)
        # ELO 500-700: Basic computation
        if rand(Bool)
            # Constant function
            h = randint(2, 6)
            a = randint(0, 3)
            b = randint(a + 2, a + 8)
            
            volume = π * h^2 * (b - a)
            
            problem(
                question="Find the volume when \\(y = $(h)\\) from \\(x = $(a)\\) to \\(x = $(b)\\) is rotated about the x-axis. (Leave answer in terms of \\(\\pi\\))",
                answer=volume,
                difficulty=(500, 700),
                solution=steps(
                    "Use disk method: \\(V = \\int_{$(a)}^{$(b)} \\pi ($(h))^2 \\, dx\\)",
                    sol("Simplify", "V = \\pi \\cdot $(h^2) \\int_{$(a)}^{$(b)} dx = $(π * h^2) [x]_{$(a)}^{$(b)}"),
                    sol("Volume", volume)
                ),
                time=90,
                calculator="scientific"
            )
        else
            # Linear function y = x
            a = randint(0, 2)
            b = randint(a + 2, a + 6)
            
            volume = π * (b^3 - a^3) // 3
            
            problem(
                question="Find the volume when \\(y = x\\) from \\(x = $(a)\\) to \\(x = $(b)\\) is rotated about the x-axis. (Leave answer in terms of \\(\\pi\\))",
                answer=volume,
                difficulty=(600, 700),
                solution=steps(
                    "Use disk method: \\(V = \\int_{$(a)}^{$(b)} \\pi x^2 \\, dx\\)",
                    sol("Integrate", "V = \\pi \\left[\\frac{x^3}{3}\\right]_{$(a)}^{$(b)} = \\frac{\\pi}{3}($(b)^3 - $(a)^3)"),
                    sol("Volume", volume)
                ),
                time=120,
                calculator="scientific"
            )
        end
        
    else
        # Identify radius for disk vs washer method
        # ELO 400-600: Conceptual understanding
        inner = randint(1, 4)
        outer = randint(inner + 2, inner + 6)
        
        problem(
            question="When rotating the region between \\(y = $(outer)\\) and \\(y = $(inner)\\) about the x-axis, what is the outer radius \\(R\\) in the washer method?",
            answer=outer,
            difficulty=(400, 600),
            solution=steps(
                "In the washer method, we have outer radius \\(R\\) and inner radius \\(r\\)",
                "The outer radius is the distance from the axis to the farther curve",
                sol("Outer radius", "R = $(outer)")
            ),
            time=60
        )
    end
end