"""
algebra2 - logarithm_properties (easy)
Generated: 2026-02-22T04:30:37.362415
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # log_b(b^n) = n  with varied base and exponent
        base = choice([2, 3, 5, 7, 10])
        exponent = randint(1, 6)
        value = base ** exponent
        ans = exponent

        return problem(
            question=f"Evaluate $\\log_{{{base}}}({value})$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Recognize that ${value} = {base}^{{{exponent}}}$",
                f"Using the property $\\log_b(b^n) = n$:",
                f"$\\log_{{{base}}}({base}^{{{exponent}}}) = {exponent}$"
            ),
        )

    elif problem_type == 2:
        # Product rule: log_b(m) + log_b(n) = log_b(mn)
        base = choice([2, 3, 5, 7, 10])
        m = randint(2, 12)
        n = randint(2, 12)

        return problem(
            question=f"Simplify $\\log_{{{base}}}({m}) + \\log_{{{base}}}({n})$",
            answer=f"log({m*n}, {base})",
            difficulty=(1100, 1200),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Use the product rule: $\\log_b(m) + \\log_b(n) = \\log_b(mn)$",
                f"$\\log_{{{base}}}({m}) + \\log_{{{base}}}({n}) = \\log_{{{base}}}({m} \\cdot {n})$",
                f"$= \\log_{{{base}}}({m*n})$"
            ),
        )

    elif problem_type == 3:
        # Quotient rule: log_b(m) - log_b(n)
        base = choice([2, 3, 5, 7, 10])
        m = randint(4, 20)
        n = randint(2, m - 1)

        return problem(
            question=f"Simplify $\\log_{{{base}}}({m}) - \\log_{{{base}}}({n})$",
            answer=f"log({m}/{n}, {base})",
            difficulty=(1100, 1250),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Use the quotient rule: $\\log_b(m) - \\log_b(n) = \\log_b\\left(\\frac{{m}}{{n}}\\right)$",
                f"$\\log_{{{base}}}({m}) - \\log_{{{base}}}({n}) = \\log_{{{base}}}\\left(\\frac{{{m}}}{{{n}}}\\right)$"
            ),
        )

    elif problem_type == 4:
        # Power rule: n*log_b(m) = log_b(m^n)
        base = choice([2, 3, 5, 7, 10])
        m = randint(2, 12)
        n = randint(2, 5)

        return problem(
            question=f"Simplify ${n} \\log_{{{base}}}({m})$",
            answer=f"{n}*log({m}, {base})",
            difficulty=(1150, 1250),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Use the power rule: $n \\log_b(m) = \\log_b(m^n)$",
                f"${n} \\log_{{{base}}}({m}) = \\log_{{{base}}}({m}^{{{n}}})$",
                f"$= \\log_{{{base}}}({m**n})$"
            ),
        )

    elif problem_type == 5:
        # log_b(1) = 0
        base = choice([2, 3, 5, 7, 10])

        return problem(
            question=f"Evaluate $\\log_{{{base}}}(1)$",
            answer=0,
            difficulty=(1000, 1100),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Recall that any base raised to the power 0 equals 1: ${base}^0 = 1$",
                f"Therefore, $\\log_{{{base}}}(1) = 0$"
            ),
        )

    else:
        # log_b(b) = 1
        base = choice([2, 3, 5, 7, 10])

        return problem(
            question=f"Evaluate $\\log_{{{base}}}({base})$",
            answer=1,
            difficulty=(1000, 1100),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Recall that $b^1 = b$ for any base $b$",
                f"Therefore, $\\log_{{{base}}}({base}) = 1$"
            ),
        )

emit(generate())
