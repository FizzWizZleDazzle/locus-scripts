"""
algebra2 - logarithm_properties (medium)
Generated: 2026-02-22T04:31:04.009558
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Expand: log_b(m*n) or log_b(x*y)
        base = choice([2, 3, 5, 7, 10])
        coeff1 = randint(2, 15)
        coeff2 = randint(2, 15)

        if randint(0, 1) == 0:
            question = f"\\log_{{{base}}}({coeff1} \\cdot {coeff2})"
            ans = f"\\log_{{{base}}}({coeff1}) + \\log_{{{base}}}({coeff2})"
            solution_text = steps(
                f"Apply the product rule: $\\log_b(mn) = \\log_b(m) + \\log_b(n)$",
                f"${question} = {ans}$"
            )
        else:
            vars_pair = choice([("x", "y"), ("a", "b"), ("m", "n")])
            u, v = vars_pair
            question = f"\\log_{{{base}}}({u}{v})"
            ans = f"\\log_{{{base}}}({u}) + \\log_{{{base}}}({v})"
            solution_text = steps(
                f"Apply the product rule: $\\log_b(mn) = \\log_b(m) + \\log_b(n)$",
                f"${question} = {ans}$"
            )

        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

    elif problem_type == 2:
        # Expand quotient rule
        base = choice([2, 3, 5, 7, 10])

        if randint(0, 1) == 0:
            num = randint(6, 60)
            denom = randint(2, 12)
            question = f"\\log_{{{base}}}\\left(\\frac{{{num}}}{{{denom}}}\\right)"
            ans = f"\\log_{{{base}}}({num}) - \\log_{{{base}}}({denom})"
            solution_text = steps(
                f"Apply the quotient rule: $\\log_b\\left(\\frac{{m}}{{n}}\\right) = \\log_b(m) - \\log_b(n)$",
                f"${question} = {ans}$"
            )
        else:
            vars_pair = choice([("x", "y"), ("a", "b"), ("p", "q")])
            u, v = vars_pair
            question = f"\\log_{{{base}}}\\left(\\frac{{{u}}}{{{v}}}\\right)"
            ans = f"\\log_{{{base}}}({u}) - \\log_{{{base}}}({v})"
            solution_text = steps(
                f"Apply the quotient rule: $\\log_b\\left(\\frac{{m}}{{n}}\\right) = \\log_b(m) - \\log_b(n)$",
                f"${question} = {ans}$"
            )

        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

    elif problem_type == 3:
        # Expand power rule
        base = choice([2, 3, 5, 7, 10])
        power = randint(2, 6)
        var = choice(["x", "a", "m", "n"])

        if randint(0, 1) == 0:
            value = randint(2, 15)
            question = f"\\log_{{{base}}}({value}^{{{power}}})"
            ans = f"{power} \\log_{{{base}}}({value})"
        else:
            question = f"\\log_{{{base}}}({var}^{{{power}}})"
            ans = f"{power} \\log_{{{base}}}({var})"

        solution_text = steps(
            f"Apply the power rule: $\\log_b(m^n) = n \\log_b(m)$",
            f"${question} = {ans}$"
        )

        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

    elif problem_type == 4:
        # Combined expansion: log(x^a * y^b / z^c) or log(x^a * y)
        base = choice([2, 3, 5, 7, 10])
        p1 = randint(2, 5)
        p2 = randint(2, 5)
        p3 = randint(2, 4)

        variant = randint(0, 2)
        if variant == 0:
            question = f"\\log_{{{base}}}\\left(\\frac{{x^{{{p1}}} y^{{{p2}}}}}{{z^{{{p3}}}}}\\right)"
            ans = f"{p1}\\log_{{{base}}}(x) + {p2}\\log_{{{base}}}(y) - {p3}\\log_{{{base}}}(z)"
            solution_text = steps(
                f"Apply quotient rule: split numerator from denominator",
                f"Apply product rule to numerator: $\\log_{{{base}}}(x^{{{p1}}} y^{{{p2}}}) = \\log_{{{base}}}(x^{{{p1}}}) + \\log_{{{base}}}(y^{{{p2}}})$",
                f"Apply power rule: $= {ans}$"
            )
        elif variant == 1:
            question = f"\\log_{{{base}}}(x^{{{p1}}} y^{{{p2}}})"
            ans = f"{p1}\\log_{{{base}}}(x) + {p2}\\log_{{{base}}}(y)"
            solution_text = steps(
                f"Apply product rule: $\\log_b(AB) = \\log_b(A) + \\log_b(B)$",
                f"Apply power rule to each: $= {ans}$"
            )
        else:
            question = f"\\log_{{{base}}}\\left(\\frac{{x^{{{p1}}}}}{{y^{{{p2}}} z^{{{p3}}}}}\\right)"
            ans = f"{p1}\\log_{{{base}}}(x) - {p2}\\log_{{{base}}}(y) - {p3}\\log_{{{base}}}(z)"
            solution_text = steps(
                f"Apply quotient rule then power rule",
                f"$= {ans}$"
            )

        return problem(
            question=f"Expand using logarithm properties: ${question}$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

    elif problem_type == 5:
        # Condense: a*log(x) + b*log(y) -> log(x^a * y^b)
        base = choice([2, 3, 5, 7, 10])
        c1 = randint(2, 5)
        c2 = randint(2, 5)
        var1 = choice(["x", "a", "m"])
        var2 = choice(["y", "b", "n"])
        while var2 == var1:
            var2 = choice(["y", "b", "n"])

        question = f"{c1}\\log_{{{base}}}({var1}) + {c2}\\log_{{{base}}}({var2})"
        ans = f"\\log_{{{base}}}({var1}^{{{c1}}} {var2}^{{{c2}}})"
        solution_text = steps(
            f"Apply power rule: $n\\log_b(m) = \\log_b(m^n)$",
            f"$= \\log_{{{base}}}({var1}^{{{c1}}}) + \\log_{{{base}}}({var2}^{{{c2}}})$",
            f"Apply product rule: $= {ans}$"
        )

        return problem(
            question=f"Write as a single logarithm: ${question}$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

    else:
        # Condense: a*log(x) - log(y)
        base = choice([2, 3, 5, 7, 10])
        coeff = randint(2, 5)
        var1 = choice(["x", "a", "m"])
        var2 = choice(["y", "b", "n"])
        while var2 == var1:
            var2 = choice(["y", "b", "n"])

        question = f"{coeff}\\log_{{{base}}}({var1}) - \\log_{{{base}}}({var2})"
        ans = f"\\log_{{{base}}}\\left(\\frac{{{var1}^{{{coeff}}}}}{{{var2}}}\\right)"
        solution_text = steps(
            f"Apply power rule: ${coeff}\\log_{{{base}}}({var1}) = \\log_{{{base}}}({var1}^{{{coeff}}})$",
            f"Apply quotient rule: $\\log_b(m) - \\log_b(n) = \\log_b(m/n)$",
            f"$= {ans}$"
        )

        return problem(
            question=f"Write as a single logarithm: ${question}$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="algebra2/logarithm_properties",
            solution=solution_text,
            answer_type="expression"
        )

emit(generate())
