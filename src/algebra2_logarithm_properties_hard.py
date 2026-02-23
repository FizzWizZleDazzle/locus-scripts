"""
algebra2 - logarithm_properties (hard)
Generated: 2026-02-22T04:31:54.116186
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'expand_logs',
        'condense_logs',
        'solve_log_equation',
        'change_of_base',
        'mixed_properties',
        'exponential_form'
    ])

    if problem_type == 'expand_logs':
        base = choice([2, 3, 5, 10])
        p1 = randint(2, 5)
        p2 = randint(2, 5)
        p3 = randint(2, 4)
        p4 = randint(2, 3)

        variant = randint(0, 2)
        if variant == 0:
            # log_b((x^p1 * y^p2) / z^p3)
            if base == 10:
                expr_str = f"\\log\\left(\\frac{{x^{{{p1}}} y^{{{p2}}}}}{{z^{{{p3}}}}}\\right)"
                ans_str = f"{p1}\\log(x) + {p2}\\log(y) - {p3}\\log(z)"
                ans = p1*log(x, 10) + p2*log(y, 10) - p3*log(z, 10)
            else:
                expr_str = f"\\log_{{{base}}}\\left(\\frac{{x^{{{p1}}} y^{{{p2}}}}}{{z^{{{p3}}}}}\\right)"
                ans_str = f"{p1}\\log_{{{base}}}(x) + {p2}\\log_{{{base}}}(y) - {p3}\\log_{{{base}}}(z)"
                ans = p1*log(x, base) + p2*log(y, base) - p3*log(z, base)
        elif variant == 1:
            # log_b(x^p1 * sqrt[p2](y) / z^p3)
            if base == 10:
                expr_str = f"\\log\\left(\\frac{{x^{{{p1}}} \\cdot \\sqrt[{p2}]{{y}}}}{{z^{{{p3}}}}}\\right)"
                ans_str = f"{p1}\\log(x) + \\frac{{1}}{{{p2}}}\\log(y) - {p3}\\log(z)"
                ans = p1*log(x, 10) + log(y, 10)/p2 - p3*log(z, 10)
            else:
                expr_str = f"\\log_{{{base}}}\\left(\\frac{{x^{{{p1}}} \\cdot \\sqrt[{p2}]{{y}}}}{{z^{{{p3}}}}}\\right)"
                ans_str = f"{p1}\\log_{{{base}}}(x) + \\frac{{1}}{{{p2}}}\\log_{{{base}}}(y) - {p3}\\log_{{{base}}}(z)"
                ans = p1*log(x, base) + log(y, base)/p2 - p3*log(z, base)
            return problem(
                question=f"Expand using logarithm properties: ${expr_str}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="algebra2/logarithm_properties",
                solution=steps(
                    f"Rewrite root as fractional exponent: $\\sqrt[{p2}]{{y}} = y^{{1/{p2}}}$",
                    f"Apply quotient and product rules",
                    f"Apply power rule: $\\log_b(x^n) = n\\log_b(x)$",
                    f"${ans_str}$"
                )
            )
        else:
            # log_b(x^p1 * y^p2 * z^p3 * w^p4)
            if base == 10:
                expr_str = f"\\log\\left(x^{{{p1}}} y^{{{p2}}} z^{{{p3}}}\\right)"
                ans_str = f"{p1}\\log(x) + {p2}\\log(y) + {p3}\\log(z)"
                ans = p1*log(x, 10) + p2*log(y, 10) + p3*log(z, 10)
            else:
                expr_str = f"\\log_{{{base}}}\\left(x^{{{p1}}} y^{{{p2}}} z^{{{p3}}}\\right)"
                ans_str = f"{p1}\\log_{{{base}}}(x) + {p2}\\log_{{{base}}}(y) + {p3}\\log_{{{base}}}(z)"
                ans = p1*log(x, base) + p2*log(y, base) + p3*log(z, base)

        return problem(
            question=f"Expand using logarithm properties: ${expr_str}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply quotient rule: $\\log_b\\left(\\frac{{A}}{{B}}\\right) = \\log_b(A) - \\log_b(B)$",
                f"Apply product rule to numerator: $\\log_b(xy) = \\log_b(x) + \\log_b(y)$",
                f"Apply power rule: $\\log_b(x^n) = n\\log_b(x)$",
                f"${ans_str}$"
            )
        )

    elif problem_type == 'condense_logs':
        base = choice([2, 3, 5, 10])
        c1 = randint(2, 6)
        c2 = randint(2, 6)
        c3 = randint(2, 5)

        if base == 10:
            question_str = f"{c1}\\log(x) + {c2}\\log(y) - {c3}\\log(z)"
            ans = log(x**c1 * y**c2 / z**c3, 10)
            ans_str = f"\\log\\left(\\frac{{x^{{{c1}}} y^{{{c2}}}}}{{z^{{{c3}}}}}\\right)"
        else:
            question_str = f"{c1}\\log_{{{base}}}(x) + {c2}\\log_{{{base}}}(y) - {c3}\\log_{{{base}}}(z)"
            ans = log(x**c1 * y**c2 / z**c3, base)
            ans_str = f"\\log_{{{base}}}\\left(\\frac{{x^{{{c1}}} y^{{{c2}}}}}{{z^{{{c3}}}}}\\right)"

        return problem(
            question=f"Write as a single logarithm: ${question_str}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply power rule: $n\\log_b(x) = \\log_b(x^n)$",
                f"Apply product rule: $\\log_b(x) + \\log_b(y) = \\log_b(xy)$",
                f"Apply quotient rule: $\\log_b(x) - \\log_b(y) = \\log_b(x/y)$",
                f"${ans_str}$"
            )
        )

    elif problem_type == 'solve_log_equation':
        base = choice([2, 3, 4, 5])
        variant = randint(0, 1)

        if variant == 0:
            # log_b(x) + log_b(x-a) = log_b(c)
            a_val = randint(2, 6)
            b_val = randint(2, 8)
            x_sol = a_val + b_val
            c_val = x_sol * (x_sol - a_val)

            question_str = f"\\log_{{{base}}}(x) + \\log_{{{base}}}(x - {a_val}) = \\log_{{{base}}}({c_val})"
            ans = x_sol

            return problem(
                question=f"Solve for $x$: ${question_str}$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="algebra2/logarithm_properties",
                solution=steps(
                    f"Apply product rule: $\\log_{{{base}}}(x(x - {a_val})) = \\log_{{{base}}}({c_val})$",
                    f"Since logs are equal: $x(x - {a_val}) = {c_val}$",
                    f"$x^2 - {a_val}x - {c_val} = 0$",
                    f"Solving: $x = {x_sol}$ (rejecting negative solution)",
                )
            )
        else:
            # log_b(x + a) - log_b(x - b) = result
            result = choice([1, 2])
            b_sub = randint(1, 3)
            power = base**result
            # (x + a_add)/(x - b_sub) = power  =>  x + a_add = power*(x - b_sub)
            # x(1-power) = -power*b_sub - a_add  pick a_add that gives integer x
            x_sol = randint(b_sub + 2, 12)
            a_add = power * (x_sol - b_sub) - x_sol
            if a_add <= 0 or a_add > 20:
                a_add = 3
                x_sol = (power * b_sub + a_add) // (power - 1)

            if x_sol > b_sub and a_add > 0:
                question_str = f"\\log_{{{base}}}(x + {a_add}) - \\log_{{{base}}}(x - {b_sub}) = {result}"
                ans = x_sol
                return problem(
                    question=f"Solve for $x$: ${question_str}$",
                    answer=ans,
                    difficulty=(1750, 1900),
                    topic="algebra2/logarithm_properties",
                    solution=steps(
                        f"Apply quotient rule: $\\log_{{{base}}}\\left(\\frac{{x + {a_add}}}{{x - {b_sub}}}\\right) = {result}$",
                        f"Convert to exponential: $\\frac{{x + {a_add}}}{{x - {b_sub}}} = {base}^{{{result}}} = {base**result}$",
                        f"$x + {a_add} = {base**result}(x - {b_sub})$",
                        f"$x = {x_sol}$"
                    )
                )
            else:
                # fallback to variant 0
                a_val = 3; b_val = 4; x_sol = a_val + b_val; c_val = x_sol*(x_sol - a_val)
                return problem(
                    question=f"Solve for $x$: $\\log_{{{base}}}(x) + \\log_{{{base}}}(x - {a_val}) = \\log_{{{base}}}({c_val})$",
                    answer=x_sol,
                    difficulty=(1700, 1850),
                    topic="algebra2/logarithm_properties",
                    solution=steps(
                        f"Product rule: $\\log_{{{base}}}(x(x-{a_val})) = \\log_{{{base}}}({c_val})$",
                        f"$x^2 - {a_val}x - {c_val} = 0$",
                        f"$x = {x_sol}$"
                    )
                )

    elif problem_type == 'change_of_base':
        old_base = choice([2, 3, 5, 7])
        new_base = choice([b for b in [2, 3, 5, 7, 10] if b != old_base])
        arg = randint(3, 30)

        question_str = f"\\log_{{{old_base}}}({arg})"
        if new_base == 10:
            ans_str = f"\\frac{{\\log({arg})}}{{\\log({old_base})}}"
        else:
            ans_str = f"\\frac{{\\log_{{{new_base}}}({arg})}}{{\\log_{{{new_base}}}({old_base})}}"
        ans = log(arg, old_base)

        return problem(
            question=f"Use the change of base formula to rewrite $\\displaystyle {question_str}$ using base ${new_base}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply change of base formula: $\\log_b(x) = \\frac{{\\log_c(x)}}{{\\log_c(b)}}$",
                f"${ans_str}$"
            )
        )

    elif problem_type == 'mixed_properties':
        base = choice([2, 3, 5, 7])
        p1 = randint(2, 5)
        p2 = randint(2, 5)
        k = randint(2, 4)

        # Simplify log_b(b^p1 * x^p2) + k or log_b(b^p1 / x^p2)
        variant = randint(0, 1)
        if variant == 0:
            question_str = f"\\log_{{{base}}}({base}^{{{p1}}} x^{{{p2}}})"
            ans = p1 + p2*log(x, base)
            ans_str = f"{p1} + {p2}\\log_{{{base}}}(x)"
        else:
            question_str = f"\\log_{{{base}}}\\left(\\frac{{{base}^{{{p1}}}}}{{x^{{{p2}}}}}\\right)"
            ans = p1 - p2*log(x, base)
            ans_str = f"{p1} - {p2}\\log_{{{base}}}(x)"

        return problem(
            question=f"Simplify: ${question_str}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply product/quotient rule",
                f"$= \\log_{{{base}}}({base}^{{{p1}}}) \\pm \\log_{{{base}}}(x^{{{p2}}})$",
                f"Use $\\log_b(b^n) = n$ and power rule",
                f"${ans_str}$"
            )
        )

    else:  # exponential_form
        base = choice([2, 3, 4, 5])
        result = randint(2, 5)
        coeff = randint(2, 5)
        const = randint(1, 8)

        # Solve: log_b(coeff*x + const) = result  =>  coeff*x + const = base^result
        x_sol_frac = (base**result - const)
        if x_sol_frac % coeff == 0 and x_sol_frac > 0:
            x_sol = x_sol_frac // coeff
            question_str = f"\\log_{{{base}}}({coeff}x + {const}) = {result}"
            ans = x_sol
        else:
            # Ensure clean integer answer
            x_sol = randint(2, 8)
            const = base**result - coeff * x_sol
            if const < 0:
                const = 1; x_sol = (base**result - const) // coeff
            question_str = f"\\log_{{{base}}}({coeff}x + {const}) = {result}"
            ans = x_sol

        return problem(
            question=f"Solve for $x$: ${question_str}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Convert to exponential form: ${coeff}x + {const} = {base}^{{{result}}} = {base**result}$",
                f"${coeff}x = {base**result} - {const} = {base**result - const}$",
                f"$x = {latex(ans)}$"
            )
        )

emit(generate())
