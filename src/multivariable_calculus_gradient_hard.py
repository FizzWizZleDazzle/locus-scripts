"""
multivariable_calculus - gradient (hard)
Generated: 2026-02-22T05:35:39.306844
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Gradient of a multivariable function with chain rule
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        k = randint(2, 4)
        
        f = a_val * x**k + b_val * y**k + x*y
        grad_f = Matrix([diff(f, x), diff(f, y)])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$",
            answer=grad_f,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"The gradient is $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(diff(f, y))}$",
                f"$\\nabla f = {latex(grad_f)}$"
            )
        )
    
    elif problem_type == 2:
        # Gradient at a specific point
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        
        f = exp(a_val*x + b_val*y)
        grad_f = Matrix([diff(f, x), diff(f, y)])
        
        x0, y0 = randint(-2, 2), randint(-2, 2)
        grad_at_point = grad_f.subs([(x, x0), (y, y0)])
        
        return problem(
            question=f"Find $\\nabla f({x0}, {y0})$ where $f(x,y) = {latex(f)}$",
            answer=grad_at_point,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"First find the gradient: $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(diff(f, y))}$",
                f"$\\nabla f = {latex(grad_f)}$",
                f"Now evaluate at $({x0}, {y0})$:",
                f"$\\nabla f({x0}, {y0}) = {latex(grad_at_point)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Directional derivative using gradient
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        f = a_val * x**2 + b_val * y**2
        grad_f = Matrix([diff(f, x), diff(f, y)])
        
        x0, y0 = nonzero(-2, 2), nonzero(-2, 2)
        u1, u2 = nonzero(-1, 1), nonzero(-1, 1)
        u_norm = sqrt(u1**2 + u2**2)
        u = Matrix([u1/u_norm, u2/u_norm])
        
        grad_at_point = grad_f.subs([(x, x0), (y, y0)])
        directional_deriv = grad_at_point.dot(u)
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction of $\\mathbf{{v}} = \\langle {u1}, {u2} \\rangle$",
            answer=simplify(directional_deriv),
            difficulty=(1700, 1800),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"First, find the gradient: $\\nabla f = \\langle {latex(diff(f, x))}, {latex(diff(f, y))} \\rangle$",
                f"Evaluate at $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = {latex(grad_at_point)}$",
                f"Normalize the direction vector: $\\|\\mathbf{{v}}\\| = {latex(u_norm)}$",
                f"$\\mathbf{{u}} = \\frac{{\\mathbf{{v}}}}{{\\|\\mathbf{{v}}\\|}} = {latex(u)}$",
                f"Directional derivative: $D_{{\\mathbf{{u}}}}f = \\nabla f \\cdot \\mathbf{{u}} = {latex(simplify(directional_deriv))}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Gradient with product/quotient of trig functions
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        
        f = sin(a_val*x) * cos(b_val*y)
        grad_f = Matrix([diff(f, x), diff(f, y)])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y) = {latex(f)}$",
            answer=grad_f,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"$\\frac{{\\partial f}}{{\\partial x}} = \\frac{{\\partial}}{{\\partial x}}[{latex(f)}] = {latex(diff(f, x))}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = \\frac{{\\partial}}{{\\partial y}}[{latex(f)}] = {latex(diff(f, y))}$",
                f"$\\nabla f = {latex(grad_f)}$"
            )
        )
    
    elif problem_type == 5:
        # Maximum rate of increase (magnitude of gradient)
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        
        f = a_val * x**2 + b_val * x * y + y**2
        grad_f = Matrix([diff(f, x), diff(f, y)])
        
        x0, y0 = nonzero(-2, 2), nonzero(-2, 2)
        grad_at_point = grad_f.subs([(x, x0), (y, y0)])
        max_rate = sqrt(grad_at_point[0]**2 + grad_at_point[1]**2)
        
        return problem(
            question=f"Find the maximum rate of change of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$",
            answer=simplify(max_rate),
            difficulty=(1750, 1850),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"The maximum rate of change equals $\\|\\nabla f\\|$ at the point",
                f"Find gradient: $\\nabla f = \\langle {latex(diff(f, x))}, {latex(diff(f, y))} \\rangle$",
                f"At $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = {latex(grad_at_point)}$",
                f"Maximum rate: $\\|\\nabla f({x0}, {y0})\\| = \\sqrt{{({latex(grad_at_point[0])})^2 + ({latex(grad_at_point[1])})^2}}$",
                f"$= {latex(simplify(max_rate))}$"
            ),
            calculator="scientific"
        )
    
    else:  # problem_type == 6
        # Gradient in three variables
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        c_val = nonzero(-2, 2)
        
        f = a_val * x * y + b_val * y * z + c_val * x * z
        grad_f = Matrix([diff(f, x), diff(f, y), diff(f, z)])
        
        return problem(
            question=f"Find the gradient $\\nabla f$ of $f(x,y,z) = {latex(f)}$",
            answer=grad_f,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/gradient",
            solution=steps(
                f"For a function of three variables, $\\nabla f = \\left\\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}}, \\frac{{\\partial f}}{{\\partial z}} \\right\\rangle$",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"$\\frac{{\\partial f}}{{\\partial y}} = {latex(diff(f, y))}$",
                f"$\\frac{{\\partial f}}{{\\partial z}} = {latex(diff(f, z))}$",
                f"$\\nabla f = {latex(grad_f)}$"
            )
        )

emit(generate())