# differential_equations - characteristic_equation (very_easy)
# Generated: 2026-03-08T20:53:24.994858

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x r λ begin
    set_topic!("differential_equations/characteristic_equation")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Identify if a given number is a root of the characteristic equation
        # ELO: 200-400 (recognition)
        r_val = randint(-8, 8)
        char_eq = expand((r - r_val) * (r - randint(-8, 8)))
        
        is_root = choice([true, false])
        test_val = is_root ? r_val : (r_val + nonzero(-5, 5))
        
        result = substitute(char_eq, r => test_val)
        answer = is_root ? "Yes" : "No"
        
        problem(
            question="Is \\(r = $(test_val)\\) a root of the characteristic equation \\($(tex(char_eq)) = 0\\)?",
            answer=answer,
            difficulty=(200, 400),
            answer_type="multiple_choice",
            solution=steps(
                sol("Characteristic equation", char_eq ~ 0),
                "Substitute \\(r = $(test_val)\\)",
                sol("Result", result),
                "Since the result is $(result == 0 ? "zero" : "not zero"), the answer is $(answer)"
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Type 2: Find the characteristic equation from a simple second-order ODE
        # ELO: 400-600 (one clear step)
        a = nonzero(-9, 9)
        b = randint(-15, 15)
        
        char_eq = r^2 + a*r + b
        
        problem(
            question="Write the characteristic equation for \\(y'' + $(a)y' + $(b)y = 0\\)",
            answer=char_eq,
            difficulty=(400, 600),
            solution=steps(
                "For the differential equation \\(y'' + $(a)y' + $(b)y = 0\\)",
                "Replace \\(y''\\) with \\(r^2\\), \\(y'\\) with \\(r\\), and \\(y\\) with \\(1\\)",
                sol("Characteristic equation", char_eq ~ 0)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Type 3: Solve a simple characteristic equation (one root given, find the other)
        # ELO: 500-700 (basic solving)
        r1 = randint(-10, 10)
        r2 = randint(-10, 10)
        
        char_eq = expand((r - r1) * (r - r2))
        
        problem(
            question="The characteristic equation \\($(tex(char_eq)) = 0\\) has a root \\(r = $(r1)\\). Find the other root.",
            answer=r2,
            difficulty=(500, 700),
            solution=steps(
                sol("Given equation", char_eq ~ 0),
                "Factor: \\((r - $(r1))(r - $(r2)) = 0\\)",
                "The roots are \\(r = $(r1)\\) and \\(r = $(r2)\\)",
                sol("Other root", r2)
            ),
            time=75
        )
        
    else
        # Type 4: Identify coefficients in a characteristic equation
        # ELO: 300-500 (recognition/identification)
        a = nonzero(-12, 12)
        b = randint(-20, 20)
        
        char_eq = r^2 + a*r + b
        
        which_coeff = choice(["constant", "linear"])
        
        if which_coeff == "constant"
            answer = b
            problem(
                question="In the characteristic equation \\($(tex(char_eq)) = 0\\), what is the constant term?",
                answer=answer,
                difficulty=(300, 500),
                solution=steps(
                    sol("Characteristic equation", char_eq ~ 0),
                    "The equation is in the form \\(r^2 + $(a)r + $(b) = 0\\)",
                    sol("Constant term", b)
                ),
                time=45
            )
        else
            answer = a
            problem(
                question="In the characteristic equation \\($(tex(char_eq)) = 0\\), what is the coefficient of \\(r\\)?",
                answer=answer,
                difficulty=(300, 500),
                solution=steps(
                    sol("Characteristic equation", char_eq ~ 0),
                    "The equation is in the form \\(r^2 + $(a)r + $(b) = 0\\)",
                    sol("Coefficient of r", a)
                ),
                time=45
            )
        end
    end
end