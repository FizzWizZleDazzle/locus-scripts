"""
multivariable_calculus - directional_derivatives (hard)
Generated: 2026-02-22T05:36:50.961459
"""

from problem_utils import *

def generate():
    # Random function types for directional derivatives at advanced level
    func_type = randint(1, 5)
    
    # Pick a clean point
    x0 = randint(-2, 2)
    y0 = randint(-2, 2)
    
    # Generate direction vector (unit or non-unit)
    use_unit = choice([True, False])
    
    if use_unit:
        # Unit vector in common directions
        angle_choice = choice([0, 30, 45, 60, 90, 120, 135, 150, 180])
        if angle_choice == 0:
            u_vec = Matrix([1, 0])
        elif angle_choice == 30:
            u_vec = Matrix([sqrt(3)/2, Rational(1,2)])
        elif angle_choice == 45:
            u_vec = Matrix([sqrt(2)/2, sqrt(2)/2])
        elif angle_choice == 60:
            u_vec = Matrix([Rational(1,2), sqrt(3)/2])
        elif angle_choice == 90:
            u_vec = Matrix([0, 1])
        elif angle_choice == 120:
            u_vec = Matrix([-Rational(1,2), sqrt(3)/2])
        elif angle_choice == 135:
            u_vec = Matrix([-sqrt(2)/2, sqrt(2)/2])
        elif angle_choice == 150:
            u_vec = Matrix([-sqrt(3)/2, Rational(1,2)])
        else:  # 180
            u_vec = Matrix([-1, 0])
        direction_vec = u_vec
    else:
        # Non-unit vector that needs normalization
        a_comp = nonzero(-4, 4)
        b_comp = nonzero(-4, 4)
        v_vec = Matrix([a_comp, b_comp])
        magnitude = sqrt(a_comp**2 + b_comp**2)
        direction_vec = v_vec / magnitude
        u_vec = direction_vec
    
    # Generate function based on type
    if func_type == 1:
        # Polynomial with cross terms
        a_coef = nonzero(-3, 3)
        b_coef = nonzero(-3, 3)
        c_coef = nonzero(-3, 3)
        f = a_coef * x**2 + b_coef * x * y + c_coef * y**2
        
    elif func_type == 2:
        # Exponential and polynomial
        a_coef = nonzero(-2, 2)
        b_coef = nonzero(-2, 2)
        f = exp(a_coef * x + b_coef * y)
        
    elif func_type == 3:
        # Product of functions
        a_coef = nonzero(-2, 2)
        b_coef = nonzero(-2, 2)
        f = x**2 * exp(a_coef * y) + b_coef * x * y
        
    elif func_type == 4:
        # Trigonometric
        a_coef = choice([1, 2])
        b_coef = choice([1, 2])
        f = sin(a_coef * x) * cos(b_coef * y)
        
    else:  # func_type == 5
        # More complex combination
        a_coef = nonzero(-2, 2)
        f = x**3 + a_coef * x * y**2 - y**3
    
    # Compute gradient
    fx = diff(f, x)
    fy = diff(f, y)
    
    # Evaluate gradient at point
    fx_at_p = fx.subs([(x, x0), (y, y0)])
    fy_at_p = fy.subs([(x, x0), (y, y0)])
    
    grad_at_p = Matrix([fx_at_p, fy_at_p])
    
    # Compute directional derivative
    D_u_f = grad_at_p.dot(direction_vec)
    ans = simplify(D_u_f)
    
    # Build question
    if use_unit:
        question = f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction $\\mathbf{{u}} = {latex(u_vec)}$."
    else:
        question = f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction of the vector $\\mathbf{{v}} = {latex(v_vec)}$."
    
    # Solution steps
    if use_unit:
        solution = steps(
            f"Compute the gradient: $\\nabla f = \\left\\langle {latex(fx)}, {latex(fy)} \\right\\rangle$",
            f"Evaluate at $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = \\left\\langle {latex(fx_at_p)}, {latex(fy_at_p)} \\right\\rangle$",
            f"The directional derivative is $D_{{\\mathbf{{u}}}}f = \\nabla f \\cdot \\mathbf{{u}}$",
            f"$D_{{\\mathbf{{u}}}}f = \\left\\langle {latex(fx_at_p)}, {latex(fy_at_p)} \\right\\rangle \\cdot {latex(u_vec)}$",
            f"$D_{{\\mathbf{{u}}}}f = {latex(ans)}$"
        )
    else:
        solution = steps(
            f"First normalize the direction vector: $\\mathbf{{u}} = \\frac{{\\mathbf{{v}}}}{{\\|\\mathbf{{v}}\\|}}$",
            f"$\\|\\mathbf{{v}}\\| = \\sqrt{{{a_comp}^2 + {b_comp}^2}} = {latex(magnitude)}$",
            f"$\\mathbf{{u}} = {latex(u_vec)}$",
            f"Compute the gradient: $\\nabla f = \\left\\langle {latex(fx)}, {latex(fy)} \\right\\rangle$",
            f"Evaluate at $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = \\left\\langle {latex(fx_at_p)}, {latex(fy_at_p)} \\right\\rangle$",
            f"The directional derivative is $D_{{\\mathbf{{u}}}}f = \\nabla f \\cdot \\mathbf{{u}} = {latex(ans)}$"
        )
    
    return problem(
        question=question,
        answer=ans,
        difficulty=(1600, 1900),
        topic="multivariable_calculus/directional_derivatives",
        solution=solution,
        calculator="scientific"
    )

emit(generate())