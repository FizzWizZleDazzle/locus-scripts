"""
multivariable_calculus - triple_integrals (easy)
Generated: 2026-02-22T05:40:20.547679
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Integrate constant over box
        constant = randint(1, 8)
        x1, x2 = randint(0, 2), randint(3, 6)
        y1, y2 = randint(0, 2), randint(3, 5)
        z1, z2 = randint(0, 2), randint(3, 5)
        volume = (x2 - x1) * (y2 - y1) * (z2 - z1)
        ans = constant * volume
        return problem(
            question=f"Evaluate $\\int_{{{z1}}}^{{{z2}}} \\int_{{{y1}}}^{{{y2}}} \\int_{{{x1}}}^{{{x2}}} {constant} \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Constant integrand: result = constant × volume",
                f"Volume $= ({x2}-{x1}) \\cdot ({y2}-{y1}) \\cdot ({z2}-{z1}) = {volume}$",
                f"Result $= {constant} \\cdot {volume} = {ans}$"
            ),
        )

    elif problem_type == 2:
        # x^n over [0,a]x[0,b]x[0,c]
        power = randint(1, 3)
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        c_val = randint(1, 4)
        x_integral = Rational(a_val**(power + 1), power + 1)
        ans = x_integral * b_val * c_val
        integrand_str = f"x^{{{power}}}" if power > 1 else "x"
        return problem(
            question=f"Evaluate $\\int_0^{{{c_val}}} \\int_0^{{{b_val}}} \\int_0^{{{a_val}}} {integrand_str} \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{a_val}}} {integrand_str} \\, dx = \\frac{{{a_val}^{{{power+1}}}}}{{{power+1}}} = {latex(x_integral)}$",
                f"Multiply by $b={b_val}$ and $c={c_val}$: $= {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # xyz over [0,a]x[0,b]x[0,c]
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(1, 3)
        ans = Rational(a_val**2, 2) * Rational(b_val**2, 2) * Rational(c_val**2, 2)
        return problem(
            question=f"Evaluate $\\int_0^{{{c_val}}} \\int_0^{{{b_val}}} \\int_0^{{{a_val}}} xyz \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{a_val}}} x \\, dx = \\frac{{{a_val}^2}}{{2}}$",
                f"$\\int_0^{{{b_val}}} y \\, dy = \\frac{{{b_val}^2}}{{2}}$",
                f"$\\int_0^{{{c_val}}} z \\, dz = \\frac{{{c_val}^2}}{{2}}$",
                f"Product: ${latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # x + y + z over [0,a]x[0,b]x[0,c]
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(1, 3)
        x_part = Rational(a_val**2, 2) * b_val * c_val
        y_part = a_val * Rational(b_val**2, 2) * c_val
        z_part = a_val * b_val * Rational(c_val**2, 2)
        ans = x_part + y_part + z_part
        return problem(
            question=f"Evaluate $\\int_0^{{{c_val}}} \\int_0^{{{b_val}}} \\int_0^{{{a_val}}} (x+y+z) \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Split: $\\iiint x + \\iiint y + \\iiint z$",
                f"$= \\frac{{{a_val**2}}}{{2}} \\cdot {b_val} \\cdot {c_val} + {a_val} \\cdot \\frac{{{b_val**2}}}{{2}} \\cdot {c_val} + {a_val} \\cdot {b_val} \\cdot \\frac{{{c_val**2}}}{{2}}$",
                f"$= {latex(x_part)} + {latex(y_part)} + {latex(z_part)} = {latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # z over non-unit box
        x1, x2 = randint(0, 2), randint(3, 5)
        y1, y2 = randint(0, 2), randint(3, 5)
        z1, z2 = randint(0, 2), randint(2, 4)
        x_part = x2 - x1
        y_part = y2 - y1
        z_part = Rational(z2**2 - z1**2, 2)
        ans = x_part * y_part * z_part
        return problem(
            question=f"Evaluate $\\int_{{{z1}}}^{{{z2}}} \\int_{{{y1}}}^{{{y2}}} \\int_{{{x1}}}^{{{x2}}} z \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Inner two integrals just multiply by width/height: $({x2}-{x1}) \\cdot ({y2}-{y1}) = {x_part * y_part}$",
                f"$\\int_{{{z1}}}^{{{z2}}} {x_part * y_part} \\cdot z \\, dz = {x_part * y_part} \\cdot \\frac{{{z2**2}-{z1**2}}}{{2}} = {latex(ans)}$"
            ),
        )

    else:
        # cx^2 * z over [0,a]x[0,b]x[0,c]
        coeff = nonzero(-2, 2)
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(1, 3)
        x_int = Rational(coeff * a_val**3, 3)
        ans = x_int * b_val * Rational(c_val**2, 2)
        return problem(
            question=f"Evaluate $\\int_0^{{{c_val}}} \\int_0^{{{b_val}}} \\int_0^{{{a_val}}} {coeff}x^2 z \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{a_val}}} {coeff}x^2 \\, dx = {latex(x_int)}$",
                f"Multiply by $\\int_0^{{{b_val}}} dy = {b_val}$ and $\\int_0^{{{c_val}}} z \\, dz = {latex(Rational(c_val**2, 2))}$",
                f"$= {latex(ans)}$"
            ),
        )

emit(generate())
