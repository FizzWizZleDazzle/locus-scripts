# calculus - volumes_of_revolution (medium)
# Generated: 2026-03-08T20:49:04.517083

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/volumes_of_revolution")
    
    problem_type = choice([:disk_about_x, :disk_about_y, :washer_about_x, :shell_about_y])
    
    if problem_type == :disk_about_x
        # Disk method: rotate about x-axis
        # y = f(x) from x=a to x=b
        # Volume = π ∫[a,b] [f(x)]^2 dx
        
        # Choose function type
        func_type = choice([:linear, :quadratic, :sqrt])
        
        if func_type == :linear
            # y = mx from x=0 to x=h (cone)
            m = randint(1, 6)
            h = randint(2, 8)
            f = m * x
            a, b = 0, h
            
            # Volume = π ∫[0,h] (mx)^2 dx = π ∫[0,h] m^2 x^2 dx = π m^2 [x^3/3] from 0 to h
            # = π m^2 h^3 / 3
            volume = π * m^2 * h^3 // 3
            
            solution_text = steps(
                sol("Given", f),
                "Bounds: \$x \\in [$(a), $(b)]\$",
                "Volume formula (disk method): \$V = \\pi \\int_{$(a)}^{$(b)} [f(x)]^2 \\, dx\$",
                sol("Setup", "V = \\pi \\int_{$(a)}^{$(b)} ($(m)x)^2 \\, dx = \\pi \\cdot $(m^2) \\int_{$(a)}^{$(b)} x^2 \\, dx"),
                sol("Integrate", "V = $(m^2)\\pi \\left[ \\frac{x^3}{3} \\right]_{$(a)}^{$(b)} = $(m^2)\\pi \\cdot \\frac{$(h)^3}{3}"),
                sol("Answer", volume)
            )
            
        elseif func_type == :sqrt
            # y = √x from x=0 to x=endpoint
            endpoint = randint(4, 16)
            f = sqrt(x)
            a, b = 0, endpoint

            # Volume = π ∫[0,endpoint] (√x)^2 dx = π ∫[0,endpoint] x dx = π [x^2/2] from 0 to endpoint
            # = π endpoint^2 / 2
            volume = π * endpoint^2 // 2

            solution_text = steps(
                sol("Given", "f(x) = \\sqrt{x}"),
                "Bounds: \$x \\in [0, $(endpoint)]\$",
                "Volume formula (disk method): \$V = \\pi \\int_{0}^{$(endpoint)} [f(x)]^2 \\, dx\$",
                sol("Setup", "V = \\pi \\int_{0}^{$(endpoint)} (\\sqrt{x})^2 \\, dx = \\pi \\int_{0}^{$(endpoint)} x \\, dx"),
                sol("Integrate", "V = \\pi \\left[ \\frac{x^2}{2} \\right]_{0}^{$(endpoint)} = \\pi \\cdot \\frac{$(endpoint)^2}{2}"),
                sol("Answer", volume)
            )
        else
            # y = c - x^2/k from x=0 to x=√(ck) (paraboloid)
            k = randint(2, 5)
            c = k * randint(2, 6)
            h = isqrt(c * k)
            f = c - x^2 // k
            a, b = 0, h
            
            # Volume = π ∫[0,h] (c - x^2/k)^2 dx
            # = π ∫[0,h] (c^2 - 2cx^2/k + x^4/k^2) dx
            # = π [c^2 x - 2c x^3/(3k) + x^5/(5k^2)] from 0 to h
            volume = π * (c^2 * h - 2 * c * h^3 // (3 * k) + h^5 // (5 * k^2))
            
            solution_text = steps(
                sol("Given", "f(x) = $(c) - \\frac{x^2}{$(k)}"),
                "Bounds: \$x \\in [0, $(h)]\$",
                "Volume formula (disk method): \$V = \\pi \\int_{0}^{$(h)} [f(x)]^2 \\, dx\$",
                sol("Expand", "V = \\pi \\int_{0}^{$(h)} \\left($(c) - \\frac{x^2}{$(k)}\\right)^2 \\, dx"),
                "Expand and integrate term by term",
                sol("Answer", volume)
            )
        end
        
        question_text = "Find the volume of the solid obtained by rotating the region bounded by \$y = $(tex(f))\$, \$y = 0\$, \$x = $(a)\$, and \$x = $(b)\$ about the \$x\$-axis."
        diff_range = (1200, 1500)
        
    elseif problem_type == :disk_about_y
        # Disk method: rotate about y-axis
        # x = g(y) from y=c to y=d
        # Volume = π ∫[c,d] [g(y)]^2 dy
        
        @variables y
        
        # x = ky from y=0 to y=h (cone)
        k = randint(1, 5)
        h = randint(2, 8)
        g = k * y
        c, d = 0, h
        
        # Volume = π ∫[0,h] (ky)^2 dy = π k^2 [y^3/3] from 0 to h
        # = π k^2 h^3 / 3
        volume = π * k^2 * h^3 // 3
        
        question_text = "Find the volume of the solid obtained by rotating the region bounded by \$x = $(k)y\$, \$x = 0\$, \$y = $(c)\$, and \$y = $(d)\$ about the \$y\$-axis."
        
        solution_text = steps(
            sol("Given", "x = $(k)y"),
            "Bounds: \$y \\in [$(c), $(d)]\$",
            "Volume formula (disk method): \$V = \\pi \\int_{$(c)}^{$(d)} [g(y)]^2 \\, dy\$",
            sol("Setup", "V = \\pi \\int_{$(c)}^{$(d)} ($(k)y)^2 \\, dy = $(k^2)\\pi \\int_{$(c)}^{$(d)} y^2 \\, dy"),
            sol("Integrate", "V = $(k^2)\\pi \\left[ \\frac{y^3}{3} \\right]_{$(c)}^{$(d)} = $(k^2)\\pi \\cdot \\frac{$(h)^3}{3}"),
            sol("Answer", volume)
        )
        diff_range = (1300, 1600)
        
    elseif problem_type == :washer_about_x
        # Washer method: rotate about x-axis
        # Between y = f(x) (outer) and y = g(x) (inner)
        # Volume = π ∫[a,b] ([f(x)]^2 - [g(x)]^2) dx
        
        # Outer: y = R, Inner: y = mx (0 ≤ x ≤ h)
        R = randint(3, 8)
        m = randint(1, min(R-1, 4))
        h = R // m
        
        if denominator(h) != 1
            # Try simpler values
            R = randint(2, 6)
            m = 1
            h = R
        end
        
        f_outer = R
        f_inner = m * x
        a, b = 0, h
        
        # Volume = π ∫[0,h] (R^2 - (mx)^2) dx = π ∫[0,h] (R^2 - m^2 x^2) dx
        # = π [R^2 x - m^2 x^3/3] from 0 to h
        # = π (R^2 h - m^2 h^3/3)
        volume = π * (R^2 * h - m^2 * h^3 // 3)
        
        question_text = "Find the volume of the solid obtained by rotating the region bounded by \$y = $(R)\$, \$y = $(tex(f_inner))\$, and \$x = 0\$ about the \$x\$-axis."
        
        solution_text = steps(
            "Outer radius: \$R(x) = $(R)\$, Inner radius: \$r(x) = $(tex(f_inner))\$",
            "Find intersection: \$$(R) = $(tex(f_inner))\$ gives \$x = $(tex(h))\$",
            "Volume formula (washer method): \$V = \\pi \\int_{0}^{$(tex(h))} ([R(x)]^2 - [r(x)]^2) \\, dx\$",
            sol("Setup", "V = \\pi \\int_{0}^{$(tex(h))} ($(R^2) - $(m^2)x^2) \\, dx"),
            sol("Integrate", "V = \\pi \\left[ $(R^2)x - \\frac{$(m^2)x^3}{3} \\right]_{0}^{$(tex(h))}"),
            sol("Answer", volume)
        )
        diff_range = (1400, 1700)
        
    else  # :shell_about_y
        # Shell method: rotate about y-axis
        # x = radius, f(x) = height
        # Volume = 2π ∫[a,b] x·f(x) dx
        
        # f(x) = h - mx from x=0 to x=h/m
        m = randint(1, 4)
        h = m * randint(2, 6)
        f = h - m * x
        a = 0
        b = h // m
        
        # Volume = 2π ∫[0,b] x(h - mx) dx = 2π ∫[0,b] (hx - mx^2) dx
        # = 2π [hx^2/2 - mx^3/3] from 0 to b
        # = 2π (h b^2/2 - m b^3/3)
        volume = 2 * π * (h * b^2 // 2 - m * b^3 // 3)
        
        question_text = "Find the volume of the solid obtained by rotating the region bounded by \$y = $(tex(f))\$, \$y = 0\$, and \$x = 0\$ about the \$y\$-axis using the shell method."
        
        solution_text = steps(
            sol("Given", "f(x) = $(tex(f))"),
            "Find \$x\$-intercept: \$$(tex(f)) = 0\$ gives \$x = $(tex(b))\$",
            "Volume formula (shell method): \$V = 2\\pi \\int_{0}^{$(tex(b))} x \\cdot f(x) \\, dx\$",
            sol("Setup", "V = 2\\pi \\int_{0}^{$(tex(b))} x($(tex(f))) \\, dx"),
            "Expand and integrate",
            sol("Answer", volume)
        )
        diff_range = (1500, 1800)
    end
    
    problem(
        question=question_text,
        answer=volume,
        difficulty=diff_range,
        solution=solution_text,
        time=180
    )
end