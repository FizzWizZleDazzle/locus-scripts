# differential_equations - undetermined_coefficients (competition)
# Generated: 2026-03-08T20:55:25.968053

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/undetermined_coefficients")
    
    # For Olympiad/Research-Adjacent (3500-5000), we need extremely challenging problems
    # involving undetermined coefficients with high-order ODEs, resonance cases,
    # coupled systems, or unusual forcing functions
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # High-order ODE with polynomial and exponential forcing
        # y^(4) + ay'' + by = polynomial * e^(rx) + trig
        
        a = nonzero(-8, 8)
        b = nonzero(-15, 15)
        r = nonzero(-4, 4)
        
        # Characteristic equation: s^4 + as^2 + b = 0
        # Let u = s^2: u^2 + au + b = 0
        disc = a^2 - 4*b
        
        # Choose coefficients for polynomial forcing
        p2 = nonzero(-6, 6)
        p1 = randint(-12, 12)
        p0 = randint(-15, 15)
        
        # Trig frequency
        omega = nonzero(1, 5)
        A_trig = nonzero(-8, 8)
        
        poly_part = p2*x^2 + p1*x + p0
        forcing = expand(poly_part * exp(r*x)) + A_trig*cos(omega*x)
        
        ode_lhs = "y^{(4)} + $(a)y'' + $(b)y"
        forcing_tex = tex(forcing)
        
        question = "Consider the differential equation \\[$(ode_lhs) = $(forcing_tex)\\] Find the correct form of the particular solution \\(y_p\\) using the method of undetermined coefficients. Specify all undetermined coefficient terms (do not solve for the coefficients). Express your answer in the form of the trial solution."
        
        # Answer construction
        exp_part = "(A_2 x^2 + A_1 x + A_0)e^{$(r)x}"
        
        # Check if omega is a root of char equation (resonance)
        # Char eq: s^4 + as^2 + b = 0, check s = i*omega
        s_test = omega^2
        char_at_omega = s_test^2 + a*s_test + b
        
        if abs(char_at_omega) < 0.01  # Near resonance
            trig_part = "x(B \\cos($(omega)x) + C \\sin($(omega)x))"
        else
            trig_part = "B \\cos($(omega)x) + C \\sin($(omega)x)"
        end
        
        answer_str = "$(exp_part) + $(trig_part)"
        
        solution_steps = steps(
            sol("ODE", "$(ode_lhs) = $(forcing_tex)"),
            "The forcing function has two parts: \\(($(tex(poly_part)))e^{$(r)x}\\) and \\($(A_trig)\\cos($(omega)x)\\)",
            "For the exponential-polynomial part \\(($(tex(poly_part)))e^{$(r)x}\\), since \\(r=$(r)\\) is not a root of the characteristic equation \\(s^4 + $(a)s^2 + $(b) = 0\\), we use: \\((A_2 x^2 + A_1 x + A_0)e^{$(r)x}\\)",
            "For the trigonometric part \\($(A_trig)\\cos($(omega)x)\\), we check if \\(\\pm i$(omega)\\) are roots of the characteristic equation",
            "Characteristic at \\(s = i$(omega)\\): \\((i$(omega))^4 + $(a)(i$(omega))^2 + $(b) = $(char_at_omega)\\)",
            abs(char_at_omega) < 0.01 ? "Resonance detected! Multiply by \\(x\\): \\(x(B\\cos($(omega)x) + C\\sin($(omega)x))\\)" : "No resonance. Use: \\(B\\cos($(omega)x) + C\\sin($(omega)x)\\)",
            sol("Particular solution form", answer_str)
        )
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3500, 4200),
            solution=solution_steps,
            time=480,
            calculator="none",
            grading_mode="exact"
        )
        
    elseif problem_type == 2
        # Resonance case with multiplicity
        # y''' + a*y'' + b*y' + c*y = P(x)*e^(rx) where r is a repeated root
        
        r = nonzero(-5, 5)
        m = rand(2:3)  # multiplicity
        
        # Build characteristic polynomial with r as root of multiplicity m
        # (s - r)^m * (s - s1) for m=2, or (s-r)^m for m=3
        
        if m == 2
            s1 = r + nonzero(1, 6)  # another distinct root
            # Char poly: (s-r)^2(s-s1) = s^3 - (2r+s1)s^2 + (r^2+2rs1)s - r^2*s1
            a = -(2*r + s1)
            b = r^2 + 2*r*s1
            c = -r^2 * s1
        else  # m == 3
            # (s-r)^3 = s^3 - 3rs^2 + 3r^2s - r^3
            a = -3*r
            b = 3*r^2
            c = -r^3
        end
        
        # Forcing: polynomial * e^(rx)
        poly_deg = rand(1:2)
        if poly_deg == 1
            p1 = nonzero(-10, 10)
            p0 = randint(-15, 15)
            poly = p1*x + p0
            poly_tex = tex(poly)
            yp_form = "x^{$(m)}(A_1 x + A_0)e^{$(r)x}"
        else
            p2 = nonzero(-8, 8)
            p1 = randint(-12, 12)
            p0 = randint(-15, 15)
            poly = p2*x^2 + p1*x + p0
            poly_tex = tex(poly)
            yp_form = "x^{$(m)}(A_2 x^2 + A_1 x + A_0)e^{$(r)x}"
        end
        
        forcing_tex = "($(poly_tex))e^{$(r)x}"
        ode_lhs = "y''' + $(a)y'' + $(b)y' + $(c)y"
        
        question = "Consider the differential equation \\[$(ode_lhs) = $(forcing_tex)\\] Given that \\(r = $(r)\\) is a root of the characteristic equation with multiplicity \\($(m)\\), determine the correct form of the particular solution \\(y_p\\) using undetermined coefficients."
        
        solution_steps = steps(
            sol("ODE", "$(ode_lhs) = $(forcing_tex)"),
            "Characteristic equation: \\(s^3 + $(a)s^2 + $(b)s + $(c) = 0\\)",
            "Given: \\(s = $(r)\\) is a root with multiplicity \\(m = $(m)\\)",
            "For forcing \\(($(poly_tex))e^{$(r)x}\\) where \\(r\\) has multiplicity \\($(m)\\), multiply the usual form by \\(x^{$(m)}\\)",
            "Polynomial in forcing has degree $(poly_deg), so include terms up to degree $(poly_deg)",
            sol("Particular solution form", yp_form)
        )
        
        problem(
            question=question,
            answer=yp_form,
            difficulty=(3800, 4500),
            solution=solution_steps,
            time=420,
            calculator="none",
            grading_mode="exact"
        )
        
    elseif problem_type == 3
        # Product of polynomial, exponential, and trig with resonance considerations
        # y^(n) + ... = x^k * e^(rx) * sin(wx) or cos(wx)
        
        k = rand(1:2)  # polynomial degree
        r = nonzero(-4, 4)
        w = nonzero(1, 5)
        
        # Order of ODE
        n = rand(3:4)
        
        # Build characteristic with complex root r ± iw having multiplicity m
        m = rand(1:2)
        
        # For simplicity, make (s - (r+iw))^m * (s - (r-iw))^m part of char
        # This gives terms involving e^(rx)sin(wx) and e^(rx)cos(wx)
        
        if m == 1
            mult_factor = ""
            x_mult = ""
        else
            mult_factor = " with multiplicity $(m)"
            x_mult = "x^{$(m)}"
        end
        
        trig_choice = rand(["sin", "cos"])
        
        if k == 1
            forcing_tex = "x e^{$(r)x} \\\$(trig_choice)($(w)x)"
            if m == 1
                yp_form = "e^{$(r)x}[(A_1 x + A_0)\\cos($(w)x) + (B_1 x + B_0)\\sin($(w)x)]"
            else
                yp_form = "x^{$(m)} e^{$(r)x}[(A_1 x + A_0)\\cos($(w)x) + (B_1 x + B_0)\\sin($(w)x)]"
            end
        else  # k == 2
            forcing_tex = "x^2 e^{$(r)x} \\\$(trig_choice)($(w)x)"
            if m == 1
                yp_form = "e^{$(r)x}[(A_2 x^2 + A_1 x + A_0)\\cos($(w)x) + (B_2 x^2 + B_1 x + B_0)\\sin($(w)x)]"
            else
                yp_form = "x^{$(m)} e^{$(r)x}[(A_2 x^2 + A_1 x + A_0)\\cos($(w)x) + (B_2 x^2 + B_1 x + B_0)\\sin($(w)x)]"
            end
        end
        
        question = "Consider a linear ODE with constant coefficients whose forcing function is \\[f(x) = $(forcing_tex)\\] The characteristic equation has roots \\($(r) \\pm $(w)i\\)$(mult_factor). Determine the form of the particular solution \\(y_p\\) using the method of undetermined coefficients."
        
        solution_steps = steps(
            sol("Forcing function", forcing_tex),
            "The forcing is of form \\(x^{$(k)} e^{$(r)x} \\\$(trig_choice)($(w)x)\\)",
            "Complex roots \\($(r) \\pm $(w)i\\) appear$(mult_factor) in the characteristic equation",
            m > 1 ? "Due to multiplicity $(m), multiply the standard form by \\(x^{$(m)}\\)" : "Multiplicity is 1, no extra \\(x\\) factor needed for resonance",
            "Must include both \\(\\sin($(w)x)\\) and \\(\\cos($(w)x)\\) terms with polynomial coefficients up to degree $(k)",
            sol("Particular solution form", yp_form)
        )
        
        problem(
            question=question,
            answer=yp_form,
            difficulty=(4000, 4800),
            solution=solution_steps,
            time=540,
            calculator="none",
            grading_mode="exact"
        )
        
    else  # problem_type == 4
        # Advanced: forcing with product of exponentials and higher powers
        # y^(4) + ... = e^(r1*x) * e^(r2*x) * P(x) = e^((r1+r2)x) * P(x)
        
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        r_sum = r1 + r2
        
        # Build char equation where r_sum might be a root
        is_root = rand(Bool)
        
        if is_root
            # Make r_sum a double root
            # (s - r_sum)^2 (s^2 + as + b)
            a_inner = nonzero(-6, 6)
            b_inner = nonzero(1, 12)
            
            # Expand (s - r_sum)^2 = s^2 - 2*r_sum*s + r_sum^2
            # Times (s^2 + a_inner*s + b_inner)
            # Result is s^4 + ... (coefficients complex)
            
            m = 2
            x_factor = "x^2"
        else
            m = 0
            x_factor = ""
        end
        
        # Polynomial part
        p_deg = rand(1:3)
        if p_deg == 1
            p1 = nonzero(-10, 10)
            p0 = randint(-15, 15)
            poly_tex = "$(p1)x + $(p0)"
            coeff_form = "A_1 x + A_0"
        elseif p_deg == 2
            p2 = nonzero(-8, 8)
            p1 = randint(-12, 12)
            p0 = randint(-15, 15)
            poly_tex = "$(p2)x^2 + $(p1)x + $(p0)"
            coeff_form = "A_2 x^2 + A_1 x + A_0"
        else
            p3 = nonzero(-5, 5)
            p2 = randint(-10, 10)
            p1 = randint(-12, 12)
            p0 = randint(-15, 15)
            poly_tex = "$(p3)x^3 + $(p2)x^2 + $(p1)x + $(p0)"
            coeff_form = "A_3 x^3 + A_2 x^2 + A_1 x + A_0"
        end
        
        forcing_tex = "($(poly_tex))e^{$(r1)x} \\cdot e^{$(r2)x}"
        simplified_forcing = "($(poly_tex))e^{$(r_sum)x}"
        
        if is_root
            yp_form = "x^2($(coeff_form))e^{$(r_sum)x}"
        else
            yp_form = "($(coeff_form))e^{$(r_sum)x}"
        end
        
        question = is_root ?
            "The forcing function has exponential parameter equal to a root of the char eq. Find the form of y_p." :
            "The forcing function has exponential parameter NOT equal to any root. Find the form of y_p."

        problem(
            question=question,
            answer=yp_form,
            difficulty=(4000, 4600),
            solution=steps(
                "Identify forcing function structure",
                is_root ? "Since parameter is a root, multiply by appropriate power of x" : "Since parameter is not a root, use standard form",
                sol("Answer", yp_form)
            ),
            time=420,
            answer_type="expression"
        )
    end
end
