# precalculus - inverse_trig_functions (hard)
# Generated: 2026-03-08T20:31:39.541631

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/inverse_trig_functions")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Solve equation involving arcsin/arccos with composition
        # e.g., arcsin(2x - 1) = π/6
        trig_func = choice([:arcsin, :arccos])
        
        # Pick clean answer first
        ans = randint(-5, 5) // randint(2, 4)
        
        # Pick clean angle with known sine/cosine
        angles_sin = [π//6 => 1//2, π//4 => sqrt(2)//2, π//3 => sqrt(3)//2, -π//6 => -1//2, -π//4 => -sqrt(2)//2]
        angles_cos = [π//6 => sqrt(3)//2, π//4 => sqrt(2)//2, π//3 => 1//2, 5*π//6 => -sqrt(3)//2]
        
        if trig_func == :arcsin
            angle_pair = choice(angles_sin)
            θ = angle_pair.first
            val = angle_pair.second
        else
            angle_pair = choice(angles_cos)
            θ = angle_pair.first
            val = angle_pair.second
        end
        
        # Construct expression: a*x + b = val, solve for x = ans
        a = nonzero(-3, 3)
        b = val - a * ans
        
        inner = a*x + b
        
        problem(
            question="Solve for \\(x\\): \\($(trig_func == :arcsin ? "\\\\arcsin" : "\\\\arccos")($(tex(inner))) = $(tex(θ))\\)",
            answer=ans,
            difficulty=(1850, 2100),
            solution=steps(
                sol("Given equation", "$(trig_func == :arcsin ? "\\\\arcsin" : "\\\\arccos")($(tex(inner))) = $(tex(θ))"),
                "Take $(trig_func == :arcsin ? "sine" : "cosine") of both sides: \\($(tex(inner)) = $(tex(val))\\)",
                "Solve for \\(x\\): \\($(tex(a*x)) = $(tex(val - b))\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Domain of composition like arcsin(quadratic)
        # arcsin requires |argument| <= 1
        q = rand_quadratic(x; a=(-3, 3), b=(-8, 8), c=(-10, 10))
        
        # Solve |q.expr| <= 1  =>  -1 <= q.expr <= 1
        # This gives us an interval
        ineq1 = q.expr - 1
        ineq2 = q.expr + 1
        
        # For expert level, create case where quadratic opens upward (a > 0)
        # then -1 <= ax² + bx + c <= 1 gives bounded interval
        while q.a <= 0 || q.a > 3
            q = rand_quadratic(x; a=(1, 3), b=(-8, 8), c=(-5, 5))
        end
        
        # Solve ax² + bx + c = 1 and ax² + bx + c = -1
        try
            sols_upper = solve(q.expr ~ 1, x)
            sols_lower = solve(q.expr ~ -1, x)
            
            if length(sols_upper) == 2 && length(sols_lower) == 2
                # Need the intersection of both intervals
                all_roots = sort([Float64(substitute(s, Dict())) for s in [sols_lower..., sols_upper...]])
                left = all_roots[2]
                right = all_roots[3]
                ans = fmt_interval(left, right, true, true)
                
                problem(
                    question="Find the domain of \\(f(x) = \\arcsin($(tex(q.expr)))\\). Express your answer in interval notation.",
                    answer=ans,
                    difficulty=(1900, 2200),
                    answer_type="interval",
                    solution=steps(
                        "The domain of \\(\\arcsin(u)\\) requires \\(-1 \\leq u \\leq 1\\)",
                        sol("Requirement", "-1 \\leq $(tex(q.expr)) \\leq 1"),
                        "Solve \\($(tex(q.expr)) = 1\\) and \\($(tex(q.expr)) = -1\\) to find boundary points",
                        "The domain is the intersection of both inequalities",
                        sol("Answer", ans)
                    ),
                    time=180
                )
            else
                # Fallback to simpler problem
                throw(DomainError("Not enough real roots"))
            end
        catch
            # Simpler fallback: arctan domain (always all reals)
            problem(
                question="Find the domain of \\(f(x) = \\arctan($(tex(q.expr)))\\). Express your answer in interval notation.",
                answer=fmt_interval(-Inf, Inf, true, true),
                difficulty=(1800, 1950),
                answer_type="interval",
                solution=steps(
                    "The domain of \\(\\arctan(u)\\) is all real numbers",
                    "Since \\($(tex(q.expr))\\) is defined for all \\(x \\in \\mathbb{R}\\)",
                    sol("Answer", fmt_interval(-Inf, Inf, true, true))
                ),
                time=90
            )
        end
        
    elseif prob_type == 3
        # Evaluate expression like arcsin(sin(θ)) for θ outside [-π/2, π/2]
        # Need to find the principal value
        k = randint(1, 3)
        sign_choice = choice([-1, 1])
        
        # θ = π - π/6 or similar
        base_angles = [π//6, π//4, π//3]
        base = choice(base_angles)
        
        if sign_choice == 1
            θ = π - base
            principal = base
        else
            θ = -π - base
            principal = -π + base
        end
        
        problem(
            question="Evaluate \\(\\arcsin(\\sin($(tex(θ))))\\). Express your answer as a multiple of \\(\\pi\\).",
            answer=principal,
            difficulty=(1900, 2250),
            solution=steps(
                sol("Given", "\\arcsin(\\sin($(tex(θ))))"),
                "Since \\($(tex(θ))\\) is outside \\([-\\frac{\\pi}{2}, \\frac{\\pi}{2}]\\), we need the principal value",
                "\\(\\sin($(tex(θ))) = \\sin($(tex(principal)))\\)",
                sol("Answer", principal)
            ),
            time=150
        )
        
    elseif prob_type == 4
        # Simplify arctan(x) + arctan(y) using addition formula
        # arctan(a) + arctan(b) = arctan((a+b)/(1-ab)) when ab < 1
        a = randint(1, 3)
        b = randint(1, 3)
        
        numerator = a + b
        denominator = 1 - a*b
        
        if denominator != 0
            ans = simplify(numerator // denominator)
            
            problem(
                question="Simplify \\(\\arctan($(a)) + \\arctan($(b))\\) to the form \\(\\arctan(k)\\). Find \\(k\\).",
                answer=ans,
                difficulty=(2000, 2300),
                solution=steps(
                    "Use the addition formula: \\(\\arctan(a) + \\arctan(b) = \\arctan\\left(\\frac{a+b}{1-ab}\\right)\\) when \\(ab < 1\\)",
                    sol("Substitute", "\\arctan\\left(\\frac{$(a)+$(b)}{1-$(a)\\cdot$(b)}\\right)"),
                    sol("Simplify", "\\arctan\\left($(tex(ans))\\right)"),
                    sol("Answer", ans)
                ),
                time=120
            )
        else
            # ab = 1, special case
            problem(
                question="Evaluate \\(\\arctan($(a)) + \\arctan($(b))\\). Express as a multiple of \\(\\pi\\).",
                answer=π//2,
                difficulty=(2100, 2400),
                solution=steps(
                    "Note that \\($(a) \\cdot $(b) = 1\\)",
                    "When \\(ab = 1\\) and \\(a, b > 0\\), \\(\\arctan(a) + \\arctan(b) = \\frac{\\pi}{2}\\)",
                    sol("Answer", π//2)
                ),
                time=120
            )
        end
        
    elseif prob_type == 5
        # Find range of function involving inverse trig
        # e.g., f(x) = 2*arcsin(x) + 3
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        
        # Range of arcsin is [-π/2, π/2]
        lower = a * (-π//2) + b
        upper = a * (π//2) + b
        
        if a > 0
            ans = fmt_interval(lower, upper, true, true)
        else
            ans = fmt_interval(upper, lower, true, true)
        end
        
        problem(
            question="Find the range of \\(f(x) = $(tex(a))" * "\\arcsin(x) + $(tex(b))\\). Express your answer in interval notation.",
            answer=ans,
            difficulty=(1850, 2050),
            answer_type="interval",
            solution=steps(
                "The range of \\(\\arcsin(x)\\) is \\([-\\frac{\\pi}{2}, \\frac{\\pi}{2}]\\)",
                "Multiply by \\($(a)\\): range becomes \\([$(tex(a*(-π//2))), $(tex(a*(π//2)))]\\)" * (a < 0 ? " (reversed)" : ""),
                "Add \\($(b)\\): shift the interval",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Solve equation arctan(2x) = arctan(x) + arctan(3)
        # Use subtraction formula
        k = randint(2, 5)
        m = randint(1, 4)
        
        # arctan(kx) - arctan(x) = arctan(m)
        # (kx - x)/(1 + kx²) = m
        # x(k-1) = m(1 + kx²)
        # x(k-1) = m + mkx²
        # mkx² - x(k-1) + m = 0
        
        a_coef = m * k
        b_coef = -(k - 1)
        c_coef = m
        
        # Solve mkx² - (k-1)x + m = 0
        discriminant = b_coef^2 - 4*a_coef*c_coef
        
        if discriminant >= 0
            ans = (-b_coef + sqrt(discriminant)) // (2 * a_coef)
            
            problem(
                question="Solve for \\(x\\): \\(\\arctan($(k)x) = \\arctan(x) + \\arctan($(m))\\)",
                answer=ans,
                difficulty=(2100, 2450),
                solution=steps(
                    sol("Given", "\\arctan($(k)x) - \\arctan(x) = \\arctan($(m))"),
                    "Use subtraction formula: \\(\\arctan(a) - \\arctan(b) = \\arctan\\left(\\frac{a-b}{1+ab}\\right)\\)",
                    sol("Equation", "\\frac{$(k)x - x}{1 + $(k)x^2} = $(m)"),
                    "Solve: \\($(tex(a_coef*x^2 + b_coef*x + c_coef)) = 0\\)",
                    sol("Answer", ans)
                ),
                time=180
            )
        else
            # Fallback simpler version
            ans = randint(1, 8)
            val = 2 * ans - 3
            
            problem(
                question="Solve for \\(x\\): \\(\\arcsin\\left(\\frac{x}{$(val)}\\right) = \\frac{\\pi}{6}\\)",
                answer=ans,
                difficulty=(1850, 2100),
                solution=steps(
                    sol("Given", "\\arcsin\\left(\\frac{x}{$(val)}\\right) = \\frac{\\pi}{6}"),
                    "Take sine of both sides: \\(\\frac{x}{$(val)} = \\sin\\left(\\frac{\\pi}{6}\\right) = \\frac{1}{2}\\)",
                    sol("Solve", "x = $(val) \\cdot \\frac{1}{2}"),
                    sol("Answer", ans)
                ),
                time=120
            )
        end
    end
end