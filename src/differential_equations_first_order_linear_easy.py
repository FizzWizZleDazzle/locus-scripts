"""
differential_equations - first_order_linear (easy)
Generated: 2026-02-22T05:20:01.222580
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: dy/dx + P(x)y = 0 (separable, simplest form)
        # Answer will be y = C*e^(-Px)
        coeff = nonzero(-3, 3)
        
        # Create the differential equation: dy/dx + coeff*y = 0
        question = f"\\frac{{dy}}{{dx}} + {latex(coeff*y)} = 0"
        
        # Solution is y = C*e^(-coeff*x)
        C = symbols('C')
        ans = C * exp(-coeff * x)
        
        return problem(
            question=f"Solve the differential equation: ${question}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"This is a separable equation. Rewrite as $\\frac{{dy}}{{y}} = {latex(-coeff)} dx$",
                f"Integrate both sides: $\\ln|y| = {latex(-coeff*x)} + C_1$",
                f"Exponentiate: $y = e^{{{latex(-coeff*x)} + C_1}} = Ce^{{{latex(-coeff*x)}}}$",
                f"General solution: $y = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: dy/dx + ay = b (constant coefficients)
        # Answer will be y = b/a + C*e^(-ax)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-5, 5)
        
        question = f"\\frac{{dy}}{{dx}} + {latex(a_val*y)} = {b_val}"
        
        C = symbols('C')
        ans = Rational(b_val, a_val) + C * exp(-a_val * x)
        
        return problem(
            question=f"Solve the differential equation: ${question}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"This is a first-order linear equation with constant coefficients",
                f"The homogeneous solution is $y_h = Ce^{{{latex(-a_val*x)}}}$",
                f"The particular solution is constant: $y_p = {latex(Rational(b_val, a_val))}$",
                f"General solution: $y = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: dy/dx = ky (exponential growth/decay)
        k_val = nonzero(-4, 4)
        
        question = f"\\frac{{dy}}{{dx}} = {latex(k_val*y)}"
        
        C = symbols('C')
        ans = C * exp(k_val * x)
        
        return problem(
            question=f"Solve the differential equation: ${question}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"This is a separable equation. Rewrite as $\\frac{{dy}}{{y}} = {k_val} dx$",
                f"Integrate both sides: $\\ln|y| = {latex(k_val*x)} + C_1$",
                f"Exponentiate: $y = e^{{{latex(k_val*x)} + C_1}} = Ce^{{{latex(k_val*x)}}}$",
                f"General solution: $y = {latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: dy/dx + y = simple function (like x or constant)
        func_type = choice(['constant', 'linear'])
        
        if func_type == 'constant':
            const = nonzero(-5, 5)
            question = f"\\frac{{dy}}{{dx}} + y = {const}"
            
            C = symbols('C')
            ans = const + C * exp(-x)
            
            return problem(
                question=f"Solve the differential equation: ${question}$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="differential_equations/first_order_linear",
                solution=steps(
                    f"This is a first-order linear equation: $\\frac{{dy}}{{dx}} + y = {const}$",
                    f"Integrating factor: $\\mu(x) = e^{{\\int 1 dx}} = e^x$",
                    f"Multiply both sides by $e^x$: $e^x\\frac{{dy}}{{dx}} + e^x y = {const}e^x$",
                    f"Left side is $\\frac{{d}}{{dx}}[e^x y] = {const}e^x$",
                    f"Integrate: $e^x y = {const}e^x + C$",
                    f"General solution: $y = {const} + Ce^{{-x}}$"
                ),
            )
        else:
            question = f"\\frac{{dy}}{{dx}} + y = x"
            
            C = symbols('C')
            ans = x - 1 + C * exp(-x)
            
            return problem(
                question=f"Solve the differential equation: ${question}$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="differential_equations/first_order_linear",
                solution=steps(
                    f"This is a first-order linear equation: $\\frac{{dy}}{{dx}} + y = x$",
                    f"Integrating factor: $\\mu(x) = e^{{\\int 1 dx}} = e^x$",
                    f"Multiply both sides by $e^x$: $\\frac{{d}}{{dx}}[e^x y] = xe^x$",
                    f"Integrate using integration by parts: $e^x y = xe^x - e^x + C$",
                    f"General solution: $y = x - 1 + Ce^{{-x}}$"
                ),
            )

emit(generate())