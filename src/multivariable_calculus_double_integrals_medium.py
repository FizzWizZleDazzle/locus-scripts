"""
multivariable_calculus - double_integrals (medium)
Generated: 2026-02-22T05:39:16.852138
"""

from problem_utils import *

def generate():
    problem_type = choice(['rectangular', 'triangular', 'order_of_integration'])
    
    if problem_type == 'rectangular':
        # Double integral over a rectangular region
        # Choose simple polynomial integrand
        a_val = randint(0, 3)
        b_val = randint(1, 4)
        c_val = randint(0, 3)
        d_val = randint(1, 4)
        
        # Build integrand (polynomial in x and y)
        power_x = randint(1, 3)
        power_y = randint(1, 3)
        coeff = nonzero(-4, 4)
        
        integrand = coeff * x**power_x * y**power_y
        
        # Integrate with respect to y first, then x
        inner_integral = integrate(integrand, (y, c_val, d_val))
        outer_integral = integrate(inner_integral, (x, a_val, b_val))
        
        ans = outer_integral
        
        question = f"\\int_{{{a_val}}}^{{{b_val}}} \\int_{{{c_val}}}^{{{d_val}}} {latex(integrand)} \\, dy \\, dx"
        
        solution_steps = steps(
            f"First integrate with respect to $y$: $\\int_{{{c_val}}}^{{{d_val}}} {latex(integrand)} \\, dy$",
            f"$= \\left[{latex(integrate(integrand, y))}\\right]_{{{c_val}}}^{{{d_val}}}$",
            f"$= {latex(inner_integral)}$",
            f"Now integrate with respect to $x$: $\\int_{{{a_val}}}^{{{b_val}}} {latex(inner_integral)} \\, dx$",
            f"$= \\left[{latex(integrate(inner_integral, x))}\\right]_{{{a_val}}}^{{{b_val}}}$",
            f"$= {latex(ans)}$"
        )
        
        difficulty_val = (1300, 1450)
        
    elif problem_type == 'triangular':
        # Double integral over a triangular region
        # Region: 0 <= x <= a, 0 <= y <= mx (or similar)
        a_val = randint(1, 3)
        m_val = randint(1, 3)
        
        # Simple integrand
        if choice([True, False]):
            integrand = x + y
            desc = "x + y"
        else:
            coeff = nonzero(-3, 3)
            integrand = coeff * x * y
            desc = latex(integrand)
        
        # Integrate: ∫₀ᵃ ∫₀^(mx) f(x,y) dy dx
        inner_integral = integrate(integrand, (y, 0, m_val * x))
        outer_integral = integrate(inner_integral, (x, 0, a_val))
        
        ans = outer_integral
        
        question = f"\\int_{{0}}^{{{a_val}}} \\int_{{0}}^{{{m_val}x}} {desc} \\, dy \\, dx"
        
        solution_steps = steps(
            f"First integrate with respect to $y$: $\\int_{{0}}^{{{m_val}x}} {desc} \\, dy$",
            f"$= \\left[{latex(integrate(integrand, y))}\\right]_{{0}}^{{{m_val}x}}$",
            f"$= {latex(inner_integral)}$",
            f"Now integrate with respect to $x$: $\\int_{{0}}^{{{a_val}}} {latex(inner_integral)} \\, dx$",
            f"$= \\left[{latex(integrate(inner_integral, x))}\\right]_{{0}}^{{{a_val}}}$",
            f"$= {latex(ans)}$"
        )
        
        difficulty_val = (1400, 1550)
        
    else:  # order_of_integration
        # Given one order, ask to evaluate in the other order
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        
        # Simple integrand that's easy to integrate in either order
        integrand = x + y
        
        # Given: ∫∫ with y from 0 to b, x from 0 to a
        # We'll integrate in the given order
        inner_integral = integrate(integrand, (x, 0, a_val))
        outer_integral = integrate(inner_integral, (y, 0, b_val))
        
        ans = outer_integral
        
        question = f"\\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} (x + y) \\, dx \\, dy"
        
        solution_steps = steps(
            f"First integrate with respect to $x$: $\\int_{{0}}^{{{a_val}}} (x + y) \\, dx$",
            f"$= \\left[\\frac{{x^2}}{{2}} + xy\\right]_{{0}}^{{{a_val}}}$",
            f"$= {latex(inner_integral)}$",
            f"Now integrate with respect to $y$: $\\int_{{0}}^{{{b_val}}} {latex(inner_integral)} \\, dy$",
            f"$= \\left[{latex(integrate(inner_integral, y))}\\right]_{{0}}^{{{b_val}}}$",
            f"$= {latex(ans)}$"
        )
        
        difficulty_val = (1300, 1450)
    
    return problem(
        question=f"Evaluate: ${question}$",
        answer=ans,
        difficulty=difficulty_val,
        topic="multivariable_calculus/double_integrals",
        solution=solution_steps,
        answer_type="numeric"
    )

emit(generate())