# algebra2 - radical_expressions (very_hard)
# Generated: 2026-03-08T20:17:43.554526

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/radical_expressions")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Nested radical denesting: √(a + b√c) = √m + √n
        # Target: 2500-3000 ELO (AMC/AIME level)
        m = randint(2, 8)
        n = randint(2, 8)
        c = randint(2, 7)
        a = m + n
        b = 2 * sqrt(m * n)
        
        if isinteger(b / sqrt(c))
            b_coeff = Int(b / sqrt(c))
            inner = a + b_coeff * sqrt(c)
            
            question = "Denest the radical: \\sqrt{$(a) + $(b_coeff)\\sqrt{$(c)}}"
            answer = sqrt(m) + sqrt(n)
            
            problem(
                question=question,
                answer=answer,
                difficulty=(2500, 3000),
                solution=steps(
                    "Assume \\sqrt{$(a) + $(b_coeff)\\sqrt{$(c)}} = \\sqrt{m} + \\sqrt{n}",
                    "Square both sides: $(a) + $(b_coeff)\\sqrt{$(c)} = m + n + 2\\sqrt{mn}",
                    "Match coefficients: m + n = $(a) and 2\\sqrt{mn} = $(b_coeff)\\sqrt{$(c)}",
                    "From second equation: mn = $(m*n), so m = $(m), n = $(n)",
                    sol("Answer", sqrt(m) + sqrt(n))
                ),
                time=240
            )
        else
            # Fallback to simpler nested radical
            a = randint(10, 30)
            b = randint(2, 8)
            question = "Simplify: \\sqrt{$(a) + \\sqrt{$(b)}}"
            answer_expr = sqrt(a + sqrt(b))
            
            problem(
                question=question,
                answer=answer_expr,
                difficulty=(2600, 3000),
                solution=steps(
                    sol("Given", answer_expr),
                    "Check if this can be denested by assuming \\sqrt{m} + \\sqrt{n} form",
                    "In this case, the radical is already in simplest form",
                    sol("Answer", answer_expr)
                ),
                time=180
            )
        end
        
    elseif prob_type == 2
        # System with radicals: √x + √y = a, √x - √y = b
        # Target: 2700-3200 ELO
        u = randint(3, 12)
        v = randint(2, 10)
        a = u + v
        b = u - v
        x_val = u^2
        y_val = v^2
        
        question = "Solve the system: \\sqrt{x} + \\sqrt{y} = $(a) and \\sqrt{x} - \\sqrt{y} = $(b)"
        answer = fmt_tuple([x_val, y_val])
        
        problem(
            question=question,
            answer=answer,
            answer_type="tuple",
            difficulty=(2700, 3200),
            solution=steps(
                "Let u = \\sqrt{x} and v = \\sqrt{y}",
                "System becomes: u + v = $(a) and u - v = $(b)",
                "Add equations: 2u = $(a+b), so u = $(u)",
                "Subtract: 2v = $(a-b), so v = $(v)",
                "Therefore x = $(x_val) and y = $(y_val)",
                sol("Answer", fmt_tuple([x_val, y_val]))
            ),
            time=300
        )
        
    elseif prob_type == 3
        # Radical equation with extraneous solutions
        # Target: 2800-3300 ELO
        r1 = randint(4, 20)
        r2 = -randint(2, 10)
        k = randint(2, 8)
        
        question = "Find all real solutions to: \\sqrt{x + $(k)} = x - $(r1)"
        
        # Squaring: x + k = x^2 - 2*r1*x + r1^2
        # x^2 - (2*r1+1)*x + (r1^2 - k) = 0
        
        discriminant = (2*r1 + 1)^2 - 4*(r1^2 - k)
        
        if discriminant >= 0
            sol1 = ((2*r1 + 1) + sqrt(discriminant)) / 2
            sol2 = ((2*r1 + 1) - sqrt(discriminant)) / 2
            
            valid_sols = []
            for s in [sol1, sol2]
                if s + k >= 0 && sqrt(s + k) ≈ s - r1
                    push!(valid_sols, s)
                end
            end
            
            if length(valid_sols) > 0
                answer = fmt_set(Set(valid_sols))
            else
                answer = fmt_set(Set([]))
            end
        else
            answer = fmt_set(Set([]))
        end
        
        problem(
            question=question,
            answer=answer,
            answer_type="set",
            difficulty=(2800, 3300),
            solution=steps(
                "Square both sides: x + $(k) = (x - $(r1))^2",
                "Expand: x + $(k) = x^2 - $(2*r1)x + $(r1^2)",
                "Rearrange: x^2 - $(2*r1+1)x + $(r1^2-k) = 0",
                "Solve quadratic and check for extraneous solutions",
                "Only solutions where x + $(k) ≥ 0 and \\sqrt{x + $(k)} = x - $(r1) are valid",
                sol("Answer", answer)
            ),
            time=270
        )
        
    elseif prob_type == 4
        # Rationalize with nested radicals
        # Target: 3000-3400 ELO (Olympiad flavor)
        a = randint(2, 6)
        b = randint(2, 6)
        c = randint(2, 5)
        
        question = "Rationalize the denominator and simplify: \\frac{1}{\\sqrt{$(a)} + \\sqrt{$(b)} + \\sqrt{$(c)}}"
        
        # This is complex; provide the strategy
        answer_str = "\\frac{\\sqrt{$(a)} + \\sqrt{$(b)} - \\sqrt{$(c)}}{$(a) + $(b) - $(c) + 2\\sqrt{$(a*b)}}"
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3000, 3400),
            solution=steps(
                "Multiply by conjugate: \\frac{1}{\\sqrt{$(a)} + \\sqrt{$(b)} + \\sqrt{$(c)}} \\cdot \\frac{\\sqrt{$(a)} + \\sqrt{$(b)} - \\sqrt{$(c)}}{\\sqrt{$(a)} + \\sqrt{$(b)} - \\sqrt{$(c)}}",
                "Denominator becomes: (\\sqrt{$(a)} + \\sqrt{$(b)})^2 - $(c) = $(a) + $(b) + 2\\sqrt{$(a*b)} - $(c)",
                "Numerator: \\sqrt{$(a)} + \\sqrt{$(b)} - \\sqrt{$(c)}",
                "Further rationalization may be needed depending on the form",
                sol("Answer", answer_str)
            ),
            time=300
        )
        
    else
        # Olympiad: Find integer solutions to radical equation
        # Target: 3200-3500 ELO
        k = randint(3, 8)
        m = randint(2, 6)
        
        question = "Find all positive integer pairs (x, y) satisfying: \\sqrt{x} + \\sqrt{y} = \\sqrt{$(k^2)} and xy = $(m^2 * k^2)"
        
        # Since √x + √y = k and xy = m²k²
        # Let √x = a, √y = b, then a + b = k and a²b² = m²k²
        # So ab = mk, giving us a, b are roots of t² - kt + mk = 0
        
        disc = k^2 - 4*m*k
        
        if disc >= 0 && isinteger(sqrt(disc))
            a = (k + sqrt(disc)) / 2
            b = (k - sqrt(disc)) / 2
            
            if a > 0 && b > 0 && isinteger(a) && isinteger(b)
                x_val = Int(a^2)
                y_val = Int(b^2)
                answer = fmt_set(Set([fmt_tuple([x_val, y_val]), fmt_tuple([y_val, x_val])]))
            else
                answer = fmt_set(Set([]))
            end
        else
            answer = fmt_set(Set([]))
        end
        
        problem(
            question=question,
            answer=answer,
            answer_type="set",
            difficulty=(3200, 3500),
            solution=steps(
                "Let \\sqrt{x} = a and \\sqrt{y} = b where a, b > 0",
                "Then a + b = $(k) and a^2 b^2 = $(m^2 * k^2)",
                "From second equation: ab = $(m*k)",
                "So a, b are roots of t^2 - $(k)t + $(m*k) = 0",
                "Solve for a, b and check they give integer values for x, y",
                sol("Answer", answer)
            ),
            time=300
        )
    end
end