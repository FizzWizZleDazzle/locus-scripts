"""
algebra2 - logarithmic_equations (hard)
Generated: 2026-02-22T04:33:17.353845
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # log_b(x+a) + log_b(x+b) = c  (quadratic after product rule)
        base = choice([2, 3, 5])
        a_val = randint(1, 6)
        b_val = randint(1, 6)
        c_val = randint(2, 4)
        product = base**c_val

        coeffs_sum = a_val + b_val
        constant = a_val * b_val - product

        solutions = solve(x**2 + coeffs_sum*x + constant, x)
        valid_solutions = [sol for sol in solutions if sol > -min(a_val, b_val)]

        if len(valid_solutions) == 1:
            ans = valid_solutions[0]
        elif len(valid_solutions) > 0:
            ans = max(valid_solutions)
        else:
            # Fallback: construct guaranteed valid
            x_sol = randint(2, 8)
            a_val = 2; b_val = 3; c_val = 2
            product = base**c_val
            coeffs_sum = a_val + b_val; constant = a_val*b_val - product
            solutions = solve(x**2 + coeffs_sum*x + constant, x)
            valid_solutions = [s for s in solutions if s > 0]
            ans = valid_solutions[0] if valid_solutions else 2

        return problem(
            question=f"Solve for $x$: $\\log_{{{base}}}(x + {a_val}) + \\log_{{{base}}}(x + {b_val}) = {c_val}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use product rule: $\\log_{{{base}}}[(x + {a_val})(x + {b_val})] = {c_val}$",
                f"Convert: $(x + {a_val})(x + {b_val}) = {base}^{{{c_val}}} = {product}$",
                f"Expand: $x^2 + {coeffs_sum}x + {a_val * b_val} = {product}$",
                f"$x^2 + {coeffs_sum}x + {constant} = 0$",
                f"Solve: $x = {latex(ans)}$ (rejecting values making arguments $\\le 0$)"
            ),
        )

    elif problem_type == 2:
        # log_b(x^2 - k) = log_b(mx)  =>  x^2 - k = mx
        base = choice([2, 3, 5])
        m_val = randint(2, 6)
        # Construct with known solution
        x_sol = randint(m_val + 2, 12)
        k_val = x_sol**2 - m_val * x_sol
        if k_val <= 0:
            x_sol += 3; k_val = x_sol**2 - m_val * x_sol
        ans = x_sol

        return problem(
            question=f"Solve for $x$: $\\log_{{{base}}}(x^2 - {k_val}) = \\log_{{{base}}}({m_val}x)$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Since the logarithms have the same base, set arguments equal:",
                f"$x^2 - {k_val} = {m_val}x$",
                f"$x^2 - {m_val}x - {k_val} = 0$",
                f"Solve quadratic; check domain ($x^2 - {k_val} > 0$ and ${m_val}x > 0$)",
                f"$x = {ans}$"
            ),
        )

    elif problem_type == 3:
        # ln(x) + ln(x - a) = ln(b)  or  ln(x-a) + ln(x-b) = ln(c)
        a_val = randint(2, 7)
        # Construct: x(x-a) = b where x > a
        x_sol = randint(a_val + 1, a_val + 8)
        b_val = x_sol * (x_sol - a_val)
        ans = x_sol

        return problem(
            question=f"Solve for $x$: $\\ln(x) + \\ln(x - {a_val}) = \\ln({b_val})$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use $\\ln(m) + \\ln(n) = \\ln(mn)$:",
                f"$\\ln[x(x - {a_val})] = \\ln({b_val})$",
                f"Since $\\ln$ is one-to-one: $x(x - {a_val}) = {b_val}$",
                f"$x^2 - {a_val}x - {b_val} = 0$",
                f"Solving gives $x = {ans}$ (need $x > {a_val}$)"
            ),
        )

    elif problem_type == 4:
        # log_b(x + a) - log_b(x) = k  =>  (x+a)/x = b^k  =>  x = a/(b^k - 1)
        base = choice([2, 3, 4, 5])
        a_val = randint(2, 10)
        k_val = randint(1, 2)
        power = base**k_val
        ans = Rational(a_val, power - 1)

        return problem(
            question=f"Solve for $x$: $\\log_{{{base}}}(x + {a_val}) - \\log_{{{base}}}(x) = {k_val}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use quotient rule: $\\log_{{{base}}}\\left(\\frac{{x + {a_val}}}{{x}}\\right) = {k_val}$",
                f"Convert: $\\frac{{x + {a_val}}}{{x}} = {base}^{{{k_val}}} = {power}$",
                f"$x + {a_val} = {power}x$",
                f"${a_val} = {power - 1}x$",
                f"$x = \\frac{{{a_val}}}{{{power - 1}}} = {latex(ans)}$"
            ),
        )

    else:
        # log_b(x) + c*log_b(d) = a  (solve for x)
        base = choice([2, 3, 5])
        d_val = randint(2, 5)
        c_val = randint(1, 3)
        a_val = randint(3, 6)

        # log_b(x) + log_b(d^c) = a  =>  log_b(x * d^c) = a  =>  x = b^a / d^c
        denominator = d_val**c_val
        numerator = base**a_val
        ans = Rational(numerator, denominator)

        return problem(
            question=f"Solve for $x$: $\\log_{{{base}}}(x) + {c_val}\\log_{{{base}}}({d_val}) = {a_val}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/logarithmic_equations",
            solution=steps(
                f"Use power rule: ${c_val}\\log_{{{base}}}({d_val}) = \\log_{{{base}}}({d_val}^{{{c_val}}}) = \\log_{{{base}}}({denominator})$",
                f"Product rule: $\\log_{{{base}}}({denominator}x) = {a_val}$",
                f"Convert: ${denominator}x = {base}^{{{a_val}}} = {numerator}$",
                f"$x = \\frac{{{numerator}}}{{{denominator}}} = {latex(ans)}$"
            ),
        )

emit(generate())
