"""
calculus - lhopitals_rule (easy)
Generated: 2026-02-22T05:10:08.721512
"""

from problem_utils import *

def generate():
    # Easy L'Hopital: single application, clear 0/0 forms
    # Large parameter spaces: a_val in {±1..±8}, k in {±1..±6}, etc.

    problem_type = randint(1, 5)

    if problem_type == 1:
        # lim(x→a) k(x-a) / (x-a) = k
        a_val = nonzero(-8, 8)
        k = nonzero(-6, 6)

        numerator = k * (x - a_val)
        denominator = x - a_val
        ans = k

        return problem(
            question=f"\\lim_{{x \\to {a_val}}} \\frac{{{latex(expand(numerator))}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: differentiate numerator and denominator",
                f"$\\lim_{{x \\to {a_val}}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}} = \\frac{{{k}}}{{1}} = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # lim(x→a) (x-a)^2 / (m*(x-a)) = 0
        a_val = nonzero(-6, 6)
        m = nonzero(-5, 5)

        numerator = (x - a_val)**2
        denominator = m * (x - a_val)
        ans = 0

        return problem(
            question=f"\\lim_{{x \\to {a_val}}} \\frac{{{latex(expand(numerator))}}}{{{latex(expand(denominator))}}}",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to {a_val}}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$",
                f"$= \\frac{{2({a_val} - {a_val})}}{{{m}}} = \\frac{{0}}{{{m}}} = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # lim(x→0) k*sin(bx) / (cx)  = kb/c
        k = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)

        numerator = k * sin(b * x)
        denominator = c * x
        ans = Rational(k * b, c)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1150, 1250),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\frac{{{k*b} \\cos(0)}}{{{c}}} = \\frac{{{k*b}}}{{{c}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # lim(x→0) (e^(kx) - 1) / (mx)  = k/m
        k = nonzero(-5, 5)
        m = nonzero(-5, 5)

        numerator = exp(k * x) - 1
        denominator = m * x
        ans = Rational(k, m)

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\frac{{{k} e^0}}{{{m}}} = \\frac{{{k}}}{{{m}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # lim(x→a) (x² - a²) / (x - a)  = 2a   (simple factoring disguised)
        a_val = nonzero(-7, 7)

        numerator = x**2 - a_val**2
        denominator = x - a_val
        ans = 2 * a_val

        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)

        return problem(
            question=f"\\lim_{{x \\to {a_val}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1050, 1200),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to {a_val}}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"$= \\lim_{{x \\to {a_val}}} 2x = 2({a_val}) = {ans}$"
            ),
            calculator="scientific"
        )

emit(generate())
