"""
multivariable_calculus - directional_derivatives (medium)
Generated: 2026-02-22T05:36:28.573734
"""

from problem_utils import *

def generate():
    # Pick a difficulty level within the standard range
    difficulty_level = randint(1300, 1600)
    
    if difficulty_level < 1400:
        # Easier: directional derivative with simple function and standard unit vector
        # Example: f(x,y) = x^2 + y^2, direction vector <1,0> or <0,1>
        func_type = randint(1, 2)
        
        if func_type == 1:
            # Quadratic polynomial
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            f = a_val * x**2 + b_val * y**2
        else:
            # Linear combination
            a_val = nonzero(-4, 4)
            b_val = nonzero(-4, 4)
            f = a_val * x + b_val * y
        
        # Use a coordinate direction
        direction_choice = randint(1, 2)
        if direction_choice == 1:
            u_vec = [1, 0]
            u_latex = "\\langle 1, 0 \\rangle"
        else:
            u_vec = [0, 1]
            u_latex = "\\langle 0, 1 \\rangle"
        
        # Point of evaluation
        x0, y0 = randint(-3, 3), randint(-3, 3)
        
        # Compute gradient
        fx = diff(f, x)
        fy = diff(f, y)
        
        # Evaluate gradient at point
        fx_val = fx.subs([(x, x0), (y, y0)])
        fy_val = fy.subs([(x, x0), (y, y0)])
        
        # Directional derivative = grad f · u
        ans = fx_val * u_vec[0] + fy_val * u_vec[1]
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction ${u_latex}$.",
            answer=ans,
            difficulty=difficulty_level,
            topic="multivariable_calculus/directional_derivatives",
            solution=steps(
                f"Compute the gradient: $\\nabla f = \\langle {latex(fx)}, {latex(fy)} \\rangle$",
                f"Evaluate at $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = \\langle {fx_val}, {fy_val} \\rangle$",
                f"The directional derivative is $D_{{\\mathbf{{u}}}} f = \\nabla f \\cdot \\mathbf{{u}} = {fx_val} \\cdot {u_vec[0]} + {fy_val} \\cdot {u_vec[1]} = {ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Harder: non-unit direction vector requiring normalization
        func_type = randint(1, 3)
        
        if func_type == 1:
            # Quadratic
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            c_val = nonzero(-3, 3)
            f = a_val * x**2 + b_val * x * y + c_val * y**2
        elif func_type == 2:
            # Polynomial
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            f = a_val * x**2 + b_val * y**2
        else:
            # Mixed
            a_val = nonzero(-2, 2)
            b_val = nonzero(-2, 2)
            f = a_val * x * y + b_val * (x**2 + y**2)
        
        # Non-unit direction vector
        v1, v2 = nonzero(-4, 4), nonzero(-4, 4)
        v_latex = f"\\langle {v1}, {v2} \\rangle"
        
        # Normalize
        v_mag = sqrt(v1**2 + v2**2)
        u1 = v1 / v_mag
        u2 = v2 / v_mag
        
        # Point of evaluation
        x0, y0 = randint(-2, 2), randint(-2, 2)
        
        # Compute gradient
        fx = diff(f, x)
        fy = diff(f, y)
        
        # Evaluate gradient at point
        fx_val = fx.subs([(x, x0), (y, y0)])
        fy_val = fy.subs([(x, x0), (y, y0)])
        
        # Directional derivative = grad f · u
        ans = simplify(fx_val * u1 + fy_val * u2)
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction of the vector ${v_latex}$.",
            answer=ans,
            difficulty=difficulty_level,
            topic="multivariable_calculus/directional_derivatives",
            solution=steps(
                f"First, normalize the direction vector: $\\mathbf{{u}} = \\frac{{{v_latex}}}{{\\|{v_latex}\\|}} = \\frac{{{v_latex}}}{{{latex(v_mag)}}}$",
                f"Compute the gradient: $\\nabla f = \\langle {latex(fx)}, {latex(fy)} \\rangle$",
                f"Evaluate at $({x0}, {y0})$: $\\nabla f({x0}, {y0}) = \\langle {fx_val}, {fy_val} \\rangle$",
                f"The directional derivative is $D_{{\\mathbf{{u}}}} f = \\nabla f \\cdot \\mathbf{{u}} = \\frac{{{fx_val} \\cdot {v1} + {fy_val} \\cdot {v2}}}{{{latex(v_mag)}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())