"""
differential_equations - first_order_linear (medium)
Generated: 2026-02-22T05:20:21.432875
"""

from problem_utils import *

def generate():
    problem_type = choice(['standard_form', 'integrating_factor', 'initial_value'])
    
    if problem_type == 'standard_form':
        # dy/dx + P(x)y = Q(x), solve for y
        # Choose simple P(x) and Q(x)
        p_coeff = nonzero(-5, 5)
        q_const = nonzero(-8, 8)
        
        # The equation: dy/dx + p_coeff*y = q_const
        # Solution: y = q_const/p_coeff + C*e^(-p_coeff*x)
        
        C = symbols('C')
        ans = Rational(q_const, p_coeff) + C * exp(-p_coeff * x)
        
        return problem(
            question=f"Solve the first-order linear differential equation: $\\frac{{dy}}{{dx}} + {p_coeff}y = {q_const}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"This is a first-order linear ODE in standard form: $\\frac{{dy}}{{dx}} + P(x)y = Q(x)$",
                f"Here, $P(x) = {p_coeff}$ and $Q(x) = {q_const}$",
                f"The integrating factor is $\\mu(x) = e^{{\\int {p_coeff} dx}} = e^{{{p_coeff}x}}$",
                f"Multiply both sides by the integrating factor: $e^{{{p_coeff}x}}\\frac{{dy}}{{dx}} + {p_coeff}e^{{{p_coeff}x}}y = {q_const}e^{{{p_coeff}x}}$",
                f"The left side is $\\frac{{d}}{{dx}}[e^{{{p_coeff}x}}y]$",
                f"Integrate both sides: $e^{{{p_coeff}x}}y = \\int {q_const}e^{{{p_coeff}x}} dx = {latex(Rational(q_const, p_coeff))}e^{{{p_coeff}x}} + C$",
                f"Solve for $y$: $y = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'integrating_factor':
        # dy/dx + P(x)y = 0 (homogeneous)
        p_coeff = nonzero(-4, 4)
        
        C = symbols('C')
        ans = C * exp(-p_coeff * x)
        
        return problem(
            question=f"Solve the homogeneous first-order linear differential equation: $\\frac{{dy}}{{dx}} + {p_coeff}y = 0$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"This is a separable equation. Rewrite as: $\\frac{{dy}}{{dx}} = -{p_coeff}y$",
                f"Separate variables: $\\frac{{dy}}{{y}} = -{p_coeff} dx$",
                f"Integrate both sides: $\\ln|y| = -{p_coeff}x + C_1$",
                f"Exponentiate: $|y| = e^{{-{p_coeff}x + C_1}} = e^{{C_1}}e^{{-{p_coeff}x}}$",
                f"Let $C = \\pm e^{{C_1}}$, so $y = {latex(ans)}$"
            ),
        )
    
    else:  # initial_value
        # dy/dx + P(x)y = Q(x) with initial condition
        p_coeff = choice([1, 2, 3])
        q_const = nonzero(-6, 6)
        x0 = 0
        y0 = nonzero(-5, 5)
        
        # General solution: y = q_const/p_coeff + C*e^(-p_coeff*x)
        # Apply initial condition: y0 = q_const/p_coeff + C*e^0
        # C = y0 - q_const/p_coeff
        C_val = y0 - Rational(q_const, p_coeff)
        
        ans = Rational(q_const, p_coeff) + C_val * exp(-p_coeff * x)
        
        return problem(
            question=f"Solve the initial value problem: $\\frac{{dy}}{{dx}} + {p_coeff}y = {q_const}$, $y(0) = {y0}$",
            answer=ans,
            difficulty=(1450, 1600),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"First solve the general equation: $\\frac{{dy}}{{dx}} + {p_coeff}y = {q_const}$",
                f"Integrating factor: $\\mu(x) = e^{{{p_coeff}x}}$",
                f"Multiply by integrating factor and integrate: $e^{{{p_coeff}x}}y = {latex(Rational(q_const, p_coeff))}e^{{{p_coeff}x}} + C$",
                f"General solution: $y = {latex(Rational(q_const, p_coeff) + symbols('C') * exp(-p_coeff * x))}$",
                f"Apply initial condition $y(0) = {y0}$: ${y0} = {latex(Rational(q_const, p_coeff))} + C$",
                f"Solve for $C$: $C = {latex(C_val)}$",
                f"Particular solution: $y = {latex(ans)}$"
            ),
        )

emit(generate())