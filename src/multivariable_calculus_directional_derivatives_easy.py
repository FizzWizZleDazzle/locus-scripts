"""
multivariable_calculus - directional_derivatives (easy)
Generated: 2026-02-22T05:36:07.735579
"""

from problem_utils import *

def generate():
    # For easier directional derivatives (1000-1300 ELO), we want:
    # - Simple functions f(x,y) like polynomials with small coefficients
    # - Direction vectors that are easy to work with (unit vectors or simple vectors)
    # - Direct application of D_u f = grad(f) · u formula
    
    problem_type = choice(['basic_gradient_dot', 'unit_vector', 'simple_direction'])
    
    if problem_type == 'basic_gradient_dot':
        # Simplest: f(x,y) = ax + by, direction vector given
        # ELO ~1000-1100
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        f = a_val * x + b_val * y
        
        # Simple direction vector
        u1 = randint(1, 3)
        u2 = randint(1, 3)
        
        # Compute gradient
        grad_f = [diff(f, x), diff(f, y)]
        
        # Directional derivative = grad · u
        D_u = grad_f[0] * u1 + grad_f[1] * u2
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ in the direction of $\\mathbf{{u}} = \\langle {u1}, {u2} \\rangle$.",
            answer=D_u,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/directional_derivatives",
            solution=steps(
                f"First, find the gradient: $\\nabla f = \\langle \\frac{{\\partial f}}{{\\partial x}}, \\frac{{\\partial f}}{{\\partial y}} \\rangle$",
                f"$\\nabla f = \\langle {latex(grad_f[0])}, {latex(grad_f[1])} \\rangle$",
                f"The directional derivative is $D_{{\\mathbf{{u}}}} f = \\nabla f \\cdot \\mathbf{{u}}$",
                f"$D_{{\\mathbf{{u}}}} f = \\langle {latex(grad_f[0])}, {latex(grad_f[1])} \\rangle \\cdot \\langle {u1}, {u2} \\rangle = {latex(grad_f[0])} \\cdot {u1} + {latex(grad_f[1])} \\cdot {u2} = {latex(D_u)}$"
            )
        )
    
    elif problem_type == 'unit_vector':
        # f(x,y) = x^2 + y^2 or similar quadratic, unit direction vector
        # ELO ~1100-1200
        coeff_x = choice([1, 2])
        coeff_y = choice([1, 2])
        f = coeff_x * x**2 + coeff_y * y**2
        
        # Use standard unit vectors or simple unit vectors
        direction_choice = choice(['i', 'j', 'diagonal'])
        
        if direction_choice == 'i':
            u1, u2 = 1, 0
            u_latex = "\\mathbf{i} = \\langle 1, 0 \\rangle"
        elif direction_choice == 'j':
            u1, u2 = 0, 1
            u_latex = "\\mathbf{j} = \\langle 0, 1 \\rangle"
        else:  # diagonal
            u1, u2 = sqrt(2)/2, sqrt(2)/2
            u_latex = "\\langle \\frac{\\sqrt{2}}{2}, \\frac{\\sqrt{2}}{2} \\rangle"
        
        # Point to evaluate at
        x0 = nonzero(-3, 3)
        y0 = nonzero(-3, 3)
        
        # Compute gradient
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        
        # Evaluate gradient at point
        grad_at_point_x = grad_f_x.subs([(x, x0), (y, y0)])
        grad_at_point_y = grad_f_y.subs([(x, x0), (y, y0)])
        
        # Directional derivative
        D_u = grad_at_point_x * u1 + grad_at_point_y * u2
        D_u = simplify(D_u)
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction of ${u_latex}$.",
            answer=D_u,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/directional_derivatives",
            solution=steps(
                f"Find the gradient: $\\nabla f = \\langle {latex(grad_f_x)}, {latex(grad_f_y)} \\rangle$",
                f"Evaluate at $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = \\langle {latex(grad_at_point_x)}, {latex(grad_at_point_y)} \\rangle$",
                f"The directional derivative is $D_{{\\mathbf{{u}}}} f = \\nabla f \\cdot \\mathbf{{u}}$",
                f"$D_{{\\mathbf{{u}}}} f = \\langle {latex(grad_at_point_x)}, {latex(grad_at_point_y)} \\rangle \\cdot {u_latex} = {latex(D_u)}$"
            )
        )
    
    else:  # simple_direction
        # f(x,y) with mixed terms, compute at origin or simple point
        # ELO ~1200-1300
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        f = a_val * x * y + b_val * x
        
        # Evaluate at origin for simplicity
        x0, y0 = 0, 0
        
        # Direction vector (will need to normalize)
        v1 = nonzero(-2, 2)
        v2 = nonzero(-2, 2)
        
        # Compute gradient
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        
        # Evaluate at point
        grad_at_point_x = grad_f_x.subs([(x, x0), (y, y0)])
        grad_at_point_y = grad_f_y.subs([(x, x0), (y, y0)])
        
        # Normalize direction vector
        magnitude = sqrt(v1**2 + v2**2)
        u1 = v1 / magnitude
        u2 = v2 / magnitude
        
        # Directional derivative
        D_u = grad_at_point_x * u1 + grad_at_point_y * u2
        D_u = simplify(D_u)
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $(0, 0)$ in the direction of $\\mathbf{{v}} = \\langle {v1}, {v2} \\rangle$.",
            answer=D_u,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/directional_derivatives",
            solution=steps(
                f"First normalize the direction vector: $\\|\\mathbf{{v}}\\| = \\sqrt{{{v1}^2 + {v2}^2}} = {latex(magnitude)}$",
                f"$\\mathbf{{u}} = \\frac{{\\mathbf{{v}}}}{{\\|\\mathbf{{v}}\\|}} = \\langle {latex(u1)}, {latex(u2)} \\rangle$",
                f"Find the gradient: $\\nabla f = \\langle {latex(grad_f_x)}, {latex(grad_f_y)} \\rangle$",
                f"Evaluate at $(0, 0)$: $\\nabla f(0, 0) = \\langle {latex(grad_at_point_x)}, {latex(grad_at_point_y)} \\rangle$",
                f"$D_{{\\mathbf{{u}}}} f = \\nabla f \\cdot \\mathbf{{u}} = {latex(D_u)}$"
            )
        )

emit(generate())