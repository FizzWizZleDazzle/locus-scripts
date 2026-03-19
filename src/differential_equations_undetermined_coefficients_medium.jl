# differential_equations - undetermined_coefficients (medium)
# Generated: 2026-03-08T20:54:48.754264

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/undetermined_coefficients")
    
    # Choose problem type
    problem_type = choice([:exponential, :polynomial, :trig, :mixed])
    
    if problem_type == :exponential
        # y'' + ay' + by = Ce^(kx)
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        C = nonzero(-12, 12)
        k = nonzero(-5, 5)
        
        # Check if k is a root of characteristic equation r^2 + ar + b = 0
        char_roots = solve(t^2 + a*t + b ~ 0, t)
        is_root = any(r -> r == k, char_roots)
        
        if is_root
            yp_form = "Axe^{$(k)x}"
            yp = "A*x*exp($(k)*x)"
        else
            yp_form = "Ae^{$(k)x}"
            yp = "A*exp($(k)*x)"
        end
        
        rhs = "$(C)e^{$(k)x}"
        
        question = "Find the form of a particular solution for the differential equation \$\$y'' + $(a)y' + $(b)y = $(rhs)\$\$ using the method of undetermined coefficients."
        answer = yp_form
        
        solution_steps = steps(
            "Homogeneous equation: \$y'' + $(a)y' + $(b)y = 0\$",
            "Characteristic equation: \$r^2 + $(a)r + $(b) = 0\$",
            is_root ? "Since \$k = $(k)\$ is a root of the characteristic equation, multiply by \$x\$" : "Since \$k = $(k)\$ is not a root of the characteristic equation, use standard form",
            sol("Particular solution form", yp_form)
        )
        
        difficulty = is_root ? (1400, 1600) : (1200, 1400)
        time_val = is_root ? 180 : 120
        
    elseif problem_type == :polynomial
        # y'' + ay' + by = polynomial
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        
        degree = choice([1, 2])
        
        if degree == 1
            C1 = nonzero(-15, 15)
            C2 = nonzero(-15, 15)
            rhs = "$(C1)x + $(C2)"
            
            # Check if 0 is root of characteristic equation
            if b == 0
                yp_form = "Ax^2 + Bx"
                multiplier = "x"
            else
                yp_form = "Ax + B"
                multiplier = "1"
            end
        else
            C1 = nonzero(-10, 10)
            C2 = nonzero(-15, 15)
            C3 = nonzero(-15, 15)
            rhs = "$(C1)x^2 + $(C2)x + $(C3)"
            
            if b == 0
                yp_form = "Ax^3 + Bx^2 + Cx"
                multiplier = "x"
            else
                yp_form = "Ax^2 + Bx + C"
                multiplier = "1"
            end
        end
        
        question = "Find the form of a particular solution for \$\$y'' + $(a)y' + $(b)y = $(rhs)\$\$ using undetermined coefficients."
        answer = yp_form
        
        solution_steps = steps(
            "The right-hand side is a polynomial of degree $(degree)",
            "Characteristic equation: \$r^2 + $(a)r + $(b) = 0\$",
            b == 0 ? "Since \$r = 0\$ is a root, multiply by \$x\$" : "Since \$r = 0\$ is not a root, use standard polynomial form",
            sol("Particular solution form", yp_form)
        )
        
        difficulty = (1300, 1500)
        time_val = 150
        
    elseif problem_type == :trig
        # y'' + ay' + by = C*cos(kx) or C*sin(kx)
        a = nonzero(-6, 6)
        b = randint(1, 12)  # positive to avoid resonance complexity
        C = nonzero(-12, 12)
        k = randint(1, 5)
        
        trig_func = choice(["cos", "sin"])
        rhs = "$(C)\\\$(trig_func)($(k)x)"
        
        # Check if ±ki are roots of characteristic equation
        # r^2 + ar + b = 0, roots are complex if discriminant < 0
        discriminant = a^2 - 4*b
        
        if discriminant < 0
            # Complex roots r = (-a ± sqrt(disc))/2 = -a/2 ± i*sqrt(-disc)/2
            imag_part = sqrt(-discriminant) / 2
            is_resonant = abs(imag_part - k) < 0.01
        else
            is_resonant = false
        end
        
        if is_resonant
            yp_form = "x(A\\cos($(k)x) + B\\sin($(k)x))"
        else
            yp_form = "A\\cos($(k)x) + B\\sin($(k)x)"
        end
        
        question = "Find the form of a particular solution for \$\$y'' + $(a)y' + $(b)y = $(rhs)\$\$ using undetermined coefficients."
        answer = yp_form
        
        solution_steps = steps(
            "The right-hand side is \$$(rhs)\$",
            "For trigonometric forcing, use both sine and cosine terms",
            is_resonant ? "Resonance detected: multiply by \$x\$" : "No resonance with homogeneous solution",
            sol("Particular solution form", yp_form)
        )
        
        difficulty = is_resonant ? (1500, 1700) : (1300, 1500)
        time_val = is_resonant ? 180 : 150
        
    else  # mixed
        # y'' + ay' + by = polynomial + exponential
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        
        C1 = nonzero(-10, 10)
        C2 = nonzero(-12, 12)
        k = nonzero(-4, 4)
        
        rhs = "$(C1)x + $(C2)e^{$(k)x}"
        
        # Check polynomial part
        if b == 0
            poly_part = "Ax^2 + Bx"
        else
            poly_part = "Ax + B"
        end
        
        # Check exponential part
        char_roots = solve(t^2 + a*t + b ~ 0, t)
        is_exp_root = any(r -> r == k, char_roots)
        
        if is_exp_root
            exp_part = "Cxe^{$(k)x}"
        else
            exp_part = "Ce^{$(k)x}"
        end
        
        yp_form = poly_part * " + " * exp_part
        
        question = "Find the form of a particular solution for \$\$y'' + $(a)y' + $(b)y = $(rhs)\$\$ using undetermined coefficients."
        answer = yp_form
        
        solution_steps = steps(
            "The right-hand side has two parts: polynomial and exponential",
            "For the polynomial part: " * (b == 0 ? "multiply by \$x\$ since \$r=0\$ is a root" : "use \$Ax + B\$"),
            "For the exponential part: " * (is_exp_root ? "multiply by \$x\$ since \$k=$(k)\$ is a root" : "use \$Ce^{$(k)x}\$"),
            sol("Particular solution form", yp_form)
        )
        
        difficulty = (1500, 1800)
        time_val = 210
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution_steps,
        time=time_val,
        answer_type="expression"
    )
end