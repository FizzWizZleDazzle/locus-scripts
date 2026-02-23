"""
calculus - antiderivatives (easy)
Generated: 2026-02-22T05:11:14.532816
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # ∫ x^n dx   n in {1..8}
        n = randint(1, 8)
        expr = x**n
        ans = x**(n + 1) / (n + 1)

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Power rule: $\\int x^n dx = \\frac{{x^{{n+1}}}}{{n+1}} + C$",
                f"For $n = {n}$: $\\frac{{x^{{{n+1}}}}}{{{n+1}}} + C$"
            ),
        )

    elif problem_type == 2:
        # ∫ k*x^n dx   k in {±1..±8}, n in {1..6}
        k = nonzero(-8, 8)
        n = randint(1, 6)
        expr = k * x**n
        ans = Rational(k, n + 1) * x**(n + 1)

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Factor out constant: $\\int {latex(expr)} dx = {k} \\int x^{{{n}}} dx$",
                f"$= {k} \\cdot \\frac{{x^{{{n+1}}}}}{{{n+1}}} + C = {latex(ans)} + C$"
            ),
        )

    elif problem_type == 3:
        # ∫ (ax² + bx + c) dx  — three-term polynomial
        a_val = nonzero(-6, 6)
        b_val = randint(-8, 8)
        c_val = randint(-8, 8)
        expr = a_val * x**2 + b_val * x + c_val
        ans = integrate(expr, x)

        return problem(
            question=f"\\int \\left({latex(expr)}\\right) dx",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate term by term",
                f"$\\int {latex(a_val*x**2)} dx = {latex(integrate(a_val*x**2, x))}$",
                f"$\\int {latex(b_val*x)} dx = {latex(integrate(b_val*x, x))}$",
                f"$\\int {c_val} dx = {c_val}x$",
                f"Combined: ${latex(ans)} + C$"
            ),
        )

    elif problem_type == 4:
        # ∫ (ax + b) dx   a in {±1..±8}, b in {-10..10}
        a_val = nonzero(-8, 8)
        b_val = randint(-10, 10)
        expr = a_val * x + b_val
        ans = integrate(expr, x)

        return problem(
            question=f"\\int \\left({latex(expr)}\\right) dx",
            answer=ans,
            difficulty=(1050, 1200),
            topic="calculus/antiderivatives",
            solution=steps(
                f"$\\int {latex(a_val*x)} dx + \\int {b_val} dx$",
                f"$= {latex(integrate(a_val*x, x))} + {b_val}x + C$",
                f"$= {latex(ans)} + C$"
            ),
        )

    else:
        # ∫ ax^p dx  where p is a positive non-integer: p in {1/2, 1/3, 3/2, 2/3}
        a_val = nonzero(-5, 5)
        p = choice([Rational(1, 2), Rational(1, 3), Rational(3, 2), Rational(2, 3)])

        expr = a_val * x**p
        ans = a_val * x**(p + 1) / (p + 1)

        p_latex = latex(p)
        p1_latex = latex(p + 1)

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1150, 1300),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Power rule applies for any $p \\neq -1$",
                f"$\\int {a_val} x^{{{p_latex}}} dx = {a_val} \\cdot \\frac{{x^{{{p1_latex}}}}}{{{p1_latex}}} + C$",
                f"$= {latex(ans)} + C$"
            ),
        )

emit(generate())
