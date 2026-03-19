# multivariable_calculus - double_integrals (medium)
# Generated: 2026-03-08T21:01:18.577049

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/double_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Rectangular region with polynomial
        a = randint(0, 3)
        b = randint(a+2, a+6)
        c = randint(0, 3)
        d = randint(c+2, c+6)
        
        k = randint(1, 5)
        m = randint(1, 4)
        n = randint(1, 4)
        
        integrand = k * x^m * y^n
        
        # Compute answer
        inner_x = k * x^(m+1) / (m+1) * y^n
        eval_x = substitute(inner_x, x => b) - substitute(inner_x, x => a)
        
        outer_y = eval_x * y^(n+1) / (n+1)
        ans_num = substitute(outer_y, y => d) - substitute(outer_y, y => c)
        ans = Float64(ans_num)
        
        problem(
            question="Evaluate the double integral \\\$\\\$\\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} $(tex(integrand)) \\, dx \\, dy\\\$\\\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", integrand),
                "First integrate with respect to \\\$x\\\$: \\\$\\int_{$(a)}^{$(b)} $(tex(integrand)) \\, dx = $(tex(eval_x))\\\$",
                "Then integrate with respect to \\\$y\\\$: \\\$\\int_{$(c)}^{$(d)} $(tex(eval_x)) \\, dy = $(tex(ans_num))\\\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type I region (y between functions of x)
        x_low = randint(0, 2)
        x_high = randint(x_low+2, x_low+5)
        
        k1 = randint(1, 3)
        k2 = randint(k1+1, k1+3)
        
        y_lower = k1 * x
        y_upper = k2 * x
        
        integrand = choice([1, x, y, 2*x, 2*y, x*y])
        
        if integrand == 1
            area = (k2 - k1) * (x_high^2 - x_low^2) / 2
        elseif integrand == x
            area = (k2 - k1) * (x_high^3 - x_low^3) / 3
        elseif integrand == y
            area = (k2^2 - k1^2) * (x_high^3 - x_low^3) / 6
        elseif integrand == 2*x
            area = (k2 - k1) * (x_high^3 - x_low^3) * 2 / 3
        elseif integrand == 2*y
            area = (k2^2 - k1^2) * (x_high^3 - x_low^3) / 3
        else  # x*y
            area = (k2^2 - k1^2) * (x_high^4 - x_low^4) / 8
        end
        
        ans = Float64(area)
        
        problem(
            question="Evaluate \\\$\\\$\\int_{$(x_low)}^{$(x_high)} \\int_{$(tex(y_lower))}^{$(tex(y_upper))} $(tex(integrand)) \\, dy \\, dx\\\$\\\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Region: \\\$$(x_low) \\leq x \\leq $(x_high)\\\$, \\\$$(tex(y_lower)) \\leq y \\leq $(tex(y_upper))\\\$",
                "Integrate with respect to \\\$y\\\$ first, treating \\\$x\\\$ as constant",
                "Then integrate the result with respect to \\\$x\\\$",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Volume under surface over rectangular region
        a = randint(0, 2)
        b = randint(a+2, a+5)
        c = randint(0, 2)
        d = randint(c+2, c+5)
        
        k = randint(1, 4)
        surface = k + x + y
        
        # Volume calculation
        inner = k*x + x^2/2 + x*y
        eval_x = substitute(inner, x => b) - substitute(inner, x => a)
        outer = expand(eval_x * y + eval_x)
        
        base_area = (b - a) * (d - c)
        avg_height = k + (a + b)/2 + (c + d)/2
        ans = base_area * avg_height
        
        problem(
            question="Find the volume under the surface \\\$z = $(tex(surface))\\\$ over the rectangular region \\\$[$(a), $(b)] \\times [$(c), $(d)]\\\$.",
            answer=Float64(ans),
            difficulty=(1400, 1600),
            solution=steps(
                sol("Surface", surface),
                "Set up: \\\$V = \\int_{$(c)}^{$(d)} \\int_{$(a)}^{$(b)} $(tex(surface)) \\, dx \\, dy\\\$",
                "Integrate with respect to \\\$x\\\$, then \\\$y\\\$",
                sol("Volume", Float64(ans))
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Switch order of integration
        x_low = randint(0, 2)
        x_high = randint(x_low+3, x_low+6)
        
        m = randint(1, 3)
        y_lower = m * x
        y_upper = m * x_high
        
        problem(
            question="Rewrite the integral \\\$\\\$\\int_{$(x_low)}^{$(x_high)} \\int_{$(tex(y_lower))}^{$(y_upper)} f(x,y) \\, dy \\, dx\\\$\\\$ by switching the order of integration.",
            answer="\\int_{0}^{$(y_upper)} \\int_{y/$(m)}^{$(x_high)} f(x,y) \\, dx \\, dy",
            difficulty=(1500, 1700),
            answer_type="text",
            solution=steps(
                "Original region: \\\$$(x_low) \\leq x \\leq $(x_high)\\\$, \\\$$(tex(y_lower)) \\leq y \\leq $(y_upper)\\\$",
                "Express \\\$x\\\$ bounds in terms of \\\$y\\\$: from \\\$y = $(m)x\\\$ we get \\\$x = y/$(m)\\\$",
                "New bounds: \\\$0 \\leq y \\leq $(y_upper)\\\$, \\\$y/$(m) \\leq x \\leq $(x_high)\\\$",
                sol("Answer", "\\int_{0}^{$(y_upper)} \\int_{y/$(m)}^{$(x_high)} f(x,y) \\, dx \\, dy")
            ),
            time=180
        )
        
    else  # problem_type == 5
        # Average value over region
        a = randint(0, 2)
        b = randint(a+2, a+4)
        c = randint(0, 2)
        d = randint(c+2, c+4)
        
        k = randint(2, 6)
        f = k * x * y
        
        area = (b - a) * (d - c)
        
        integral = k * (b^2 - a^2) / 2 * (d^2 - c^2) / 2
        ans = Float64(integral / area)
        
        problem(
            question="Find the average value of \\\$f(x,y) = $(tex(f))\\\$ over the rectangle \\\$[$(a), $(b)] \\times [$(c), $(d)]\\\$.",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                "Average value formula: \\\$\\bar{f} = \\frac{1}{A} \\iint_R f(x,y) \\, dA\\\$",
                "Area: \\\$A = $(area)\\\$",
                "Compute \\\$\\iint_R $(tex(f)) \\, dA = $(integral)\\\$",
                sol("Average value", ans)
            ),
            time=150
        )
    end
end