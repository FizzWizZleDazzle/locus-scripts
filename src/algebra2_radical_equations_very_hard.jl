# algebra2 - radical_equations (very_hard)
# Generated: 2026-03-08T20:18:23.421488

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/radical_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition level: nested radicals with extraneous solutions
        # ELO 2500-2800
        a = randint(2, 5)
        b = randint(3, 8)
        c = randint(10, 25)
        
        # Construct backward: x = solution
        sol_val = randint(5, 15)
        
        # sqrt(ax + b) = sqrt(x) + sqrt(c)
        # Square: ax + b = x + c + 2*sqrt(cx)
        # (a-1)x + b - c = 2*sqrt(cx)
        # Square: ((a-1)x + b - c)^2 = 4cx
        
        lhs_inner = a*x + b
        rhs_inner1 = x
        rhs_inner2 = c
        
        question_text = "Solve for \\( x \\): \\[ \\sqrt{$(a)x + $(b)} = \\sqrt{x} + \\sqrt{$(c)} \\]"
        
        # Solve symbolically
        eqn = sqrt(lhs_inner) ~ sqrt(rhs_inner1) + sqrt(rhs_inner2)
        
        # Manual solution
        # sqrt(ax+b) = sqrt(x) + sqrt(c)
        # ax + b = x + c + 2*sqrt(cx)
        # (a-1)x + (b-c) = 2*sqrt(cx)
        # Square: ((a-1)x + (b-c))^2 = 4cx
        
        expanded = expand((a-1)^2 * x^2 + 2*(a-1)*(b-c)*x + (b-c)^2 - 4*c*x)
        
        solutions = solve(expanded ~ 0, x)
        
        # Check which solutions are valid
        valid_sols = []
        for s in solutions
            val = Float64(s)
            if val >= 0 && a*val + b >= 0 && c >= 0
                lhs_check = sqrt(a*val + b)
                rhs_check = sqrt(val) + sqrt(c)
                if abs(lhs_check - rhs_check) < 0.01
                    push!(valid_sols, s)
                end
            end
        end
        
        if length(valid_sols) == 0
            ans = "\\emptyset"
            ans_type = "text"
        elseif length(valid_sols) == 1
            ans = valid_sols[1]
            ans_type = "expression"
        else
            ans = fmt_set(Set(valid_sols))
            ans_type = "set"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(2500, 2800),
            answer_type=ans_type,
            solution=steps(
                sol("Given", eqn),
                "Square both sides: \\( $(a)x + $(b) = x + $(c) + 2\\sqrt{cx} \\)",
                "Isolate radical: \\( $(a-1)x + $(b-c) = 2\\sqrt{$(c)x} \\)",
                "Square again and expand to get quadratic",
                sol("Valid solutions after checking", ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad level: radical equation with parameter-like structure
        # ELO 3000-3300
        
        # x + sqrt(x) = k, find relationship
        k = randint(6, 20)
        
        # Let u = sqrt(x), then x = u^2
        # u^2 + u = k
        # u^2 + u - k = 0
        
        question_text = "Solve for \\( x \\): \\[ x + \\sqrt{x} = $(k) \\]"
        
        # u = (-1 ± sqrt(1 + 4k))/2, take positive root
        # u = (-1 + sqrt(1 + 4k))/2
        # x = u^2
        
        disc = 1 + 4*k
        u_val = (-1 + sqrt(disc))/2
        x_val = u_val^2
        
        # Express symbolically
        u_expr = (-1 + sqrt(1 + 4*k))//2
        x_exact = expand(u_expr^2)
        
        ans_val = (3 - 2*sqrt(1 + 4*k) + 1 + 4*k)//4
        ans_simplified = (4 + 4*k - 2*sqrt(1 + 4*k))//4
        ans_final = (2 + 2*k - sqrt(1 + 4*k))//2
        
        problem(
            question=question_text,
            answer=x_val,
            difficulty=(3000, 3300),
            solution=steps(
                sol("Given", x + sqrt(x) ~ k),
                "Substitute \\( u = \\sqrt{x} \\), so \\( x = u^2 \\)",
                sol("Transform to", "u^2 + u = $(k)"),
                "Solve quadratic: \\( u = \\frac{-1 + \\sqrt{1 + 4 \\cdot $(k)}}{2} \\)",
                sol("Then", "x = u^2"),
                "Simplify to get final answer"
            ),
            time=300
        )
        
    elseif problem_type == 3
        # High competition: system with radicals
        # ELO 2700-3000
        
        a = randint(2, 6)
        b = randint(2, 6)
        c = randint(8, 20)
        
        # sqrt(x) + sqrt(y) = a
        # x + y = c
        
        question_text = "Solve the system: \\begin{align*} \\sqrt{x} + \\sqrt{y} &= $(a) \\\\ x + y &= $(c) \\end{align*}"
        
        # Let u = sqrt(x), v = sqrt(y)
        # u + v = a, u^2 + v^2 = c
        # (u+v)^2 = a^2 => u^2 + 2uv + v^2 = a^2
        # c + 2uv = a^2
        # uv = (a^2 - c)/2
        
        uv_prod = (a^2 - c)//2
        
        # u, v are roots of t^2 - at + (a^2-c)/2 = 0
        # t = (a ± sqrt(a^2 - 2(a^2-c)))/2 = (a ± sqrt(2c - a^2))/2
        
        disc_val = 2*c - a^2
        
        if disc_val >= 0
            u1 = (a + sqrt(disc_val))/2
            u2 = (a - sqrt(disc_val))/2
            x1 = u1^2
            x2 = u2^2
            y1 = u2^2
            y2 = u1^2
            
            ans = fmt_set(Set([(x1, y1), (x2, y2)]))
            ans_type = "set"
        else
            ans = "\\emptyset"
            ans_type = "text"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(2700, 3000),
            answer_type=ans_type,
            solution=steps(
                "Let \\( u = \\sqrt{x} \\) and \\( v = \\sqrt{y} \\)",
                sol("System becomes", "u + v = $(a), u^2 + v^2 = $(c)"),
                "From \\( (u+v)^2 = u^2 + 2uv + v^2 \\): \\( $(a^2) = $(c) + 2uv \\)",
                sol("Therefore", "uv = $(uv_prod)"),
                "Solve \\( t^2 - $(a)t + $(uv_prod) = 0 \\) for u and v",
                sol("Solutions", ans)
            ),
            time=270
        )
        
    else
        # Competition: radical equation with multiple radicals and extraneous solutions
        # ELO 2600-2900
        
        m = randint(2, 5)
        n = randint(3, 8)
        p = randint(1, 4)
        
        # sqrt(mx + n) - sqrt(x) = p
        
        question_text = "Find all real solutions: \\[ \\sqrt{$(m)x + $(n)} - \\sqrt{x} = $(p) \\]"
        
        # sqrt(mx+n) = sqrt(x) + p
        # mx + n = x + p^2 + 2p*sqrt(x)
        # (m-1)x + n - p^2 = 2p*sqrt(x)
        # Square: ((m-1)x + n - p^2)^2 = 4p^2*x
        
        lhs_coeff = (m-1)^2
        lhs_linear = 2*(m-1)*(n - p^2) - 4*p^2
        lhs_const = (n - p^2)^2
        
        quad_expr = lhs_coeff*x^2 + lhs_linear*x + lhs_const
        
        solutions = solve(quad_expr ~ 0, x)
        
        # Check validity
        valid_sols = []
        for s in solutions
            val = Float64(s)
            if val >= 0 && m*val + n >= 0
                lhs_check = sqrt(m*val + n) - sqrt(val)
                if abs(lhs_check - p) < 0.01
                    push!(valid_sols, s)
                end
            end
        end
        
        if length(valid_sols) == 0
            ans = "\\emptyset"
            ans_type = "text"
        elseif length(valid_sols) == 1
            ans = valid_sols[1]
            ans_type = "expression"
        else
            ans = fmt_set(Set(valid_sols))
            ans_type = "set"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(2600, 2900),
            answer_type=ans_type,
            solution=steps(
                sol("Given", sqrt(m*x + n) - sqrt(x) ~ p),
                "Isolate one radical: \\( \\sqrt{$(m)x + $(n)} = \\sqrt{x} + $(p) \\)",
                "Square both sides: \\( $(m)x + $(n) = x + $(p^2) + 2 \\cdot $(p) \\sqrt{x} \\)",
                "Isolate remaining radical and square again",
                "Solve resulting quadratic and check for extraneous solutions",
                sol("Valid solution(s)", ans)
            ),
            time=250
        )
    end
end