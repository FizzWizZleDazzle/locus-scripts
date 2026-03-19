# precalculus - transformations (medium)
# Generated: 2026-03-08T20:26:17.559834

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/transformations")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Horizontal/vertical shifts
        base_func = choice(["x^2", "\\sqrt{x}", "|x|", "x^3"])
        h = nonzero(-8, 8)
        k = nonzero(-8, 8)
        
        h_sign = h > 0 ? "-" : "+"
        h_val = abs(h)
        k_sign = k > 0 ? "+" : "-"
        k_val = abs(k)
        
        direction_h = h > 0 ? "right" : "left"
        direction_v = k > 0 ? "up" : "down"
        
        if base_func == "x^2"
            transformed = "(x $h_sign $h_val)^2 $k_sign $k_val"
            base_name = "f(x) = x^2"
        elseif base_func == "\\sqrt{x}"
            transformed = "\\sqrt{x $h_sign $h_val} $k_sign $k_val"
            base_name = "f(x) = \\sqrt{x}"
        elseif base_func == "|x|"
            transformed = "|x $h_sign $h_val| $k_sign $k_val"
            base_name = "f(x) = |x|"
        else
            transformed = "(x $h_sign $h_val)^3 $k_sign $k_val"
            base_name = "f(x) = x^3"
        end
        
        ans = fmt_tuple((h, k))
        
        problem(
            question="The graph of \$$base_name\$ is transformed to \$g(x) = $transformed\$. What is the ordered pair (h, k) representing the horizontal and vertical shifts?",
            answer=ans,
            answer_type="tuple",
            difficulty=(1200, 1400),
            solution=steps(
                "Base function: \$$base_name\$",
                "Transformed function: \$g(x) = $transformed\$",
                "Horizontal shift: $h_val units $direction_h (h = $h)",
                "Vertical shift: $k_val units $direction_v (k = $k)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Reflections and stretches
        a = choice([-4, -3, -2, 2, 3, 4, 5])
        base_func = choice(["x^2", "\\sqrt{x}", "|x|"])
        
        if a < 0
            reflection_text = "reflected across the x-axis"
            stretch_factor = abs(a)
        else
            reflection_text = "not reflected"
            stretch_factor = a
        end
        
        if stretch_factor > 1
            stretch_text = "vertically stretched by a factor of $stretch_factor"
        elseif stretch_factor == 1
            stretch_text = "no vertical stretch"
        else
            stretch_text = "vertically compressed by a factor of $stretch_factor"
        end
        
        if base_func == "x^2"
            base_name = "f(x) = x^2"
            transformed = "$a x^2"
        elseif base_func == "\\sqrt{x}"
            base_name = "f(x) = \\sqrt{x}"
            transformed = "$a\\sqrt{x}"
        else
            base_name = "f(x) = |x|"
            transformed = "$a|x|"
        end
        
        problem(
            question="Describe the transformations applied to \$$base_name\$ to obtain \$g(x) = $transformed\$. What is the value of the vertical stretch/compression factor (use negative if reflected)?",
            answer=a,
            difficulty=(1100, 1300),
            solution=steps(
                "Base function: \$$base_name\$",
                "Transformed function: \$g(x) = $transformed\$",
                "The coefficient $a indicates: $reflection_text and $stretch_text",
                sol("Answer", a)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Combined transformations
        a = choice([2, 3, -2, -3])
        h = nonzero(-6, 6)
        k = nonzero(-6, 6)
        
        h_sign = h > 0 ? "-" : "+"
        h_val = abs(h)
        k_sign = k > 0 ? "+" : "-"
        k_val = abs(k)
        
        base_func = choice(["x^2", "|x|"])
        
        if base_func == "x^2"
            transformed = "$a(x $h_sign $h_val)^2 $k_sign $k_val"
            base_name = "y = x^2"
        else
            transformed = "$a|x $h_sign $h_val| $k_sign $k_val"
            base_name = "y = |x|"
        end
        
        # Ask for the vertex/turning point
        vertex_x = h
        vertex_y = k
        
        ans = fmt_tuple((vertex_x, vertex_y))
        
        problem(
            question="The function \$$base_name\$ is transformed to \$y = $transformed\$. What are the coordinates of the vertex (or turning point) of the transformed function?",
            answer=ans,
            answer_type="tuple",
            difficulty=(1300, 1500),
            solution=steps(
                "Base function: \$$base_name\$ with vertex at (0, 0)",
                "Transformed function: \$y = $transformed\$",
                "Horizontal shift moves vertex to x = $h",
                "Vertical shift moves vertex to y = $k",
                sol("Vertex", ans)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Horizontal stretch/compression
        b = choice([2, 3, 4, 1//2, 1//3])
        k = nonzero(-5, 5)
        
        base_func = choice(["x^2", "|x|", "x^3"])
        
        if base_func == "x^2"
            transformed = "($b x)^2 + $k"
            base_name = "f(x) = x^2"
        elseif base_func == "|x|"
            transformed = "|$b x| + $k"
            base_name = "f(x) = |x|"
        else
            transformed = "($b x)^3 + $k"
            base_name = "f(x) = x^3"
        end
        
        if b > 1
            horizontal_factor = 1 // b
        else
            horizontal_factor = 1 // b
        end
        
        problem(
            question="The function \$$base_name\$ is transformed to \$g(x) = $transformed\$. What is the horizontal stretch/compression factor? (Use a fraction less than 1 for compression, greater than 1 for stretch.)",
            answer=horizontal_factor,
            difficulty=(1400, 1600),
            solution=steps(
                "Base function: \$$base_name\$",
                "Transformed function: \$g(x) = $transformed\$",
                "Coefficient of x is $b, so horizontal factor = 1/$b = $horizontal_factor",
                "If factor < 1: horizontal compression. If factor > 1: horizontal stretch.",
                sol("Answer", horizontal_factor)
            ),
            time=120
        )
        
    else
        # Finding the transformation equation
        a = choice([2, 3, -2, -3, 1//2])
        h = nonzero(-7, 7)
        k = nonzero(-7, 7)
        
        h_sign = h > 0 ? "-" : "+"
        h_val = abs(h)
        k_sign = k > 0 ? "+" : "-"
        k_val = abs(k)
        
        transformed = "$a(x $h_sign $h_val)^2 $k_sign $k_val"
        
        # Ask them to identify specific value
        which = choice(["a", "h", "k"])
        
        if which == "a"
            ans = a
            question_text = "In the transformed function \$g(x) = $transformed\$ of the parent function \$f(x) = x^2\$, what is the value of the vertical stretch factor a?"
        elseif which == "h"
            ans = h
            question_text = "In the transformed function \$g(x) = $transformed\$ of the parent function \$f(x) = x^2\$, what is the value of h (the horizontal shift)?"
        else
            ans = k
            question_text = "In the transformed function \$g(x) = $transformed\$ of the parent function \$f(x) = x^2\$, what is the value of k (the vertical shift)?"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Standard form: \$g(x) = a(x - h)^2 + k\$",
                "Given: \$g(x) = $transformed\$",
                "Identify: a = $a, h = $h, k = $k",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end