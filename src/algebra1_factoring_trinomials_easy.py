"""
algebra1 - factoring_trinomials (easy)
Generated: 2026-02-22T04:00:42.070028
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 3)

    if problem_type == 1:
        # Both roots positive (x+r1)(x+r2) — varied range
        r1 = randint(1, 10)
        r2 = randint(1, 10)
        factored = (x + r1) * (x + r2)
        expr = expand(factored)
        ans = factor(expr)
        b_coeff = r1 + r2
        c_coeff = r1 * r2

        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Find two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"The numbers are ${r1}$ and ${r2}$: ${r1} \\cdot {r2} = {c_coeff}$, ${r1}+{r2} = {b_coeff}$",
                f"${latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # One positive, one negative root — wide range
        r1 = randint(1, 9)
        r2 = randint(1, 9)
        sign = choice([1, -1])
        factored = (x + sign*r1) * (x - sign*r2) if randint(0,1) else (x - r1) * (x + r2)
        expr = expand(factored)
        ans = factor(expr)
        b_coeff = int(expr.coeff(x, 1))
        c_coeff = int(expr.coeff(x, 0))

        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Find two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"Since the constant is {'negative, the two numbers have opposite signs' if c_coeff < 0 else 'positive, the two numbers have the same sign'}",
                f"${latex(ans)}$"
            )
        )

    else:
        # Both roots negative (x-r1)(x-r2) — wide range
        r1 = randint(1, 10)
        r2 = randint(1, 10)
        factored = (x - r1) * (x - r2)
        expr = expand(factored)
        ans = factor(expr)
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Find two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"Both numbers are negative: $(-{r1}) \\cdot (-{r2}) = {c_coeff}$, $(-{r1})+(-{r2}) = {b_coeff}$",
                f"${latex(ans)}$"
            )
        )

emit(generate())
