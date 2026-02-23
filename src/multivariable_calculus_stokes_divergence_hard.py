"""
multivariable_calculus - stokes_divergence (hard)
Generated: 2026-02-22T05:47:52.411516
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Stokes: line integral via curl on disk
        r_val = randint(1, 5)
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        z_val = randint(1, 4)
        F_x = -b_coeff * y
        F_y = a_coeff * x
        curl_z = simplify(diff(F_y, x) - diff(F_x, y))
        ans = curl_z * pi * r_val**2
        return problem(
            question=f"Use Stokes' Theorem: $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, 0 \\rangle$, $C$: $x^2+y^2={r_val**2}$ at $z={z_val}$ (CCW).",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$(\\nabla \\times \\mathbf{{F}})_z = {latex(curl_z)}$",
                f"Surface: disk $x^2+y^2 \\le {r_val**2}$ at $z={z_val}$, normal $\\mathbf{{k}}$",
                f"$\\oint = \\iint {latex(curl_z)} \\, dA = {latex(curl_z)} \\cdot \\pi {r_val}^2 = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Divergence Theorem: flux through box (signed coefficients)
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(1, 3)
        k1 = nonzero(-3, 3)
        k2 = nonzero(-3, 3)
        k3 = nonzero(-3, 3)
        div_F = k1 + k2 + k3
        # box from -a to a
        volume = 8 * a_val * b_val * c_val
        flux = div_F * volume
        return problem(
            question=f"Use the Divergence Theorem: outward flux of $\\mathbf{{F}} = \\langle {k1}x, {k2}y, {k3}z \\rangle$ through $[-{a_val},{a_val}]\\times[-{b_val},{b_val}]\\times[-{c_val},{c_val}]$.",
            answer=flux,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\cdot \\mathbf{{F}} = {k1}+{k2}+{k3} = {div_F}$",
                f"Volume $= 2 \\cdot {a_val} \\cdot 2 \\cdot {b_val} \\cdot 2 \\cdot {c_val} = {volume}$",
                f"Flux $= {div_F} \\cdot {volume} = {flux}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Divergence Theorem: flux through sphere
        r_val = randint(1, 5)
        k_val = nonzero(-3, 3)
        div_F = 3 * k_val
        volume = Rational(4, 3) * pi * r_val**3
        ans = simplify(div_F * volume)
        return problem(
            question=f"Use Divergence Theorem: flux of $\\mathbf{{F}} = {k_val}\\langle x,y,z \\rangle$ across $x^2+y^2+z^2={r_val**2}$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\cdot \\mathbf{{F}} = {k_val}+{k_val}+{k_val} = {div_F}$",
                f"Volume of sphere $= \\frac{{4}}{{3}}\\pi {r_val}^3 = {latex(volume)}$",
                f"Flux $= {div_F} \\cdot {latex(volume)} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Curl computation at a point
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        F_x = a * y * z
        F_y = b * x * z
        F_z = c * x * y
        curl_x = simplify(diff(F_z, y) - diff(F_y, z))
        curl_y = simplify(diff(F_x, z) - diff(F_z, x))
        curl_z = simplify(diff(F_y, x) - diff(F_x, y))
        x0, y0, z0 = randint(1, 3), randint(1, 3), randint(1, 3)
        cx = curl_x.subs([(x, x0), (y, y0), (z, z0)])
        cy = curl_y.subs([(x, x0), (y, y0), (z, z0)])
        cz = curl_z.subs([(x, x0), (y, y0), (z, z0)])
        ans = Matrix([cx, cy, cz])
        return problem(
            question=f"Evaluate $(\\nabla \\times \\mathbf{{F}})$ at $({x0},{y0},{z0})$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, {latex(F_z)} \\rangle$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$\\nabla \\times \\mathbf{{F}} = \\langle {latex(curl_x)}, {latex(curl_y)}, {latex(curl_z)} \\rangle$",
                f"At $({x0},{y0},{z0})$: $\\langle {latex(cx)}, {latex(cy)}, {latex(cz)} \\rangle$"
            )
        )

    else:
        # Stokes on simple field over rectangle in xz-plane
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        r_val = randint(1, 4)
        F_x = a_coeff * z
        F_y = 0
        F_z = b_coeff * x
        # curl = <0 - 0, a - b, 0> = <0, a - b, 0>
        curl_y = simplify(diff(F_x, z) - diff(F_z, x))
        # surface: disk in xz-plane, but use rectangle [-r,r]x[-r,r] in yz=0
        # actually just compute line integral around circle via Stokes
        # Surface = disk x^2 + z^2 <= r^2 at y=0, normal j
        ans = curl_y * pi * r_val**2
        return problem(
            question=f"Use Stokes: $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, 0, {latex(F_z)} \\rangle$, $C$: $x^2+z^2={r_val**2}$ in $y=0$ plane.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"$(\\nabla \\times \\mathbf{{F}})_y = F_{{x,z}} - F_{{z,x}} = {a_coeff} - {b_coeff} = {latex(curl_y)}$",
                f"Surface disk $x^2+z^2 \\le {r_val**2}$, normal $\\mathbf{{j}}$",
                f"$\\oint = {latex(curl_y)} \\cdot \\pi {r_val}^2 = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
