"""
multivariable_calculus - triple_integrals (medium)
Generated: 2026-02-22T05:40:42.728671
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Linear polynomial over box
        a_lim = randint(1, 4)
        b_lim = randint(1, 4)
        c_lim = randint(1, 4)
        coeffs = [nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)]
        integrand = coeffs[0] * x + coeffs[1] * y + coeffs[2] * z
        int_z = integrate(integrand, (z, 0, c_lim))
        int_y = integrate(int_z, (y, 0, b_lim))
        ans = integrate(int_y, (x, 0, a_lim))
        return problem(
            question=f"Evaluate $\\int_0^{{{a_lim}}} \\int_0^{{{b_lim}}} \\int_0^{{{c_lim}}} ({latex(integrand)}) \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{c_lim}}} ({latex(integrand)}) \\, dz = {latex(int_z)}$",
                f"$\\int_0^{{{b_lim}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"$\\int_0^{{{a_lim}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # x^p * y^q * z^r over box
        a_lim = randint(1, 3)
        b_lim = randint(1, 3)
        c_lim = randint(1, 3)
        coeff = nonzero(-2, 2)
        px = randint(1, 3)
        py = randint(1, 3)
        pz = randint(1, 3)
        integrand = coeff * x**px * y**py * z**pz
        int_z = integrate(integrand, (z, 0, c_lim))
        int_y = integrate(int_z, (y, 0, b_lim))
        ans = integrate(int_y, (x, 0, a_lim))
        return problem(
            question=f"Evaluate $\\int_0^{{{a_lim}}} \\int_0^{{{b_lim}}} \\int_0^{{{c_lim}}} {latex(integrand)} \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{c_lim}}} {latex(integrand)} \\, dz = {latex(int_z)}$",
                f"$\\int_0^{{{b_lim}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"$\\int_0^{{{a_lim}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # z from 0 to x + y (variable upper bound)
        a_lim = randint(1, 3)
        b_lim = randint(1, 3)
        coeff = randint(1, 4)
        integrand = coeff
        int_z = integrate(integrand, (z, 0, x + y))
        int_y = integrate(int_z, (y, 0, b_lim))
        ans = integrate(int_y, (x, 0, a_lim))
        return problem(
            question=f"Evaluate $\\int_0^{{{a_lim}}} \\int_0^{{{b_lim}}} \\int_0^{{x+y}} {coeff} \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1450, 1550),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{x+y}} {coeff} \\, dz = {latex(int_z)}$",
                f"$\\int_0^{{{b_lim}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"$\\int_0^{{{a_lim}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # Tetrahedron volume: x + y + z <= a
        a_val = randint(2, 5)
        int_z = integrate(1, (z, 0, a_val - x - y))
        int_y = integrate(int_z, (y, 0, a_val - x))
        ans = integrate(int_y, (x, 0, a_val))
        return problem(
            question=f"Find the volume of the tetrahedron $x+y+z \\le {a_val}$, $x,y,z \\ge 0$.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{a_val}-x-y}} dz = {a_val}-x-y$",
                f"$\\int_0^{{{a_val}-x}} ({a_val}-x-y) \\, dy = {latex(int_y)}$",
                f"$\\int_0^{{{a_val}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # Non-zero lower limits, polynomial integrand
        x1, x2 = randint(0, 2), randint(3, 5)
        y1, y2 = randint(0, 1), randint(2, 4)
        z1, z2 = randint(0, 1), randint(2, 3)
        coeff = nonzero(-2, 2)
        integrand = coeff * x * y
        int_z = integrate(integrand, (z, z1, z2))
        int_y = integrate(int_z, (y, y1, y2))
        ans = integrate(int_y, (x, x1, x2))
        return problem(
            question=f"Evaluate $\\int_{{{x1}}}^{{{x2}}} \\int_{{{y1}}}^{{{y2}}} \\int_{{{z1}}}^{{{z2}}} {latex(integrand)} \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_{{{z1}}}^{{{z2}}} {latex(integrand)} \\, dz = {latex(int_z)}$",
                f"$\\int_{{{y1}}}^{{{y2}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"$\\int_{{{x1}}}^{{{x2}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

    else:
        # z from x to a, y from x to a (triangular in multiple directions)
        a_val = randint(2, 4)
        coeff = nonzero(-2, 2)
        integrand = coeff * z
        int_z = integrate(integrand, (z, x, a_val))
        int_y = integrate(int_z, (y, 0, a_val))
        ans = integrate(int_y, (x, 0, a_val))
        return problem(
            question=f"Evaluate $\\int_0^{{{a_val}}} \\int_0^{{{a_val}}} \\int_x^{{{a_val}}} {latex(integrand)} \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1450, 1560),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_x^{{{a_val}}} {latex(integrand)} \\, dz = {latex(int_z)}$",
                f"$\\int_0^{{{a_val}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"$\\int_0^{{{a_val}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

emit(generate())
