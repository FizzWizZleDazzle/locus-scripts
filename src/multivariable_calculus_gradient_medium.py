"""
multivariable_calculus - gradient (medium)
Generated: 2026-02-22T05:35:11.704729
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Gradient of polynomial function (1300-1400)
        # Build a simple polynomial f(x,y)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        # f(x,y) = ax^2 + by^2 + cx + dy
        f = a*x**2 + b*y**2 + c*x + d*y
        
        # Compute gradient
        df_dx = diff(f, x)
        df_dy = diff(f, y)
        grad_f = Matrix([df_dx, df_dy])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$",
            answer=grad_f,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"The gradient is $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(df_dx)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(df_dy)}$",
                f"$\\nabla f = {latex(grad_f)}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Evaluate gradient at a point (1400-1500)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        # f(x,y) = ax^2 + bxy + cy^2
        f = a*x**2 + b*x*y + c*y**2
        
        # Pick evaluation point
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        # Compute gradient
        df_dx = diff(f, x)
        df_dy = diff(f, y)
        
        # Evaluate at point
        df_dx_val = df_dx.subs([(x, x0), (y, y0)])
        df_dy_val = df_dy.subs([(x, x0), (y, y0)])
        grad_at_point = Matrix([df_dx_val, df_dy_val])
        
        return problem(
            question=f"Find $\\nabla f({x0}, {y0})$ where $f(x,y) = {latex(f)}$",
            answer=grad_at_point,
            difficulty=(1400, 1500),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"First find the gradient: $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(df_dx)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(df_dy)}$",
                f"Evaluate at $({x0}, {y0})$:",
                f"$\\frac{{\\partial f}}{{\\partial x}}\\bigg|_{{({x0},{y0})}} = {latex(df_dx_val)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}}\\bigg|_{{({x0},{y0})}} = {latex(df_dy_val)}$",
                f"$\\nabla f({x0}, {y0}) = {latex(grad_at_point)}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Gradient with trigonometric/exponential functions (1500-1600)
        trig_choice = randint(1, 2)
        
        if trig_choice == 1:
            # f(x,y) = sin(ax) + cos(by)
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            f = sin(a*x) + cos(b*y)
            
            df_dx = diff(f, x)
            df_dy = diff(f, y)
            grad_f = Matrix([df_dx, df_dy])
            
            return problem(
                question=f"Find the gradient of $f(x,y) = {latex(f)}$",
                answer=grad_f,
                difficulty=(1500, 1600),
                topic="multivariable_calculus/gradient",
                solution=steps(
                    f"$\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                    f"$\\frac{{\\partial f}}{{\\partial x}} = \\frac{{\\partial}}{{\\partial x}}\\left[{latex(sin(a*x))}\\right] = {latex(df_dx)}$",
                    f"$\\frac{{\\partial f}}{{\\partial y}} = \\frac{{\\partial}}{{\\partial y}}\\left[{latex(cos(b*y))}\\right] = {latex(df_dy)}$",
                    f"$\\nabla f = {latex(grad_f)}$"
                )
            )
        else:
            # f(x,y) = e^(ax + by)
            a = nonzero(-2, 2)
            b = nonzero(-2, 2)
            f = exp(a*x + b*y)
            
            df_dx = diff(f, x)
            df_dy = diff(f, y)
            grad_f = Matrix([df_dx, df_dy])
            
            return problem(
                question=f"Find the gradient of $f(x,y) = {latex(f)}$",
                answer=grad_f,
                difficulty=(1500, 1600),
                topic="multivariable_calculus/gradient",
                solution=steps(
                    f"$\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                    f"Using the chain rule:",
                    f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(df_dx)}$",
                    f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(df_dy)}$",
                    f"$\\nabla f = {latex(grad_f)}$"
                )
            )
    
    else:
        # Type 4: Gradient of product or quotient (1400-1600)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # f(x,y) = xy(ax + by)
        f = x*y*(a*x + b*y)
        f_expanded = expand(f)
        
        df_dx = diff(f_expanded, x)
        df_dy = diff(f_expanded, y)
        grad_f = Matrix([df_dx, df_dy])
        
        return problem(
            question=f"Find the gradient of $f(x,y) = xy({latex(a*x + b*y)})$",
            answer=grad_f,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"First expand: $f(x,y) = {latex(f_expanded)}$",
                f"$\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(df_dx)}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(df_dy)}$",
                f"$\\nabla f = {latex(grad_f)}$"
            )
        )

emit(generate())