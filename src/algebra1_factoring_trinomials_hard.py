"""
algebra1 - factoring_trinomials (hard)
Generated: 2026-02-22T04:01:25.742080
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Non-monic trinomial: (a1*x + b1)(a2*x + b2)
        # Wide leading coefficient and constant ranges
        a1 = choice([2, 3, 4, 5, 6, 7])
        a2 = choice([2, 3, 4, 5, 6])
        while a1 == a2:
            a2 = choice([2, 3, 4, 5, 6])
        b1 = nonzero(-9, 9)
        b2 = nonzero(-9, 9)

        factored = (a1*x + b1) * (a2*x + b2)
        expr = expand(factored)
        ans = factor(expr)

        A = a1 * a2
        B = a1*b2 + a2*b1
        C = b1 * b2

        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Factor ${latex(expr)}$ where the leading coefficient is ${A}$",
                f"Find factors of $({A})({C}) = {A*C}$ that add to ${B}$",
                f"Those numbers are ${a1*b2}$ and ${a2*b1}$",
                f"Rewrite the middle term and group: use trial and error or AC method",
                f"${latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Factor by grouping: split the middle term explicitly
        a1 = choice([3, 4, 5, 6, 7, 8])
        a2 = choice([2, 3, 4, 5, 6])
        b1 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)

        factored = (a1*x + b1) * (a2*x + b2)
        expr = expand(factored)
        ans = factor(expr)

        A = a1 * a2
        B = a1*b2 + a2*b1
        C = b1 * b2
        m1 = a1 * b2
        m2 = a2 * b1

        return problem(
            question=f"Factor using the AC (grouping) method: ${latex(expr)}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Multiply $A \\cdot C = ({A})({C}) = {A*C}$; find two numbers that multiply to ${A*C}$ and add to ${B}$",
                f"Those numbers are ${m1}$ and ${m2}$ (check: ${m1} \\cdot {m2} = {m1*m2}$, ${m1}+{m2} = {m1+m2}$)",
                f"Rewrite: ${A}x^2 + {m1}x + {m2}x + {C}$",
                f"Group: $x({a1}x + {b2}) + {b1}({a2}x + {b2})$ — look for common binomial",
                f"${latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Perfect square trinomial: (a*x + b)^2 with wide coefficient range
        a_val = choice([2, 3, 4, 5, 6, 7])
        b_val = nonzero(-8, 8)

        factored = (a_val*x + b_val)**2
        expr = expand(factored)
        ans = factor(expr)

        A = a_val**2
        B = 2*a_val*b_val
        C = b_val**2

        return problem(
            question=f"Factor completely (recognize the pattern): ${latex(expr)}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Check if ${latex(expr)}$ is a perfect square trinomial",
                f"First term: ${A}x^2 = ({a_val}x)^2$",
                f"Last term: ${C} = ({b_val})^2$",
                f"Middle term check: $2 \\cdot ({a_val}x) \\cdot ({b_val}) = {B}x$ ✓",
                f"${latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Difference of squares: (a*x)^2 - b^2 with wide ranges
        a_val = choice([2, 3, 4, 5, 6, 7])
        b_val = choice([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])

        factored = (a_val*x - b_val) * (a_val*x + b_val)
        expr = expand(factored)
        ans = factor(expr)

        return problem(
            question=f"Factor using difference of squares: ${latex(expr)}$",
            answer=ans,
            difficulty=(1550, 1700),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Recognize ${latex(expr)}$ as a difference of squares: $({a_val}x)^2 - {b_val}^2$",
                f"Apply the identity $a^2 - b^2 = (a - b)(a + b)$",
                f"${latex(ans)}$"
            )
        )

    elif problem_type == 5:
        # GCF extraction then factor: gcf * (a1*x + b1)(a2*x + b2)
        gcf = choice([2, 3, 4, 5, 6])
        a1 = choice([1, 2, 3, 4])
        a2 = choice([1, 2, 3, 4])
        b1 = nonzero(-7, 7)
        b2 = nonzero(-7, 7)

        inner_factored = (a1*x + b1) * (a2*x + b2)
        inner_expanded = expand(inner_factored)
        expr = expand(gcf * inner_expanded)
        ans = factor(expr)

        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"First identify and factor out the GCF from ${latex(expr)}$",
                f"GCF $= {gcf}$, giving ${gcf}({latex(inner_expanded)})$",
                f"Now factor the inner trinomial ${latex(inner_expanded)}$",
                f"${latex(ans)}$"
            )
        )

    else:
        # Sum/difference of cubes or GCF + perfect square for variety
        # Use GCF + non-monic perfect square: gcf*(a*x + b)^2
        gcf = choice([2, 3, 4, 5])
        a_val = choice([2, 3, 4, 5])
        b_val = nonzero(-6, 6)

        inner = (a_val*x + b_val)**2
        inner_expanded = expand(inner)
        expr = expand(gcf * inner_expanded)
        ans = factor(expr)

        A = a_val**2
        B_coeff = 2*a_val*b_val
        C = b_val**2

        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Factor out the GCF first: GCF $= {gcf}$",
                f"${latex(expr)} = {gcf}({latex(inner_expanded)})$",
                f"The inner polynomial ${latex(inner_expanded)}$ is a perfect square trinomial",
                f"Check: $\\sqrt{{{A}x^2}} = {a_val}x$, $\\sqrt{{{C}}} = {abs(b_val)}$, middle term $= 2({a_val})({b_val})x = {B_coeff}x$ ✓",
                f"${latex(ans)}$"
            )
        )

emit(generate())
