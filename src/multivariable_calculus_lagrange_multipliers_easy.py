"""
multivariable_calculus - lagrange_multipliers (easy)
Generated: 2026-02-22T05:37:14.650899
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Minimize x^2 + y^2 subject to ax + by = c
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-6, 6)
        # min = c^2 / (a^2 + b^2)
        ans = simplify(Rational(c_val**2, a_val**2 + b_val**2))
        return problem(
            question=f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to ${latex(a_val*x + b_val*y)} = {c_val}$.",
            answer=ans,
            difficulty=(1100, 1300),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"Lagrangian: $L = x^2 + y^2 - \\lambda({latex(a_val*x + b_val*y - c_val)})$",
                f"$2x = {a_val}\\lambda$, $2y = {b_val}\\lambda$",
                f"Substituting into constraint gives $\\lambda = \\frac{{2 \\cdot {c_val}}}{{{a_val**2} + {b_val**2}}}$",
                f"Minimum value: $\\frac{{{c_val}^2}}{{{a_val**2 + b_val**2}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Maximize xy subject to x + y = c
        c_val = randint(4, 16)
        ans = Rational(c_val**2, 4)
        return problem(
            question=f"Find the maximum value of $f(x,y) = xy$ subject to $x + y = {c_val}$.",
            answer=ans,
            difficulty=(1000, 1200),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"From $\\nabla f = \\lambda \\nabla g$: $y = \\lambda$ and $x = \\lambda$, so $x = y$",
                f"Constraint: $2x = {c_val}$, so $x = y = {Rational(c_val, 2)}$",
                f"Maximum: $xy = \\left(\\frac{{{c_val}}}{{2}}\\right)^2 = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Maximize x + y subject to x^2 + y^2 = r^2
        r_val = randint(2, 8)
        ans = simplify(r_val * sqrt(2))
        return problem(
            question=f"Find the maximum value of $f(x,y) = x + y$ subject to $x^2 + y^2 = {r_val**2}$.",
            answer=ans,
            difficulty=(1100, 1300),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"From $\\nabla f = \\lambda \\nabla g$: $1 = 2\\lambda x$ and $1 = 2\\lambda y$, so $x = y$",
                f"Constraint: $2x^2 = {r_val**2}$, so $x = y = \\frac{{{r_val}}}{{\\sqrt{{2}}}}$",
                f"Maximum: $x + y = \\frac{{2 \\cdot {r_val}}}{{\\sqrt{{2}}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Maximize ax + by subject to x^2 + y^2 = r^2
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        r_sq = choice([4, 9, 16, 25, 36])
        # max = r * sqrt(a^2 + b^2)
        ans = simplify(sqrt(r_sq) * sqrt(a_coeff**2 + b_coeff**2))
        return problem(
            question=f"Find the maximum value of $f(x,y) = {latex(a_coeff*x + b_coeff*y)}$ subject to $x^2 + y^2 = {r_sq}$.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$\\nabla f = ({a_coeff}, {b_coeff})$, $\\nabla g = (2x, 2y)$",
                f"From Lagrange: $x = \\frac{{{a_coeff}}}{{2\\lambda}}$, $y = \\frac{{{b_coeff}}}{{2\\lambda}}$",
                f"Substituting into $x^2+y^2={r_sq}$ and solving",
                f"Maximum = $\\sqrt{{{r_sq}}} \\cdot \\sqrt{{{a_coeff**2}+{b_coeff**2}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # Minimize x^2 + y^2 subject to x + y = c (same as type 1 but symmetric)
        c_val = nonzero(-8, 8)
        ans = Rational(c_val**2, 2)
        return problem(
            question=f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to $x + y = {c_val}$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"From Lagrange: $2x = \\lambda$ and $2y = \\lambda$, so $x = y$",
                f"Constraint: $2x = {c_val}$, so $x = y = {Rational(c_val, 2)}$",
                f"Minimum: $2x^2 = 2\\left(\\frac{{{c_val}}}{{2}}\\right)^2 = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
