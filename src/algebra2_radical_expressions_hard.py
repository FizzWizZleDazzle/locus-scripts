"""
algebra2 - radical_expressions (hard)
Generated: 2026-02-22T04:26:28.204973
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Rational exponent simplification: (x^(p/q) * x^(r/s))^(m/n)
        num1, den1 = choice([(2,3), (3,4), (1,2), (3,5), (2,5)])
        num2, den2 = choice([(1,2), (1,3), (2,5), (1,4), (3,4)])
        outer_num, outer_den = choice([(6,5), (4,3), (3,2), (5,4), (10,3)])

        expr = (x**(Rational(num1, den1)) * x**(Rational(num2, den2)))**(Rational(outer_num, outer_den))
        ans = simplify(expr)

        return problem(
            question=f"Simplify $\\left(x^{{{num1}/{den1}}} \\cdot x^{{{num2}/{den2}}}\\right)^{{{outer_num}/{outer_den}}}$ (assume $x > 0$)",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Add exponents inside: $x^{{{num1}/{den1} + {num2}/{den2}}} = x^{{{latex(Rational(num1,den1)+Rational(num2,den2))}}}$",
                f"Apply outer exponent (multiply): result is ${latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Rationalize with conjugate: 1/(a + sqrt(b)) or a/(sqrt(m) - sqrt(n))
        a_val = randint(2, 6)
        b_val = choice([2, 3, 5, 6, 7, 10, 11])
        # Ensure a^2 != b so denominator doesn't vanish
        while a_val**2 == b_val:
            a_val = randint(2, 6)

        numerator_coeff = randint(1, 4)
        denom = a_val + sqrt(b_val)
        conjugate = a_val - sqrt(b_val)
        new_denom = a_val**2 - b_val
        ans = simplify(numerator_coeff * conjugate / new_denom)

        return problem(
            question=f"Rationalize the denominator: $\\frac{{{numerator_coeff}}}{{{a_val} + \\sqrt{{{b_val}}}}}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Multiply by conjugate $\\frac{{{a_val} - \\sqrt{{{b_val}}}}}{{{a_val} - \\sqrt{{{b_val}}}}}$",
                f"Denominator: $({a_val})^2 - (\\sqrt{{{b_val}}})^2 = {a_val**2} - {b_val} = {a_val**2 - b_val}$",
                f"$= \\frac{{{numerator_coeff}({a_val} - \\sqrt{{{b_val}}})}}{{{a_val**2 - b_val}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Rationalize with cube root identity: 1/(a + cbrt(b))
        a_val = choice([2, 3, 4, 5])
        b_val = choice([2, 3, 4, 5, 6, 7])
        from sympy import cbrt
        denominator = a_val + cbrt(b_val)
        conjugate = a_val**2 - a_val*cbrt(b_val) + cbrt(b_val)**2
        new_denom = a_val**3 + b_val
        ans = simplify(conjugate / new_denom)

        return problem(
            question=f"Rationalize the denominator: $\\frac{{1}}{{{a_val} + \\sqrt[3]{{{b_val}}}}}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use identity $(a+b)(a^2-ab+b^2) = a^3 + b^3$",
                f"Multiply by $\\frac{{{a_val}^2 - {a_val}\\sqrt[3]{{{b_val}}} + \\sqrt[3]{{{b_val}^2}}}}{{{a_val}^2 - {a_val}\\sqrt[3]{{{b_val}}} + \\sqrt[3]{{{b_val}^2}}}}$",
                f"Denominator: ${a_val}^3 + {b_val} = {a_val**3 + b_val}$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Simplify nested radical: sqrt(outer_coeff * x^2 * sqrt(x^power))
        power1 = choice([3, 5, 7])
        outer_coeff = choice([1, 4, 9, 16])

        inner = sqrt(x**power1)
        expr = sqrt(outer_coeff * x**2 * inner)
        ans = simplify(expr)

        return problem(
            question=f"Simplify $\\sqrt{{{outer_coeff}x^2\\sqrt{{x^{{{power1}}}}}}}$ (assume $x > 0$)",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Rewrite inner radical: $\\sqrt{{x^{{{power1}}}}} = x^{{{power1}/2}}$",
                f"Expression inside outer radical: ${outer_coeff} x^{{2 + {power1}/2}}$",
                f"Apply outer square root: ${latex(ans)}$"
            )
        )

    else:
        # Simplify (a√m + b√n)(c√m - d√n) using FOIL
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        c_val = randint(1, 4)
        d_val = randint(1, 4)
        m_val = choice([2, 3, 5, 7])
        n_val = choice([2, 3, 5, 7])
        while n_val == m_val:
            n_val = choice([2, 3, 5, 7])

        ans = simplify((a_val*sqrt(m_val) + b_val*sqrt(n_val)) * (c_val*sqrt(m_val) - d_val*sqrt(n_val)))

        return problem(
            question=f"Expand: $({a_val}\\sqrt{{{m_val}}} + {b_val}\\sqrt{{{n_val}}})({c_val}\\sqrt{{{m_val}}} - {d_val}\\sqrt{{{n_val}}})$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use FOIL: multiply each term",
                f"First: ${a_val}\\sqrt{{{m_val}}} \\cdot {c_val}\\sqrt{{{m_val}}} = {a_val*c_val} \\cdot {m_val} = {a_val*c_val*m_val}$",
                f"Outer: ${a_val}\\sqrt{{{m_val}}} \\cdot (-{d_val}\\sqrt{{{n_val}}}) = -{a_val*d_val}\\sqrt{{{m_val*n_val}}}$",
                f"Inner: ${b_val}\\sqrt{{{n_val}}} \\cdot {c_val}\\sqrt{{{m_val}}} = {b_val*c_val}\\sqrt{{{m_val*n_val}}}$",
                f"Last: ${b_val}\\sqrt{{{n_val}}} \\cdot (-{d_val}\\sqrt{{{n_val}}}) = -{b_val*d_val} \\cdot {n_val} = {-b_val*d_val*n_val}$",
                f"Combine: ${latex(ans)}$"
            )
        )

emit(generate())
