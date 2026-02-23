"""
calculus - antiderivatives (hard)
Generated: 2026-02-22T05:12:00.718770
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Integration by parts: ∫ x^n * e^(ax) dx  or  ∫ x^n * trig(ax) dx
        n = randint(1, 3)
        a = nonzero(-4, 4)
        choice_type = choice(['exp', 'sin', 'cos'])

        if choice_type == 'exp':
            f = x**n * exp(a * x)
            ans_no_c = simplify(integrate(f, x))
            u_choice = f"u = x^{{{n}}}, dv = e^{{{a}x}} dx"
            dudv = f"du = {n}x^{{{n-1}}}dx, v = \\frac{{1}}{{{a}}}e^{{{a}x}}"
        elif choice_type == 'sin':
            f = x**n * sin(a * x)
            ans_no_c = simplify(integrate(f, x))
            u_choice = f"u = x^{{{n}}}, dv = \\sin({a}x)\\,dx"
            dudv = f"du = {n}x^{{{n-1}}}dx, v = -\\frac{{1}}{{{a}}}\\cos({a}x)"
        else:
            f = x**n * cos(a * x)
            ans_no_c = simplify(integrate(f, x))
            u_choice = f"u = x^{{{n}}}, dv = \\cos({a}x)\\,dx"
            dudv = f"du = {n}x^{{{n-1}}}dx, v = \\frac{{1}}{{{a}}}\\sin({a}x)"

        C = symbols('C')
        ans = ans_no_c + C

        return problem(
            question=f"\\int {latex(f)} \\, dx",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use integration by parts: ${u_choice}$",
                f"Then ${dudv}$",
                f"Apply $\\int u\\,dv = uv - \\int v\\,du$ (repeat if needed)",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 2:
        # U-substitution: ∫ k * f'(g(x)) * g'(x) dx  with varied inner functions
        sub_type = choice(['trig_linear', 'exp_poly', 'power_linear', 'log_deriv'])

        if sub_type == 'trig_linear':
            a = nonzero(-4, 4)
            b = randint(-5, 5)
            k = nonzero(-3, 3)
            tc = choice(['sin', 'cos'])
            if tc == 'sin':
                f = k * sin(a * x + b) * a
                ans_no_c = -k * cos(a * x + b)
            else:
                f = k * cos(a * x + b) * a
                ans_no_c = k * sin(a * x + b)
            u_expr = f"{a}x + {b}"

        elif sub_type == 'exp_poly':
            a = nonzero(-3, 3)
            b = randint(-4, 4)
            k = nonzero(-4, 4)
            inner = a * x**2 + b
            f = k * exp(inner) * 2 * a * x
            ans_no_c = k * exp(inner)
            u_expr = latex(inner)

        elif sub_type == 'power_linear':
            a = nonzero(-4, 4)
            b = randint(-6, 6)
            n = randint(2, 6)
            k = nonzero(-3, 3)
            inner = a * x + b
            f = k * a * inner**n
            ans_no_c = k * inner**(n + 1) / (n + 1)
            u_expr = latex(inner)

        else:  # log_deriv
            a = randint(1, 5)
            b = randint(1, 5)
            k = nonzero(-4, 4)
            inner = a * x + b
            f = k * a / inner
            ans_no_c = k * log(Abs(inner))
            u_expr = latex(inner)

        C = symbols('C')
        ans = ans_no_c + C

        return problem(
            question=f"\\int {latex(f)} \\, dx",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Let $u = {u_expr}$",
                f"The integral becomes expressible in terms of $u$",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 3:
        # Partial fractions: ∫ (A/(x-a) + B/(x-b)) dx
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        while a_val == b_val:
            b_val = nonzero(-5, 5)

        A = nonzero(-4, 4)
        B = nonzero(-4, 4)
        integrand = A / (x - a_val) + B / (x - b_val)
        C = symbols('C')
        ans = A * log(Abs(x - a_val)) + B * log(Abs(x - b_val)) + C

        return problem(
            question=f"\\int \\left({latex(integrand)}\\right) dx",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate each partial fraction separately",
                f"$\\int \\frac{{{A}}}{{x - {a_val}}} dx = {A}\\ln|x - {a_val}|$",
                f"$\\int \\frac{{{B}}}{{x - {b_val}}} dx = {B}\\ln|x - {b_val}|$",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 4:
        # Trig power reduction: ∫ sin²(ax) or cos²(ax) or sin(ax)cos(ax)
        a = randint(1, 5)
        k = nonzero(-4, 4)
        trig_choice = choice(['sin2', 'cos2', 'sincos'])

        if trig_choice == 'sin2':
            f = k * sin(a * x)**2
            ans_no_c = simplify(integrate(f, x))
            hint = f"$\\sin^2({a}x) = \\frac{{1 - \\cos({2*a}x)}}{{2}}$"
        elif trig_choice == 'cos2':
            f = k * cos(a * x)**2
            ans_no_c = simplify(integrate(f, x))
            hint = f"$\\cos^2({a}x) = \\frac{{1 + \\cos({2*a}x)}}{{2}}$"
        else:
            f = k * sin(a * x) * cos(a * x)
            ans_no_c = simplify(integrate(f, x))
            hint = f"$\\sin({a}x)\\cos({a}x) = \\frac{{1}}{{2}}\\sin({2*a}x)$"

        C = symbols('C')
        ans = ans_no_c + C

        return problem(
            question=f"\\int {latex(f)} \\, dx",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use identity: {hint}",
                f"Substitute and integrate",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

    else:
        # Long division then integrate: ∫ (x² + ax + b)/(x + c) dx
        a_val = randint(-5, 5)
        b_val = randint(-5, 5)
        c_val = nonzero(-5, 5)

        # Quotient: x + (a-c), remainder: b + c(c-a)
        quotient_const = a_val - c_val
        remainder = b_val + c_val * (c_val - a_val)

        numerator = x**2 + a_val * x + b_val
        denominator = x + c_val

        C = symbols('C')
        ans = Rational(1, 2) * x**2 + quotient_const * x + remainder * log(Abs(x + c_val)) + C

        return problem(
            question=f"\\int \\frac{{{latex(numerator)}}}{{{latex(denominator)}}} dx",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Perform polynomial long division",
                f"$\\frac{{{latex(numerator)}}}{{{latex(denominator)}}} = x + {quotient_const} + \\frac{{{remainder}}}{{x + {c_val}}}$",
                f"Integrate term by term",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

emit(generate())
