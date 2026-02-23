"""
multivariable_calculus - stokes_divergence (medium)
Generated: 2026-02-22T05:47:12.391552
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Divergence of 3D polynomial field
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        px = randint(1, 3)
        py = randint(1, 3)
        pz = randint(1, 3)
        P = a * x**px
        Q = b * y**py
        R = c * z**pz
        div_F = simplify(diff(P, x) + diff(Q, y) + diff(R, z))
        return problem(
            question=f"Compute $\\nabla \\cdot \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)}, {latex(R)} \\rangle$",
            answer=div_F,
            difficulty=(1300, 1450),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(P)}) = {latex(diff(P,x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(Q)}) = {latex(diff(Q,y))}$",
                f"$\\frac{{\\partial}}{{\\partial z}}({latex(R)}) = {latex(diff(R,z))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            )
        )

    elif problem_type == 2:
        # Curl of 3D field F = <ay, bx, cz>
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        P = a * y
        Q = b * x
        R = c * z
        curl_x = simplify(diff(R, y) - diff(Q, z))
        curl_y = simplify(diff(P, z) - diff(R, x))
        curl_z = simplify(diff(Q, x) - diff(P, y))
        ans = fmt_tuple(curl_x, curl_y, curl_z)
        return problem(
            question=f"Compute $\\nabla \\times \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)}, {latex(R)} \\rangle$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\times \\mathbf{{F}} = \\langle R_y - Q_z,\\ P_z - R_x,\\ Q_x - P_y \\rangle$",
                f"$= \\langle {latex(curl_x)},\\ {latex(curl_y)},\\ {latex(curl_z)} \\rangle$"
            )
        )

    elif problem_type == 3:
        # Divergence Theorem: flux through box
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        c_val = randint(1, 4)
        k1 = nonzero(-3, 3)
        k2 = nonzero(-3, 3)
        k3 = nonzero(-3, 3)
        div_F = k1 + k2 + k3
        volume = a_val * b_val * c_val
        flux = div_F * volume
        return problem(
            question=f"Use the Divergence Theorem: flux of $\\mathbf{{F}} = \\langle {k1}x, {k2}y, {k3}z \\rangle$ through $[0,{a_val}]\\times[0,{b_val}]\\times[0,{c_val}]$.",
            answer=flux,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\cdot \\mathbf{{F}} = {k1} + {k2} + {k3} = {div_F}$",
                f"Volume $= {a_val} \\cdot {b_val} \\cdot {c_val} = {volume}$",
                f"Flux $= {div_F} \\cdot {volume} = {flux}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Stokes: line integral via curl over disk
        r_val = randint(1, 4)
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        F_x = -b_coeff * y
        F_y = a_coeff * x
        curl_z = simplify(diff(F_y, x) - diff(F_x, y))
        ans = curl_z * pi * r_val**2
        return problem(
            question=f"Use Stokes' Theorem: $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, 0 \\rangle$ and $C$: $x^2+y^2={r_val**2}$ (CCW).",
            answer=ans,
            difficulty=(1400, 1580),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$(\\nabla \\times \\mathbf{{F}})_z = \\frac{{\\partial F_y}}{{\\partial x}} - \\frac{{\\partial F_x}}{{\\partial y}} = {latex(curl_z)}$",
                f"$\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\iint_D {latex(curl_z)} \\, dA = {latex(curl_z)} \\cdot \\pi {r_val}^2 = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # Divergence of mixed field with cross terms
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        P = a * x * y
        Q = b * y * z
        R = c * x * z
        div_F = simplify(diff(P, x) + diff(Q, y) + diff(R, z))
        return problem(
            question=f"Compute $\\nabla \\cdot \\mathbf{{F}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)}, {latex(R)} \\rangle$",
            answer=div_F,
            difficulty=(1300, 1480),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\frac{{\\partial}}{{\\partial x}}({latex(P)}) = {latex(diff(P,x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}({latex(Q)}) = {latex(diff(Q,y))}$",
                f"$\\frac{{\\partial}}{{\\partial z}}({latex(R)}) = {latex(diff(R,z))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            )
        )

emit(generate())
