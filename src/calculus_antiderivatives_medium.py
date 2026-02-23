"""
calculus - antiderivatives (medium)
Generated: 2026-02-22T05:11:34.344324
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # ∫ k * x^n dx  wide ranges: k in {±1..±10}, n in {2..8}
        n = randint(2, 8)
        coeff = nonzero(-10, 10)
        expr = coeff * x**n
        ans = integrate(expr, x)

        return problem(
            question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Power rule: $\\int {latex(expr)} dx = {coeff} \\cdot \\frac{{x^{{{n+1}}}}}{{{n+1}}} + C$",
                f"$= {latex(ans)} + C$"
            ),
        )

    elif problem_type == 2:
        # ∫ (ax³ + bx² + cx + d) dx  — quartic terms
        a = nonzero(-5, 5)
        b = randint(-6, 6)
        c = randint(-8, 8)
        d = randint(-8, 8)
        expr = a * x**3 + b * x**2 + c * x + d
        ans = integrate(expr, x)

        return problem(
            question=f"Find the antiderivative: $\\int \\left({latex(expr)}\\right) dx$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate term by term:",
                f"$\\int {latex(a*x**3)} dx = {latex(integrate(a*x**3, x))}$",
                f"$\\int {latex(b*x**2)} dx = {latex(integrate(b*x**2, x))}$",
                f"$\\int {latex(c*x + d)} dx = {latex(integrate(c*x+d, x))}$",
                f"Combined: ${latex(ans)} + C$"
            ),
        )

    elif problem_type == 3:
        # ∫ k * sin(ax) or cos(ax)  or sec²(ax)   a in {1..5}, k in {±1..±6}
        trig_choice = randint(1, 3)
        a = randint(1, 5)
        k = nonzero(-6, 6)

        if trig_choice == 1:
            expr = k * sin(a * x)
            ans = -k * cos(a * x) / a
            rule = f"$\\int \\sin({a}x)\\,dx = -\\frac{{1}}{{{a}}}\\cos({a}x) + C$"
        elif trig_choice == 2:
            expr = k * cos(a * x)
            ans = k * sin(a * x) / a
            rule = f"$\\int \\cos({a}x)\\,dx = \\frac{{1}}{{{a}}}\\sin({a}x) + C$"
        else:
            expr = k * sec(a * x)**2
            ans = k * tan(a * x) / a
            rule = f"$\\int \\sec^2({a}x)\\,dx = \\frac{{1}}{{{a}}}\\tan({a}x) + C$"

        return problem(
            question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use: {rule}",
                f"$\\int {latex(expr)} dx = {latex(ans)} + C$"
            ),
        )

    elif problem_type == 4:
        # ∫ k * e^(ax) dx   a in {±1..±5}, k in {±1..±6}
        a = nonzero(-5, 5)
        k = nonzero(-6, 6)
        expr = k * exp(a * x)
        ans = k * exp(a * x) / a

        return problem(
            question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/antiderivatives",
            solution=steps(
                f"$\\int e^{{ax}} dx = \\frac{{1}}{{a}}e^{{ax}} + C$",
                f"$\\int {latex(expr)} dx = \\frac{{{k}}}{{{a}}}e^{{{a}x}} + C$",
                f"$= {latex(ans)} + C$"
            ),
        )

    elif problem_type == 5:
        # ∫ (k/x + m*√x) dx   k in {±1..±6}, m in {±1..±5}
        k = nonzero(-6, 6)
        m = nonzero(-5, 5)

        expr_str = f"{latex(k / x)} + {latex(m * sqrt(x))}"
        ans = k * log(x) + m * Rational(2, 3) * x**Rational(3, 2)

        return problem(
            question=f"Find the antiderivative: $\\int \\left({expr_str}\\right) dx$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="calculus/antiderivatives",
            solution=steps(
                f"$\\int \\frac{{{k}}}{{x}} dx = {k}\\ln|x|$",
                f"$\\int {m}\\sqrt{{x}} dx = {m} \\cdot \\frac{{x^{{3/2}}}}{{3/2}} = \\frac{{{2*m}}}{{3}}x^{{3/2}}$",
                f"Combined: ${latex(ans)} + C$"
            ),
        )

    else:
        # ∫ k * a^x dx  for a ∈ {2,3,5,7,10}
        base = choice([2, 3, 5, 7, 10])
        k = nonzero(-5, 5)
        expr = k * base**x
        ans = k * base**x / log(base)

        return problem(
            question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
            answer=ans,
            difficulty=(1450, 1600),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use: $\\int a^x dx = \\frac{{a^x}}{{\\ln(a)}} + C$",
                f"$\\int {latex(expr)} dx = \\frac{{{k} \\cdot {base}^x}}{{\\ln({base})}} + C$",
                f"$= {latex(ans)} + C$"
            ),
        )

emit(generate())
