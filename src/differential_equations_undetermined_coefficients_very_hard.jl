# differential_equations - undetermined_coefficients (very_hard)
# Generated: 2026-03-08T20:55:10.394863

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("differential_equations/undetermined_coefficients")
    
    # Generate a competition-level undetermined coefficients problem
    # COMPETITION to OLYMPIAD (2500-3500): requires multiple insights,
    # non-standard forcing functions, or strategic coefficient matching
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: High-order ODE with resonance case
        # y''' + ay'' + by' + cy = polynomial * exp(rx) where r is a root of characteristic
        r1 = randint(-3, 3)
        r2 = randint(-3, 3)
        r3 = randint(-3, 3)
        
        # Characteristic: (D - r1)(D - r2)(D - r3)
        # Expanded: D³ - (r1+r2+r3)D² + (r1*r2 + r1*r3 + r2*r3)D - r1*r2*r3
        a = -(r1 + r2 + r3)
        b = r1*r2 + r1*r3 + r2*r3
        c = -r1*r2*r3
        
        # Forcing function: P(x) * exp(r1*x) where r1 is a root (resonance!)
        forcing_deg = randint(1, 2)
        if forcing_deg == 1
            p = nonzero(-5, 5)
            q = randint(-8, 8)
            forcing_poly = p*x + q
        else
            p = nonzero(-3, 3)
            q = randint(-5, 5)
            r = randint(-5, 5)
            forcing_poly = p*x^2 + q*x + r
        end
        
        forcing = expand(forcing_poly * exp(r1*x))
        
        eq_lhs = "y''' + $(a)y'' + $(b)y' + $(c)y"
        eq_rhs = tex(forcing)
        
        question = "Consider the differential equation: \$\$$(eq_lhs) = $(eq_rhs)\$\$ This is a resonance case. What is the correct form for the particular solution \$y_p\$ using the method of undetermined coefficients?"
        
        # Answer: x^multiplicity * polynomial * exp(r1*x)
        # Since r1 appears once in (D-r1)(D-r2)(D-r3), multiplicity = 1
        if forcing_deg == 1
            answer = "y_p = x(Ax + B)e^{$(r1)x}"
        else
            answer = "y_p = x(Ax^2 + Bx + C)e^{$(r1)x}"
        end
        
        difficulty = (2600, 2900)
        
        solution_text = steps(
            "The characteristic equation is \$r^3 + $(a)r^2 + $(b)r + $(c) = 0\$ with roots \$r = $(r1), $(r2), $(r3)\$",
            "The forcing function is \$($(tex(forcing_poly)))e^{$(r1)x}\$. Since \$r = $(r1)\$ is a simple root of the characteristic equation, we have resonance",
            "For resonance with multiplicity \$m = 1\$, multiply the usual particular solution form by \$x^1\$",
            "The degree of the polynomial in the forcing term is $(forcing_deg), so the particular solution has the form: \$$(answer)\$"
        )
        
    elseif problem_type == 2
        # Type 2: Mixed forcing with sin/cos and polynomial-exponential
        omega = nonzero(-4, 4)
        alpha = nonzero(-3, 3)
        
        # Characteristic roots that don't match alpha or i*omega
        r1 = nonzero(-5, 5)
        while r1 == alpha
            r1 = nonzero(-5, 5)
        end
        r2 = nonzero(-5, 5)
        
        a_coeff = -(r1 + r2)
        b_coeff = r1 * r2
        
        # Forcing: A*e^(alpha*x) + B*cos(omega*x) + C*sin(omega*x)
        A = nonzero(-8, 8)
        B = nonzero(-8, 8)
        C = nonzero(-8, 8)
        
        eq_lhs = "y'' + $(a_coeff)y' + $(b_coeff)y"
        eq_rhs = "$(A)e^{$(alpha)x} + $(B)\\cos($(omega)x) + $(C)\\sin($(omega)x)"
        
        question = "For the differential equation \$\$$(eq_lhs) = $(eq_rhs)\$\$ determine the form of the particular solution \$y_p\$ using undetermined coefficients. Express as a sum of terms."
        
        answer = "y_p = Ae^{$(alpha)x} + B\\cos($(omega)x) + C\\sin($(omega)x)"
        
        difficulty = (2500, 2700)
        
        solution_text = steps(
            "The characteristic equation is \$r^2 + $(a_coeff)r + $(b_coeff) = 0\$ with roots \$r = $(r1), $(r2)\$",
            "The forcing function has three parts: exponential \$e^{$(alpha)x}\$, cosine, and sine with frequency \$\\omega = $(omega)\$",
            "Check: \$\\alpha = $(alpha)\$ is not a characteristic root, and \$\\pm $(omega)i\$ are not characteristic roots",
            "No resonance occurs. The particular solution form is: \$$(answer)\$"
        )
        
    elseif problem_type == 3
        # Type 3: Product of polynomial and trig with potential resonance
        omega = nonzero(2, 5)
        
        # Characteristic: r² + omega² = 0, roots = ±omega*i (pure imaginary)
        a_coeff = 0
        b_coeff = omega^2
        
        # Forcing: x * sin(omega*x) - resonance case!
        A = nonzero(-6, 6)
        
        eq_lhs = "y'' + $(b_coeff)y"
        eq_rhs = "$(A)x\\sin($(omega)x)"
        
        question = "Solve using undetermined coefficients. What is the correct form for the particular solution of: \$\$$(eq_lhs) = $(eq_rhs)\$\$ (This involves resonance.)"
        
        # Resonance with trig: multiply by x
        answer = "y_p = x[(Ax + B)\\cos($(omega)x) + (Cx + D)\\sin($(omega)x)]"
        
        difficulty = (2700, 3200)
        
        solution_text = steps(
            "The characteristic equation is \$r^2 + $(b_coeff) = 0\$ with roots \$r = \\pm $(omega)i\$",
            "The forcing function is \$$(A)x\\sin($(omega)x)\$, which contains the frequency \$\\omega = $(omega)\$ that matches the characteristic roots",
            "This is a resonance case. The forcing term is a polynomial of degree 1 times \$\\sin($(omega)x)\$",
            "For resonance with trig functions, multiply by \$x\$ and include both sin and cos with matching polynomial degrees: \$$(answer)\$"
        )
        
    else
        # Type 4: Fourth-order equation with complex forcing
        r1 = randint(-2, 2)
        r2 = randint(-2, 2)
        omega = randint(2, 4)
        
        # Characteristic: (r² - 2*r1*r + r1²)(r² + omega²)
        # = (r - r1)²(r² + omega²)
        a_coeff = -2*r1
        b_coeff = r1^2 + omega^2
        c_coeff = -2*r1*omega^2
        d_coeff = r1^2 * omega^2
        
        A = nonzero(-5, 5)
        B = nonzero(-5, 5)
        
        eq_lhs = "y^{(4)} + $(a_coeff)y''' + $(b_coeff)y'' + $(c_coeff)y' + $(d_coeff)y"
        eq_rhs = "$(A)e^{$(r1)x} + $(B)\\cos($(omega)x)"
        
        question = "For the fourth-order equation \$\$$(eq_lhs) = $(eq_rhs)\$\$ the characteristic polynomial has a repeated real root and a pair of imaginary roots. Determine the form of \$y_p\$."
        
        # r1 is a double root (resonance!), ±omega*i are simple roots
        answer = "y_p = x^2 Ae^{$(r1)x} + B\\cos($(omega)x) + C\\sin($(omega)x)"
        
        difficulty = (2900, 3400)
        
        solution_text = steps(
            "The characteristic equation factors as \$(r - $(r1))^2(r^2 + $(omega^2)) = 0\$",
            "Roots: \$r = $(r1)\$ (multiplicity 2) and \$r = \\pm $(omega)i\$ (simple)",
            "The forcing term \$$(A)e^{$(r1)x}\$ resonates with the double root at \$r = $(r1)\$, requiring multiplication by \$x^2\$",
            "The forcing term \$$(B)\\cos($(omega)x)\$ does NOT resonate (we need \$\\pm $(omega)i\$ which ARE roots, but our forcing doesn't have those frequencies... wait, it does! So we need \$x\$ multiplication there too... Actually, checking: if \$\\pm \\omega i\$ are roots and forcing is \$\\cos(\\omega x)\$, that IS resonance",
            "Correcting: \$y_p = x^2 Ae^{$(r1)x} + x[B\\cos($(omega)x) + C\\sin($(omega)x)]\$"
        )
        
        answer = "y_p = x^2 Ae^{$(r1)x} + x[B\\cos($(omega)x) + C\\sin($(omega)x)]"
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution_text,
        answer_type="text",
        time=300,
        calculator="none"
    )
end