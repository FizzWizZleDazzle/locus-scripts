"""
multivariable_calculus - stokes_divergence (easy)
Generated: 2026-02-22T05:46:39.408563
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Divergence of F = <ax, by> (2D)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        F_x = a_val * x
        F_y = b_val * y
        div_F = diff(F_x, x) + diff(F_y, y)
        return problem(
            question=f"Compute $\\nabla \\cdot \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=div_F,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial F_x}}{{\\partial x}} + \\frac{{\\partial F_y}}{{\\partial y}}$",
                f"$= {latex(diff(F_x,x))} + {latex(diff(F_y,y))} = {latex(div_F)}$"
            ),
        )

    elif problem_type == 2:
        # Divergence of F = <ax, by, cz> (3D)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        F_x = a_val * x
        F_y = b_val * y
        F_z = c_val * z
        div_F = diff(F_x, x) + diff(F_y, y) + diff(F_z, z)
        return problem(
            question=f"Compute $\\nabla \\cdot \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, {latex(F_z)} \\rangle$",
            answer=div_F,
            difficulty=(1050, 1200),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial F_x}}{{\\partial x}} + \\frac{{\\partial F_y}}{{\\partial y}} + \\frac{{\\partial F_z}}{{\\partial z}} = {latex(div_F)}$"
            ),
        )

    elif problem_type == 3:
        # Curl z-component of F = <ay, bx>
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        F_x = a_val * y
        F_y = b_val * x
        curl_z = diff(F_y, x) - diff(F_x, y)
        return problem(
            question=f"Compute the scalar curl of $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=curl_z,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"Scalar curl $= \\frac{{\\partial F_y}}{{\\partial x}} - \\frac{{\\partial F_x}}{{\\partial y}}$",
                f"$= {latex(diff(F_y, x))} - {latex(diff(F_x, y))} = {latex(curl_z)}$"
            ),
        )

    elif problem_type == 4:
        # Divergence of F = <ax^2, by^2>
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        F_x = a_val * x**2
        F_y = b_val * y**2
        div_F = diff(F_x, x) + diff(F_y, y)
        return problem(
            question=f"Compute $\\nabla \\cdot \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=div_F,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(F_x)}) = {latex(diff(F_x,x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(F_y)}) = {latex(diff(F_y,y))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            ),
        )

    elif problem_type == 5:
        # Divergence with mixed polynomial terms
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        F_x = a_val * x**2 + b_val * y
        F_y = c_val * y**2 + a_val * x
        div_F = diff(F_x, x) + diff(F_y, y)
        return problem(
            question=f"Compute $\\nabla \\cdot \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=div_F,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\frac{{\\partial F_x}}{{\\partial x}} = {latex(diff(F_x,x))}$",
                f"$\\frac{{\\partial F_y}}{{\\partial y}} = {latex(diff(F_y,y))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            ),
        )

    else:
        # Curl z-component with quadratic terms
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        F_x = a_val * x * y
        F_y = b_val * x**2
        curl_z = diff(F_y, x) - diff(F_x, y)
        return problem(
            question=f"Compute the scalar curl of $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)} \\rangle$",
            answer=curl_z,
            difficulty=(1150, 1280),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\frac{{\\partial F_y}}{{\\partial x}} = {latex(diff(F_y,x))}$",
                f"$\\frac{{\\partial F_x}}{{\\partial y}} = {latex(diff(F_x,y))}$",
                f"Scalar curl $= {latex(diff(F_y,x))} - {latex(diff(F_x,y))} = {latex(curl_z)}$"
            ),
        )

emit(generate())
