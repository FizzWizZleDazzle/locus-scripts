"""
multivariable_calculus - stokes_divergence (easy)
Generated: 2026-02-22T05:46:39.408563
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Compute divergence of a simple 2D vector field
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        # Vector field F = <ax, by>
        F_x = a_val * x
        F_y = b_val * y
        
        # Divergence = dF_x/dx + dF_y/dy
        div_F = diff(F_x, x) + diff(F_y, y)
        
        return problem(
            question=f"Compute the divergence of the vector field $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=div_F,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"The divergence is $\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial F_x}}{{\\partial x}} + \\frac{{\\partial F_y}}{{\\partial y}}$",
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(F_x)}) = {latex(diff(F_x, x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(F_y)}) = {latex(diff(F_y, y))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            ),
        )
    
    elif problem_type == 2:
        # Compute divergence of a simple 3D vector field
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        c_val = nonzero(-2, 2)
        
        # Vector field F = <ax, by, cz>
        F_x = a_val * x
        F_y = b_val * y
        F_z = c_val * z
        
        # Divergence = dF_x/dx + dF_y/dy + dF_z/dz
        div_F = diff(F_x, x) + diff(F_y, y) + diff(F_z, z)
        
        return problem(
            question=f"Compute the divergence of the vector field $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, {latex(F_z)} \\rangle$",
            answer=div_F,
            difficulty=(1050, 1200),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"The divergence is $\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial F_x}}{{\\partial x}} + \\frac{{\\partial F_y}}{{\\partial y}} + \\frac{{\\partial F_z}}{{\\partial z}}$",
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(F_x)}) = {latex(diff(F_x, x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(F_y)}) = {latex(diff(F_y, y))}$",
                f"$\\frac{{\\partial}}{{\\partial z}}({latex(F_z)}) = {latex(diff(F_z, z))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            ),
        )
    
    elif problem_type == 3:
        # Compute curl of a simple 2D vector field (result is scalar in 2D)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        # Vector field F = <ay, bx>
        F_x = a_val * y
        F_y = b_val * x
        
        # Curl (z-component) = dF_y/dx - dF_x/dy
        curl_z = diff(F_y, x) - diff(F_x, y)
        
        return problem(
            question=f"Compute the scalar curl (z-component) of the 2D vector field $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=curl_z,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"The scalar curl is $\\frac{{\\partial F_y}}{{\\partial x}} - \\frac{{\\partial F_x}}{{\\partial y}}$",
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(F_y)}) = {latex(diff(F_y, x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(F_x)}) = {latex(diff(F_x, y))}$",
                f"Curl = ${latex(curl_z)}$"
            ),
        )
    
    else:
        # Compute divergence of vector field with quadratic terms
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        
        # Vector field F = <x^2, y^2>
        F_x = a_val * x**2
        F_y = b_val * y**2
        
        # Divergence = dF_x/dx + dF_y/dy
        div_F = diff(F_x, x) + diff(F_y, y)
        
        return problem(
            question=f"Compute the divergence of the vector field $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=div_F,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"The divergence is $\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial F_x}}{{\\partial x}} + \\frac{{\\partial F_y}}{{\\partial y}}$",
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(F_x)}) = {latex(diff(F_x, x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(F_y)}) = {latex(diff(F_y, y))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            ),
        )

emit(generate())