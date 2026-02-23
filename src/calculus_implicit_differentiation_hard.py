"""
calculus - implicit_differentiation (hard)
Generated: 2026-02-22T05:05:25.184470
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Circle: evaluate dy/dx at a specific point
        r = randint(3, 9)
        x0 = randint(-r + 1, r - 1)
        y0_sq = r**2 - x0**2
        y0 = int(sqrt(y0_sq))
        if choice([True, False]) and y0 != 0:
            y0 = -y0
        # dy/dx = -x/y
        if y0 != 0:
            ans = Rational(-x0, y0)
        else:
            ans = oo
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $x^2+y^2={r**2}$ at $({x0},{y0})$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$2x + 2y\\frac{{dy}}{{dx}} = 0 \\Rightarrow \\frac{{dy}}{{dx}} = -\\frac{{x}}{{y}}$",
                f"At $({x0},{y0})$: $\\frac{{dy}}{{dx}} = -\\frac{{{x0}}}{{{y0}}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Ellipse x^2/a + y^2/b = 1
        a_sq = choice([4, 9, 16, 25, 36])
        b_sq = choice([4, 9, 16, 25, 36])
        while a_sq == b_sq:
            b_sq = choice([4, 9, 16, 25, 36])
        # 2x/a + 2y/b * dy/dx = 0 => dy/dx = -bx/(ay)
        ans = simplify(Rational(-b_sq, a_sq) * x / y)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $\\frac{{x^2}}{{{a_sq}}} + \\frac{{y^2}}{{{b_sq}}} = 1$.",
            answer=ans,
            difficulty=(1600, 1720),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$\\frac{{2x}}{{{a_sq}}} + \\frac{{2y}}{{{b_sq}}}\\frac{{dy}}{{dx}} = 0$",
                f"$\\frac{{dy}}{{dx}} = -\\frac{{{b_sq}x}}{{{a_sq}y}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # ax^2*y + bx*y^2 = c
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(1, 20)
        # a(2xy + x^2 dy/dx) + b(y^2 + 2xy dy/dx) = 0
        # (ax^2 + 2bxy) dy/dx = -(2axy + by^2)
        numerator = -(2 * a * x * y + b * y**2)
        denominator = a * x**2 + 2 * b * x * y
        ans = simplify(numerator / denominator)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for ${latex(a*x**2*y + b*x*y**2)} = {c}$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Product rule: ${a}(2xy + x^2\\frac{{dy}}{{dx}}) + {b}(y^2 + 2xy\\frac{{dy}}{{dx}}) = 0$",
                f"$({latex(a*x**2 + 2*b*x*y)})\\frac{{dy}}{{dx}} = {latex(numerator)}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # sin(ax + by) = c*x (with nonzero c)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        # cos(ax+by)*(a + b*dy/dx) = c
        # b*cos(ax+by)*dy/dx = c - a*cos(ax+by)
        # dy/dx = (c - a*cos(ax+by))/(b*cos(ax+by))
        numerator = c - a * cos(a * x + b * y)
        denominator = b * cos(a * x + b * y)
        ans = simplify(numerator / denominator)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $\\sin({latex(a*x + b*y)}) = {c}x$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$\\cos({latex(a*x+b*y)}) \\cdot ({a} + {b}\\frac{{dy}}{{dx}}) = {c}$",
                f"${b}\\cos({latex(a*x+b*y)})\\frac{{dy}}{{dx}} = {c} - {a}\\cos({latex(a*x+b*y)})$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # e^(xy) + y^k = c
        k = randint(2, 5)
        c = randint(1, 10)
        # e^(xy)*(y + x*dy/dx) + k*y^(k-1)*dy/dx = 0
        # dy/dx*(e^(xy)*x + k*y^(k-1)) = -y*e^(xy)
        numerator = -exp(x * y) * y
        denominator = exp(x * y) * x + k * y**(k - 1)
        ans = simplify(numerator / denominator)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $e^{{xy}} + y^{k} = {c}$.",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$e^{{xy}}(y + x\\frac{{dy}}{{dx}}) + {k}y^{{{k-1}}}\\frac{{dy}}{{dx}} = 0$",
                f"$(xe^{{xy}} + {k}y^{{{k-1}}})\\frac{{dy}}{{dx}} = -ye^{{xy}}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

    else:
        # ln(xy) + ax^2 = c
        a = nonzero(-4, 4)
        c = randint(1, 10)
        # 1/(xy) * (y + x*dy/dx) + 2ax = 0
        # 1/x + (1/y)*dy/dx + 2ax = 0
        # dy/dx = -y*(1/x + 2ax) = -y*(1 + 2ax^2)/x
        ans = simplify(-y * (1 + 2 * a * x**2) / x)
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for $\\ln(xy) + {latex(a*x**2)} = {c}$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"$\\frac{{d}}{{dx}}[\\ln(xy)] = \\frac{{1}}{{xy}}(y + x\\frac{{dy}}{{dx}}) = \\frac{{1}}{{x}} + \\frac{{1}}{{y}}\\frac{{dy}}{{dx}}$",
                f"$\\frac{{1}}{{x}} + \\frac{{1}}{{y}}\\frac{{dy}}{{dx}} + {latex(2*a*x)} = 0$",
                f"$\\frac{{dy}}{{dx}} = -y\\left(\\frac{{1}}{{x}} + {latex(2*a*x)}\\right) = {latex(ans)}$"
            ),
        )

emit(generate())
