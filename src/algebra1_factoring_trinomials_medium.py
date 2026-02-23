"""
algebra1 - factoring_trinomials (medium)
Generated: 2026-02-22T04:00:57.880004
"""

from problem_utils import *

def generate():
    diff = randint(1300, 1600)

    if diff <= 1400:
        # Monic trinomial, wider root range
        r1 = randint(-10, 10)
        r2 = randint(-10, 10)
        while r1 == r2 or r1 == 0 or r2 == 0:
            r1 = randint(-10, 10)
            r2 = randint(-10, 10)

        factored = (x - r1) * (x - r2)
        expr = expand(factored)
        ans = factor(expr)
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=diff,
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Find two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"The numbers are ${-r1}$ and ${-r2}$",
                f"${latex(ans)}$"
            )
        )

    else:
        # Non-monic: leading coefficient ∈ {2,3,4,5}
        a_val = choice([2, 3, 4, 5])
        variant = randint(0, 1)

        if variant == 0:
            # a(x - r1)(x - r2) form
            r1 = randint(-8, 8)
            r2 = randint(-8, 8)
            while r1 == r2 or r1 == 0 or r2 == 0:
                r1 = randint(-8, 8)
                r2 = randint(-8, 8)

            factored = a_val * (x - r1) * (x - r2)
            expr = expand(factored)
            ans = factor(expr)

            return problem(
                question=f"Factor completely: ${latex(expr)}$",
                answer=ans,
                difficulty=diff,
                topic="algebra1/factoring_trinomials",
                grading_mode="factor",
                solution=steps(
                    f"Leading coefficient is ${a_val}$; factor it out",
                    f"${a_val}({latex(expand((x-r1)*(x-r2)))})$",
                    f"Factor the remaining trinomial: ${latex(ans)}$"
                )
            )
        else:
            # (a1*x - m)(a2*x - n) with a1*a2 = a_val
            divisors = [(i, a_val//i) for i in range(1, a_val+1) if a_val % i == 0]
            a1, a2 = choice(divisors)
            m = nonzero(-7, 7)
            n = nonzero(-7, 7)

            factored = (a1*x - m) * (a2*x - n)
            expr = expand(factored)
            ans = factor(expr)

            A = a1*a2
            B = a1*(-n) + a2*(-m)  # middle coeff

            return problem(
                question=f"Factor the trinomial: ${latex(expr)}$",
                answer=ans,
                difficulty=diff,
                topic="algebra1/factoring_trinomials",
                grading_mode="factor",
                solution=steps(
                    f"Leading coefficient ${A}$ — look for factors $({a1}x + \\ldots)({a2}x + \\ldots)$",
                    f"Using the AC method or trial and error:",
                    f"${latex(ans)}$"
                )
            )

emit(generate())
