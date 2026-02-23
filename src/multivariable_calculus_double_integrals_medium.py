"""
multivariable_calculus - double_integrals (medium)
Generated: 2026-02-22T05:39:16.852138
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Polynomial integrand over rectangle
        a_val = randint(0, 3)
        b_val = a_val + randint(1, 4)
        c_val = randint(0, 3)
        d_val = c_val + randint(1, 4)
        power_x = randint(1, 3)
        power_y = randint(1, 3)
        coeff = nonzero(-4, 4)
        integrand = coeff * x**power_x * y**power_y
        inner = integrate(integrand, (y, c_val, d_val))
        ans = integrate(inner, (x, a_val, b_val))
        return problem(
            question=f"Evaluate $\\int_{{{a_val}}}^{{{b_val}}} \\int_{{{c_val}}}^{{{d_val}}} {latex(integrand)} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_{{{c_val}}}^{{{d_val}}} {latex(integrand)} \\, dy = {latex(inner)}$",
                f"Outer: $\\int_{{{a_val}}}^{{{b_val}}} {latex(inner)} \\, dx = {latex(ans)}$"
            ),
            answer_type="numeric"
        )

    elif problem_type == 2:
        # Triangular region: 0 <= x <= a, 0 <= y <= mx
        a_val = randint(1, 4)
        m_val = randint(1, 3)
        coeff = nonzero(-3, 3)
        func_choice = choice(['x_plus_y', 'xy', 'x2', 'y2'])
        if func_choice == 'x_plus_y':
            integrand = coeff * (x + y)
        elif func_choice == 'xy':
            integrand = coeff * x * y
        elif func_choice == 'x2':
            integrand = coeff * x**2
        else:
            integrand = coeff * y**2
        inner = integrate(integrand, (y, 0, m_val * x))
        ans = integrate(inner, (x, 0, a_val))
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{a_val}}} \\int_{{0}}^{{{m_val}x}} {latex(integrand)} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_0^{{{m_val}x}} {latex(integrand)} \\, dy = {latex(inner)}$",
                f"Outer: $\\int_0^{{{a_val}}} {latex(inner)} \\, dx = {latex(ans)}$"
            ),
            answer_type="numeric"
        )

    elif problem_type == 3:
        # Iterated integral in x then y order
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        coeff = nonzero(-3, 3)
        func_choice = choice(['x_plus_y', 'xy', 'x2y'])
        if func_choice == 'x_plus_y':
            integrand = x + y
        elif func_choice == 'xy':
            integrand = coeff * x * y
        else:
            integrand = coeff * x**2 * y
        inner = integrate(integrand, (x, 0, a_val))
        ans = integrate(inner, (y, 0, b_val))
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} {latex(integrand)} \\, dx \\, dy$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_0^{{{a_val}}} {latex(integrand)} \\, dx = {latex(inner)}$",
                f"Outer: $\\int_0^{{{b_val}}} {latex(inner)} \\, dy = {latex(ans)}$"
            ),
            answer_type="numeric"
        )

    elif problem_type == 4:
        # Region y from x to a (upper triangular)
        a_val = randint(1, 3)
        c_val = nonzero(-3, 3)
        func_choice = choice(['x_plus_y', 'xy', 'y'])
        if func_choice == 'x_plus_y':
            integrand = c_val * (x + y)
        elif func_choice == 'xy':
            integrand = c_val * x * y
        else:
            integrand = c_val * y
        inner = integrate(integrand, (y, x, a_val))
        ans = integrate(inner, (x, 0, a_val))
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{a_val}}} \\int_{{x}}^{{{a_val}}} {latex(integrand)} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner ($y$ from $x$ to ${a_val}$): $= {latex(inner)}$",
                f"Outer: $\\int_0^{{{a_val}}} {latex(inner)} \\, dx = {latex(ans)}$"
            ),
            answer_type="numeric"
        )

    else:
        # ax^p * y^q over rectangle with non-zero lower bounds
        a_val = randint(1, 3)
        b_val = a_val + randint(1, 3)
        c_val = randint(1, 2)
        d_val = c_val + randint(1, 3)
        coeff = nonzero(-2, 2)
        px = randint(1, 3)
        py = randint(1, 3)
        integrand = coeff * x**px * y**py
        inner = integrate(integrand, (y, c_val, d_val))
        ans = integrate(inner, (x, a_val, b_val))
        return problem(
            question=f"Evaluate $\\int_{{{a_val}}}^{{{b_val}}} \\int_{{{c_val}}}^{{{d_val}}} {latex(integrand)} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner: $\\int_{{{c_val}}}^{{{d_val}}} {latex(integrand)} \\, dy = {latex(inner)}$",
                f"Outer: $\\int_{{{a_val}}}^{{{b_val}}} {latex(inner)} \\, dx = {latex(ans)}$"
            ),
            answer_type="numeric"
        )

emit(generate())
