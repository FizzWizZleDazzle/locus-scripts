"""
algebra2 - radical_expressions (easy)
Generated: 2026-02-22T04:25:39.499579
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Simplify sqrt of perfect square
        base = randint(2, 15)
        value = base**2
        ans = base

        return problem(
            question=f"Simplify: $\\sqrt{{{value}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Recognize that ${value} = {base}^2$",
                f"Therefore $\\sqrt{{{value}}} = {base}$"
            )
        )

    elif problem_type == 2:
        # Simplify sqrt(a^2 * b) where b is small non-perfect-square
        base = randint(2, 10)
        small_num = choice([2, 3, 5, 6, 7, 10, 11, 13])
        value = base**2 * small_num
        ans = base * sqrt(small_num)

        return problem(
            question=f"Simplify: $\\sqrt{{{value}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Factor: ${value} = {base**2} \\cdot {small_num} = {base}^2 \\cdot {small_num}$",
                f"Extract perfect square: $\\sqrt{{{base}^2 \\cdot {small_num}}} = {base}\\sqrt{{{small_num}}}$"
            )
        )

    elif problem_type == 3:
        # Add or subtract like radicals: a√n ± b√n
        coeff1 = randint(2, 10)
        coeff2 = randint(2, 10)
        radical_num = choice([2, 3, 5, 6, 7, 10, 11])
        operation = choice(['+', '-'])

        if operation == '+':
            result_coeff = coeff1 + coeff2
        else:
            # Ensure positive result
            if coeff1 < coeff2:
                coeff1, coeff2 = coeff2, coeff1
            result_coeff = coeff1 - coeff2

        ans = result_coeff * sqrt(radical_num)

        return problem(
            question=f"Simplify: ${coeff1}\\sqrt{{{radical_num}}} {operation} {coeff2}\\sqrt{{{radical_num}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Combine like radicals (both have $\\sqrt{{{radical_num}}}$)",
                f"$= ({coeff1} {operation} {coeff2})\\sqrt{{{radical_num}}} = {result_coeff}\\sqrt{{{radical_num}}}$"
            )
        )

    elif problem_type == 4:
        # Multiply sqrt(a) * sqrt(b)
        num1 = randint(2, 12)
        num2 = randint(2, 12)
        product = num1 * num2
        ans = simplify(sqrt(product))

        return problem(
            question=f"Simplify: $\\sqrt{{{num1}}} \\cdot \\sqrt{{{num2}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use the property $\\sqrt{{a}} \\cdot \\sqrt{{b}} = \\sqrt{{ab}}$",
                f"$= \\sqrt{{{product}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 5:
        # Simplify coeff * sqrt(perfect square)
        coeff = randint(2, 8)
        base = randint(2, 7)
        value = base**2
        ans = coeff * base

        return problem(
            question=f"Simplify: ${coeff}\\sqrt{{{value}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Simplify $\\sqrt{{{value}}} = {base}$",
                f"${coeff} \\cdot {base} = {ans}$"
            )
        )

    else:
        # Simplify cube root of perfect cube
        base = randint(2, 8)
        value = base**3
        ans = base

        return problem(
            question=f"Simplify: $\\sqrt[3]{{{value}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Recognize that ${value} = {base}^3$",
                f"$\\sqrt[3]{{{value}}} = {base}$"
            )
        )

emit(generate())
