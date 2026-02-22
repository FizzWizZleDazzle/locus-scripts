"""
multivariable_calculus - gradient (easy)
Generated: 2026-02-22T05:34:48.025402
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Gradient of a simple polynomial f(x,y) = ax^n + by^m
        # ELO ~1000-1100: Direct application of gradient definition
        a_coeff = nonzero(-5, 5)
        b_coeff = nonzero(-5, 5)
        n_exp = randint(2, 3)
        m_exp = randint(2, 3)
        
        f = a_coeff * x**n_exp + b_coeff * y**m_exp
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        ans = Matrix([grad_x, grad_y])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"The gradient is $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(grad_x)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(grad_y)}$",
                f"$\\nabla f = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Gradient of f(x,y) = ax + by + c (linear function)
        # ELO ~1000-1050: Simplest possible - constant gradient
        a_coeff = nonzero(-8, 8)
        b_coeff = nonzero(-8, 8)
        c_const = randint(-10, 10)
        
        f = a_coeff * x + b_coeff * y + c_const
        
        grad_x = a_coeff
        grad_y = b_coeff
        
        ans = Matrix([grad_x, grad_y])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1000, 1050),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"The gradient is $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {grad_x}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {grad_y}$",
                f"$\\nabla f = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Evaluate gradient at a point
        # ELO ~1100-1250: Two-step (compute gradient, then evaluate)
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        
        f = a_coeff * x**2 + b_coeff * y**2
        
        x_val = nonzero(-3, 3)
        y_val = nonzero(-3, 3)
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        grad_x_at_point = grad_x.subs([(x, x_val), (y, y_val)])
        grad_y_at_point = grad_y.subs([(x, x_val), (y, y_val)])
        
        ans = Matrix([grad_x_at_point, grad_y_at_point])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$ at the point $({x_val}, {y_val})$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"First find the gradient: $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(grad_x)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(grad_y)}$",
                f"Now evaluate at $({x_val}, {y_val})$:",
                f"$\\frac{{\\partial f}}{{\\partial x}}\\bigg|_{{({x_val},{y_val})}} = {latex(grad_x_at_point)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}}\\bigg|_{{({x_val},{y_val})}} = {latex(grad_y_at_point)}$",
                f"$\\nabla f({x_val}, {y_val}) = {latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: Gradient with mixed terms xy
        # ELO ~1200-1300: Slightly more complex partial derivatives
        a_coeff = nonzero(-5, 5)
        b_coeff = nonzero(-5, 5)
        c_coeff = nonzero(-5, 5)
        
        f = a_coeff * x * y + b_coeff * x + c_coeff * y
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        ans = Matrix([grad_x, grad_y])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"The gradient is $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(grad_x)}$ (treat $y$ as constant)",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(grad_y)}$ (treat $x$ as constant)",
                f"$\\nabla f = {latex(ans)}$"
            ),
        )

emit(generate())