"""
multivariable_calculus - double_integrals (easy)
Generated: 2026-02-22T05:38:57.585888
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Integrate constant c over rectangle
        const = randint(1, 8)
        x_lower = randint(0, 3)
        x_upper = x_lower + randint(1, 5)
        y_lower = randint(0, 3)
        y_upper = y_lower + randint(1, 5)
        width = x_upper - x_lower
        height = y_upper - y_lower
        ans = const * width * height
        return problem(
            question=f"Evaluate $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} {const} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner integral: $\\int_{{{y_lower}}}^{{{y_upper}}} {const} \\, dy = {const} \\cdot {height} = {const * height}$",
                f"Outer integral: $\\int_{{{x_lower}}}^{{{x_upper}}} {const * height} \\, dx = {const * height} \\cdot {width} = {ans}$"
            ),
        )

    elif problem_type == 2:
        # Integrate x
        x_lower = randint(0, 2)
        x_upper = x_lower + randint(2, 5)
        y_lower = randint(0, 2)
        y_upper = y_lower + randint(2, 4)
        y_part = y_upper - y_lower
        ans = Rational(y_part * (x_upper**2 - x_lower**2), 2)
        return problem(
            question=f"Evaluate $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} x \\, dy \\, dx$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_{{{y_lower}}}^{{{y_upper}}} x \\, dy = {y_part}x$",
                f"Outer: $\\int_{{{x_lower}}}^{{{x_upper}}} {y_part}x \\, dx = {y_part} \\cdot \\frac{{{x_upper**2}-{x_lower**2}}}{{2}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Integrate y
        x_lower = randint(0, 2)
        x_upper = x_lower + randint(2, 4)
        y_lower = randint(0, 2)
        y_upper = y_lower + randint(2, 5)
        x_part = x_upper - x_lower
        ans = Rational(x_part * (y_upper**2 - y_lower**2), 2)
        return problem(
            question=f"Evaluate $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} y \\, dy \\, dx$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_{{{y_lower}}}^{{{y_upper}}} y \\, dy = \\frac{{{y_upper**2}-{y_lower**2}}}{{2}} = {latex(Rational(y_upper**2 - y_lower**2, 2))}$",
                f"Outer: ${x_part} \\cdot {latex(Rational(y_upper**2 - y_lower**2, 2))} = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # Integrate xy
        x_lower = randint(0, 2)
        x_upper = x_lower + randint(1, 4)
        y_lower = randint(0, 2)
        y_upper = y_lower + randint(1, 4)
        x_part = Rational(x_upper**2 - x_lower**2, 2)
        y_part = Rational(y_upper**2 - y_lower**2, 2)
        ans = x_part * y_part
        return problem(
            question=f"Evaluate $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} xy \\, dy \\, dx$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_{{{y_lower}}}^{{{y_upper}}} xy \\, dy = x \\cdot {latex(y_part)}$",
                f"Outer: ${latex(y_part)} \\cdot \\int_{{{x_lower}}}^{{{x_upper}}} x \\, dx = {latex(y_part)} \\cdot {latex(x_part)} = {latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # Integrate cx^2 over rectangle
        c = nonzero(-3, 3)
        x_lower = 0
        x_upper = randint(1, 4)
        y_lower = 0
        y_upper = randint(1, 4)
        x_int = Rational(c * x_upper**3, 3)
        ans = x_int * y_upper
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{y_upper}}} \\int_{{0}}^{{{x_upper}}} {c}x^2 \\, dx \\, dy$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_0^{{{x_upper}}} {c}x^2 \\, dx = {c} \\cdot \\frac{{{x_upper}^3}}{{3}} = {latex(x_int)}$",
                f"Outer: $\\int_0^{{{y_upper}}} {latex(x_int)} \\, dy = {latex(x_int)} \\cdot {y_upper} = {latex(ans)}$"
            ),
        )

    else:
        # Integrate cy^2 over rectangle
        c = nonzero(-3, 3)
        x_lower = 0
        x_upper = randint(1, 4)
        y_lower = 0
        y_upper = randint(1, 4)
        y_int = Rational(c * y_upper**3, 3)
        ans = y_int * x_upper
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{x_upper}}} \\int_{{0}}^{{{y_upper}}} {c}y^2 \\, dy \\, dx$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_0^{{{y_upper}}} {c}y^2 \\, dy = {c} \\cdot \\frac{{{y_upper}^3}}{{3}} = {latex(y_int)}$",
                f"Outer: $\\int_0^{{{x_upper}}} {latex(y_int)} \\, dx = {latex(y_int)} \\cdot {x_upper} = {latex(ans)}$"
            ),
        )

emit(generate())
