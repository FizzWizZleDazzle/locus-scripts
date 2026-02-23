"""
multivariable_calculus - partial_derivatives (medium)
Generated: 2026-02-22T05:33:55.748810
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # First-order partial of polynomial with randomized coefficients
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        xp = randint(2, 4)
        yp = randint(2, 4)
        f = a * x**xp * y**yp + b * x**3 + c * y**3
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right)$",
            answer=ans,
            difficulty=(1300, 1420),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Treat all variables except ${latex(var_choice)}$ as constants",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right) = {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Second-order partial derivative
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        xp = randint(2, 4)
        yp = randint(2, 4)
        f = a * x**xp * y**yp + b * x * y
        var1 = choice([x, y])
        var2 = choice([x, y])
        ans = simplify(diff(diff(f, var1), var2))
        if var1 == var2:
            notation = f"\\frac{{\\partial^2}}{{\\partial {latex(var1)}^2}}"
        else:
            notation = f"\\frac{{\\partial^2}}{{\\partial {latex(var2)} \\partial {latex(var1)}}}"
        first_deriv = diff(f, var1)
        return problem(
            question=f"Find ${notation}\\left({latex(f)}\\right)$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"First: $\\frac{{\\partial}}{{\\partial {latex(var1)}}}\\left({latex(f)}\\right) = {latex(first_deriv)}$",
                f"Then differentiate with respect to ${latex(var2)}$",
                f"${notation} = {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Partial of exp(ax + by)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        f = exp(a*x + b*y)
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right)$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Use the chain rule: $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}} e^{{{latex(a*x + b*y)}}} = e^{{{latex(a*x + b*y)}}} \\cdot \\frac{{\\partial}}{{\\partial {latex(var_choice)}}}({latex(a*x + b*y)})$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Partial of sin or cos
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        trig_func = choice([sin, cos])
        f = trig_func(a*x + b*y)
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right)$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Use the chain rule for trig functions",
                f"Treat variables other than ${latex(var_choice)}$ as constants",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right) = {latex(ans)}$"
            )
        )

    elif problem_type == 5:
        # Evaluate partial at a point
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        f = a * x**2 * y + b * x * y**2 + c * x * y
        var_choice = choice([x, y])
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        partial_deriv = diff(f, var_choice)
        ans = partial_deriv.subs([(x, x0), (y, y0)])
        return problem(
            question=f"Evaluate $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ at $({x0}, {y0})$ where $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(partial_deriv)}$",
                f"Substitute $x={x0},\\ y={y0}$: $= {latex(ans)}$"
            )
        )

    else:
        # Product rule partial: f = x^a * sin(by) or similar
        a = randint(2, 4)
        b = nonzero(-3, 3)
        variant = choice(['sin', 'cos', 'exp'])
        if variant == 'sin':
            f = x**a * sin(b*y)
        elif variant == 'cos':
            f = x**a * cos(b*y)
        else:
            f = x**a * exp(b*y)
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        return problem(
            question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right)$",
            answer=ans,
            difficulty=(1450, 1600),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Treat the other variable as a constant",
                f"Apply differentiation rules",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(f)}\\right) = {latex(ans)}$"
            )
        )

emit(generate())
