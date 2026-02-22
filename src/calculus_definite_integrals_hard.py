"""
calculus - definite_integrals (hard)
Generated: 2026-02-22T05:15:20.515827
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Integration by parts
        funcs = [
            (x * exp(x), "x e^x"),
            (x * sin(x), "x \\sin(x)"),
            (x * cos(x), "x \\cos(x)"),
            (x**2 * exp(x), "x^2 e^x"),
            (x * log(x), "x \\ln(x)")
        ]
        func, func_latex = choice(funcs)
        a_val = randint(1, 3)
        b_val = a_val + randint(2, 4)
        
        ans = integrate(func, (x, a_val, b_val))
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {func_latex} \\, dx",
            answer=ans_simplified,
            difficulty=(1650, 1850),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Use integration by parts: $\\int u \\, dv = uv - \\int v \\, du$",
                f"Evaluate the antiderivative from ${a_val}$ to ${b_val}$",
                f"Answer: ${latex(ans_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Trigonometric substitution or complex trig integral
        power = randint(2, 3)
        a_val = 0
        b_val = choice([pi/6, pi/4, pi/3, pi/2])
        
        if power == 2:
            func = sin(x)**2
            func_latex = "\\sin^2(x)"
        else:
            func = sin(x)**3
            func_latex = "\\sin^3(x)"
        
        ans = integrate(func, (x, a_val, b_val))
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"\\int_{{0}}^{{{latex(b_val)}}} {func_latex} \\, dx",
            answer=ans_simplified,
            difficulty=(1700, 1850),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Use power-reduction formula or substitution",
                f"For $\\sin^{power}(x)$, apply appropriate trigonometric identities",
                f"Evaluate from $0$ to ${latex(b_val)}$",
                f"Answer: ${latex(ans_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # U-substitution with composition
        inner_coeff = nonzero(-3, 3)
        inner_const = nonzero(-4, 4)
        power = randint(2, 4)
        
        inner = inner_coeff * x + inner_const
        func = inner**power
        
        a_val = randint(0, 2)
        b_val = a_val + randint(2, 4)
        
        ans = integrate(func, (x, a_val, b_val))
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(func)} \\, dx",
            answer=ans_simplified,
            difficulty=(1600, 1750),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Let $u = {latex(inner)}$, so $du = {latex(inner_coeff)} \\, dx$",
                f"Change limits: when $x={a_val}$, $u={inner.subs(x, a_val)}$; when $x={b_val}$, $u={inner.subs(x, b_val)}$",
                f"Evaluate the integral with substitution",
                f"Answer: ${latex(ans_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Rational function requiring partial fractions
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)
        
        numerator_const = nonzero(-5, 5)
        denom = (x - r1) * (x - r2)
        func = numerator_const / denom
        
        a_val = max(r1, r2) + 1
        b_val = a_val + randint(2, 3)
        
        ans = integrate(func, (x, a_val, b_val))
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} \\frac{{{numerator_const}}}{{{latex(expand(denom))}}} \\, dx",
            answer=ans_simplified,
            difficulty=(1700, 1900),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Factor denominator: ${latex(denom)}$",
                f"Use partial fraction decomposition",
                f"Integrate each term (results in logarithms)",
                f"Evaluate from ${a_val}$ to ${b_val}$",
                f"Answer: ${latex(ans_simplified)}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Exponential with linear argument
        coeff = nonzero(-3, 3)
        linear_coeff = nonzero(-2, 2)
        const = nonzero(-3, 3)
        
        func = coeff * exp(linear_coeff * x + const)
        
        a_val = randint(0, 2)
        b_val = a_val + randint(1, 3)
        
        ans = integrate(func, (x, a_val, b_val))
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(func)} \\, dx",
            answer=ans_simplified,
            difficulty=(1650, 1800),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Let $u = {latex(linear_coeff * x + const)}$, so $du = {latex(linear_coeff)} \\, dx$",
                f"Rewrite: $\\int {latex(coeff / linear_coeff)} e^u \\, du$",
                f"Evaluate from ${a_val}$ to ${b_val}$",
                f"Answer: ${latex(ans_simplified)}$"
            ),
            calculator="scientific"
        )

emit(generate())