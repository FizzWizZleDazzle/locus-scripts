"""
algebra1 - exponent_rules (hard)
Generated: 2026-02-22T03:58:26.371899
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Simplify with coefficients and negative exponents
        base_var = choice([x, y])
        exp_num = randint(1, 5)
        exp_den = exp_num + randint(1, 4)
        c_num = randint(2, 9)
        c_den = randint(2, 9)

        final_coeff = Rational(c_num, c_den)
        final_exp = exp_num - exp_den  # negative

        if final_coeff == 1:
            ans = base_var**final_exp
        else:
            ans = final_coeff * base_var**final_exp

        return problem(
            question=f"Simplify: $\\frac{{{c_num}{latex(base_var)}^{{{exp_num}}}}}{{{c_den}{latex(base_var)}^{{{exp_den}}}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"$\\frac{{{c_num}}}{{{c_den}}} \\cdot {latex(base_var)}^{{{exp_num}-{exp_den}}} = {latex(final_coeff)} \\cdot {latex(base_var)}^{{{final_exp}}}$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Multi-variable: (x^a * y^b)^c / (x^d * y^e)
        a_e = randint(2, 5)
        b_e = randint(2, 5)
        c_e = randint(2, 4)
        d_e = randint(1, a_e*c_e - 1)
        e_e = randint(1, b_e*c_e - 1)

        x_exp = a_e*c_e - d_e
        y_exp = b_e*c_e - e_e
        ans = x**x_exp * y**y_exp

        return problem(
            question=f"Simplify: $\\frac{{(x^{{{a_e}}}y^{{{b_e}}})^{{{c_e}}}}}{{x^{{{d_e}}}y^{{{e_e}}}}}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Apply power rule: $(x^{{{a_e}}}y^{{{b_e}}})^{{{c_e}}} = x^{{{a_e*c_e}}}y^{{{b_e*c_e}}}$",
                f"Apply quotient rule: $x^{{{a_e*c_e}-{d_e}}}y^{{{b_e*c_e}-{e_e}}} = {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Exponential equation: base^(linear1) = base^(linear2)
        base_val = choice([2, 3, 4, 5, 7])
        # Random coefficients for both sides
        a_coeff = randint(2, 6)
        b_coeff = randint(1, 5)
        c_coeff = randint(3, 8)
        while c_coeff == a_coeff:
            c_coeff = randint(3, 8)
        # a_coeff*x + b_const = c_coeff*x + d_const → pick x_val and derive
        x_val = randint(1, 10)
        lhs_exp = a_coeff * x_val + b_coeff
        d_const = lhs_exp - c_coeff * x_val

        ans = x_val
        return problem(
            question=f"Solve for $x$: ${base_val}^{{{a_coeff}x+{b_coeff}}} = {base_val}^{{{c_coeff}x+{d_const}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Since bases are equal, set exponents equal: ${a_coeff}x + {b_coeff} = {c_coeff}x + {d_const}$",
                f"${b_coeff} - {d_const} = {c_coeff}x - {a_coeff}x$",
                f"${b_coeff - d_const} = {c_coeff - a_coeff}x$",
                f"$x = {ans}$"
            )
        )

    elif problem_type == 4:
        # (x^a)^c * x^(-b) - power then product with negative exponent
        a_e = randint(2, 5)
        c_e = randint(2, 4)
        b_e = randint(1, a_e*c_e - 1)
        final_exp = a_e*c_e - b_e
        ans = x**final_exp

        return problem(
            question=f"Simplify: $(x^{{{a_e}}})^{{{c_e}}} \\cdot x^{{-{b_e}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Power rule: $(x^{{{a_e}}})^{{{c_e}}} = x^{{{a_e*c_e}}}$",
                f"Product rule: $x^{{{a_e*c_e}}} \\cdot x^{{-{b_e}}} = x^{{{a_e*c_e}+(-{b_e})}} = x^{{{final_exp}}}$"
            )
        )

    elif problem_type == 5:
        # Complex: (x^a / x^b)^c * (x^d)^e
        a_e = randint(3, 6)
        b_e = randint(a_e+1, a_e+4)
        c_e = randint(2, 4)
        d_e = randint(1, 4)
        e_e = randint(2, 4)

        final_exp = (a_e - b_e)*c_e + d_e*e_e
        ans = x**final_exp

        return problem(
            question=f"Simplify: $\\left(\\frac{{x^{{{a_e}}}}}{{x^{{{b_e}}}}}\\right)^{{{c_e}}} \\cdot (x^{{{d_e}}})^{{{e_e}}}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Quotient inside: $\\frac{{x^{{{a_e}}}}}{{x^{{{b_e}}}}} = x^{{{a_e-b_e}}}$",
                f"Power rule: $(x^{{{a_e-b_e}}})^{{{c_e}}} = x^{{{(a_e-b_e)*c_e}}}$",
                f"Other term: $(x^{{{d_e}}})^{{{e_e}}} = x^{{{d_e*e_e}}}$",
                f"Product: $x^{{{(a_e-b_e)*c_e}}} \\cdot x^{{{d_e*e_e}}} = x^{{{final_exp}}}$"
            )
        )

    else:
        # Fractional exponent: x^(1/n) = n-th root
        base_var = choice([x, y])
        n = randint(2, 5)
        m = randint(1, n)
        # Simplify x^(m/n)
        ans = base_var**Rational(m, n)
        # Sometimes ask to evaluate: base^(m/n) for numeric base
        base_num = choice([4, 8, 9, 16, 25, 27, 32, 64])
        from sympy import Rational as R
        exp_frac = R(m, n)
        val = base_num**exp_frac
        if val.is_Integer or val.is_Rational:
            return problem(
                question=f"Evaluate: ${base_num}^{{\\frac{{{m}}}{{{n}}}}}$",
                answer=val,
                difficulty=(1650, 1750),
                topic="algebra1/exponent_rules",
                solution=steps(
                    f"$x^{{m/n}} = (\\sqrt[n]{{x}})^m = (x^{{1/n}})^m$",
                    f"$= (\\sqrt[{n}]{{{base_num}}})^{{{m}}}$",
                    f"$= {latex(val)}$"
                )
            )
        else:
            # Fall back to variable simplification
            exp1 = randint(2, 5)
            exp2 = randint(2, 5)
            ans2 = base_var**(exp1+exp2)
            return problem(
                question=f"Simplify: ${latex(base_var)}^{{{exp1}}} \\cdot {latex(base_var)}^{{{exp2}}}$",
                answer=ans2,
                difficulty=(1600, 1700),
                topic="algebra1/exponent_rules",
                solution=steps(
                    f"$= {latex(base_var)}^{{{exp1+exp2}}}$"
                )
            )

emit(generate())
