"""
calculus - lhopitals_rule (hard)
Generated: 2026-02-22T05:11:01.379869
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # e^(cx) / x^n  as x→∞  (∞/∞, apply L'Hopital n times → ∞)
        c = randint(1, 5)
        power = randint(2, 5)

        numerator = exp(c * x)
        denominator = x**power

        expr = numerator / denominator

        steps_list = [f"Evaluate $\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"]
        steps_list.append(f"This is $\\infty/\\infty$ — apply L'Hôpital's rule {power} time(s)")

        num_cur = numerator
        den_cur = denominator
        for i in range(power):
            num_cur = diff(num_cur, x)
            den_cur = diff(den_cur, x)
            steps_list.append(f"After differentiation #{i+1}: $\\frac{{{latex(num_cur)}}}{{{latex(den_cur)}}}$")

        steps_list.append(f"Denominator is constant ${latex(den_cur)}$; numerator $\\to \\infty$, so limit is $+\\infty$")
        ans = oo

        return problem(
            question=f"Evaluate $\\lim_{{x \\to \\infty}} {latex(expr)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/lhopitals_rule",
            solution=steps(*steps_list),
        )

    elif problem_type == 2:
        # (1 + a/x)^(bx) as x→∞  →  e^(ab)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-4, 4)

        expr = (1 + Rational(a_val, 1) / x)**(b_val * x)
        ans = exp(a_val * b_val)

        return problem(
            question=f"Evaluate $\\lim_{{x \\to \\infty}} \\left(1 + \\frac{{{a_val}}}{{x}}\\right)^{{{b_val}x}}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"This is a $1^\\infty$ indeterminate form",
                f"Take logarithm: $\\ln L = \\lim_{{x \\to \\infty}} {b_val}x \\cdot \\ln\\left(1 + \\frac{{{a_val}}}{{x}}\\right)$",
                f"Rewrite as $0/0$: $\\ln L = \\lim_{{x \\to \\infty}} \\frac{{\\ln\\left(1 + \\frac{{{a_val}}}{{x}}\\right)}}{{1/({b_val}x)}}$",
                f"Apply L'Hôpital: numerator derivative $\\approx \\frac{{-{a_val}/x^2}}{{1+{a_val}/x}}$, denominator $= -\\frac{{1}}{{{b_val}x^2}}$",
                f"$\\ln L = {a_val} \\cdot {b_val} = {a_val * b_val}$",
                f"$L = e^{{{a_val * b_val}}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # (sin(ax) - ax) / x^3  as x→0  →  -a³/6
        a_val = nonzero(-5, 5)

        numerator = sin(a_val * x) - a_val * x
        denominator = x**3
        ans = Rational(-a_val**3, 6)

        n2 = diff(numerator, x)
        d2 = diff(denominator, x)
        n3 = diff(n2, x)
        d3 = diff(d2, x)
        n4 = diff(n3, x)
        d4 = diff(d3, x)

        return problem(
            question=f"Evaluate $\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"$\\frac{{0}}{{0}}$ form — apply L'Hôpital",
                f"After 1st: $\\lim_{{x \\to 0}} \\frac{{{latex(n2)}}}{{{latex(d2)}}}$ — still $0/0$",
                f"After 2nd: $\\lim_{{x \\to 0}} \\frac{{{latex(n3)}}}{{{latex(d3)}}}$ — still $0/0$",
                f"After 3rd: $\\lim_{{x \\to 0}} \\frac{{{latex(n4)}}}{{{latex(d4)}}}$",
                f"$= \\frac{{-{a_val**3}\\cos(0)}}{{6}} = \\frac{{-{a_val**3}}}{{6}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # (e^(ax) - e^(bx)) / sin(cx)  as x→0  →  (a-b)/c
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        while b_val == a_val:
            b_val = nonzero(-5, 5)
        c_val = nonzero(-4, 4)

        numerator = exp(a_val * x) - exp(b_val * x)
        denominator = sin(c_val * x)
        ans = Rational(a_val - b_val, c_val)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"Evaluate $\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"$\\frac{{0}}{{0}}$ form — apply L'Hôpital",
                f"$\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\frac{{{a_val}e^0 - {b_val}e^0}}{{{c_val}\\cos(0)}} = \\frac{{{a_val - b_val}}}{{{c_val}}} = {latex(ans)}$"
            ),
        )

    else:
        # x^a * ln(x)  as x→0⁺  →  0  (for a > 0)
        # Written as ln(x) / x^(-a)  →  0/0 form
        a_val = randint(1, 5)

        expr = x**a_val * log(x)
        # Rewrite as ln(x)/x^(-a): derivative of ln(x) = 1/x, derivative of x^(-a) = -a*x^(-a-1)
        # ratio = (1/x)/(-a*x^(-a-1)) = x^a / (-a) → 0 as x→0⁺
        ans = 0

        return problem(
            question=f"Evaluate $\\lim_{{x \\to 0^+}} x^{{{a_val}}} \\ln(x)$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"This is $0 \\cdot (-\\infty)$ indeterminate form",
                f"Rewrite: $x^{{{a_val}}} \\ln(x) = \\frac{{\\ln(x)}}{{x^{{-{a_val}}}}}$ — now $-\\infty/\\infty$ form",
                f"Apply L'Hôpital: $\\frac{{1/x}}{{-{a_val}x^{{-{a_val}-1}}}} = \\frac{{x^{{{a_val}}}}}{{-{a_val}}}$",
                f"As $x \\to 0^+$: $\\frac{{x^{{{a_val}}}}}{{-{a_val}}} \\to \\frac{{0}}{{-{a_val}}} = 0$",
                f"$\\lim_{{x \\to 0^+}} x^{{{a_val}}} \\ln(x) = {ans}$"
            ),
        )

emit(generate())
