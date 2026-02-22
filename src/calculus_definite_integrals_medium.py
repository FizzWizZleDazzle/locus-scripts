"""
calculus - definite_integrals (medium)
Generated: 2026-02-22T05:14:57.561822
"""

from problem_utils import *

def generate():
    problem_type = choice(['polynomial', 'trig', 'exponential', 'rational'])
    
    if problem_type == 'polynomial':
        # ∫[a to b] (cx^n + d) dx for standard polynomials
        n = randint(2, 4)
        coeff = nonzero(-5, 5)
        const = randint(-10, 10)
        a_val = randint(-3, 2)
        b_val = randint(a_val + 1, a_val + 4)
        
        expr = coeff * x**n + const
        antideriv = coeff * x**(n+1) / (n+1) + const * x
        
        upper = antideriv.subs(x, b_val)
        lower = antideriv.subs(x, a_val)
        ans = simplify(upper - lower)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} \\left({latex(expr)}\\right) dx",
            answer=ans,
            difficulty=(1300, 1450),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Find antiderivative: ${latex(antideriv)}$",
                f"Evaluate at bounds: $\\left[{latex(antideriv)}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"Upper bound: ${latex(upper)}$",
                f"Lower bound: ${latex(lower)}$",
                f"Result: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 'trig':
        # ∫[a to b] sin(x) or cos(x) dx
        func = choice([sin, cos])
        coeff = nonzero(-4, 4)
        
        # Use nice bounds like 0, π/2, π
        bound_choices = [0, Rational(1,2), 1, Rational(3,2), 2]
        a_idx = randint(0, len(bound_choices) - 2)
        b_idx = randint(a_idx + 1, len(bound_choices) - 1)
        a_val = bound_choices[a_idx] * pi
        b_val = bound_choices[b_idx] * pi
        
        expr = coeff * func(x)
        
        if func == sin:
            antideriv = -coeff * cos(x)
        else:  # cos
            antideriv = coeff * sin(x)
        
        upper = antideriv.subs(x, b_val)
        lower = antideriv.subs(x, a_val)
        ans = simplify(upper - lower)
        
        return problem(
            question=f"\\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1350, 1500),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Antiderivative of ${latex(expr)}$ is ${latex(antideriv)}$",
                f"Evaluate: $\\left[{latex(antideriv)}\\right]_{{{latex(a_val)}}}^{{{latex(b_val)}}}$",
                f"${latex(upper)} - ({latex(lower)}) = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'exponential':
        # ∫[a to b] e^x dx
        coeff = nonzero(-3, 3)
        a_val = randint(-2, 1)
        b_val = randint(a_val + 1, a_val + 3)
        
        expr = coeff * exp(x)
        antideriv = coeff * exp(x)
        
        upper = antideriv.subs(x, b_val)
        lower = antideriv.subs(x, a_val)
        ans = simplify(upper - lower)
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1300, 1450),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Antiderivative of ${latex(expr)}$ is ${latex(antideriv)}$",
                f"Evaluate at bounds: ${latex(upper)} - {latex(lower)}$",
                f"Result: ${latex(ans)}$"
            ),
        )
    
    else:  # rational - simple 1/x
        # ∫[a to b] k/x dx = k ln|x| evaluated
        coeff = nonzero(-4, 4)
        a_val = randint(1, 3)
        b_val = randint(a_val + 1, a_val + 4)
        
        expr = coeff / x
        
        ans = coeff * (log(b_val) - log(a_val))
        ans_simplified = coeff * log(Rational(b_val, a_val))
        
        return problem(
            question=f"\\int_{{{a_val}}}^{{{b_val}}} {latex(expr)} \\, dx",
            answer=ans_simplified,
            difficulty=(1400, 1550),
            topic="calculus/definite_integrals",
            solution=steps(
                f"Antiderivative of ${latex(expr)}$ is ${coeff}\\ln|x|$",
                f"Evaluate: ${coeff}\\ln({b_val}) - {coeff}\\ln({a_val})$",
                f"Simplify: ${latex(ans_simplified)}$"
            ),
        )

emit(generate())