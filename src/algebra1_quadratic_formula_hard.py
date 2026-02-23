"""
algebra1 - quadratic_formula (hard)
Generated: 2026-02-22T04:02:42.037205
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Irrational solutions: x^2 + 2px + (p^2 - q) = 0 → x = -p ± sqrt(q)
        p = nonzero(-7, 7)
        q = randint(2, 15)
        # Ensure q is not a perfect square (for irrational answer)
        while int(q**0.5)**2 == q:
            q = randint(2, 15)
        b_coeff = 2 * p
        c_coeff = p**2 - q
        discriminant = b_coeff**2 - 4*c_coeff  # = 4q
        sol1 = (-b_coeff + sqrt(discriminant)) / 2
        sol2 = (-b_coeff - sqrt(discriminant)) / 2
        ans = FiniteSet(sol1, sol2)

        return problem(
            question=f"Solve: $x^2 + {b_coeff}x + {c_coeff} = 0$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a=1$, $b={b_coeff}$, $c={c_coeff}$",
                f"$\\Delta = ({b_coeff})^2 - 4(1)({c_coeff}) = {discriminant}$",
                f"$x = \\frac{{{-b_coeff} \\pm \\sqrt{{{discriminant}}}}}{{2}} = {-b_coeff//2} \\pm {latex(sqrt(discriminant)//2)}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Rearrangement required before quadratic formula
        a_val = choice([2, 3, 4, 5])
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r1 == r2:
            r2 = nonzero(-5, 5)
        b_coeff = -a_val*(r1+r2)
        c_coeff = a_val*r1*r2
        disc = b_coeff**2 - 4*a_val*c_coeff
        ans = FiniteSet(r1, r2)

        # Present as ax^2 = -bx - c (rearranged form)
        rhs_b = -b_coeff
        rhs_c = -c_coeff
        rhs_str = f"{'+' if rhs_b >= 0 else ''}{rhs_b}x {'+' if rhs_c >= 0 else ''}{rhs_c}".strip()

        return problem(
            question=f"Rearrange and solve using the quadratic formula: ${a_val}x^2 = {rhs_str}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"Rearrange to standard form: ${a_val}x^2 + {b_coeff}x + {c_coeff} = 0$",
                f"$a={a_val}$, $b={b_coeff}$, $c={c_coeff}$",
                f"$\\Delta = ({b_coeff})^2 - 4({a_val})({c_coeff}) = {disc}$",
                f"$x = \\frac{{-({b_coeff}) \\pm \\sqrt{{{disc}}}}}{{2({a_val})}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Complex (imaginary) roots
        a_val = choice([1, 2, 3])
        b_val = choice([-6,-4,-2,0,2,4,6])
        # Force negative discriminant
        c_val = randint(5, 20)
        while b_val**2 - 4*a_val*c_val >= 0:
            c_val += 1
        disc = b_val**2 - 4*a_val*c_val
        sol1 = (-b_val + sqrt(disc)) / (2*a_val)
        sol2 = (-b_val - sqrt(disc)) / (2*a_val)
        ans = FiniteSet(sol1, sol2)

        return problem(
            question=f"Solve using the quadratic formula: ${a_val}x^2 + {b_val}x + {c_val} = 0$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"$\\Delta = ({b_val})^2 - 4({a_val})({c_val}) = {disc} < 0$",
                f"Since $\\Delta < 0$, the roots are complex (imaginary)",
                f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc))}}}{{{2*a_val}}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Word problem requiring setup
        d_val = randint(1, 6)
        area = randint(12, 60)
        # x(x + d) = area → x^2 + d*x - area = 0
        equation = x**2 + d_val*x - area
        sols = solve(equation, x)
        pos_sols = [s for s in sols if s > 0]
        if not pos_sols:
            d_val = 2
            area = 24
            equation = x**2 + d_val*x - area
            sols = solve(equation, x)
            pos_sols = [s for s in sols if s > 0]
        ans = pos_sols[0]
        disc = d_val**2 + 4*area

        return problem(
            question=f"A rectangle has length $x$ meters and width $(x - {d_val})$ meters. If its area is ${area}$ square meters, find the length $x$. Use the quadratic formula.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"Area: $x(x-{d_val}) = {area}$",
                f"$x^2 - {d_val}x - {area} = 0$",
                f"$\\Delta = {d_val}^2 + 4({area}) = {disc}$",
                f"$x = \\frac{{{d_val} \\pm \\sqrt{{{disc}}}}}{{2}}$",
                f"Taking positive value: $x = {latex(ans)}$ m"
            ),
            calculator="scientific"
        )

    elif problem_type == 5:
        # Non-monic with irrational roots (broad coefficient range)
        a_val = choice([2, 3, 4, 5])
        b_val = randint(-10, 10)
        c_val = randint(-20, 20)
        if c_val == 0:
            c_val = 1
        disc = b_val**2 - 4*a_val*c_val
        # Try a few times to get non-perfect-square discriminant
        for _ in range(10):
            if disc > 0 and not sqrt(disc).is_Integer:
                break
            b_val = randint(-10, 10)
            c_val = randint(-15, 15)
            if c_val == 0:
                c_val = 1
            disc = b_val**2 - 4*a_val*c_val

        sols = solve(a_val*x**2 + b_val*x + c_val, x)
        ans = FiniteSet(*sols) if sols else FiniteSet()

        return problem(
            question=f"Solve: ${a_val}x^2 + {b_val}x + {c_val} = 0$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"$\\Delta = ({b_val})^2 - 4({a_val})({c_val}) = {disc}$",
                f"$x = \\frac{{-({b_val}) \\pm \\sqrt{{{disc}}}}}{{2({a_val})}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # Fractional coefficient quadratic
        a_val = choice([2, 3, 4])
        b_val = nonzero(-8, 8)
        c_val = nonzero(-6, 6)
        equation = Rational(1, a_val)*x**2 + b_val*x + c_val
        sols = solve(equation, x)
        ans = FiniteSet(*sols)
        a_frac = Rational(1, a_val)
        discriminant = b_val**2 - 4*a_frac*c_val

        return problem(
            question=f"Solve: ${latex(equation)} = 0$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a=\\frac{{1}}{{{a_val}}}$, $b={b_val}$, $c={c_val}$",
                f"$\\Delta = ({b_val})^2 - 4\\cdot\\frac{{1}}{{{a_val}}}\\cdot({c_val}) = {latex(discriminant)}$",
                f"$x = \\frac{{-{b_val} \\pm {latex(sqrt(discriminant))}}}{{2/({a_val})}} = \\frac{{-{b_val} \\pm {latex(sqrt(discriminant))}}}{{\\frac{{2}}{{{a_val}}}}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
