# precalculus - transformations (easy)
# Generated: 2026-03-08T20:25:56.288839

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/transformations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Vertical shift identification
        base_func = choice(["x^2", "\\sqrt{x}", "|x|", "x^3"])
        k = nonzero(-8, 8)
        direction = k > 0 ? "up" : "down"
        
        problem(
            question="The graph of \$f(x) = $(base_func)\$ is shifted $(abs(k)) units $(direction) to produce \$g(x)\$. What is \$g(x)\$?",
            answer=base_func * (k > 0 ? " + $(k)" : " - $(abs(k))"),
            difficulty=(700, 850),
            solution=steps(
                "Vertical shifts add a constant to the function",
                "Shifting $(direction) by $(abs(k)) units means $(k > 0 ? "adding" : "subtracting") $(abs(k))",
                sol("Answer", base_func * (k > 0 ? " + $(k)" : " - $(abs(k))"))
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Horizontal shift identification
        base_func = choice(["x^2", "\\sqrt{x}", "|x|", "x^3"])
        h = nonzero(-8, 8)
        direction = h > 0 ? "right" : "left"
        
        problem(
            question="The graph of \$f(x) = $(base_func)\$ is shifted $(abs(h)) units $(direction) to produce \$g(x)\$. What is \$g(x)\$?",
            answer=replace(base_func, "x" => "(x $(h > 0 ? "-" : "+") $(abs(h)))"),
            difficulty=(750, 900),
            solution=steps(
                "Horizontal shifts replace \$x\$ with \$x - h\$ where \$h\$ is the shift",
                "Shifting $(direction) by $(abs(h)) means replacing \$x\$ with \$x $(h > 0 ? "-" : "+") $(abs(h))\$",
                sol("Answer", replace(base_func, "x" => "(x $(h > 0 ? "-" : "+") $(abs(h)))"))
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Vertical stretch/compression
        base_func = choice(["x^2", "\\sqrt{x}", "|x|", "\\sin(x)"])
        a = choice([2, 3, 4, 1//2, 1//3, 1//4])
        stretch_or_compress = abs(a) > 1 ? "stretched" : "compressed"
        
        problem(
            question="The graph of \$f(x) = $(base_func)\$ is vertically $(stretch_or_compress) by a factor of \$$(a)\$ to produce \$g(x)\$. What is \$g(x)\$?",
            answer="$(a) \\cdot ($(base_func))",
            difficulty=(800, 950),
            solution=steps(
                "Vertical stretches/compressions multiply the function by a constant",
                "A factor of \$$(a)\$ means multiplying the entire function by \$$(a)\$",
                sol("Answer", "$(a)($(base_func))")
            ),
            time=50
        )
        
    elseif problem_type == 4
        # Combined vertical and horizontal shift
        base_func = choice(["x^2", "|x|", "x^3"])
        h = nonzero(-6, 6)
        k = nonzero(-6, 6)
        
        problem(
            question="Describe the transformations needed to obtain \$g(x) = $(replace(base_func, "x" => "(x $(h > 0 ? "-" : "+") $(abs(h)))"))$(k > 0 ? "+" : "")$(k)\$ from \$f(x) = $(base_func)\$.",
            answer="Shift $(abs(h)) units $(h > 0 ? "right" : "left") and $(abs(k)) units $(k > 0 ? "up" : "down")",
            difficulty=(900, 1100),
            answer_type="text",
            solution=steps(
                "Identify horizontal shift: \$x $(h > 0 ? "-" : "+") $(abs(h))\$ means shift $(abs(h)) units $(h > 0 ? "right" : "left")",
                "Identify vertical shift: \$$(k > 0 ? "+" : "")$(k)\$ means shift $(abs(k)) units $(k > 0 ? "up" : "down")",
                "Answer: Shift $(abs(h)) units $(h > 0 ? "right" : "left") and $(abs(k)) units $(k > 0 ? "up" : "down")"
            ),
            time=90
        )
        
    else
        # Reflection identification
        base_func = choice(["x^2", "\\sqrt{x}", "|x|", "x^3"])
        reflect_type = rand(1:2)
        
        if reflect_type == 1
            # Reflect over x-axis
            problem(
                question="The graph of \$f(x) = $(base_func)\$ is reflected over the x-axis to produce \$g(x)\$. What is \$g(x)\$?",
                answer="-($(base_func))",
                difficulty=(750, 900),
                solution=steps(
                    "Reflection over the x-axis negates the entire function",
                    "Multiply \$f(x)\$ by \$-1\$",
                    sol("Answer", "-($(base_func))")
                ),
                time=50
            )
        else
            # Reflect over y-axis
            problem(
                question="The graph of \$f(x) = $(base_func)\$ is reflected over the y-axis to produce \$g(x)\$. What is \$g(x)\$?",
                answer=replace(base_func, "x" => "(-x)"),
                difficulty=(800, 950),
                solution=steps(
                    "Reflection over the y-axis replaces \$x\$ with \$-x\$",
                    "Substitute \$-x\$ for \$x\$ in \$f(x)\$",
                    sol("Answer", replace(base_func, "x" => "(-x)"))
                ),
                time=60
            )
        end
    end
end