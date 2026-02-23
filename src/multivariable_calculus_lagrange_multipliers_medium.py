"""
multivariable_calculus - lagrange_multipliers (medium)
Generated: 2026-02-22T05:37:50.028875
"""

from problem_utils import *

def generate():
    prob_type = randint(1, 5)

    if prob_type == 1:
        # f(x,y) = ax + by on circle x^2 + y^2 = r^2
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        r_sq = choice([4, 9, 16, 25, 36, 49])
        # max = sqrt(r_sq*(a^2+b^2))
        max_val = simplify(sqrt(r_sq * (a_coeff**2 + b_coeff**2)))
        return problem(
            question=f"Find the maximum value of $f(x,y) = {latex(a_coeff*x + b_coeff*y)}$ subject to $x^2 + y^2 = {r_sq}$.",
            answer=max_val,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$\\nabla f = ({a_coeff}, {b_coeff})$, $\\nabla g = (2x, 2y)$",
                f"From $({a_coeff}, {b_coeff}) = \\lambda(2x, 2y)$: $x = \\frac{{{a_coeff}}}{{2\\lambda}}$, $y = \\frac{{{b_coeff}}}{{2\\lambda}}$",
                f"Substitute into constraint to get $\\lambda = \\pm\\frac{{\\sqrt{{{a_coeff**2}+{b_coeff**2}}}}}{{2\\sqrt{{{r_sq}}}}}$",
                f"Maximum value: ${latex(max_val)}$"
            )
        )

    elif prob_type == 2:
        # Minimize x^2 + y^2 on line ax + by = c
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        c_val = nonzero(-8, 8)
        denom = a_coeff**2 + b_coeff**2
        min_val = simplify(Rational(c_val**2, denom))
        return problem(
            question=f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to ${latex(a_coeff*x + b_coeff*y)} = {c_val}$.",
            answer=min_val,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$2x = {a_coeff}\\lambda$, $2y = {b_coeff}\\lambda$",
                f"Substituting: $\\frac{{{a_coeff**2}+{b_coeff**2}}}{{2}}\\lambda = {c_val}$",
                f"$\\lambda = \\frac{{2 \\cdot {c_val}}}{{{denom}}}$",
                f"Minimum: $\\frac{{{c_val}^2}}{{{denom}}} = {latex(min_val)}$"
            )
        )

    elif prob_type == 3:
        # Maximize xy subject to x + y = k
        k_val = randint(4, 16)
        max_val = Rational(k_val**2, 4)
        return problem(
            question=f"Find the maximum value of $f(x,y) = xy$ subject to $x + y = {k_val}$.",
            answer=max_val,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$y = \\lambda$, $x = \\lambda$, so $x = y = \\frac{{{k_val}}}{{2}}$",
                f"Maximum: $xy = \\left(\\frac{{{k_val}}}{{2}}\\right)^2 = {latex(max_val)}$"
            )
        )

    elif prob_type == 4:
        # Maximize xyz on x + y + z = k (3 variables)
        k_val = randint(6, 18)
        val = Rational(k_val, 3)
        max_val = val**3
        return problem(
            question=f"Find the maximum value of $f(x,y,z) = xyz$ subject to $x+y+z = {k_val}$, $x,y,z > 0$.",
            answer=max_val,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$yz = \\lambda$, $xz = \\lambda$, $xy = \\lambda$ implies $x = y = z$",
                f"Constraint: $3x = {k_val}$, so $x = y = z = {latex(val)}$",
                f"Maximum: $\\left(\\frac{{{k_val}}}{{3}}\\right)^3 = {latex(max_val)}$"
            )
        )

    else:
        # Minimize x^2 + y^2 + z^2 on plane ax + by + cz = d
        a_coeff = nonzero(-2, 2)
        b_coeff = nonzero(-2, 2)
        c_coeff = nonzero(-2, 2)
        d_val = nonzero(-6, 6)
        denom = a_coeff**2 + b_coeff**2 + c_coeff**2
        lambda_val = Rational(2*d_val, denom)
        x_crit = simplify(lambda_val * a_coeff / 2)
        y_crit = simplify(lambda_val * b_coeff / 2)
        z_crit = simplify(lambda_val * c_coeff / 2)
        min_val = simplify(x_crit**2 + y_crit**2 + z_crit**2)
        return problem(
            question=f"Find the minimum value of $f(x,y,z) = x^2+y^2+z^2$ subject to ${latex(a_coeff*x+b_coeff*y+c_coeff*z)} = {d_val}$.",
            answer=min_val,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"$2x = {a_coeff}\\lambda$, $2y = {b_coeff}\\lambda$, $2z = {c_coeff}\\lambda$",
                f"Substituting into constraint: $\\lambda = {latex(lambda_val)}$",
                f"Critical point: $({latex(x_crit)}, {latex(y_crit)}, {latex(z_crit)})$",
                f"Minimum: ${latex(min_val)}$"
            )
        )

emit(generate())
