"""
algebra1 - quadratic_formula (hard)
Generated: 2026-02-22T04:02:42.037205
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Quadratic with irrational solutions requiring simplification
        # e.g., x^2 + 4x - 3 = 0 -> x = -2 ± sqrt(7)
        p = nonzero(-5, 5)
        q = nonzero(2, 8)
        
        # Create equation x^2 + 2px + (p^2 - q) = 0
        # Solutions: x = -p ± sqrt(q)
        b_coeff = 2 * p
        c_coeff = p**2 - q
        
        equation = x**2 + b_coeff*x + c_coeff
        
        # Calculate discriminant
        discriminant = b_coeff**2 - 4*c_coeff
        
        sol1 = (-b_coeff + sqrt(discriminant)) / 2
        sol2 = (-b_coeff - sqrt(discriminant)) / 2
        
        ans = FiniteSet(sol1, sol2)
        
        return problem(
            question=f"Solve using the quadratic formula: ${latex(equation)} = 0$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"For ${latex(equation)} = 0$, we have $a=1$, $b={b_coeff}$, $c={c_coeff}$",
                f"Discriminant: $\\Delta = b^2 - 4ac = ({b_coeff})^2 - 4(1)({c_coeff}) = {discriminant}$",
                f"$x = \\frac{{-b \\pm \\sqrt{{\\Delta}}}}{{2a}} = \\frac{{-({b_coeff}) \\pm \\sqrt{{{discriminant}}}}}{{2}}$",
                f"$x = \\frac{{{-b_coeff} \\pm {latex(sqrt(discriminant))}}}{{2}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Equation requiring rearrangement to standard form
        # e.g., 2x^2 = 5x + 12
        a_val = nonzero(2, 4)
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r1 == r2:
            r2 = nonzero(-4, 4)
        
        # Expand a(x - r1)(x - r2)
        expanded = expand(a_val * (x - r1) * (x - r2))
        
        # Split into form: ax^2 = bx + c
        a_coeff = a_val
        b_coeff = -a_val * (r1 + r2)
        c_coeff = a_val * r1 * r2
        
        ans = FiniteSet(r1, r2)
        
        return problem(
            question=f"Solve using the quadratic formula: ${a_coeff}x^2 = {latex(-b_coeff*x - c_coeff)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"Rearrange to standard form: ${a_coeff}x^2 {b_coeff:+}x {c_coeff:+} = 0$",
                f"Here $a={a_coeff}$, $b={b_coeff}$, $c={c_coeff}$",
                f"$\\Delta = ({b_coeff})^2 - 4({a_coeff})({c_coeff}) = {b_coeff**2 - 4*a_coeff*c_coeff}$",
                f"$x = \\frac{{-{b_coeff} \\pm \\sqrt{{{b_coeff**2 - 4*a_coeff*c_coeff}}}}}{{2({a_coeff})}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Type 3: Quadratic with fractional coefficients
        a_val = choice([2, 3, 4])
        b_val = nonzero(-7, 7)
        c_val = nonzero(-5, 5)
        
        equation = Rational(1, a_val)*x**2 + b_val*x + c_val
        
        sols = solve(equation, x)
        ans = FiniteSet(*sols)
        
        a_frac = Rational(1, a_val)
        discriminant = b_val**2 - 4*a_frac*c_val
        
        return problem(
            question=f"Solve using the quadratic formula: ${latex(equation)} = 0$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"For ${latex(equation)} = 0$, we have $a=\\frac{{1}}{{{a_val}}}$, $b={b_val}$, $c={c_val}$",
                f"$\\Delta = ({b_val})^2 - 4\\left(\\frac{{1}}{{{a_val}}}\\right)({c_val}) = {latex(discriminant)}$",
                f"$x = \\frac{{-{b_val} \\pm \\sqrt{{{latex(discriminant)}}}}}{{2 \\cdot \\frac{{1}}{{{a_val}}}}}$",
                f"$x = \\frac{{-{b_val} \\pm {latex(sqrt(discriminant))}}}{{\\frac{{2}}{{{a_val}}}}}$",
                f"Solutions: ${latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Type 4: Word problem requiring setup and quadratic formula
        width = nonzero(3, 8)
        area = (width + nonzero(2, 6)) * width
        
        # Rectangle: length = x, width = x - d, area = A
        # x(x - d) = A
        # x^2 - dx - A = 0
        
        d = nonzero(2, 5)
        # Solve x(x - d) = area for x > 0
        # x^2 - dx - area = 0
        
        equation = x**2 - d*x - area
        sols = solve(equation, x)
        positive_sol = [s for s in sols if s > 0][0]
        
        return problem(
            question=f"A rectangle has length $x$ meters and width $(x - {d})$ meters. If its area is ${area}$ square meters, find the length. Use the quadratic formula.",
            answer=positive_sol,
            difficulty=(1750, 1850),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"Area = length × width: $x(x - {d}) = {area}$",
                f"Expand: $x^2 - {d}x = {area}$",
                f"Standard form: $x^2 - {d}x - {area} = 0$",
                f"$\\Delta = (-{d})^2 - 4(1)(-{area}) = {d**2 + 4*area}$",
                f"$x = \\frac{{{d} \\pm \\sqrt{{{d**2 + 4*area}}}}}{{2}}$",
                f"Taking the positive solution: $x = {latex(positive_sol)}$ meters"
            ),
            calculator="scientific"
        )
    
    else:
        # Type 5: Complex coefficient quadratic
        a_val = nonzero(2, 5)
        b_val = nonzero(-9, 9)
        c_val = nonzero(3, 12)
        
        # Make sure discriminant is not a perfect square for challenge
        discriminant = b_val**2 - 4*a_val*c_val
        while discriminant >= 0 and sqrt(discriminant).is_Integer:
            b_val = nonzero(-9, 9)
            c_val = nonzero(3, 12)
            discriminant = b_val**2 - 4*a_val*c_val
        
        equation = a_val*x**2 + b_val*x + c_val
        sols = solve(equation, x)
        
        if len(sols) == 0:
            ans = FiniteSet()
            solution_text = steps(
                f"For ${latex(equation)} = 0$, we have $a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"$\\Delta = ({b_val})^2 - 4({a_val})({c_val}) = {discriminant}$",
                f"Since $\\Delta < 0$, there are no real solutions"
            )
        else:
            ans = FiniteSet(*sols)
            solution_text = steps(
                f"For ${latex(equation)} = 0$, we have $a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"$\\Delta = ({b_val})^2 - 4({a_val})({c_val}) = {discriminant}$",
                f"$x = \\frac{{-{b_val} \\pm \\sqrt{{{discriminant}}}}}{{2({a_val})}}$",
                f"Solutions: ${latex(ans)}$"
            )
        
        return problem(
            question=f"Solve using the quadratic formula: ${latex(equation)} = 0$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/quadratic_formula",
            solution=solution_text,
            calculator="scientific"
        )

emit(generate())