# multivariable_calculus - line_integrals (easy)
# Generated: 2026-03-08T21:04:06.791062

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("multivariable_calculus/line_integrals")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Evaluate ∫_C F·dr where F and C are simple (ELO 700-900)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        
        # Parameterization: r(t) = (t, t), 0 ≤ t ≤ 2
        # F(x,y) = (a, b)
        # F(r(t)) · r'(t) = (a, b) · (1, 1) = a + b
        # ∫_0^2 (a+b) dt = 2(a+b)
        
        ans = 2 * (a + b)
        
        problem(
            question="Evaluate the line integral \\(\\int_C \\mathbf{F} \\cdot d\\mathbf{r}\\) where \\(\\mathbf{F}(x,y) = ($(a), $(b))\\) and \\(C\\) is the line segment from \\((0,0)\\) to \\((2,2)\\).",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Parameterize \\(C\\): \\(\\mathbf{r}(t) = (t, t)\\) for \\(0 \\leq t \\leq 2\\)",
                "Compute \\(\\mathbf{r}'(t) = (1, 1)\\)",
                "\\(\\mathbf{F}(\\mathbf{r}(t)) \\cdot \\mathbf{r}'(t) = ($(a), $(b)) \\cdot (1, 1) = $(a + b)\\)",
                "\\(\\int_0^2 $(a + b) \\, dt = $(a + b) \\cdot 2 = $(ans)\\)"
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type 2: Line integral of x + y along a straight path (ELO 800-1000)
        x1 = randint(-5, 5)
        y1 = randint(-5, 5)
        x2 = randint(-5, 5)
        y2 = randint(-5, 5)
        
        while x1 == x2 && y1 == y2
            x2 = randint(-5, 5)
            y2 = randint(-5, 5)
        end
        
        # r(t) = (x1, y1) + t((x2-x1), (y2-y1)), 0 ≤ t ≤ 1
        # f(r(t)) = x1 + t(x2-x1) + y1 + t(y2-y1) = (x1+y1) + t(x2-x1+y2-y1)
        # |r'(t)| = sqrt((x2-x1)^2 + (y2-y1)^2)
        
        dx = x2 - x1
        dy = y2 - y1
        length = sqrt(dx^2 + dy^2)
        
        # ∫_0^1 [(x1+y1) + t(dx+dy)] * length dt
        # = length * [(x1+y1) + (dx+dy)/2]
        # = length * [(x1+y1+x2+y2)/2]
        
        ans = length * (x1 + y1 + x2 + y2) / 2
        ans_rounded = round(ans, digits=2)
        
        problem(
            question="Evaluate \\(\\int_C (x + y) \\, ds\\) where \\(C\\) is the line segment from \\(($(x1), $(y1))\\) to \\(($(x2), $(y2))\\). Round to 2 decimal places.",
            answer=ans_rounded,
            difficulty=(800, 1000),
            solution=steps(
                "Parameterize: \\(\\mathbf{r}(t) = ($(x1), $(y1)) + t($(dx), $(dy))\\) for \\(0 \\leq t \\leq 1\\)",
                "\\(x(t) = $(x1) + $(dx)t\\), \\(y(t) = $(y1) + $(dy)t\\)",
                "\\(\\mathbf{r}'(t) = ($(dx), $(dy))\\), so \\(|\\mathbf{r}'(t)| = \\sqrt{$(dx^2) + $(dy^2)} = $(round(length, digits=2))\\)",
                "\\(x(t) + y(t) = $(x1 + y1) + $(dx + dy)t\\)",
                "\\(\\int_0^1 ($(x1 + y1) + $(dx + dy)t) \\cdot $(round(length, digits=2)) \\, dt = $(ans_rounded)\\)"
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Type 3: Work done by force field F = (x, y) along path (ELO 900-1100)
        # Circle centered at origin, radius r
        r = randint(2, 6)
        
        # Parameterize: x = r*cos(t), y = r*sin(t), 0 ≤ t ≤ π
        # F·dr = (r*cos(t), r*sin(t))·(-r*sin(t), r*cos(t)) dt
        # = -r²cos(t)sin(t) + r²sin(t)cos(t) = 0
        
        ans = 0
        
        problem(
            question="Calculate the work done by the force field \\(\\mathbf{F}(x,y) = (x, y)\\) along the upper semicircle \\(x^2 + y^2 = $(r^2)\\) from \\(($(r), 0)\\) to \\(($(-r), 0)\\).",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Parameterize: \\(\\mathbf{r}(t) = ($(r)\\cos t, $(r)\\sin t)\\) for \\(0 \\leq t \\leq \\pi\\)",
                "\\(\\mathbf{r}'(t) = (-$(r)\\sin t, $(r)\\cos t)\\)",
                "\\(\\mathbf{F}(\\mathbf{r}(t)) = ($(r)\\cos t, $(r)\\sin t)\\)",
                "\\(\\mathbf{F} \\cdot \\mathbf{r}' = $(r)\\cos t \\cdot (-$(r)\\sin t) + $(r)\\sin t \\cdot $(r)\\cos t = -$(r^2)\\cos t \\sin t + $(r^2)\\sin t \\cos t = 0\\)",
                "\\(\\int_0^\\pi 0 \\, dt = 0\\)"
            ),
            time=150
        )
        
    else
        # Type 4: Line integral with linear function along horizontal segment (ELO 700-900)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        x_start = randint(-5, 0)
        x_end = randint(1, 5)
        y_val = randint(-5, 5)
        
        # f(x,y) = ax + by along y = y_val from (x_start, y_val) to (x_end, y_val)
        # r(t) = (t, y_val), x_start ≤ t ≤ x_end
        # f(r(t)) = at + b*y_val
        # |r'(t)| = 1
        # ∫ (at + b*y_val) dt from x_start to x_end
        # = [at²/2 + b*y_val*t] from x_start to x_end
        
        ans = a * (x_end^2 - x_start^2) // 2 + b * y_val * (x_end - x_start)
        
        problem(
            question="Evaluate \\(\\int_C ($(a)x + $(b)y) \\, ds\\) where \\(C\\) is the horizontal line segment from \\(($(x_start), $(y_val))\\) to \\(($(x_end), $(y_val))\\).",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Parameterize: \\(\\mathbf{r}(t) = (t, $(y_val))\\) for \\($(x_start) \\leq t \\leq $(x_end)\\)",
                "\\(|\\mathbf{r}'(t)| = |(1, 0)| = 1\\)",
                "\\(f(\\mathbf{r}(t)) = $(a)t + $(b) \\cdot $(y_val) = $(a)t + $(b * y_val)\\)",
                "\\(\\int_{$(x_start)}^{$(x_end)} ($(a)t + $(b * y_val)) \\, dt = \\left[\\frac{$(a)t^2}{2} + $(b * y_val)t\\right]_{$(x_start)}^{$(x_end)}\\)",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end