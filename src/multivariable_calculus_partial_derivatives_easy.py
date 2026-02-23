"""
multivariable_calculus - partial_derivatives (easy)
Generated: 2026-02-22T05:33:32.789809
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # f(x,y) = ax^m + by^n, find partial
        a_coeff = nonzero(-6, 6)
        b_coeff = nonzero(-6, 6)
        x_power = randint(2, 5)
        y_power = randint(2, 5)
        f = a_coeff * x**x_power + b_coeff * y**y_power
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ where $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Treat all variables except ${latex(var_choice)}$ as constants",
                f"Apply the power rule term by term",
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # f(x,y) = ax^m*y^n + bx^p, find partial
        a_coeff = nonzero(-5, 5)
        b_coeff = nonzero(-5, 5)
        xp1 = randint(1, 4)
        yp1 = randint(1, 4)
        xp2 = randint(2, 4)
        f = a_coeff * x**xp1 * y**yp1 + b_coeff * x**xp2
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Compute $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left[{latex(f)}\\right]$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Differentiate ${latex(f)}$ with respect to ${latex(var_choice)}$, treating other variables as constants",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left[{latex(f)}\\right] = {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Evaluate partial at a point
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        xp = randint(2, 4)
        yp = randint(2, 4)
        f = a_coeff * x**xp + b_coeff * y**yp
        var_choice = choice([x, y])
        partial = diff(f, var_choice)
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        ans = partial.subs([(x, x0), (y, y0)])
        return problem(
            question=f"Let $f(x,y) = {latex(f)}$. Evaluate $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ at $({x0}, {y0})$",
            answer=ans,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(partial)}$",
                f"Substitute $x = {x0},\\ y = {y0}$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # f(x,y,z) = ax*y + by*z + cz*x, find partial
        a_coeff = nonzero(-5, 5)
        b_coeff = nonzero(-5, 5)
        c_coeff = nonzero(-5, 5)
        f = a_coeff * x * y + b_coeff * y * z + c_coeff * z * x
        var_choice = choice([x, y, z])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ where $f(x,y,z) = {latex(f)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Differentiate with respect to ${latex(var_choice)}$, treating other variables as constants",
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 5:
        # f(x,y) = ax^m + bxy + cy^n
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        c_coeff = nonzero(-4, 4)
        xp = randint(2, 4)
        yp = randint(2, 4)
        f = a_coeff * x**xp + b_coeff * x * y + c_coeff * y**yp
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right)$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Treat ${latex([v for v in [x, y] if v != var_choice][0])}$ as a constant",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right) = {latex(ans)}$"
            )
        )

    else:
        # Evaluate 3-variable partial at a point
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        f = a_coeff * x**2 * y + b_coeff * y * z**2
        var_choice = choice([x, y, z])
        partial = diff(f, var_choice)
        x0 = randint(-2, 2)
        y0 = randint(-2, 2)
        z0 = randint(-2, 2)
        ans = partial.subs([(x, x0), (y, y0), (z, z0)])
        return problem(
            question=f"Evaluate $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ at $({x0}, {y0}, {z0})$ where $f(x,y,z) = {latex(f)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(partial)}$",
                f"Substitute $x={x0},\\ y={y0},\\ z={z0}$: $= {latex(ans)}$"
            )
        )

emit(generate())
