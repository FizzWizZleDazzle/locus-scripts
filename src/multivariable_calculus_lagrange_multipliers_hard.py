"""
multivariable_calculus - lagrange_multipliers (hard)
Generated: 2026-02-22T05:38:35.453285
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Minimize x^2 + y^2 subject to ax + by = c
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-6, 6)
        lambda_val = Rational(2*c_val, a_val**2 + b_val**2)
        x_val = lambda_val * a_val / 2
        y_val = lambda_val * b_val / 2
        ans_val = simplify(x_val**2 + y_val**2)
        return problem(
            question=f"Find the minimum value of $f(x,y) = x^2+y^2$ subject to ${latex(a_val*x+b_val*y)} = {c_val}$ using Lagrange multipliers.",
            answer=ans_val,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$\\mathcal{{L}} = x^2+y^2 - \\lambda({latex(a_val*x+b_val*y-c_val)})$",
                f"$2x = {a_val}\\lambda$, $2y = {b_val}\\lambda$",
                f"$\\lambda = {latex(lambda_val)}$, $x = {latex(x_val)}$, $y = {latex(y_val)}$",
                f"Minimum: ${latex(ans_val)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Minimize f(x,y) = x^2/a^2 + y^2/b^2 on ellipse, find closest to origin
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        # min of x^2+y^2 on ellipse x^2/a^2 + y^2/b^2 = 1 is min(a^2, b^2)
        ans_val = min(a_val, b_val)**2
        return problem(
            question=f"Find the minimum value of $f(x,y)=x^2+y^2$ subject to $\\frac{{x^2}}{{{a_val**2}}}+\\frac{{y^2}}{{{b_val**2}}}=1$.",
            answer=ans_val,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$(2x, 2y) = \\lambda\\left(\\frac{{2x}}{{{a_val**2}}}, \\frac{{2y}}{{{b_val**2}}}\\right)$",
                f"If $x \\ne 0$: $\\lambda = {a_val**2}$. If $y \\ne 0$: $\\lambda = {b_val**2}$",
                f"Critical points at $(\\pm{a_val}, 0)$ giving $f={a_val**2}$ and $(0, \\pm{b_val})$ giving $f={b_val**2}$",
                f"Minimum: ${ans_val}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Maximize xy subject to x^2/a^2 + y^2/b^2 = 1
        a_val = randint(2, 6)
        b_val = randint(2, 6)
        # max at x = a/sqrt(2), y = b/sqrt(2), max = ab/2
        ans_val = simplify(Rational(a_val * b_val, 2))
        return problem(
            question=f"Maximize $f(x,y) = xy$ subject to $\\frac{{x^2}}{{{a_val**2}}} + \\frac{{y^2}}{{{b_val**2}}} = 1$, $x,y > 0$.",
            answer=ans_val,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"Lagrange: $y = \\frac{{2\\lambda x}}{{{a_val**2}}}$ and $x = \\frac{{2\\lambda y}}{{{b_val**2}}}$",
                f"Dividing: $\\frac{{y}}{{x}} = \\frac{{b_val^2 x}}{{a_val^2 y}}$, so $\\frac{{y^2}}{{x^2}} = \\frac{{{b_val**2}}}{{{a_val**2}}}$",
                f"$x = \\frac{{{a_val}}}{{\\sqrt{{2}}}}$, $y = \\frac{{{b_val}}}{{\\sqrt{{2}}}}$",
                f"Maximum $xy = \\frac{{{a_val*b_val}}}{{2}} = {latex(ans_val)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Closest point on circle to a given point
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        r_val = randint(1, 3)
        dist_to_center = sqrt(a_val**2 + b_val**2)
        # min distance from origin to circle centered at (a,b) r=r_val
        ans_val = simplify((dist_to_center - r_val)**2)
        if ans_val < 0:
            ans_val = simplify((r_val - dist_to_center)**2)
        return problem(
            question=f"Find the minimum value of $f(x,y)=x^2+y^2$ subject to $(x-{a_val})^2+(y-{b_val})^2={r_val**2}$.",
            answer=ans_val,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"Constraint is circle centered at $({a_val},{b_val})$ with radius ${r_val}$",
                f"Distance from origin to center: $\\sqrt{{{a_val}^2+{b_val}^2}} = {latex(dist_to_center)}$",
                f"Closest point on circle is along the line from origin to center",
                f"Minimum $f = (\\text{{dist to center}} - r)^2 = ({latex(dist_to_center)} - {r_val})^2 = {latex(ans_val)}$"
            ),
            calculator="scientific"
        )

    else:
        # Max/min on sphere: x^2+y^2+z^2=r^2 with linear objective
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        c_coeff = nonzero(-3, 3)
        r_sq = choice([4, 9, 16, 25])
        # max = r*sqrt(a^2+b^2+c^2)
        ans_val = simplify(sqrt(r_sq) * sqrt(a_coeff**2 + b_coeff**2 + c_coeff**2))
        return problem(
            question=f"Find the maximum of $f(x,y,z) = {latex(a_coeff*x + b_coeff*y + c_coeff*z)}$ subject to $x^2+y^2+z^2={r_sq}$.",
            answer=ans_val,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$(a,b,c) = 2\\lambda(x,y,z)$, so $x = \\frac{{{a_coeff}}}{{2\\lambda}}$, etc.",
                f"Substituting into constraint gives $\\lambda = \\pm\\frac{{\\sqrt{{{a_coeff**2}+{b_coeff**2}+{c_coeff**2}}}}}{{2\\sqrt{{{r_sq}}}}}$",
                f"Maximum: $\\sqrt{{{r_sq}}} \\cdot \\sqrt{{{a_coeff**2}+{b_coeff**2}+{c_coeff**2}}} = {latex(ans_val)}$"
            ),
            calculator="scientific"
        )

emit(generate())
