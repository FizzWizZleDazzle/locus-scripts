# precalculus - transformations (very_easy)
# Generated: 2026-03-08T20:25:48.113977

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/transformations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Vertical shift identification (ELO 200-400)
        base_func = choice(["f(x)", "g(x)", "h(x)"])
        shift = randint(-8, 8)
        if shift >= 0
            transformed = "$(base_func) + $(shift)"
            direction = "up"
            shift_abs = shift
        else
            transformed = "$(base_func) - $(abs(shift))"
            direction = "down"
            shift_abs = abs(shift)
        end
        
        problem(
            question="The function \$$(transformed)\$ is a vertical shift of \$$(base_func)\$. How many units and in what direction?",
            answer="$(shift_abs) units $(direction)",
            difficulty=(200, 400),
            answer_type="string",
            solution=steps(
                "Vertical shifts have the form \$f(x) + k\$ or \$f(x) - k\$",
                "If \$k > 0\$, the shift is upward; if \$k < 0\$, the shift is downward",
                sol("Answer: $(shift_abs) units $(direction)")
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Horizontal shift identification (ELO 300-500)
        base_func = choice(["f(x)", "g(x)", "h(x)"])
        shift = randint(-10, 10)
        if shift == 0
            shift = randint(1, 10)
        end
        
        if shift > 0
            transformed = "$(base_func[1:end-2])(x - $(shift))"
            direction = "right"
            shift_abs = shift
        else
            transformed = "$(base_func[1:end-2])(x + $(abs(shift)))"
            direction = "left"
            shift_abs = abs(shift)
        end
        
        problem(
            question="The function \$$(transformed)\$ is a horizontal shift of \$$(base_func)\$. How many units and in what direction?",
            answer="$(shift_abs) units $(direction)",
            difficulty=(300, 500),
            answer_type="string",
            solution=steps(
                "Horizontal shifts have the form \$f(x - h)\$ or \$f(x + h)\$",
                "If the form is \$f(x - h)\$ with \$h > 0\$, shift right by \$h\$ units",
                "If the form is \$f(x + h)\$ with \$h > 0\$, shift left by \$h\$ units",
                sol("Answer: $(shift_abs) units $(direction)")
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Vertical stretch/compression (ELO 400-600)
        base_func = choice(["f(x)", "g(x)", "h(x)"])
        factor = choice([2, 3, 4, 5, 1//2, 1//3, 1//4])
        
        if factor >= 1
            type_str = "vertical stretch"
        else
            type_str = "vertical compression"
        end
        
        transformed = "$(factor)$(base_func)"
        
        problem(
            question="Is \$$(transformed)\$ a vertical stretch or vertical compression of \$$(base_func)\$?",
            answer=type_str,
            difficulty=(400, 600),
            answer_type="string",
            solution=steps(
                "Vertical scaling has the form \$a \\cdot f(x)\$",
                "If \$|a| > 1\$, it is a vertical stretch",
                "If \$0 < |a| < 1\$, it is a vertical compression",
                sol("Here \$a = $(factor)\$, so this is a $(type_str)")
            ),
            time=50
        )
        
    elseif problem_type == 4
        # Reflection identification (ELO 300-500)
        base_func = choice(["f(x)", "g(x)", "h(x)"])
        reflection_type = rand(1:2)
        
        if reflection_type == 1
            transformed = "-$(base_func)"
            axis = "x-axis"
        else
            transformed = "$(base_func[1:end-2])(-x)"
            axis = "y-axis"
        end
        
        problem(
            question="The function \$$(transformed)\$ is a reflection of \$$(base_func)\$ across which axis?",
            answer=axis,
            difficulty=(300, 500),
            answer_type="string",
            solution=steps(
                "Reflection across the x-axis: \$-f(x)\$",
                "Reflection across the y-axis: \$f(-x)\$",
                sol("This is \$$(transformed)\$, so it is a reflection across the $(axis)")
            ),
            time=50
        )
        
    else
        # Combined vertical shift and stretch (ELO 500-700)
        base_func = choice(["f(x)", "g(x)", "h(x)"])
        a = choice([2, 3, 4, 1//2, 1//3])
        k = randint(-6, 6)
        
        if k >= 0
            transformed = "$(a)$(base_func) + $(k)"
        else
            transformed = "$(a)$(base_func) - $(abs(k))"
        end
        
        if a >= 1
            stretch_type = "vertical stretch by factor $(a)"
        else
            stretch_type = "vertical compression by factor $(a)"
        end
        
        if k > 0
            shift_type = "shifted up $(k) units"
        elseif k < 0
            shift_type = "shifted down $(abs(k)) units"
        else
            shift_type = "no vertical shift"
        end
        
        answer_str = "$(stretch_type), $(shift_type)"
        
        problem(
            question="Describe the transformations applied to \$$(base_func)\$ to obtain \$$(transformed)\$",
            answer=answer_str,
            difficulty=(500, 700),
            answer_type="string",
            solution=steps(
                "The coefficient \$$(a)\$ represents vertical scaling",
                "The constant term \$$(k >= 0 ? "+" : "")$(k)\$ represents vertical shift",
                sol("Transformations: $(stretch_type), then $(shift_type)")
            ),
            time=75
        )
    end
end