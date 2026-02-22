"""
calculus - definite_integrals (easy)
Generated: 2026-02-22T05:14:38.454846
"""

from problem_utils import *

def generate():
    # Choose a random problem type for easier definite integrals (1000-1300 ELO)
    problem_type = choice([
        'constant',
        'power_rule_simple',
        'power_rule_with_coeff',
        'sum_of_powers',
        'simple_trig'
    ])
    
    if problem_type == 'constant':
        # Integral of a constant: ∫[a to b] c dx = c(b-a)
        # ELO ~1000-1100
        const = nonzero(-5, 5)
        a_val = randint(0, 5)
        b_val = randint(a_val + 1, a_val + 5)
        
        ans = const * (b_val - a_val)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(const)} \\, dx",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/definite_integrals",
            solution=steps(
                f"The integral of a constant ${latex(const)}$ is ${latex(const)}x$",
                f"Evaluate: ${latex(const)}x \\Big|_{{{a_val}}}^{{{b_val}}} = {latex(const)}({b_val}) - {latex(const)}({a_val})$",
                f"$= {const * b_val} - {const * a_val} = {ans}$"
            ),
        )
    
    elif problem_type == 'power_rule_simple':
        # Simple power rule: ∫[a to b] x^n dx
        # ELO ~1100-1200
        n = randint(1, 3)
        a_val = randint(0, 3)
        b_val = randint(a_val + 1, a_val + 3)
        
        # Compute antiderivative: x^(n+1)/(n+1)
        antideriv = x**(n+1) / (n+1)
        ans = antideriv.subs(x, b_val) - antideriv.subs(x, a_val)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(x**n)} \\, dx",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Apply the power rule: $\\int x^{{{n}}} \\, dx = \\frac{{x^{{{n+1}}}}}{{{n+1}}}$",
                f"Evaluate: $\\frac{{x^{{{n+1}}}}}{{{n+1}}} \\Big|_{{{a_val}}}^{{{b_val}}} = \\frac{{{b_val}^{{{n+1}}}}}{{{n+1}}} - \\frac{{{a_val}^{{{n+1}}}}}{{{n+1}}}$",
                f"$= {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'power_rule_with_coeff':
        # Power rule with coefficient: ∫[a to b] c*x^n dx
        # ELO ~1150-1250
        coeff = nonzero(-4, 4)
        n = randint(1, 2)
        a_val = randint(0, 2)
        b_val = randint(a_val + 1, a_val + 3)
        
        expr = coeff * x**n
        antideriv = coeff * x**(n+1) / (n+1)
        ans = antideriv.subs(x, b_val) - antideriv.subs(x, a_val)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1150, 1250),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Apply the power rule: $\\int {latex(expr)} \\, dx = {latex(antideriv)}$",
                f"Evaluate: ${latex(antideriv)} \\Big|_{{{a_val}}}^{{{b_val}}}$",
                f"$= {latex(antideriv.subs(x, b_val))} - {latex(antideriv.subs(x, a_val))} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'sum_of_powers':
        # Sum of two terms: ∫[a to b] (c1*x^n1 + c2*x^n2) dx
        # ELO ~1200-1300
        c1 = nonzero(-3, 3)
        c2 = nonzero(-3, 3)
        n1 = randint(1, 2)
        n2 = choice([i for i in range(0, 3) if i != n1])
        
        a_val = randint(0, 2)
        b_val = randint(a_val + 1, a_val + 2)
        
        if n2 == 0:
            expr = c1 * x**n1 + c2
            antideriv = c1 * x**(n1+1) / (n1+1) + c2 * x
        else:
            expr = c1 * x**n1 + c2 * x**n2
            antideriv = c1 * x**(n1+1) / (n1+1) + c2 * x**(n2+1) / (n2+1)
        
        ans = antideriv.subs(x, b_val) - antideriv.subs(x, a_val)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} \\left({latex(expr)}\\right) \\, dx",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Integrate term by term: $\\int \\left({latex(expr)}\\right) \\, dx = {latex(antideriv)}$",
                f"Evaluate: ${latex(antideriv)} \\Big|_{{{a_val}}}^{{{b_val}}}$",
                f"$= {latex(antideriv.subs(x, b_val))} - {latex(antideriv.subs(x, a_val))} = {latex(ans)}$"
            ),
        )
    
    else:  # simple_trig
        # Simple trig integral with nice bounds
        # ELO ~1200-1300
        trig_type = choice(['sin', 'cos'])
        
        if trig_type == 'sin':
            # ∫ sin(x) dx = -cos(x)
            a_val = 0
            b_val = choice([pi/2, pi])
            expr = sin(x)
            antideriv = -cos(x)
        else:  # cos
            # ∫ cos(x) dx = sin(x)
            a_val = 0
            b_val = choice([pi/2, pi])
            expr = cos(x)
            antideriv = sin(x)
        
        ans = simplify(antideriv.subs(x, b_val) - antideriv.subs(x, a_val))
        
        return problem(
            question=f"\\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/definite_integrals",
            solution=steps(
                f"The antiderivative of ${latex(expr)}$ is ${latex(antideriv)}$",
                f"Evaluate: ${latex(antideriv)} \\Big|_{{{latex(a_val)}}}^{{{latex(b_val)}}}$",
                f"$= {latex(antideriv.subs(x, b_val))} - {latex(antideriv.subs(x, a_val))} = {latex(ans)}$"
            ),
        )

emit(generate())