# precalculus - transformations (hard)
# Generated: 2026-03-08T20:26:38.620101

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/transformations")
    
    prob_type = choice(1:5)
    
    if prob_type == 1
        # Composition of transformations - determine final function
        base_type = choice([:quadratic, :absolute, :cubic, :sqrt])
        
        if base_type == :quadratic
            base_expr = x^2
            base_str = "x^2"
        elseif base_type == :absolute
            base_expr = abs(x)
            base_str = "|x|"
        elseif base_type == :cubic
            base_expr = x^3
            base_str = "x^3"
        else
            base_expr = sqrt(x)
            base_str = "\\sqrt{x}"
        end
        
        h = nonzero(-8, 8)
        k = nonzero(-8, 8)
        a = choice([-3, -2, -1//2, 1//2, 2, 3, 4])
        
        transforms = []
        if a < 0
            push!(transforms, "reflection across the x-axis")
        end
        if abs(a) != 1
            if abs(a) > 1
                push!(transforms, "vertical stretch by factor $(abs(a))")
            else
                push!(transforms, "vertical compression by factor $(abs(a))")
            end
        end
        if h != 0
            direction = h > 0 ? "right" : "left"
            push!(transforms, "horizontal shift $(abs(h)) units $direction")
        end
        if k != 0
            direction = k > 0 ? "up" : "down"
            push!(transforms, "vertical shift $(abs(k)) units $direction")
        end
        
        transform_desc = join(transforms, ", then ")
        
        # Build answer
        if base_type == :sqrt
            inner = x - h
            answer_expr = a * sqrt(inner) + k
            answer_str = "$(tex(a)) \\sqrt{x $(h >= 0 ? "-" : "+") $(abs(h))} $(k >= 0 ? "+" : "-") $(abs(k))"
        elseif base_type == :absolute
            inner = x - h
            answer_str = "$(tex(a)) |x $(h >= 0 ? "-" : "+") $(abs(h))| $(k >= 0 ? "+" : "-") $(abs(k))"
        elseif base_type == :quadratic
            inner = x - h
            answer_str = "$(tex(a))(x $(h >= 0 ? "-" : "+") $(abs(h)))^2 $(k >= 0 ? "+" : "-") $(abs(k))"
        else  # cubic
            inner = x - h
            answer_str = "$(tex(a))(x $(h >= 0 ? "-" : "+") $(abs(h)))^3 $(k >= 0 ? "+" : "-") $(abs(k))"
        end
        
        problem(
            question="Starting with the parent function \\(f(x) = $base_str\\), apply the following transformations in order: $transform_desc. What is the equation of the resulting function?",
            answer=answer_str,
            difficulty=(1850, 2050),
            solution=steps(
                "Start with \\(f(x) = $base_str\\)",
                "Apply transformations: $transform_desc",
                "Horizontal shift by $h: replace \\(x\\) with \\(x - $h\\)",
                "Vertical stretch/reflection by $a: multiply by $a",
                "Vertical shift by $k: add $k",
                sol("Final answer", answer_str)
            ),
            time=180
        )
        
    elseif prob_type == 2
        # Given transformed function, identify all parameters
        base_type = choice([:quadratic, :absolute, :cubic])
        
        h = nonzero(-7, 7)
        k = nonzero(-7, 7)
        a = choice([-4, -3, -2, 2, 3, 4])
        
        if base_type == :quadratic
            func_str = "g(x) = $(a)(x $(h >= 0 ? "-" : "+") $(abs(h)))^2 $(k >= 0 ? "+" : "-") $(abs(k))"
            parent = "f(x) = x^2"
        elseif base_type == :absolute
            func_str = "g(x) = $(a)|x $(h >= 0 ? "-" : "+") $(abs(h))| $(k >= 0 ? "+" : "-") $(abs(k))"
            parent = "f(x) = |x|"
        else
            func_str = "g(x) = $(a)(x $(h >= 0 ? "-" : "+") $(abs(h)))^3 $(k >= 0 ? "+" : "-") $(abs(k))"
            parent = "f(x) = x^3"
        end
        
        answer = fmt_tuple([a, h, k])
        
        problem(
            question="The function \\($func_str\\) is a transformation of the parent function \\($parent\\). Express the transformation in the form \\(g(x) = a \\cdot f(x - h) + k\\). What are the values of \\((a, h, k)\\)?",
            answer=answer,
            answer_type="tuple",
            difficulty=(1800, 2000),
            solution=steps(
                "Given: \\($func_str\\)",
                "Compare to form \\(a \\cdot f(x - h) + k\\)",
                "Vertical stretch/reflection factor: \\(a = $a\\)",
                "Horizontal shift: \\(h = $h\\)",
                "Vertical shift: \\(k = $k\\)",
                sol("Answer", answer)
            ),
            time=150
        )
        
    elseif prob_type == 3
        # Find the transformation that maps one point to another
        x1 = nonzero(-8, 8)
        y1 = nonzero(-8, 8)
        
        h = nonzero(-9, 9)
        k = nonzero(-9, 9)
        a = choice([-3, -2, 2, 3])
        
        x2 = x1 + h
        y2 = a * y1 + k
        
        answer = fmt_tuple([a, h, k])
        
        problem(
            question="A function \\(f(x)\\) passes through the point \\(($x1, $y1)\\). After applying the transformation \\(g(x) = a \\cdot f(x - h) + k\\), the corresponding point on \\(g(x)\\) is \\(($x2, $y2)\\). Find \\((a, h, k)\\).",
            answer=answer,
            answer_type="tuple",
            difficulty=(2000, 2250),
            solution=steps(
                "Original point: \\(($x1, $y1)\\)",
                "Transformed point: \\(($x2, $y2)\\)",
                "Horizontal shift: \\($x2 - $x1 = $h\\), so \\(h = $h\\)",
                "For y-coordinate: \\($y2 = a($y1) + k\\)",
                "We have \\($y2 = a($y1) + k\\)",
                "Since \\(a \\cdot $y1 + k = $y2\\), we need \\(a = $(a)\\) and \\(k = $k\\)",
                sol("Answer", answer)
            ),
            time=240
        )
        
    elseif prob_type == 4
        # Determine range/domain after transformation
        base_type = choice([:quadratic, :sqrt])
        
        if base_type == :quadratic
            # For quadratic, give domain, ask for range
            h = randint(-6, 6)
            k = randint(-8, 8)
            a = choice([-3, -2, 2, 3])
            
            x_min = nonzero(-5, 5)
            x_max = x_min + randint(4, 10)
            
            # Range calculation
            vertex_x = h
            if x_min <= vertex_x && vertex_x <= x_max
                # Vertex in domain
                if a > 0
                    y_at_vertex = k
                    y_at_left = a * (x_min - h)^2 + k
                    y_at_right = a * (x_max - h)^2 + k
                    y_min = y_at_vertex
                    y_max = max(y_at_left, y_at_right)
                else
                    y_at_vertex = k
                    y_at_left = a * (x_min - h)^2 + k
                    y_at_right = a * (x_max - h)^2 + k
                    y_max = y_at_vertex
                    y_min = min(y_at_left, y_at_right)
                end
            else
                # Vertex outside domain
                y_at_left = a * (x_min - h)^2 + k
                y_at_right = a * (x_max - h)^2 + k
                y_min = min(y_at_left, y_at_right)
                y_max = max(y_at_left, y_at_right)
            end
            
            answer = fmt_interval(y_min, y_max, true, true)
            
            func_str = "f(x) = $(a)(x $(h >= 0 ? "-" : "+") $(abs(h)))^2 $(k >= 0 ? "+" : "-") $(abs(k))"
            domain_str = fmt_interval(x_min, x_max, true, true)
            
            problem(
                question="Consider the function \\($func_str\\) with domain \\($domain_str\\). What is the range of \\(f\\)?",
                answer=answer,
                answer_type="interval",
                difficulty=(1900, 2150),
                solution=steps(
                    "Given: \\($func_str\\) on domain \\($domain_str\\)",
                    "Vertex at \\(x = $h\\), \\(y = $k\\)",
                    "Evaluate endpoints and vertex (if in domain)",
                    "\\(f($x_min) = $(a * (x_min - h)^2 + k)\\)",
                    "\\(f($x_max) = $(a * (x_max - h)^2 + k)\\)",
                    sol("Range", answer)
                ),
                time=200
            )
        else
            # For sqrt, give range, ask for domain
            h = randint(-7, 7)
            k = randint(-8, 8)
            a = choice([2, 3, 4])
            
            y_min = k
            y_max = k + randint(8, 16)
            
            # Domain calculation: y = a*sqrt(x - h) + k
            # y_min = k => x = h
            # y_max = k + a*sqrt(x_max - h) => x_max = h + ((y_max - k)/a)^2
            
            x_min = h
            x_max = h + ((y_max - k) // a)^2
            
            answer = fmt_interval(x_min, x_max, true, true)
            
            func_str = "f(x) = $(a)\\sqrt{x $(h >= 0 ? "-" : "+") $(abs(h))} $(k >= 0 ? "+" : "-") $(abs(k))"
            range_str = fmt_interval(y_min, y_max, true, true)
            
            problem(
                question="The function \\($func_str\\) has range \\($range_str\\). What is the domain of \\(f\\)?",
                answer=answer,
                answer_type="interval",
                difficulty=(2050, 2300),
                solution=steps(
                    "Given: \\($func_str\\) with range \\($range_str\\)",
                    "Square root requires \\(x - $h \\geq 0\\), so \\(x \\geq $h\\)",
                    "When \\(x = $h\\): \\(f($h) = $k\\) (minimum y-value)",
                    "When \\(y = $y_max\\): \\($y_max = $a\\sqrt{x - $h} + $k\\)",
                    "Solving: \\(\\sqrt{x - $h} = $(Rational((y_max - k), a))\\), so \\(x = $x_max\\)",
                    sol("Domain", answer)
                ),
                time=220
            )
        end
        
    else  # prob_type == 5
        # Inverse transformation problem
        h = nonzero(-6, 6)
        k = nonzero(-6, 6)
        a = choice([2, 3, 4, -2, -3])
        
        # g(x) = a*f(x - h) + k
        # To find f in terms of g: f(x) = (g(x + h) - k) / a
        
        h_inv = -h
        k_inv = -k
        a_inv = 1 // a
        
        answer = fmt_tuple([a_inv, h_inv, k_inv])
        
        problem(
            question="Suppose \\(g(x) = $a \\cdot f(x - $h) + $k\\). Express \\(f(x)\\) in terms of \\(g\\) in the form \\(f(x) = A \\cdot g(x - B) + C\\). Find \\((A, B, C)\\).",
            answer=answer,
            answer_type="tuple",
            difficulty=(2100, 2400),
            solution=steps(
                "Given: \\(g(x) = $a \\cdot f(x - $h) + $k\\)",
                "Solve for \\(f(x - $h)\\): \\(f(x - $h) = \\frac{g(x) - $k}{$a}\\)",
                "Substitute \\(u = x - $h\\), so \\(x = u + $h\\)",
                "Then \\(f(u) = \\frac{g(u + $h) - $k}{$a}\\)",
                "Replace \\(u\\) with \\(x\\): \\(f(x) = \\frac{1}{$a} \\cdot g(x - ($h_inv)) + $(k_inv)\\)",
                sol("Answer: (A, B, C)", answer)
            ),
            time=270
        )
    end
end