# algebra2 - radical_expressions (competition)
# Generated: 2026-03-08T20:17:43.375071

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z n begin
    set_topic!("algebra2/radical_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Nested radical equation with algebraic manipulation (3500-4000)
        a = randint(2, 5)
        b = randint(3, 8)
        c = randint(10, 30)
        
        k = randint(2, 4)
        m = randint(5, 15)
        
        ans = (c^2 - b^2 * k^2) // (a^2)
        
        if ans > 0 && denominator(ans) == 1
            ans_val = numerator(ans)
            
            lhs_inner = a^2 * x + b^2 * k^2
            lhs = sqrt(lhs_inner)
            
            problem(
                question="Solve for \\(x\\): \\[\\sqrt{$(a^2)x + $(b^2 * k^2)} = $(c)\\]",
                answer=ans_val,
                difficulty=(3500, 3800),
                solution=steps(
                    sol("Given", sqrt(lhs_inner) ~ c),
                    "Square both sides: \\($(a^2)x + $(b^2 * k^2) = $(c^2)\\)",
                    "Isolate \\(x\\): \\($(a^2)x = $(c^2 - b^2 * k^2)\\)",
                    "Divide: \\(x = $(ans_val)\\)",
                    "Verify by substitution to ensure validity"
                ),
                time=240,
            )
        else
            # Fallback: simpler nested radical
            p = randint(2, 6)
            q = randint(3, 9)
            r = randint(4, 12)
            
            ans2 = (r^2 - q) // p
            if ans2 > 0 && denominator(ans2) == 1
                ans_val2 = numerator(ans2)
                
                problem(
                    question="Solve for \\(x\\): \\[\\sqrt{$(p)x + $(q)} = $(r)\\]",
                    answer=ans_val2,
                    difficulty=(3500, 3700),
                    solution=steps(
                        sol("Given", sqrt(p*x + q) ~ r),
                        "Square both sides: \\($(p)x + $(q) = $(r^2)\\)",
                        "Solve: \\(x = \\frac{$(r^2 - q)}{$(p)} = $(ans_val2)\\)",
                        "Verify the solution satisfies the original equation"
                    ),
                    time=200,
                )
            else
                ans_simple = randint(5, 25)
                p_s = randint(2, 5)
                q_s = r^2 - p_s * ans_simple
                
                problem(
                    question="Solve for \\(x\\): \\[\\sqrt{$(p_s)x + $(q_s)} = $(r)\\]",
                    answer=ans_simple,
                    difficulty=(3500, 3700),
                    solution=steps(
                        sol("Given", sqrt(p_s*x + q_s) ~ r),
                        "Square both sides: \\($(p_s)x + $(q_s) = $(r^2)\\)",
                        "Solve: \\(x = $(ans_simple)\\)",
                        "Verify by substitution"
                    ),
                    time=200,
                )
            end
        end
        
    elseif problem_type == 2
        # Radical equation with double radicals (3800-4200)
        m = randint(3, 8)
        n = randint(2, 6)
        p = randint(4, 12)
        
        ans = randint(8, 40)
        
        r1 = m * ans + n
        r2 = p * ans
        
        problem(
            question="Solve for \\(x\\): \\[\\sqrt{$(m)x + $(n)} + \\sqrt{$(p)x} = $(isqrt(r1) + isqrt(r2))\\]",
            answer=ans,
            difficulty=(3800, 4200),
            solution=steps(
                sol("Given", "\\(\\sqrt{$(m)x + $(n)} + \\sqrt{$(p)x} = $(isqrt(r1) + isqrt(r2))\\)"),
                "Isolate one radical and square both sides",
                "Simplify and isolate the remaining radical",
                "Square again and solve the resulting equation",
                "Check: \\(x = $(ans)\\) satisfies the original equation"
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # System with radical expressions (4000-4500)
        a = randint(2, 7)
        b = randint(3, 9)
        
        x_ans = randint(4, 16)
        y_ans = randint(9, 36)
        
        eq1_val = a * sqrt(x_ans) + b
        eq2_val = sqrt(y_ans) - sqrt(x_ans)
        
        problem(
            question="Solve the system:\\begin{align*}$(a)\\sqrt{x} + $(b) &= $(eq1_val)\\\\\\sqrt{y} - \\sqrt{x} &= $(eq2_val)\\end{align*}",
            answer="($(x_ans), $(y_ans))",
            difficulty=(4000, 4500),
            answer_type="tuple",
            solution=steps(
                "From first equation: \\($(a)\\sqrt{x} = $(eq1_val - b)\\)",
                "Solve for \\(x\\): \\(\\sqrt{x} = $(round(Int, (eq1_val - b) / a))\\), so \\(x = $(x_ans)\\)",
                "Substitute into second equation: \\(\\sqrt{y} = $(eq2_val) + $(round(Int, sqrt(x_ans)))\\)",
                "Therefore \\(\\sqrt{y} = $(round(Int, sqrt(y_ans)))\\), giving \\(y = $(y_ans)\\)",
                "Solution: \\(($(x_ans), $(y_ans))\\)"
            ),
            time=280,
        )
        
    elseif problem_type == 4
        # Radical expression simplification with nested structure (3600-4000)
        k = randint(2, 5)
        m = randint(3, 8)
        base = randint(2, 6)
        
        inner = base^(2*k) * m
        ans = base^k * sqrt(m)
        
        problem(
            question="Simplify completely: \\[\\sqrt[$(k)]{$(inner)}\\]",
            answer="$(base^k)\\sqrt[$(k)]{$(m)}",
            difficulty=(3600, 4000),
            solution=steps(
                sol("Given", "\\(\\sqrt[$(k)]{$(inner)}\\)"),
                "Factor: \\(\\sqrt[$(k)]{$(base^(2*k)) \\cdot $(m)}\\)",
                "Simplify: \\(\\sqrt[$(k)]{$(base^(2*k))} \\cdot \\sqrt[$(k)]{$(m)}\\)",
                "Extract perfect $(k)th power: \\($(base^k)\\sqrt[$(k)]{$(m)}\\)"
            ),
            time=220,
        )
        
    else
        # Radical inequality with domain considerations (4200-4800)
        a = randint(2, 6)
        b = randint(5, 15)
        c = randint(3, 10)
        
        bound = (c^2 - b) // a
        
        if bound >= 0 && denominator(bound) == 1
            bound_val = numerator(bound)
            lower_bound = -b // a
            lower_val = numerator(lower_bound)
            
            ans = fmt_interval(lower_val, bound_val, true, true)
            
            problem(
                question="Find all \\(x\\) such that: \\[\\sqrt{$(a)x + $(b)} \\leq $(c)\\]",
                answer=ans,
                difficulty=(4200, 4800),
                answer_type="interval",
                solution=steps(
                    "Domain restriction: \\($(a)x + $(b) \\geq 0\\), so \\(x \\geq $(lower_val)\\)",
                    "Square both sides (valid since both sides non-negative): \\($(a)x + $(b) \\leq $(c^2)\\)",
                    "Solve: \\(x \\leq $(bound_val)\\)",
                    "Combine with domain: \\($(lower_val) \\leq x \\leq $(bound_val)\\)",
                    sol("Answer", ans)
                ),
                time=260,
            )
        else
            # Simpler version
            p = randint(1, 4)
            q = randint(8, 20)
            r = randint(4, 8)
            
            ub = (r^2 - q) // p
            lb = -q // p
            
            if ub >= 0 && lb >= 0 && denominator(ub) == 1 && denominator(lb) == 1
                ub_v = numerator(ub)
                lb_v = numerator(lb)
                ans_int = fmt_interval(lb_v, ub_v, true, true)
                
                problem(
                    question="Solve: \\[\\sqrt{$(p)x + $(q)} \\leq $(r)\\]",
                    answer=ans_int,
                    difficulty=(4200, 4600),
                    answer_type="interval",
                    solution=steps(
                        "Domain: \\(x \\geq $(lb_v)\\)",
                        "Square: \\($(p)x + $(q) \\leq $(r^2)\\)",
                        "Solve: \\(x \\leq $(ub_v)\\)",
                        sol("Answer", ans_int)
                    ),
                    time=240,
                )
            else
                simple_ans = randint(10, 30)
                simple_p = 2
                simple_q = r^2 - simple_p * simple_ans
                simple_lb = -simple_q // simple_p
                
                ans_final = fmt_interval(numerator(simple_lb), simple_ans, true, true)
                
                problem(
                    question="Solve: \\[\\sqrt{$(simple_p)x + $(simple_q)} \\leq $(r)\\]",
                    answer=ans_final,
                    difficulty=(4200, 4500),
                    answer_type="interval",
                    solution=steps(
                        "Determine domain restriction",
                        "Square both sides and solve inequality",
                        "Combine with domain",
                        sol("Answer", ans_final)
                    ),
                    time=240,
                )
            end
        end
    end
end