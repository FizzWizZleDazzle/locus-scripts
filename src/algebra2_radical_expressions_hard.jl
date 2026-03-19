# algebra2 - radical_expressions (hard)
# Generated: 2026-03-08T20:17:35.090940

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/radical_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simplify nested radicals with rationalization
        # Target: 1800-2200
        a = rand([2, 3, 5, 7])
        b = rand([2, 3, 5, 7])
        while b == a
            b = rand([2, 3, 5, 7])
        end
        c = randint(2, 5)
        d = randint(2, 5)
        
        # Problem: simplify (c*√a + d*√b) / (√a - √b)
        # Rationalize by multiplying by conjugate
        
        numer_simplified = c*a + d*b + (c*b + d*a)
        denom_simplified = a - b
        
        if gcd(numer_simplified, abs(denom_simplified)) > 1
            g = gcd(numer_simplified, abs(denom_simplified))
            numer_simplified = numer_simplified ÷ g
            denom_simplified = denom_simplified ÷ g
        end
        
        conjugate_expr = "\\sqrt{$a} + \\sqrt{$b}"
        
        problem(
            question = "Rationalize the denominator and simplify: \$\\dfrac{$c\\sqrt{$a} + $d\\sqrt{$b}}{\\sqrt{$a} - \\sqrt{$b}}\$",
            answer = "$(numer_simplified)/$(denom_simplified)",
            difficulty = (1850, 2100),
            solution = steps(
                "Given: \$\\dfrac{$c\\sqrt{$a} + $d\\sqrt{$b}}{\\sqrt{$a} - \\sqrt{$b}}\$",
                "Multiply numerator and denominator by conjugate: \$\\sqrt{$a} + \\sqrt{$b}\$",
                "Numerator: \$($c\\sqrt{$a} + $d\\sqrt{$b})(\\sqrt{$a} + \\sqrt{$b}) = $c($a) + $c\\sqrt{$(a*b)} + $d\\sqrt{$(a*b)} + $d($b) = $(c*a + d*b) + $(c+d)\\sqrt{$(a*b)}\$",
                "Denominator: \$(\\sqrt{$a} - \\sqrt{$b})(\\sqrt{$a} + \\sqrt{$b}) = $a - $b = $(a-b)\$",
                sol("Answer", "\\dfrac{$(c*a + d*b) + $(c+d)\\sqrt{$(a*b)}}{$(a-b)}")
            ),
            time = 240
        )
        
    elseif problem_type == 2
        # Solve radical equation with extraneous solutions
        # Target: 1900-2300
        r1 = randint(3, 15)
        r2 = randint(-12, -2)
        
        # √(x + a) = x - b where one root is extraneous
        # Squaring: x + a = x² - 2bx + b²
        # x² - (2b+1)x + (b² - a) = 0
        # Roots: r1 (valid), r2 (extraneous)
        
        a = r1 - r2^2
        b = -r2
        
        check1 = sqrt(r1 + a)
        check2_val = r2 + a
        
        valid_root = r1
        
        problem(
            question = "Solve for x: \$\\sqrt{x + $a} = x - $b\$. Enter all valid solutions as a set.",
            answer = fmt_set(Set([valid_root])),
            answer_type = "set",
            difficulty = (1900, 2250),
            solution = steps(
                sol("Given", "\\sqrt{x + $a} = x - $b"),
                "Square both sides: \$x + $a = (x - $b)^2 = x^2 - $(2*b)x + $(b^2)\$",
                "Rearrange: \$x^2 - $(2*b+1)x + $(b^2 - a) = 0\$",
                "Factor or use quadratic formula to get: \$x = $r1\$ or \$x = $r2\$",
                "Check \$x = $r1\$: \$\\sqrt{$r1 + $a} = \\sqrt{$(r1+a)} = $(Int(sqrt(r1+a)))\$ and \$$r1 - $b = $(r1-b)\$ ✓",
                "Check \$x = $r2\$: \$\\sqrt{$r2 + $a} = \\sqrt{$(r2+a)}\$ is $(r2+a >= 0 ? "defined but" : "not real") and \$$r2 - $b = $(r2-b)\$ $(r2+a >= 0 && sqrt(r2+a) != r2-b ? "≠ $(Int(sqrt(r2+a)))" : "") ✗",
                sol("Valid solution", "\\{$valid_root\\}")
            ),
            time = 300
        )
        
    elseif problem_type == 3
        # Simplify radical expressions with higher roots
        # Target: 1850-2150
        base = rand([2, 3, 5, 6, 7, 10])
        root_index = rand([3, 4])
        inside_power = randint(2, 5)
        extra_factor = rand([2, 3, 5, 7])
        
        # Simplify ∜(base^inside_power * extra_factor^root_index * extra_small)
        full_power = inside_power
        partial_power = inside_power % root_index
        outside_power = inside_power ÷ root_index
        
        if root_index == 3
            root_symbol = "\\sqrt[3]"
        else
            root_symbol = "\\sqrt[4]"
        end
        
        inside_val = base^inside_power * extra_factor^root_index
        outside_part = base^outside_power * extra_factor
        inside_remainder = base^partial_power
        
        problem(
            question = "Simplify: \$$root_symbol{$(base^inside_power) \\cdot $(extra_factor^root_index)}\$",
            answer = "$(outside_part)*$(root_symbol){$(inside_remainder)}",
            difficulty = (1850, 2100),
            solution = steps(
                sol("Given", "$root_symbol{$inside_val}"),
                "Factor: \$$root_symbol{$base^$inside_power \\cdot $extra_factor^$root_index}\$",
                "Extract perfect $root_index-th powers: \$$base^$inside_power = $base^{$(outside_power * root_index)} \\cdot $base^{$partial_power}\$",
                "Simplify: \$$extra_factor \\cdot $base^$outside_power \\cdot $root_symbol{$base^$partial_power} = $outside_part$root_symbol{$inside_remainder}\$",
                sol("Answer", "$outside_part$root_symbol{$inside_remainder}")
            ),
            time = 210
        )
        
    elseif problem_type == 4
        # Radical expression with conjugate multiplication
        # Target: 1900-2300
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 6)
        d = randint(2, 6)
        
        # (a√c + b)(a√c - b) or similar pattern
        result = a^2 * c - b^2
        
        problem(
            question = "Multiply and simplify: \$($a\\sqrt{$c} + $b)($a\\sqrt{$c} - $b)\$",
            answer = result,
            difficulty = (1800, 2000),
            solution = steps(
                sol("Given", "($a\\sqrt{$c} + $b)($a\\sqrt{$c} - $b)"),
                "Use difference of squares formula: \$(u + v)(u - v) = u^2 - v^2\$",
                "Here \$u = $a\\sqrt{$c}\$ and \$v = $b\$",
                sol("Calculate", "($a\\sqrt{$c})^2 - ($b)^2 = $(a^2) \\cdot $c - $(b^2) = $(a^2 * c) - $(b^2) = $result"),
                sol("Answer", result)
            ),
            time = 150
        )
        
    else
        # Solve system involving radicals
        # Target: 2100-2500
        p = randint(4, 12)
        q = randint(2, 8)
        
        # x + y = p, √x + √y = q
        # Let u = √x, v = √y
        # u² + v² = p, u + v = q
        # (u+v)² = u² + 2uv + v² = q²
        # p + 2uv = q²
        # uv = (q² - p)/2
        
        product_uv = (q^2 - p) / 2
        
        # u, v are roots of t² - qt + product_uv = 0
        discriminant = q^2 - 4*product_uv
        
        if discriminant >= 0 && discriminant == Int(sqrt(discriminant))^2
            u_val = (q + Int(sqrt(discriminant))) / 2
            v_val = (q - Int(sqrt(discriminant))) / 2
            
            x_val = u_val^2
            y_val = v_val^2
            
            problem(
                question = "Solve the system: \$x + y = $p\$ and \$\\sqrt{x} + \\sqrt{y} = $q\$. Find the value of \$x\$ (the larger solution).",
                answer = Int(max(x_val, y_val)),
                difficulty = (2100, 2450),
                solution = steps(
                    "Let \$u = \\sqrt{x}\$ and \$v = \\sqrt{y}\$, so \$x = u^2\$ and \$y = v^2\$",
                    "System becomes: \$u^2 + v^2 = $p\$ and \$u + v = $q\$",
                    "From \$(u+v)^2 = u^2 + 2uv + v^2\$: \$$q^2 = $p + 2uv\$",
                    sol("Product", "uv = \\frac{$(q^2) - $p}{2} = $(product_uv)"),
                    "Now \$u\$ and \$v\$ are roots of \$t^2 - $q t + $(product_uv) = 0\$",
                    "Solutions: \$u = $(u_val), v = $(v_val)\$ (or vice versa)",
                    sol("Therefore", "x = $(Int(x_val)), y = $(Int(y_val))")
                ),
                time = 300
            )
        else
            # Fallback simpler problem
            m = randint(4, 20)
            n = randint(2, 8)
            inside = m * n^2
            
            problem(
                question = "Simplify: \$\\sqrt{$inside}\$",
                answer = "$(n)*sqrt($(m))",
                difficulty = (1800, 2000),
                solution = steps(
                    sol("Given", "\\sqrt{$inside}"),
                    "Factor: \$\\sqrt{$inside} = \\sqrt{$m \\cdot $(n^2)}\$",
                    "Extract perfect square: \$\\sqrt{$(n^2)} \\cdot \\sqrt{$m} = $n\\sqrt{$m}\$",
                    sol("Answer", "$n\\sqrt{$m}")
                ),
                time = 120
            )
        end
    end
end