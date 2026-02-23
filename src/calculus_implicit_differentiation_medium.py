"""
calculus - implicit_differentiation (medium)
Generated: 2026-02-22T05:04:55.640510
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # ax^2 + by^2 = c (general ellipse/hyperbola)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = randint(1, 30)
        ans = simplify(-a * x / (b * y))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a*x**2 + b*y**2)} = {c}$.",
            answer=ans,
            difficulty=(1300, 1450),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate: ${latex(2*a*x)} + {latex(2*b*y)}\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # axy + bx = c
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(1, 20)
        # a(y + x dy/dx) + b = 0 => dy/dx = -(ay+b)/(ax)
        ans = simplify(-(a * y + b) / (a * x))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a*x*y + b*x)} = {c}$.",
            answer=ans,
            difficulty=(1350, 1500),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Product rule on $xy$: ${a}(y + x\\frac{{dy}}{{dx}}) + {b} = 0$",
                f"${a}x\\frac{{dy}}{{dx}} = {latex(-(a*y + b))}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # x^2 + axy + y^2 = c
        a = nonzero(-5, 5)
        c = randint(1, 20)
        # 2x + a(y + x dy/dx) + 2y dy/dx = 0
        # (ax + 2y) dy/dx = -(2x + ay)
        ans = simplify(-(2 * x + a * y) / (a * x + 2 * y))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $x^2 {'+' if a > 0 else ''}{latex(a*x*y)} + y^2 = {c}$.",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$2x + {a}(y + x\\frac{{dy}}{{dx}}) + 2y\\frac{{dy}}{{dx}} = 0$",
                f"$({latex(a*x)} + 2y)\\frac{{dy}}{{dx}} = {latex(-(2*x + a*y))}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # ax^m + by^n = c
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        m = randint(2, 4)
        n = randint(2, 4)
        c = randint(1, 25)
        # a*m*x^(m-1) + b*n*y^(n-1)*dy/dx = 0
        ans = simplify(-a * m * x**(m-1) / (b * n * y**(n-1)))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a*x**m + b*y**n)} = {c}$.",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate: ${latex(a*m*x**(m-1))} + {latex(b*n*y**(n-1))}\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # axy^2 + bx^2 = c
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(1, 25)
        # a(y^2 + x*2y*dy/dx) + 2b*x = 0
        # 2axy * dy/dx = -(ay^2 + 2bx)
        ans = simplify(-(a * y**2 + 2 * b * x) / (2 * a * x * y))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a*x*y**2 + b*x**2)} = {c}$.",
            answer=ans,
            difficulty=(1450, 1580),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$({a})(y^2 + 2xy\\frac{{dy}}{{dx}}) + {2*b}x = 0$",
                f"$2({a})xy\\frac{{dy}}{{dx}} = {latex(-(a*y**2 + 2*b*x))}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    else:
        # ax^2 + bxy = c
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(1, 20)
        # 2ax + b(y + x*dy/dx) = 0
        # bx * dy/dx = -(2ax + by)
        ans = simplify(-(2 * a * x + b * y) / (b * x))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a*x**2 + b*x*y)} = {c}$.",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$2({a})x + {b}(y + x\\frac{{dy}}{{dx}}) = 0$",
                f"${b}x\\frac{{dy}}{{dx}} = {latex(-(2*a*x + b*y))}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

emit(generate())
