# algebra1 - systems_substitution (hard)
# Generated: 2026-03-08T19:57:41.803193

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_substitution")
    
    # Pick a clean solution point
    x_sol = randint(-15, 15)
    y_sol = randint(-15, 15)
    
    # Problem type selector
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: One equation already solved for a variable (classic substitution)
        # y = mx + b form, then substitute into ax + cy = d
        m = nonzero(-8, 8)
        b = randint(-20, 20)
        
        # First equation: y = mx + b (passing through our solution)
        # y_sol = m*x_sol + b, so b = y_sol - m*x_sol
        b = y_sol - m*x_sol
        eq1 = y ~ m*x + b
        
        # Second equation: ax + cy = d
        a = nonzero(-10, 10)
        c = nonzero(-10, 10)
        d = a*x_sol + c*y_sol
        eq2 = a*x + c*y ~ d
        
        question = "Solve the system using substitution:<br>\$$(tex(eq1))\$<br>\$$(tex(eq2))\$"
        
        solution = steps(
            "From the first equation, we have \$y = $(tex(m*x + b))\$",
            "Substitute into the second equation: \$$(tex(substitute(a*x + c*y, y => m*x + b))) = $(d)\$",
            "Expand: \$$(tex(expand(a*x + c*(m*x + b)))) = $(d)\$",
            "Solve for \$x\$: \$x = $(x_sol)\$",
            "Substitute back: \$y = $(tex(m*x_sol + b)) = $(y_sol)\$",
            sol("Answer", fmt_tuple((x_sol, y_sol)))
        )
        diff_range = (1800, 2100)
        time_limit = 180
        
    elseif problem_type == 2
        # Type 2: Both equations in standard form, need to solve one for a variable first
        # ax + by = e and cx + dy = f, where solving requires fraction manipulation
        a = nonzero(-12, 12)
        b = nonzero(-12, 12)
        e = a*x_sol + b*y_sol
        
        c = nonzero(-12, 12)
        d = nonzero(-12, 12)
        f = c*x_sol + d*y_sol
        
        eq1 = a*x + b*y ~ e
        eq2 = c*x + d*y ~ f
        
        question = "Solve the system using substitution:<br>\$$(tex(eq1))\$<br>\$$(tex(eq2))\$"
        
        solution = steps(
            sol("System", [eq1, eq2]),
            "Solve the first equation for \$x\$: \$x = \\frac{$(e) - $(tex(b*y))}{$(a)}\$",
            "Substitute into the second equation and solve for \$y\$",
            sol("y", y_sol),
            "Substitute back to find \$x\$",
            sol("Answer", fmt_tuple((x_sol, y_sol)))
        )
        diff_range = (1900, 2200)
        time_limit = 240
        
    elseif problem_type == 3
        # Type 3: Non-linear system (one linear, one with x*y term or quadratic)
        # y = ax + b and xy = c or x^2 + y^2 = r^2
        if rand() < 0.5
            # xy = c type
            a = nonzero(-6, 6)
            b = randint(-10, 10)
            b_val = y_sol - a*x_sol
            
            eq1 = y ~ a*x + b_val
            c = x_sol * y_sol
            eq2 = x*y ~ c
            
            question = "Solve the system using substitution:<br>\$$(tex(eq1))\$<br>\$$(tex(eq2))\$"
            
            solution = steps(
                sol("System", [eq1, eq2]),
                "From the first equation: \$y = $(tex(a*x + b_val))\$",
                "Substitute into \$xy = $(c)\$: \$x($(tex(a*x + b_val))) = $(c)\$",
                "This gives a quadratic: \$$(tex(expand(a*x^2 + b_val*x))) = $(c)\$",
                "Solve the quadratic equation",
                sol("Answer", fmt_tuple((x_sol, y_sol)))
            )
            diff_range = (2100, 2400)
            time_limit = 300
        else
            # Quadratic + linear
            a = nonzero(-4, 4)
            b = randint(-8, 8)
            b_val = y_sol - a*x_sol
            
            eq1 = y ~ a*x + b_val
            
            # x^2 + y = k form
            k = x_sol^2 + y_sol
            eq2 = x^2 + y ~ k
            
            question = "Solve the system using substitution:<br>\$$(tex(eq1))\$<br>\$$(tex(eq2))\$"
            
            solution = steps(
                sol("System", [eq1, eq2]),
                "From the first equation: \$y = $(tex(a*x + b_val))\$",
                "Substitute into \$x^2 + y = $(k)\$",
                "Get: \$x^2 + $(tex(a*x + b_val)) = $(k)\$",
                "Rearrange and solve the quadratic",
                sol("Answer", fmt_tuple((x_sol, y_sol)))
            )
            diff_range = (2000, 2300)
            time_limit = 240
        end
        
    else
        # Type 4: Three-step substitution (requires multiple substitutions)
        # y = mx + b, z = ny + c, then substitute into ax + by + cz = d
        m = nonzero(-5, 5)
        b_coef = randint(-10, 10)
        b_val = y_sol - m*x_sol
        
        # For a 2-variable challenge: nested substitution
        # y = mx + p, substitute into a complicated second equation
        a1 = nonzero(-8, 8)
        b1 = nonzero(-8, 8)
        c1 = randint(-25, 25)
        
        # Make second equation: a1*x + b1*y + c1 = d1*x*y form (challenging)
        # Actually, let's do: (x-h)^2 + (y-k)^2 = r^2 with linear
        h = randint(-8, 8)
        k = randint(-8, 8)
        r_sq = (x_sol - h)^2 + (y_sol - k)^2
        
        if r_sq == 0
            r_sq = randint(1, 50)
        end
        
        eq1 = y ~ m*x + b_val
        eq2 = (x - h)^2 + (y - k)^2 ~ r_sq
        
        question = "Solve the system using substitution:<br>\$$(tex(eq1))\$<br>\$$(tex(expand((x - h)^2 + (y - k)^2))) = $(r_sq)\$"
        
        solution = steps(
            sol("Linear equation", eq1),
            "Substitute \$y = $(tex(m*x + b_val))\$ into the second equation",
            "Expand: \$(x - $(h))^2 + ($(tex(m*x + b_val)) - $(k))^2 = $(r_sq)\$",
            "This becomes a quadratic in \$x\$. Solve for \$x\$",
            sol("x", x_sol),
            "Substitute back: \$y = $(tex(m*x_sol + b_val)) = $(y_sol)\$",
            sol("Answer", fmt_tuple((x_sol, y_sol)))
        )
        diff_range = (2200, 2500)
        time_limit = 300
    end
    
    problem(
        question=question,
        answer=fmt_tuple((x_sol, y_sol)),
        difficulty=diff_range,
        answer_type="tuple",
        solution=solution,
        time=time_limit
    )
end