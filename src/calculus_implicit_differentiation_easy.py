"""
calculus - implicit_differentiation (easy)
Generated: 2026-02-22T05:04:36.786935
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # ax^2 + by^2 = c (ellipse/hyperbola)
        a_val = nonzero(-6, 6)
        b_val = nonzero(-6, 6)
        c_val = randint(1, 30)
        # 2a x + 2b y dy/dx = 0 => dy/dx = -ax/(by)
        ans = simplify(Rational(-a_val, b_val) * x / y)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a_val*x**2 + b_val*y**2)} = {c_val}$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate: ${latex(2*a_val*x)} + {latex(2*b_val*y)}\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Linear: ax + by = c, dy/dx = -a/b (constant)
        a_val = nonzero(-6, 6)
        b_val = nonzero(-6, 6)
        c_val = randint(-15, 15)
        ans = Rational(-a_val, b_val)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a_val*x + b_val*y)} = {c_val}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate: ${a_val} + {b_val}\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # xy = k
        k_val = randint(2, 30)
        ans = -y/x
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $xy = {k_val}$.",
            answer=ans,
            difficulty=(1050, 1200),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Product rule: $y + x\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = -\\frac{{y}}{{x}}$"
            ),
        )

    elif problem_type == 4:
        # x^2 + y^2 = r^2 (circle)
        r_sq = randint(4, 50)
        ans = -x/y
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $x^2 + y^2 = {r_sq}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate: $2x + 2y\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = -\\frac{{x}}{{y}}$"
            ),
        )

    elif problem_type == 5:
        # ax^n + by = c, dy/dx = -an*x^(n-1)/b
        a_val = nonzero(-5, 5)
        n_val = randint(2, 4)
        b_val = nonzero(-5, 5)
        c_val = randint(1, 20)
        # a*n*x^(n-1) + b*dy/dx = 0
        ans = simplify(Rational(-a_val * n_val, b_val) * x**(n_val - 1))
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a_val*x**n_val + b_val*y)} = {c_val}$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate: ${latex(a_val*n_val*x**(n_val-1))} + {b_val}\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    else:
        # ax*y^2 = c, differentiate
        a_val = nonzero(-4, 4)
        c_val = randint(1, 20)
        # a*y^2 + a*x*2y*dy/dx = 0 => dy/dx = -y/(2x)
        ans = -y / (2 * x)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a_val*x*y**2)} = {c_val}$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Product rule: ${a_val}y^2 + {a_val}x \\cdot 2y\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = -\\frac{{y}}{{2x}}$"
            ),
        )

emit(generate())
