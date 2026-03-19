# multivariable_calculus - double_integrals (hard)
# Generated: 2026-03-08T21:01:44.819133

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/double_integrals")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Type 1: Double integral with polynomial integrand over rectangular region
        # ELO: 1800-2000
        a = randint(1, 4)
        b = randint(1, 4)
        m = randint(1, 3)
        n = randint(1, 3)
        
        x_lo = randint(-3, 0)
        x_hi = randint(1, 4)
        y_lo = randint(-3, 0)
        y_hi = randint(1, 4)
        
        integrand = a*x^m + b*y^n
        
        # Compute answer by hand
        x_antideriv = a*x^(m+1)//(m+1)
        x_eval = substitute(x_antideriv, x => x_hi) - substitute(x_antideriv, x => x_lo)
        
        y_antideriv = b*y^(n+1)//(n+1)
        y_eval = substitute(y_antideriv, y => y_hi) - substitute(y_antideriv, y => y_lo)
        
        ans_numerator = (x_hi^(m+1) - x_lo^(m+1))*(y_hi^(n+1) - y_lo^(n+1))
        ans_denom = (m+1)*(n+1)
        
        if m == n
            ans = a*x_eval*(y_hi - y_lo) + b*(x_hi - x_lo)*y_eval
        else
            # Use symbolic computation
            temp1 = substitute(integrand, x => x)
            integrated_y = simplify(substitute(b*y^(n+1)//(n+1), y => y_hi) - substitute(b*y^(n+1)//(n+1), y => y_lo))
            integrated_x = simplify(substitute(a*x^(m+1)//(m+1), x => x_hi) - substitute(a*x^(m+1)//(m+1), x => x_lo))
            
            ans = a*integrated_x*(y_hi - y_lo) + b*(x_hi - x_lo)*integrated_y
        end
        
        problem(
            question="Evaluate \\\$\\displaystyle \\int_{$(x_lo)}^{$(x_hi)} \\int_{$(y_lo)}^{$(y_hi)} ($(tex(integrand))) \\, dy \\, dx\\\$",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", "\\int_{$(x_lo)}^{$(x_hi)} \\int_{$(y_lo)}^{$(y_hi)} ($(tex(integrand))) \\, dy \\, dx"),
                "Integrate with respect to y first: \\\$\\int_{$(y_lo)}^{$(y_hi)} ($(tex(integrand))) \\, dy = $(a*x^m*(y_hi - y_lo)) + $(tex(y_eval))\\\$",
                "Now integrate with respect to x",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Type 2: Double integral with triangular region (Type I or II)
        # ELO: 2000-2200
        use_type_1 = choice([true, false])
        
        if use_type_1
            # Type I: integrate dy dx, bounds y from g1(x) to g2(x)
            x_lo = randint(0, 2)
            x_hi = randint(3, 6)
            m1 = randint(1, 3)
            b1 = randint(-2, 1)
            
            integrand_coeff = nonzero(-5, 5)
            
            # Region: y from 0 to m1*x + b1, x from x_lo to x_hi
            y_upper = m1*x + b1
            
            integrand = integrand_coeff*x*y
            
            # Integrate y first
            y_int = substitute(integrand_coeff*x*y^2//2, y => y_upper) - 0
            y_int = expand(y_int)
            
            # Then integrate x
            final_int = simplify(substitute(diff(y_int, x) * 0, x => x) + y_int)
            
            # Manual calculation for clean answer
            # ∫∫ c*x*y dy dx = ∫ c*x*(m1*x+b1)^2/2 dx from x_lo to x_hi
            # = c/2 ∫ x*(m1^2*x^2 + 2*m1*b1*x + b1^2) dx
            # = c/2 ∫ (m1^2*x^3 + 2*m1*b1*x^2 + b1^2*x) dx
            # = c/2 [m1^2*x^4/4 + 2*m1*b1*x^3/3 + b1^2*x^2/2] from x_lo to x_hi
            
            term1 = m1^2*(x_hi^4 - x_lo^4)//4
            term2 = 2*m1*b1*(x_hi^3 - x_lo^3)//3
            term3 = b1^2*(x_hi^2 - x_lo^2)//2
            
            ans = integrand_coeff*(term1 + term2 + term3)//2
            
            problem(
                question="Evaluate \\\$\\displaystyle \\int_{$(x_lo)}^{$(x_hi)} \\int_{0}^{$(tex(y_upper))} $(tex(integrand)) \\, dy \\, dx\\\$",
                answer=ans,
                difficulty=(2000, 2200),
                solution=steps(
                    sol("Given", "\\int_{$(x_lo)}^{$(x_hi)} \\int_{0}^{$(tex(y_upper))} $(tex(integrand)) \\, dy \\, dx"),
                    "Integrate with respect to y: \\\$\\int_0^{$(tex(y_upper))} $(tex(integrand)) \\, dy = $(tex(integrand_coeff*x*(y_upper)^2//2))\\\$",
                    "Expand and integrate with respect to x",
                    sol("Answer", ans)
                ),
                time=240
            )
        else
            # Type II: integrate dx dy
            y_lo = randint(0, 2)
            y_hi = randint(3, 6)
            m2 = randint(1, 3)
            
            integrand_coeff = nonzero(-5, 5)
            
            # Region: x from 0 to y/m2, y from y_lo to y_hi
            x_upper = y//m2
            
            integrand = integrand_coeff*x*y
            
            # Manual calculation
            # ∫∫ c*x*y dx dy = ∫ c*y*(y/m2)^2/2 dy from y_lo to y_hi
            # = c/(2*m2^2) ∫ y^3 dy
            # = c/(2*m2^2) * [y^4/4] from y_lo to y_hi
            
            ans = integrand_coeff*(y_hi^4 - y_lo^4)//(8*m2^2)
            
            problem(
                question="Evaluate \\\$\\displaystyle \\int_{$(y_lo)}^{$(y_hi)} \\int_{0}^{y/$(m2)} $(tex(integrand)) \\, dx \\, dy\\\$",
                answer=ans,
                difficulty=(2000, 2200),
                solution=steps(
                    sol("Given", "\\int_{$(y_lo)}^{$(y_hi)} \\int_{0}^{y/$(m2)} $(tex(integrand)) \\, dx \\, dy"),
                    "Integrate with respect to x: \\\$\\int_0^{y/$(m2)} $(tex(integrand)) \\, dx = $(tex(integrand_coeff*y*(y//m2)^2//2))\\\$",
                    "Simplify and integrate with respect to y",
                    sol("Answer", ans)
                ),
                time=240
            )
        end
        
    elseif problem_type == 3
        # Type 3: Change order of integration
        # ELO: 2100-2300
        a = randint(1, 5)
        b = randint(1, 4)
        
        # Original: ∫[0,a] ∫[x,a] f(x,y) dy dx
        # New: ∫[0,a] ∫[0,y] f(x,y) dx dy
        
        x_lo = 0
        x_hi = a
        
        integrand = nonzero(-3, 3)*x + nonzero(-3, 3)*y
        
        # For grading, we'll accept the new integral bounds
        new_y_lo = 0
        new_y_hi = a
        new_x_lo_expr = 0
        new_x_hi_expr = y
        
        ans_text = "\\int_{0}^{$(a)} \\int_{0}^{y} ($(tex(integrand))) \\, dx \\, dy"
        
        problem(
            question="Reverse the order of integration for \\\$\\displaystyle \\int_{0}^{$(a)} \\int_{x}^{$(a)} ($(tex(integrand))) \\, dy \\, dx\\\$",
            answer=ans_text,
            difficulty=(2100, 2300),
            answer_type="expression",
            solution=steps(
                "Sketch the region: \\\$0 \\le x \\le $(a)\\\$, \\\$x \\le y \\le $(a)\\\$",
                "This is the region above the line \\\$y = x\\\$ and below \\\$y = $(a)\\\$",
                "Reversing order: \\\$0 \\le y \\le $(a)\\\$, \\\$0 \\le x \\le y\\\$",
                sol("Answer", ans_text)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Type 4: Polar coordinates double integral
        # ELO: 2200-2400
        r_hi = randint(2, 5)
        
        # Full circle or sector
        use_full = choice([true, false])
        
        if use_full
            theta_lo = 0
            theta_hi = 2
            integrand = 1  # Just area
            
            ans = "\\pi \\cdot $(r_hi)^2"
            ans_numeric = r_hi^2
            
            problem(
                question="Evaluate \\\$\\displaystyle \\int_{0}^{2\\pi} \\int_{0}^{$(r_hi)} r \\, dr \\, d\\theta\\\$ (Express answer as a multiple of π)",
                answer=ans_numeric,
                difficulty=(2000, 2200),
                solution=steps(
                    sol("Given", "\\int_{0}^{2\\pi} \\int_{0}^{$(r_hi)} r \\, dr \\, d\\theta"),
                    "Integrate with respect to r: \\\$\\int_0^{$(r_hi)} r \\, dr = \\frac{r^2}{2}\\Big|_0^{$(r_hi)} = \\frac{$(r_hi^2)}{2}\\\$",
                    "Integrate with respect to θ: \\\$\\int_0^{2\\pi} \\frac{$(r_hi^2)}{2} \\, d\\theta = $(r_hi^2)\\pi\\\$",
                    sol("Answer", "$(r_hi^2)\\pi")
                ),
                time=150
            )
        else
            # Sector
            theta_hi = choice([1, 2, 3, 4])  # Multiples of π
            integrand_r = choice([1, 2])
            
            # ∫∫ r^integrand_r dr dθ
            # = ∫ r^(integrand_r+1)/(integrand_r+1) |_0^r_hi dθ
            # = ∫ r_hi^(integrand_r+1)/(integrand_r+1) dθ from 0 to theta_hi*π
            
            r_integral = r_hi^(integrand_r+1)//(integrand_r+1)
            ans_numeric = r_integral * theta_hi
            
            if integrand_r == 1
                integrand_tex = "r"
            else
                integrand_tex = "r^$(integrand_r)"
            end
            
            problem(
                question="Evaluate \\\$\\displaystyle \\int_{0}^{$(theta_hi)\\pi} \\int_{0}^{$(r_hi)} $(integrand_tex) \\, dr \\, d\\theta\\\$ (Express answer as a multiple of π)",
                answer=ans_numeric,
                difficulty=(2100, 2300),
                solution=steps(
                    sol("Given", "\\int_{0}^{$(theta_hi)\\pi} \\int_{0}^{$(r_hi)} $(integrand_tex) \\, dr \\, d\\theta"),
                    "Integrate with respect to r: \\\$\\int_0^{$(r_hi)} $(integrand_tex) \\, dr = \\frac{r^{$(integrand_r+1)}}{$(integrand_r+1)}\\Big|_0^{$(r_hi)} = $(tex(r_integral))\\\$",
                    "Integrate with respect to θ: \\\$\\int_0^{$(theta_hi)\\pi} $(tex(r_integral)) \\, d\\theta = $(tex(ans_numeric))\\pi\\\$",
                    sol("Answer", "$(tex(ans_numeric))\\pi")
                ),
                time=180
            )
        end
        
    else
        # Type 5: Volume under surface (challenging setup)
        # ELO: 2300-2500
        a = randint(2, 4)
        b = randint(2, 4)
        c = nonzero(1, 3)
        
        # Volume under z = c - x - y over rectangle [0,a] × [0,b]
        # V = ∫∫ (c - x - y) dA where c > a + b to keep positive
        c = a + b + randint(1, 3)
        
        # ∫[0,a] ∫[0,b] (c - x - y) dy dx
        # = ∫[0,a] [c*y - x*y - y^2/2]|_0^b dx
        # = ∫[0,a] (c*b - x*b - b^2/2) dx
        # = [c*b*x - b*x^2/2 - b^2*x/2]|_0^a
        # = c*b*a - b*a^2/2 - b^2*a/2
        
        ans = c*b*a - b*a^2//2 - b^2*a//2
        
        problem(
            question="Find the volume of the solid bounded by z = $(c) - x - y and the coordinate planes over [0, $(a)] x [0, $(b)].",
            answer=ans,
            difficulty=(2300, 2500),
            solution=steps(
                "Set up double integral",
                "Inner integral with respect to y, then outer with respect to x",
                sol("Answer", ans)
            ),
            time=210
        )
    end
end
