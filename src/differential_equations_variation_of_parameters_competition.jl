# differential_equations - variation_of_parameters (competition)
# Generated: 2026-03-08T20:56:18.053246

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/variation_of_parameters")
    
    # Generate a challenging variation of parameters problem
    # y'' + p(x)y' + q(x)y = g(x)
    # We'll use second-order linear ODEs with non-constant coefficients
    
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Euler equation with variation of parameters
        # x²y'' + axy' + by = g(x)
        a = rand([1, 2, 3, 4])
        b = rand([-4, -3, -2, -1, 1, 2, 3, 4])
        
        # Characteristic equation: r(r-1) + ar + b = 0
        # r² + (a-1)r + b = 0
        char_a = a - 1
        char_b = b
        
        discriminant = char_a^2 - 4*char_b
        
        if discriminant > 0
            r1 = (-char_a + sqrt(discriminant)) / 2
            r2 = (-char_a - sqrt(discriminant)) / 2
            y1_str = "x^{$(r1)}"
            y2_str = "x^{$(r2)}"
            y1_desc = "x^$(r1)"
            y2_desc = "x^$(r2)"
        elseif discriminant == 0
            r = -char_a / 2
            y1_str = "x^{$(r)}"
            y2_str = "x^{$(r)}\\ln(x)"
            y1_desc = "x^$(r)"
            y2_desc = "x^$(r) ln(x)"
        else
            α = -char_a / 2
            β = sqrt(-discriminant) / 2
            y1_str = "x^{$(α)}\\cos($(β)\\ln x)"
            y2_str = "x^{$(α)}\\sin($(β)\\ln x)"
            y1_desc = "x^$(α) cos($(β) ln x)"
            y2_desc = "x^$(α) sin($(β) ln x)"
        end
        
        # Choose forcing function
        g_choices = ["x^$(rand(2:5))", "x^$(rand(2:4))\\ln(x)", "\\frac{1}{x}", "\\frac{\\ln(x)}{x}"]
        g_str = choice(g_choices)
        
        question = "Consider the Euler differential equation: \$\$x^2 y'' + $(a)xy' + $(b)y = $(g_str)\$\$ The complementary solution has fundamental solutions \\(y_1 = $(y1_str)\\) and \\(y_2 = $(y2_str)\\). Set up the variation of parameters formula for the particular solution \\(y_p = u_1(x)y_1 + u_2(x)y_2\\). What is the Wronskian \\(W(y_1, y_2)\\) in simplified form?"
        
        answer_str = "x^{$(discriminant >= 0 ? r1 + r2 - 1 : 2*α - 1)}"
        if discriminant < 0
            α = -char_a / 2
            β = sqrt(-discriminant) / 2
            answer_str = "$(β)x^{$(2*α - 1)}"
        elseif discriminant > 0
            answer_str = "$(abs(r2 - r1))x^{$(r1 + r2 - 1)}"
        else
            r = -char_a / 2
            answer_str = "x^{$(2*r - 1)}"
        end
        
        solution_text = steps(
            "Given Euler equation: \\(x^2 y'' + $(a)xy' + $(b)y = $(g_str)\\)",
            "Fundamental solutions: \\(y_1 = $(y1_str)\\), \\(y_2 = $(y2_str)\\)",
            "Compute Wronskian: \\(W = y_1 y_2' - y_2 y_1'\\)",
            "For Euler equations, \\(W(y_1, y_2) = Cx^{r_1 + r_2 - 1}\\) where \\(r_1, r_2\\) are characteristic roots",
            sol("Wronskian", answer_str)
        )
        
        difficulty_rating = (3500, 4200)
        time_estimate = 300
        
    elseif problem_type == 2
        # Bessel-type equation requiring advanced variation of parameters
        # x²y'' + xy' + (x² - ν²)y = g(x)
        ν = rand([0, 1, 2])
        
        g_choices = ["x^$(rand(2:4))", "x \\sin(x)", "x \\cos(x)", "xe^x"]
        g_str = choice(g_choices)
        
        if ν == 0
            y1_str = "J_0(x)"
            y2_str = "Y_0(x)"
        else
            y1_str = "J_{$(ν)}(x)"
            y2_str = "Y_{$(ν)}(x)"
        end
        
        question = "Consider the Bessel differential equation of order $(ν): \$\$x^2 y'' + xy' + (x^2 - $(ν^2))y = $(g_str)\$\$ Using variation of parameters with fundamental solutions \\(y_1 = $(y1_str)\\) and \\(y_2 = $(y2_str)\\), the particular solution is \\(y_p = u_1(x)y_1 + u_2(x)y_2\\) where \\(u_1' = -\\frac{y_2 g}{W}\\) and \\(u_2' = \\frac{y_1 g}{W}\\). Express the integral formula for \\(u_1(x)\\) in terms of Bessel functions."
        
        answer_str = "-\\int \\frac{$(y2_str) \\cdot $(g_str)}{x \\cdot W($(y1_str), $(y2_str))} dx"
        
        solution_text = steps(
            "Bessel equation: \\(x^2 y'' + xy' + (x^2 - $(ν^2))y = $(g_str)\\)",
            "Convert to standard form: \\(y'' + \\frac{1}{x}y' + \\frac{x^2 - $(ν^2)}{x^2}y = \\frac{$(g_str)}{x^2}\\)",
            "For variation of parameters: \\(u_1' = -\\frac{y_2 f(x)}{W}\\) where \\(f(x) = \\frac{$(g_str)}{x^2}\\)",
            "Wronskian for Bessel functions: \\(W($(y1_str), $(y2_str)) = \\frac{2}{\\pi x}\\)",
            sol("Integral formula", answer_str)
        )
        
        difficulty_rating = (4000, 4800)
        time_estimate = 360
        
    else
        # Problem type 3: Green's function approach to variation of parameters
        # y'' + p(x)y' + q(x)y = δ(x - ξ)
        
        p_val = rand([-2, -1, 0, 1, 2])
        q_val = rand([1, 4, 9, 16])
        ω = Int(sqrt(q_val))
        
        if p_val == 0
            if q_val == 1
                y1_str = "\\cos(x)"
                y2_str = "\\sin(x)"
                W_str = "1"
            else
                y1_str = "\\cos($(ω)x)"
                y2_str = "\\sin($(ω)x)"
                W_str = "$(ω)"
            end
            
            g_str = "e^{$(rand(1:3))x}"
            
            question = "For the differential equation \\(y'' + $(q_val)y = $(g_str)\\), use variation of parameters with \\(y_1 = $(y1_str)\\) and \\(y_2 = $(y2_str)\\). The Green's function method gives \\(y_p(x) = \\int_0^x G(x, \\xi) f(\\xi) d\\xi\\) where \\(G(x, \\xi) = \\frac{y_1(\\xi)y_2(x) - y_1(x)y_2(\\xi)}{W(y_1, y_2)}\\) for \\(x > \\xi\\). What is the Green's function \\(G(x, \\xi)\\) for \\(x > \\xi\\)?"
            
            answer_str = "\\frac{1}{$(W_str)}($(y1_str.replace("x", "\\xi"))$(y2_str) - $(y1_str)$(y2_str.replace("x", "\\xi")))"
            answer_str = "\\frac{1}{$(ω)}\\sin($(ω)(x - \\xi))"
            
            solution_text = steps(
                "Given: \\(y'' + $(q_val)y = $(g_str)\\) with \\(y_1 = $(y1_str)\\), \\(y_2 = $(y2_str)\\)",
                "Compute Wronskian: \\(W(y_1, y_2) = $(W_str)\\)",
                "Green's function for \\(x > \\xi\\): \\(G(x, \\xi) = \\frac{y_1(\\xi)y_2(x) - y_1(x)y_2(\\xi)}{W}\\)",
                "Substitute and simplify using trig identity",
                sol("Green's function", answer_str)
            )
            
            difficulty_rating = (3800, 4600)
            time_estimate = 320
        else
            # Damped oscillator
            y1_str = "e^{-$(abs(p_val))x/2}\\cos(\\omega x)"
            y2_str = "e^{-$(abs(p_val))x/2}\\sin(\\omega x)"
            
            g_str = choice(["\\delta(x - 1)", "\\delta(x - a)", "e^{-x}"])
            
            question = "For the damped oscillator equation \\(y'' + $(p_val)y' + $(q_val)y = $(g_str)\\), derive the integral expression for the particular solution using variation of parameters. Assume the homogeneous solutions are \\(y_1 = $(y1_str)\\) and \\(y_2 = $(y2_str)\\). What is the form of the Wronskian?"
            
            answer_str = "\\omega e^{-$(abs(p_val))x}"
            
            solution_text = steps(
                "Damped oscillator: \\(y'' + $(p_val)y' + $(q_val)y = $(g_str)\\)",
                "Fundamental solutions involve exponential decay and oscillation",
                "Compute \\(W = y_1 y_2' - y_2 y_1'\\)",
                "The exponential factors combine and oscillatory terms cancel",
                sol("Wronskian", answer_str)
            )
            
            difficulty_rating = (3600, 4400)
            time_estimate = 300
        end
    end
    
    problem(
        question=question,
        answer=answer_str,
        difficulty=difficulty_rating,
        solution=solution_text,
        time=time_estimate,
        answer_type="expression"
    )
end