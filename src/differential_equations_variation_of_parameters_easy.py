"""
differential_equations - variation_of_parameters (easy)
Generated: 2026-02-22T05:28:46.441851
"""

from problem_utils import *

def generate():
    # For variation of parameters at 1000-1300 ELO, we want the simplest cases:
    # - First-order linear ODEs with constant coefficients
    # - Simplest possible particular solutions
    # - Minimal computation required
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Type 1: y' + ay = g(x) where g(x) is a simple polynomial
        # and the homogeneous solution is straightforward
        a_coeff = choice([1, 2])
        const = choice([1, 2, 3, 4, 6])
        
        # The ODE is y' + a*y = const
        # Homogeneous solution: y_h = C*e^(-a*x)
        # For variation of parameters: y_p = u(x)*e^(-a*x)
        # u'(x) = const*e^(a*x)
        # u(x) = (const/a)*e^(a*x)
        # y_p = (const/a)*e^(-a*x)*e^(a*x) = const/a
        
        particular = Rational(const, a_coeff)
        
        return problem(
            question=f"Find the particular solution to $y' + {a_coeff}y = {const}$ using variation of parameters.",
            answer=particular,
            difficulty=(1000, 1200),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"The homogeneous solution is $y_h = Ce^{{-{a_coeff}x}}$",
                f"For variation of parameters, let $y_p = u(x)e^{{-{a_coeff}x}}$",
                f"Then $y_p' = u'e^{{-{a_coeff}x}} - {a_coeff}ue^{{-{a_coeff}x}}$",
                f"Substituting: $u'e^{{-{a_coeff}x}} - {a_coeff}ue^{{-{a_coeff}x}} + {a_coeff}ue^{{-{a_coeff}x}} = {const}$",
                f"Simplifying: $u'e^{{-{a_coeff}x}} = {const}$",
                f"So $u' = {const}e^{{{a_coeff}x}}$",
                f"Integrating: $u = {latex(Rational(const, a_coeff))}e^{{{a_coeff}x}}$",
                f"Therefore $y_p = {latex(Rational(const, a_coeff))}e^{{{a_coeff}x}} \\cdot e^{{-{a_coeff}x}} = {latex(particular)}$"
            ),
            grading_mode="equivalent"
        )
    
    elif problem_type == 2:
        # Type 2: y' - ay = g(x) with simple exponential on right side
        a_coeff = choice([1, 2])
        const = choice([1, 2, 3])
        
        # The ODE is y' - a*y = const*e^(a*x)
        # Homogeneous solution: y_h = C*e^(a*x)
        # For variation of parameters: y_p = u(x)*e^(a*x)
        # u'(x) = const
        # u(x) = const*x
        # y_p = const*x*e^(a*x)
        
        particular = const * x * exp(a_coeff * x)
        
        return problem(
            question=f"Find the particular solution to $y' - {a_coeff}y = {const}e^{{{a_coeff}x}}$ using variation of parameters.",
            answer=particular,
            difficulty=(1100, 1300),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"The homogeneous solution is $y_h = Ce^{{{a_coeff}x}}$",
                f"For variation of parameters, let $y_p = u(x)e^{{{a_coeff}x}}$",
                f"Then $y_p' = u'e^{{{a_coeff}x}} + {a_coeff}ue^{{{a_coeff}x}}$",
                f"Substituting: $u'e^{{{a_coeff}x}} + {a_coeff}ue^{{{a_coeff}x}} - {a_coeff}ue^{{{a_coeff}x}} = {const}e^{{{a_coeff}x}}$",
                f"Simplifying: $u'e^{{{a_coeff}x}} = {const}e^{{{a_coeff}x}}$",
                f"So $u' = {const}$",
                f"Integrating: $u = {const}x$",
                f"Therefore $y_p = {latex(particular)}$"
            ),
            grading_mode="equivalent"
        )
    
    else:
        # Type 3: y' + y = simple function (easiest case with a=1)
        const = choice([2, 3, 4, 5])
        
        # The ODE is y' + y = const
        # Homogeneous solution: y_h = C*e^(-x)
        # Particular solution: y_p = const
        
        particular = const
        
        return problem(
            question=f"Find the particular solution to $y' + y = {const}$ using variation of parameters.",
            answer=particular,
            difficulty=(1000, 1100),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"The homogeneous solution is $y_h = Ce^{{-x}}$",
                f"For variation of parameters, let $y_p = u(x)e^{{-x}}$",
                f"Then $y_p' = u'e^{{-x}} - ue^{{-x}}$",
                f"Substituting: $u'e^{{-x}} - ue^{{-x}} + ue^{{-x}} = {const}$",
                f"Simplifying: $u'e^{{-x}} = {const}$",
                f"So $u' = {const}e^x$",
                f"Integrating: $u = {const}e^x$",
                f"Therefore $y_p = {const}e^x \\cdot e^{{-x}} = {const}$"
            ),
            grading_mode="equivalent"
        )

emit(generate())