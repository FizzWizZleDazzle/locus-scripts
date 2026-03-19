# arithmetic - ratios_proportions (very_hard)
# Generated: 2026-03-08T19:52:01.226061

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/ratios_proportions")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition-level: Ratio manipulation with constraints
        # If a:b:c = 2:3:5 and a²+b²+c² = 304, find abc
        k1, k2, k3 = rand(2:7), rand(2:7), rand(2:7)
        while gcd(gcd(k1, k2), k3) > 1 || k1 == k2 || k2 == k3 || k1 == k3
            k1, k2, k3 = rand(2:7), rand(2:7), rand(2:7)
        end
        
        multiplier = rand(3:8)
        a_val = k1 * multiplier
        b_val = k2 * multiplier
        c_val = k3 * multiplier
        
        sum_squares = a_val^2 + b_val^2 + c_val^2
        ans = a_val * b_val * c_val
        
        problem(
            question="If \\(a:b:c = $(k1):$(k2):$(k3)\\) and \\(a^2 + b^2 + c^2 = $(sum_squares)\\), find the value of \\(abc\\).",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                "Let \\(a = $(k1)k\\), \\(b = $(k2)k\\), \\(c = $(k3)k\\) for some positive constant \\(k\\)",
                sol("Substitute into constraint", "$(k1)^2 k^2 + $(k2)^2 k^2 + $(k3)^2 k^2 = $(sum_squares)"),
                sol("Simplify", "$(k1^2 + k2^2 + k3^2) k^2 = $(sum_squares)"),
                sol("Solve for k²", "k^2 = $(sum_squares ÷ (k1^2 + k2^2 + k3^2))"),
                sol("Therefore k", "k = $(multiplier)"),
                sol("Calculate abc", "abc = ($(k1) \\cdot $(multiplier))($(k2) \\cdot $(multiplier))($(k3) \\cdot $(multiplier)) = $(ans)"),
            ),
            time=240,
        )
        
    elseif problem_type == 2
        # Olympiad-level: Nested ratios with algebraic manipulation
        # Given (a+b)/(b+c) = p/q and (b+c)/(c+a) = r/s, find a:b:c
        p, q = rand(3:9), rand(3:9)
        r, s = rand(3:9), rand(3:9)
        while gcd(p, q) > 1 || gcd(r, s) > 1 || p == q || r == s
            p, q = rand(3:9), rand(3:9)
            r, s = rand(3:9), rand(3:9)
        end
        
        # Work backwards: choose a ratio like a:b:c = x:y:z
        # Then verify our conditions give consistent results
        a_coef = p * s - q * r
        b_coef = p * s
        c_coef = q * r
        
        # Simplify if needed
        g = gcd(gcd(abs(a_coef), abs(b_coef)), abs(c_coef))
        if g > 1
            a_coef ÷= g
            b_coef ÷= g
            c_coef ÷= g
        end
        
        ans = "$(a_coef):$(b_coef):$(c_coef)"
        
        problem(
            question="Suppose \\(\\frac{a+b}{b+c} = \\frac{$(p)}{$(q)}\\) and \\(\\frac{b+c}{c+a} = \\frac{$(r)}{$(s)}\\). Express \\(a:b:c\\) in simplest form.",
            answer=ans,
            difficulty=(3000, 3400),
            solution=steps(
                sol("From first ratio", "$(q)(a+b) = $(p)(b+c)"),
                sol("Expand", "$(q)a + $(q)b = $(p)b + $(p)c"),
                sol("Rearrange", "$(q)a = $(p-q)b + $(p)c"),
                sol("From second ratio", "$(s)(b+c) = $(r)(c+a)"),
                sol("Expand", "$(s)b + $(s)c = $(r)c + $(r)a"),
                sol("Rearrange", "$(s)b = $(r)a + $(r-s)c"),
                "Solve the system of linear equations to obtain",
                sol("Answer", "a:b:c = $(ans)"),
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # Competition: Weighted average with proportional reasoning
        # Three quantities in ratio, weighted average equals target
        r1, r2, r3 = rand(2:8), rand(2:8), rand(2:8)
        while gcd(gcd(r1, r2), r3) > 1
            r1, r2, r3 = rand(2:8), rand(2:8), rand(2:8)
        end
        
        v1, v2, v3 = rand(10:40), rand(10:40), rand(10:40)
        total_val = r1 * v1 + r2 * v2 + r3 * v3
        total_parts = r1 + r2 + r3
        
        # Check if average is clean
        if total_val % total_parts == 0
            avg = total_val ÷ total_parts
            ans = avg
            ans_str = "$(avg)"
        else
            ans = total_val // total_parts
            ans_str = "\\frac{$(total_val)}{$(total_parts)}"
        end
        
        problem(
            question="Three quantities are in the ratio \\($(r1):$(r2):$(r3)\\). If their values per unit are \\\$$(v1), \\\$$(v2), and \\\$$(v3) respectively, what is the weighted average value per unit across all quantities?",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                "Let the quantities be \\($(r1)k\\), \\($(r2)k\\), and \\($(r3)k\\) for some constant \\(k\\)",
                sol("Total value", "$(v1) \\cdot $(r1)k + $(v2) \\cdot $(r2)k + $(v3) \\cdot $(r3)k = $(total_val)k"),
                sol("Total quantity", "$(r1)k + $(r2)k + $(r3)k = $(total_parts)k"),
                sol("Weighted average", "\\frac{$(total_val)k}{$(total_parts)k} = $(ans_str)"),
            ),
            time=180,
        )
        
    else
        # Olympiad: Ratio chain with constraints
        # If a/b = m/n, b/c = p/q, c/d = r/s, and a+d = target, find b+c
        m, n = rand(2:7), rand(2:7)
        p, q = rand(2:7), rand(2:7)
        r, s = rand(2:7), rand(2:7)
        while gcd(m, n) > 1 || gcd(p, q) > 1 || gcd(r, s) > 1
            m, n = rand(2:7), rand(2:7)
            p, q = rand(2:7), rand(2:7)
            r, s = rand(2:7), rand(2:7)
        end
        
        # a:b:c:d = (m*p*r):(n*p*r):(n*q*r):(n*q*s)
        a_coef = m * p * r
        b_coef = n * p * r
        c_coef = n * q * r
        d_coef = n * q * s
        
        k_mult = rand(2:5)
        target = k_mult * (a_coef + d_coef)
        ans = k_mult * (b_coef + c_coef)
        
        problem(
            question="Given that \\(\\frac{a}{b} = \\frac{$(m)}{$(n)}\\), \\(\\frac{b}{c} = \\frac{$(p)}{$(q)}\\), \\(\\frac{c}{d} = \\frac{$(r)}{$(s)}\\), and \\(a + d = $(target)\\), find \\(b + c\\).",
            answer=ans,
            difficulty=(3100, 3500),
            solution=steps(
                "From the given ratios, we have \\(a = \\frac{$(m)}{$(n)}b\\), \\(c = \\frac{$(q)}{$(p)}b\\), and \\(d = \\frac{$(q)$(s)}{$(p)$(r)}b\\)",
                sol("Express in terms of b", "a:b:c:d = $(a_coef):$(b_coef):$(c_coef):$(d_coef)"),
                sol("Let a", "a = $(a_coef)k, b = $(b_coef)k, c = $(c_coef)k, d = $(d_coef)k"),
                sol("Use constraint a+d", "$(a_coef)k + $(d_coef)k = $(target)"),
                sol("Solve for k", "k = $(k_mult)"),
                sol("Calculate b+c", "b + c = $(b_coef)k + $(c_coef)k = $(b_coef + c_coef) \\cdot $(k_mult) = $(ans)"),
            ),
            time=270,
        )
    end
end