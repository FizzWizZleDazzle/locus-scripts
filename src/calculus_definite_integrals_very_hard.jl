# calculus - definite_integrals (very_hard)
# Generated: 2026-03-08T20:47:36.685010

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t n begin
    set_topic!("calculus/definite_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Symmetric function trick (ELO 2500-2800)
        k = randint(2, 6)
        a = randint(3, 10)
        
        # Choose odd or even function with twist
        func_choice = rand(1:3)
        if func_choice == 1
            # f(x) = x^k * sin(x) type (odd)
            integrand = x^k * sin(x)
            ans = 0
            explanation = "The integrand is an odd function since \\(f(-x) = -f(x)\\)"
        elseif func_choice == 2
            # f(x) = x^(2k-1) * cos(x^2) (odd)
            integrand = x^(2k-1) * cos(x^2)
            ans = 0
            explanation = "The integrand is an odd function"
        else
            # Non-symmetric but evaluates nicely
            m = randint(2, 5)
            integrand = x^(2m-1)
            ans = 0  # symmetric limits, odd power
            explanation = "Odd function over symmetric interval"
        end
        
        problem(
            question="Evaluate \\displaystyle \\int_{-$a}^{$a} $(tex(integrand)) \\, dx",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given integral", "\\int_{-$a}^{$a} $(tex(integrand)) \\, dx"),
                explanation,
                "Therefore, the integral over the symmetric interval is 0",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Feynman's trick / parameter differentiation (ELO 2800-3200)
        a = randint(2, 8)
        b = randint(2, 8)
        
        # Integral of form involving parameter
        param_type = rand(1:2)
        if param_type == 1
            # ∫₀^π x sin(ax) dx type problem
            integrand_tex = "x \\sin($a x)"
            # Result: (sin(aπ) - aπcos(aπ))/(a²)
            ans_val = (sin(a*π) - a*π*cos(a*π))/(a^2)
            ans = round(ans_val, digits=6)
            
            problem(
                question="Evaluate \\displaystyle \\int_0^{\\pi} $integrand_tex \\, dx",
                answer=ans,
                difficulty=(2800, 3200),
                solution=steps(
                    "Use integration by parts with \\(u = x\\), \\(dv = \\sin($a x)dx\\)",
                    "Then \\(du = dx\\), \\(v = -\\frac{1}{$a}\\cos($a x)\\)",
                    "Applying the formula and evaluating limits",
                    sol("Answer", ans)
                ),
                time=240
            )
        else
            # Leibniz integral rule application
            c = randint(1, 4)
            integrand_tex = "\\frac{\\sin($a x)}{x}"
            ans = π/2  # Classic result for certain values
            
            problem(
                question="Evaluate \\displaystyle \\int_0^{\\infty} $integrand_tex e^{-$c x} \\, dx\\quad (Use Feynman's technique or known results)",
                answer=round(atan(a/c), digits=6),
                difficulty=(3000, 3400),
                solution=steps(
                    "Consider the parametric family \\(I(t) = \\int_0^\\infty \\frac{\\sin(ax)}{x}e^{-tx}dx\\)",
                    "Differentiate under the integral sign with respect to \\(t\\)",
                    "Solve the resulting differential equation and apply limits",
                    sol("Answer", round(atan(a/c), digits=6))
                ),
                time=300
            )
        end
        
    elseif problem_type == 3
        # Inequality + integral bounds (ELO 2600-3000)
        n_val = randint(3, 8)
        a = randint(2, 6)
        
        # Problem about bounding an integral
        bound_type = rand(1:2)
        if bound_type == 1
            # Estimate ∫ₐᵇ f(x)dx using bounds
            lower_bound = a^(n_val+1)/(n_val+1)
            upper_bound = (a+1)^(n_val+1)/(n_val+1)
            
            problem(
                question="Find an upper bound for \\displaystyle \\int_0^{$a} \\frac{x^{$n_val}}{1+x^2} \\, dx",
                answer=round(a^(n_val+1)/(n_val+1), digits=4),
                difficulty=(2600, 3000),
                solution=steps(
                    "Note that \\(\\frac{x^{$n_val}}{1+x^2} \\leq x^{$n_val}\\) for \\(x \\geq 0\\)",
                    "Therefore \\displaystyle \\int_0^{$a} \\frac{x^{$n_val}}{1+x^2} dx \\leq \\int_0^{$a} x^{$n_val} dx",
                    "Evaluate: \\(\\int_0^{$a} x^{$n_val} dx = \\frac{$a^{$(n_val+1)}}{$(n_val+1)}\\)",
                    sol("Answer", round(a^(n_val+1)/(n_val+1), digits=4))
                ),
                time=240
            )
        else
            # Squeeze theorem for limits of integrals
            ans = 1
            problem(
                question="Evaluate \\displaystyle \\lim_{n\\to\\infty} n\\int_0^1 x^n e^{-x} \\, dx",
                answer=ans,
                difficulty=(2800, 3200),
                solution=steps(
                    "For large \\(n\\), \\(x^n\\) concentrates near \\(x=1\\) on \\([0,1]\\)",
                    "Use dominated convergence or bound: \\(n\\int_0^1 x^n e^{-x}dx \\approx n\\int_0^1 x^n e^{-1}dx\\)",
                    "This gives \\(\\frac{ne^{-1}}{n+1} \\to e^{-1} \\cdot 1 = 1/e\\)",
                    sol("Answer", ans)
                ),
                time=270
            )
        end
        
    elseif problem_type == 4
        # Contour/residue inspired or special substitution (ELO 3000-3500)
        param = randint(2, 5)
        
        special_type = rand(1:2)
        if special_type == 1
            # ∫₀^∞ special rational function
            # Using residue calculus ideas
            ans = π / (2*param)
            
            problem(
                question="Evaluate \\displaystyle \\int_0^{\\infty} \\frac{dx}{1+x^{$param}}",
                answer=round(π/(param * sin(π/param)), digits=6),
                difficulty=(3000, 3500),
                solution=steps(
                    "Use the substitution \\(u = x^{$param}\\), or apply residue theorem",
                    "The integral equals \\(\\frac{1}{$param}\\int_0^\\infty \\frac{u^{1/$param - 1}}{1+u}du\\)",
                    "This is a Beta function: \\(\\frac{\\pi}{$param \\sin(\\pi/$param)}\\)",
                    sol("Answer", round(π/(param * sin(π/param)), digits=6))
                ),
                time=300
            )
        else
            # Gaussian-type integral variation
            a = randint(2, 5)
            ans = sqrt(π/a) / 2
            
            problem(
                question="Evaluate \\displaystyle \\int_0^{\\infty} e^{-$a x^2} \\, dx",
                answer=round(sqrt(π/a)/2, digits=6),
                difficulty=(2800, 3200),
                solution=steps(
                    "This is a Gaussian integral variant",
                    "Use \\(\\int_0^\\infty e^{-ax^2}dx = \\frac{1}{2}\\sqrt{\\frac{\\pi}{a}}\\)",
                    "Substitute \\(a = $a\\)",
                    sol("Answer", round(sqrt(π/a)/2, digits=6))
                ),
                time=240
            )
        end
        
    else
        # Interchange of integration order / Fubini (ELO 2700-3300)
        a = randint(2, 6)
        b = randint(2, 6)
        
        # ∫∫ problem requiring order switch
        problem(
            question="Evaluate \\displaystyle \\int_0^{$a} \\int_x^{$a} e^{y^2} \\, dy \\, dx by reversing the order of integration",
            answer=round((exp(a^2) - 1)/2, digits=4),
            difficulty=(2700, 3300),
            solution=steps(
                "The region is \\(0 \\leq x \\leq y \\leq $a\\)",
                "Reverse to \\displaystyle \\int_0^{$a} \\int_0^y e^{y^2} \\, dx \\, dy = \\int_0^{$a} y e^{y^2} dy",
                "Substitute \\(u = y^2\\), \\(du = 2y\\,dy\\)",
                sol("Answer", round((exp(a^2) - 1)/2, digits=4))
            ),
            time=270
        )
    end
end