# multivariable_calculus - line_integrals (very_easy)
# Generated: 2026-03-08T21:03:54.572661

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t begin
    set_topic!("multivariable_calculus/line_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Evaluate a simple line integral of a constant along a straight path (ELO 200-400)
        # ∫_C k ds where C is a line segment
        k = randint(1, 9)
        x1, y1 = randint(-8, 8), randint(-8, 8)
        x2, y2 = randint(-8, 8), randint(-8, 8)
        while x1 == x2 && y1 == y2
            x2, y2 = randint(-8, 8), randint(-8, 8)
        end
        
        length = sqrt((x2 - x1)^2 + (y2 - y1)^2)
        ans = k * length
        
        problem(
            question="Evaluate \\(\\int_C $(k) \\, ds\\) where \\(C\\) is the line segment from \\(($(x1), $(y1))\\) to \\(($(x2), $(y2))\\).",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "For a constant integrand, \\(\\int_C k \\, ds = k \\cdot \\text{(length of path)}\\)",
                "Length = \\(\\sqrt{($(x2) - $(x1))^2 + ($(y2) - $(y1))^2} = \\sqrt{$(((x2-x1)^2 + (y2-y1)^2))} = $(length)\\)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Type 2: Compute ds for a parametric curve (ELO 400-600)
        # Given r(t) = (at + b, ct + d), find ds
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = nonzero(-5, 5)
        d = randint(-8, 8)
        
        ds_expr = sqrt(a^2 + c^2)
        
        problem(
            question="For the parametric curve \\(\\mathbf{r}(t) = ($(a)t + $(b), $(c)t + $(d))\\), find the differential arc length \\(ds\\) in terms of \\(dt\\).",
            answer="$(ds_expr) dt",
            difficulty=(400, 600),
            answer_type="expression",
            solution=steps(
                "Compute \\(\\frac{dx}{dt} = $(a)\\) and \\(\\frac{dy}{dt} = $(c)\\)",
                "Arc length differential: \\(ds = \\sqrt{\\left(\\frac{dx}{dt}\\right)^2 + \\left(\\frac{dy}{dt}\\right)^2} \\, dt\\)",
                sol("Answer", "ds = $(ds_expr) dt")
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Type 3: Line integral of x along a horizontal line (ELO 300-500)
        # ∫_C x ds where C is from (x1, y0) to (x2, y0)
        y0 = randint(-8, 8)
        x1 = randint(-8, 5)
        x2 = randint(x1 + 1, 8)
        
        # ∫_{x1}^{x2} x dx = x²/2 evaluated
        ans = (x2^2 - x1^2) // 2
        
        problem(
            question="Evaluate \\(\\int_C x \\, ds\\) where \\(C\\) is the line segment from \\(($(x1), $(y0))\\) to \\(($(x2), $(y0))\\).",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "The path is horizontal (y constant), so \\(ds = dx\\)",
                "\\(\\int_C x \\, ds = \\int_{$(x1)}^{$(x2)} x \\, dx\\)",
                "Evaluate: \\(\\left[\\frac{x^2}{2}\\right]_{$(x1)}^{$(x2)} = \\frac{$(x2)^2}{2} - \\frac{$(x1)^2}{2} = $(ans)\\)"
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Type 4: Line integral of y along a vertical line (ELO 300-500)
        # ∫_C y ds where C is from (x0, y1) to (x0, y2)
        x0 = randint(-8, 8)
        y1 = randint(-8, 5)
        y2 = randint(y1 + 1, 8)
        
        ans = (y2^2 - y1^2) // 2
        
        problem(
            question="Evaluate \\(\\int_C y \\, ds\\) where \\(C\\) is the line segment from \\(($(x0), $(y1))\\) to \\(($(x0), $(y2))\\).",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "The path is vertical (x constant), so \\(ds = dy\\)",
                "\\(\\int_C y \\, ds = \\int_{$(y1)}^{$(y2)} y \\, dy\\)",
                "Evaluate: \\(\\left[\\frac{y^2}{2}\\right]_{$(y1)}^{$(y2)} = \\frac{$(y2)^2}{2} - \\frac{$(y1)^2}{2} = $(ans)\\)"
            ),
            time=90
        )
        
    else
        # Type 5: Find the length of a simple parametric curve (ELO 500-700)
        # Arc length of r(t) = (at, bt) from t=0 to t=T
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        T = randint(2, 8)
        
        speed = sqrt(a^2 + b^2)
        ans = T * speed
        
        problem(
            question="Find the arc length of the curve \\(\\mathbf{r}(t) = ($(a)t, $(b)t)\\) for \\(0 \\leq t \\leq $(T)\\).",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Compute \\(\\mathbf{r}'(t) = ($(a), $(b))\\)",
                "Speed: \\(|\\mathbf{r}'(t)| = \\sqrt{$(a)^2 + $(b)^2} = $(speed)\\)",
                "Arc length: \\(L = \\int_0^{$(T)} $(speed) \\, dt = $(speed) \\cdot $(T) = $(ans)\\)"
            ),
            time=120
        )
    end
end