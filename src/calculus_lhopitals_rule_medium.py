"""
calculus - lhopitals_rule (medium)
Generated: 2026-02-22T05:10:30.832647
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # 0/0 form: lim(x→root) quadratic/quadratic
        root = nonzero(-6, 6)

        other_num = nonzero(-6, 6)
        while other_num == root:
            other_num = nonzero(-6, 6)

        other_den = nonzero(-6, 6)
        while other_den == root or other_den == other_num:
            other_den = nonzero(-6, 6)

        # Extra coefficients for more variety
        k_num = randint(1, 4)
        k_den = randint(1, 4)

        numerator = expand(k_num * (x - root) * (x - other_num))
        denominator = expand(k_den * (x - root) * (x - other_den))

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)
        ans = simplify(num_prime.subs(x, root) / den_prime.subs(x, root))

        return problem(
            question=f"\\lim_{{x \\to {root}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to {root}}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"Substitute $x = {root}$: $\\frac{{{num_prime.subs(x, root)}}}{{{den_prime.subs(x, root)}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # 0/0 trig: lim(x→0) sin(ax) / (bx)  or  lim tan(ax)/bx
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        trig_choice = choice(['sin', 'tan'])

        if trig_choice == 'sin':
            numerator = sin(a * x)
            denominator = b * x
            ans = Rational(a, b)
        else:
            numerator = tan(a * x)
            denominator = b * x
            ans = Rational(a, b)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"Substitute $x = 0$: $\\frac{{{latex(simplify(num_prime.subs(x, 0)))}}}{{{latex(den_prime.subs(x, 0))}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Exponential 0/0: lim(x→0) (e^(ax) - 1)/(bx)  = a/b
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)

        numerator = exp(a * x) - 1
        denominator = b * x
        ans = Rational(a, b)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1450, 1600),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\frac{{{a} \\cdot e^0}}{{{b}}} = \\frac{{{a}}}{{{b}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Log 0/0: lim(x→0) ln(1 + ax) / (bx)  = a/b
        a = randint(1, 7)
        b = randint(1, 7)

        numerator = log(1 + a * x)
        denominator = b * x
        ans = Rational(a, b)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{\\ln(1 + {a}x)}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\frac{{{latex(simplify(num_prime.subs(x, 0)))}}}{{{latex(den_prime.subs(x, 0))}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # ∞/∞ form: lim(x→∞) (ax + b) / (cx + d)  = a/c
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = nonzero(-5, 5)
        d = randint(-8, 8)

        numerator = a * x + b
        denominator = c * x + d
        ans = Rational(a, c)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1350, 1500),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"As $x \\to \\infty$, both numerator and denominator $\\to \\infty$ (indeterminate $\\infty/\\infty$)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to \\infty}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\frac{{{a}}}{{{c}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
