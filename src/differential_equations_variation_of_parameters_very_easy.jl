# differential_equations - variation_of_parameters (very_easy)
# Generated: 2026-03-08T20:55:11.175017

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/variation_of_parameters")
    
    # For FOUNDATIONAL/ELEMENTARY (100-700), we need very basic problems
    # These should be recognition/recall or single-step conceptual questions
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Identify if variation of parameters is needed (200-400 ELO)
        homogeneous = choice([true, false])
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-10, 10)
        
        if homogeneous
            rhs = 0
            question_text = "Is the differential equation \$y'' + $(a)y' + $(b)y = 0\$ homogeneous or nonhomogeneous?"
            ans = "homogeneous"
            sol_text = "The right-hand side is zero, so this is a homogeneous equation."
        else
            rhs = c
            question_text = "Is the differential equation \$y'' + $(a)y' + $(b)y = $(rhs)\$ homogeneous or nonhomogeneous?"
            ans = "nonhomogeneous"
            sol_text = "The right-hand side is nonzero, so this is a nonhomogeneous equation."
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                "A differential equation is homogeneous if the right-hand side equals zero",
                sol_text,
                "Answer: $(ans)"
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Type 2: Recognize the form needed for variation of parameters (400-600 ELO)
        y1_type = choice(["e^{$(randint(2,5))x}", "\\sin($(randint(2,4))x)", "\\cos($(randint(2,4))x)", "x^$(randint(2,3))"])
        y2_type = choice(["e^{-$(randint(2,5))x}", "\\cos($(randint(2,4))x)", "\\sin($(randint(2,4))x)", "x"])
        
        question_text = "For variation of parameters, if \$y_1 = $(y1_type)\$ and \$y_2 = $(y2_type)\$ are solutions to the homogeneous equation, what form does the particular solution take? Answer with: y_p = u_1*y_1 + u_2*y_2"
        ans = "y_p = u_1*y_1 + u_2*y_2"
        
        problem(
            question=question_text,
            answer=ans,
            answer_type="text",
            difficulty=(400, 600),
            solution=steps(
                "In variation of parameters, we assume a particular solution of the form \$y_p = u_1(x)y_1(x) + u_2(x)y_2(x)\$",
                "where \$y_1\$ and \$y_2\$ are solutions to the homogeneous equation",
                "Answer: \$y_p = u_1 y_1 + u_2 y_2\$"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Type 3: Identify what functions are needed (500-700 ELO)
        question_text = "To use variation of parameters on a second-order linear differential equation, what must you first find?"
        ans = choice([
            "solutions to the homogeneous equation",
            "the homogeneous solutions"
        ])
        
        problem(
            question=question_text,
            answer=ans,
            answer_type="text",
            difficulty=(500, 700),
            solution=steps(
                "Variation of parameters requires the general solution to the homogeneous equation",
                "We need two linearly independent solutions \$y_1\$ and \$y_2\$ to the homogeneous equation",
                "Answer: solutions to the homogeneous equation"
            ),
            time=60
        )
        
    else
        # Type 4: Recognize when to use variation of parameters vs undetermined coefficients (600-700 ELO)
        rhs_options = [
            ("e^x / x", "variation of parameters", "The function \$e^x/x\$ is not a simple polynomial, exponential, sine, or cosine"),
            ("ln(x)", "variation of parameters", "The function \$\\ln(x)\$ is not covered by undetermined coefficients"),
            ("sec(x)", "variation of parameters", "The function \$\\sec(x)\$ requires variation of parameters"),
            ("x^2 + 3", "undetermined coefficients", "The function \$x^2 + 3\$ is a polynomial"),
            ("5e^{2x}", "undetermined coefficients", "The function \$5e^{2x}\$ is a simple exponential"),
        ]
        
        selected = choice(rhs_options)
        rhs_func = selected[1]
        ans = selected[2]
        explanation = selected[3]
        
        question_text = "For the differential equation \$y'' + y' - 2y = $(rhs_func)\$, which method should you use: undetermined coefficients or variation of parameters?"
        
        problem(
            question=question_text,
            answer=ans,
            answer_type="text",
            difficulty=(600, 700),
            solution=steps(
                "Undetermined coefficients works for polynomials, exponentials, sines, and cosines",
                explanation,
                "Answer: $(ans)"
            ),
            time=75
        )
    end
end