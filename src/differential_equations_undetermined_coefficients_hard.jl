# differential_equations - undetermined_coefficients (hard)
# Generated: 2026-03-08T20:55:07.518904

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/undetermined_coefficients")
    
    # Choose problem type
    prob_type = choice([:second_order_polynomial, :second_order_exponential, :second_order_trig, :second_order_mixed])
    
    if prob_type == :second_order_polynomial
        # y'' + ay' + by = polynomial
        # Characteristic equation has real distinct roots
        r1 = randint(-4, -1)
        r2 = randint(1, 4)
        a = -(r1 + r2)
        b = r1 * r2
        
        # Non-homogeneous term: polynomial
        deg = choice([0, 1, 2])
        if deg == 0
            c = nonzero(-20, 20)
            g_x = c
            yp_form = "A"
            A = c // b
            yp = A
            yp_tex = tex(A)
        elseif deg == 1
            c1 = nonzero(-15, 15)
            c0 = randint(-20, 20)
            g_x = c1*x + c0
            yp_form = "Ax + B"
            # y_p = Ax + B, y_p' = A, y_p'' = 0
            # 0 + a*A + b*(Ax + B) = c1*x + c0
            # bAx + (aA + bB) = c1*x + c0
            A = c1 // b
            B = (c0 - a*A) // b
            yp = A*x + B
            yp_tex = tex(yp)
        else
            c2 = nonzero(-10, 10)
            c1 = randint(-15, 15)
            c0 = randint(-20, 20)
            g_x = c2*x^2 + c1*x + c0
            yp_form = "Ax^2 + Bx + C"
            # y_p = Ax^2 + Bx + C, y_p' = 2Ax + B, y_p'' = 2A
            # 2A + a*(2Ax + B) + b*(Ax^2 + Bx + C) = c2*x^2 + c1*x + c0
            # bAx^2 + (2aA + bB)x + (2A + aB + bC) = c2*x^2 + c1*x + c0
            A = c2 // b
            B = (c1 - 2*a*A) // b
            C = (c0 - 2*A - a*B) // b
            yp = A*x^2 + B*x + C
            yp_tex = tex(yp)
        end

        lhs = diff(diff(x, x), x) + a*diff(x, x) + b*x
        ode_tex = "y'' + $(a)y' + $(b)y = $(tex(g_x))"
        
        diff_level = (1800, 2100)
        
        solution_text = steps(
            sol("ODE", ode_tex),
            "Step 1: Solve homogeneous equation y'' + $(a)y' + $(b)y = 0",
            "Characteristic equation: r² + $(a)r + $(b) = 0",
            "Roots: r₁ = $(r1), r₂ = $(r2)",
            sol("Homogeneous solution", "y_h = C₁e^{$(r1)x} + C₂e^{$(r2)x}"),
            "Step 2: Find particular solution using undetermined coefficients",
            "Try y_p = $(yp_form)",
            "Substitute into ODE and equate coefficients",
            sol("Particular solution", "y_p = $(yp_tex)"),
            sol("General solution", "y = C₁e^{$(r1)x} + C₂e^{$(r2)x} + $(yp_tex)")
        )
        
        ans = "C_1*exp($(r1)*x) + C_2*exp($(r2)*x) + $(yp_tex)"
        
        problem(
            question="Find the general solution to the differential equation: \\\$$(ode_tex)\\\$",
            answer=ans,
            difficulty=diff_level,
            solution=solution_text,
            time=240
        )
        
    elseif prob_type == :second_order_exponential
        # y'' + ay' + by = c*e^(kx) where k is not a root
        r1 = randint(-4, -1)
        r2 = randint(1, 4)
        a = -(r1 + r2)
        b = r1 * r2
        
        # Choose k different from r1, r2
        k = choice([i for i in -6:6 if i != r1 && i != r2 && i != 0])
        c = nonzero(-20, 20)
        
        g_x = c * exp(k*x)
        
        # y_p = A*e^(kx), y_p' = kA*e^(kx), y_p'' = k²A*e^(kx)
        # k²A + a*kA + b*A = c
        # A(k² + ak + b) = c
        A = c // (k^2 + a*k + b)
        yp = A * exp(k*x)
        
        ode_tex = "y'' + $(a)y' + $(b)y = $(tex(g_x))"
        
        solution_text = steps(
            sol("ODE", ode_tex),
            "Step 1: Homogeneous solution from characteristic equation",
            "r² + $(a)r + $(b) = 0 gives r = $(r1), $(r2)",
            sol("y_h", "C₁e^{$(r1)x} + C₂e^{$(r2)x}"),
            "Step 2: Since $(k) is not a characteristic root, try y_p = Ae^{$(k)x}",
            "Substitute: $(k)²A + $(a)·$(k)A + $(b)A = $(c)",
            "Solve for A: A = $(tex(A))",
            sol("y_p", tex(yp)),
            sol("General solution", "y = C₁e^{$(r1)x} + C₂e^{$(r2)x} + $(tex(yp))")
        )
        
        ans = "C_1*exp($(r1)*x) + C_2*exp($(r2)*x) + $(tex(yp))"
        
        problem(
            question="Find the general solution to: \\\$$(ode_tex)\\\$",
            answer=ans,
            difficulty=(1900, 2200),
            solution=solution_text,
            time=270
        )
        
    elseif prob_type == :second_order_trig
        # y'' + ω²y = A*cos(kx) + B*sin(kx) where k ≠ ω
        omega = choice([2, 3, 4, 5])
        k = choice([i for i in 1:7 if i != omega])
        
        A_coeff = nonzero(-15, 15)
        B_coeff = randint(-15, 15)
        
        if B_coeff == 0
            g_x = A_coeff * cos(k*x)
            g_tex = "$(A_coeff)\\cos($(k)x)"
        else
            g_x = A_coeff * cos(k*x) + B_coeff * sin(k*x)
            g_tex = "$(A_coeff)\\cos($(k)x) + $(B_coeff)\\sin($(k)x)"
        end

        ode_tex = "y'' + $(omega^2)y = $(g_tex)"
        
        # y_p = A*cos(kx) + B*sin(kx)
        # y_p'' = -k²A*cos(kx) - k²B*sin(kx)
        # -k²A*cos(kx) - k²B*sin(kx) + ω²A*cos(kx) + ω²B*sin(kx) = A_coeff*cos(kx) + B_coeff*sin(kx)
        # (ω² - k²)A = A_coeff, (ω² - k²)B = B_coeff
        
        A = A_coeff // (omega^2 - k^2)
        B = B_coeff // (omega^2 - k^2)
        
        if B == 0
            yp_tex = "$(tex(A))\\cos($(k)x)"
        else
            yp_tex = "$(tex(A))\\cos($(k)x) + $(tex(B))\\sin($(k)x)"
        end

        solution_text = steps(
            sol("ODE", ode_tex),
            "Step 1: Characteristic equation r² + $(omega^2) = 0",
            "Roots: r = ±$(omega)i",
            sol("y_h", "C₁\\cos($(omega)x) + C₂\\sin($(omega)x)"),
            "Step 2: Since $(k) ≠ $(omega), try y_p = A\\cos($(k)x) + B\\sin($(k)x)",
            "Compute y_p'' and substitute into ODE",
            "($(omega^2) - $(k^2))(A\\cos($(k)x) + B\\sin($(k)x)) = $(g_tex)",
            "Solve: A = $(tex(A)), B = $(tex(B))",
            sol("General solution", "y = C₁\\cos($(omega)x) + C₂\\sin($(omega)x) + $(yp_tex)")
        )
        
        ans = "C_1*cos($(omega)*x) + C_2*sin($(omega)*x) + $(yp_tex)"
        
        problem(
            question="Solve the differential equation using undetermined coefficients: \\\$$(ode_tex)\\\$",
            answer=ans,
            difficulty=(2000, 2300),
            solution=solution_text,
            time=300
        )
        
    else  # :second_order_mixed
        # More challenging: y'' + ay' + by = polynomial + exponential
        r1 = randint(-3, -1)
        r2 = randint(1, 3)
        a = -(r1 + r2)
        b = r1 * r2
        
        c_poly = nonzero(-10, 10)
        k = choice([i for i in -5:5 if i != r1 && i != r2 && i != 0])
        c_exp = nonzero(-15, 15)
        
        g_x = c_poly + c_exp * exp(k*x)
        g_tex = "$(c_poly) + $(c_exp)e^{$(k)x}"
        
        # y_p = A + B*e^(kx)
        A = c_poly // b
        B = c_exp // (k^2 + a*k + b)
        
        yp_tex = "$(tex(A)) + $(tex(B))e^{$(k)x}"
        
        ode_tex = "y'' + $(a)y' + $(b)y = $(g_tex)"
        
        solution_text = steps(
            sol("ODE", ode_tex),
            "Step 1: Homogeneous solution with roots r = $(r1), $(r2)",
            sol("y_h", "C₁e^{$(r1)x} + C₂e^{$(r2)x}"),
            "Step 2: For g(x) = $(c_poly) + $(c_exp)e^{$(k)x}, try y_p = A + Be^{$(k)x}",
            "Substituting y_p'' = $(k)²Be^{$(k)x}, y_p' = $(k)Be^{$(k)x}",
            "Equate coefficients for constant and exponential terms",
            "From constant: $(b)A = $(c_poly), so A = $(tex(A))",
            "From exponential: B($(k)² + $(a)·$(k) + $(b)) = $(c_exp), so B = $(tex(B))",
            sol("General solution", "y = C₁e^{$(r1)x} + C₂e^{$(r2)x} + $(yp_tex)")
        )
        
        ans = "C_1*exp($(r1)*x) + C_2*exp($(r2)*x) + $(yp_tex)"
        
        problem(
            question="Find the general solution using the method of undetermined coefficients: \\\$$(ode_tex)\\\$",
            answer=ans,
            difficulty=(2100, 2500),
            solution=solution_text,
            time=300
        )
    end
end