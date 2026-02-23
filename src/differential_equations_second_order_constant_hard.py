"""
differential_equations - second_order_constant (hard)
Generated: 2026-02-22T05:25:36.135861
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Repeated roots + IVP
        r = nonzero(-4, 4)
        b_coeff = -2 * r
        c_coeff = r ** 2
        y0 = nonzero(-5, 5)
        yp0 = nonzero(-6, 6)

        # y = (C1 + C2*t)*e^(r*t)
        # y(0) = C1 = y0
        C1_val = y0
        # y'(0) = r*C1 + C2 = yp0
        C2_val = yp0 - r * C1_val

        ans = (C1_val + C2_val * t) * exp(r * t)

        return problem(
            question=f"Solve the IVP: $y''{b_coeff:+d}y'{c_coeff:+d}y=0$, $y(0)={y0}$, $y'(0)={yp0}$",
            answer=ans,
            difficulty=(1600, 1720),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $(r-{r})^2=0$; repeated root $r={r}$",
                f"General solution: $y=(C_1+C_2 t)e^{{{r}t}}$",
                f"$y(0)={y0}$: $C_1={y0}$",
                f"$y'(0)={yp0}$: ${r}\\cdot{y0}+C_2={yp0}$, so $C_2={C2_val}$",
                f"$y={latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Complex roots + IVP
        alpha = nonzero(-4, 4)
        beta = randint(2, 6)
        b_coeff = -2 * alpha
        c_coeff = alpha ** 2 + beta ** 2
        y0 = nonzero(-5, 5)
        yp0 = nonzero(-6, 6)

        C1_val = y0
        C2_val = Rational(yp0 - alpha * C1_val, beta)

        ans = exp(alpha * t) * (C1_val * cos(beta * t) + C2_val * sin(beta * t))

        return problem(
            question=f"Solve the IVP: $y''{b_coeff:+d}y'{c_coeff:+d}y=0$, $y(0)={y0}$, $y'(0)={yp0}$",
            answer=ans,
            difficulty=(1650, 1780),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Roots: $r={alpha}\\pm{beta}i$",
                f"General: $y=e^{{{alpha}t}}(C_1\\cos({beta}t)+C_2\\sin({beta}t))$",
                f"$y(0)={y0}$: $C_1={y0}$",
                f"$y'(0)={yp0}$: ${alpha}\\cdot{y0}+{beta}C_2={yp0}$, $C_2={latex(C2_val)}$",
                f"$y={latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Non-homogeneous y'' + b*y' + c*y = k*e^(a*t), a not a root
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        a_val = nonzero(-4, 4)
        while a_val == r1 or a_val == r2:
            a_val = nonzero(-4, 4)
        k_val = nonzero(-5, 5)

        # y_p = k/(a^2 + b*a + c)*e^(a*t)
        denom = a_val**2 + b_coeff * a_val + c_coeff
        if denom == 0:
            a_val += 1
            denom = a_val**2 + b_coeff * a_val + c_coeff
        y_p = Rational(k_val, denom) * exp(a_val * t)

        C1, C2 = symbols('C_1 C_2')
        yh = C1 * exp(r1 * t) + C2 * exp(r2 * t)
        ans = yh + y_p

        return problem(
            question=f"Find the general solution: $y''{b_coeff:+d}y'{c_coeff:+d}y = {k_val}e^{{{a_val}t}}$",
            answer=ans,
            difficulty=(1700, 1820),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Homogeneous solution: $y_h = C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}$",
                f"Try $y_p = Ae^{{{a_val}t}}$; substitute to get $({a_val**2}{b_coeff:+d}\\cdot{a_val}{c_coeff:+d})A = {k_val}$",
                f"$A = \\frac{{{k_val}}}{{{denom}}} = {latex(Rational(k_val, denom))}$",
                f"General solution: $y = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Non-homogeneous y'' + b*y' + c*y = k*cos(omega*t) or k*sin(omega*t)
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        omega = randint(1, 5)
        k_val = nonzero(-5, 5)
        trig_fn = choice(['cos', 'sin'])

        # For y_p = A*cos + B*sin when forcing is cos(omega*t):
        # (c - omega^2)*A + b*omega*B = k
        # -b*omega*A + (c - omega^2)*B = 0
        D = (c_coeff - omega**2)**2 + (b_coeff * omega)**2
        if D == 0:
            omega += 1
            D = (c_coeff - omega**2)**2 + (b_coeff * omega)**2

        if trig_fn == 'cos':
            A_val = Rational(k_val * (c_coeff - omega**2), D)
            B_val = Rational(-k_val * b_coeff * omega, D)
            y_p = A_val * cos(omega * t) + B_val * sin(omega * t)
            rhs_latex = f"{k_val}\\cos({omega}t)"
        else:
            A_val = Rational(k_val * b_coeff * omega, D)
            B_val = Rational(k_val * (c_coeff - omega**2), D)
            y_p = A_val * cos(omega * t) + B_val * sin(omega * t)
            rhs_latex = f"{k_val}\\sin({omega}t)"

        C1, C2 = symbols('C_1 C_2')
        yh = C1 * exp(r1 * t) + C2 * exp(r2 * t)
        ans = yh + y_p

        return problem(
            question=f"Find the general solution: $y''{b_coeff:+d}y'{c_coeff:+d}y = {rhs_latex}$",
            answer=ans,
            difficulty=(1750, 1880),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Homogeneous: $y_h = C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}$",
                f"Try $y_p = A\\cos({omega}t) + B\\sin({omega}t)$",
                f"Substitute, equate coefficients: $A = {latex(A_val)}$, $B = {latex(B_val)}$",
                f"General solution: $y = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # Non-homogeneous with polynomial forcing: y'' + b*y' + c*y = poly
        r1 = nonzero(-3, 3)
        r2 = nonzero(-3, 3)
        while r2 == r1:
            r2 = nonzero(-3, 3)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        n = randint(1, 2)
        coeffs_rhs = [nonzero(-4, 4) for _ in range(n + 1)]
        g_t = sum(coeffs_rhs[i] * t**i for i in range(n + 1))

        # Particular solution: y_p = sum of polynomial terms
        # For simplicity compute via undetermined coefficients
        # For degree n forcing: y_p is degree n polynomial (since c_coeff != 0)
        # y_p = a0 + a1*t + ... + an*t^n
        # Substitute into ODE and match coefficients
        poly_syms = symbols(f'a0:{n+1}')
        y_p_try = sum(poly_syms[i] * t**i for i in range(n + 1))
        eqn = diff(y_p_try, t, 2) + b_coeff * diff(y_p_try, t) + c_coeff * y_p_try - g_t
        eqn_expanded = expand(eqn)

        coeff_eqs = [eqn_expanded.coeff(t, i) for i in range(n + 1)]
        sol_dict = solve(coeff_eqs, poly_syms)
        y_p = y_p_try.subs(sol_dict)
        y_p = simplify(y_p)

        C1, C2 = symbols('C_1 C_2')
        yh = C1 * exp(r1 * t) + C2 * exp(r2 * t)
        ans = yh + y_p

        return problem(
            question=f"Find the general solution: $y''{b_coeff:+d}y'{c_coeff:+d}y = {latex(g_t)}$",
            answer=ans,
            difficulty=(1800, 1950),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Homogeneous: $y_h = C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}$",
                f"Particular (undetermined coefficients): try $y_p = $ polynomial of degree {n}",
                f"Substituting and matching gives $y_p = {latex(y_p)}$",
                f"General solution: $y = {latex(ans)}$"
            ),
            calculator="scientific"
        )


emit(generate())
