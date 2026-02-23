"""
calculus - volumes_of_revolution (medium)
Generated: 2026-02-22T05:17:35.758971
"""

from problem_utils import *

def generate():
    problem_type = choice(['disk_x', 'disk_y', 'washer_x', 'washer_y'])

    if problem_type == 'disk_x':
        func_type = choice(['linear', 'quadratic', 'sqrt', 'power'])

        if func_type == 'linear':
            m = randint(1, 6)
            a_val = randint(0, 3)
            b_val = a_val + randint(2, 6)
            f = m * x

            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)

            q = (f"Find the volume of the solid obtained by rotating the region bounded by "
                 f"$y = {latex(f)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.")
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{latex(f)}]^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(expand(f**2))} \\, dx$",
                f"$V = \\pi \\left[{latex(integrate(f**2, x))}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )

        elif func_type == 'quadratic':
            c = randint(1, 3)
            a_val = randint(0, 2)
            b_val = a_val + randint(1, 3)
            f = c * x**2

            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)

            q = (f"Find the volume of the solid obtained by rotating the region bounded by "
                 f"$y = {latex(f)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.")
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({latex(f)})^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(expand(f**2))} \\, dx$",
                f"$V = \\pi \\left[{latex(integrate(f**2, x))}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )

        elif func_type == 'sqrt':
            c = randint(1, 4)
            a_val = randint(0, 3)
            b_val = a_val + randint(2, 6)
            f = sqrt(c * x)

            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)

            q = (f"Find the volume of the solid obtained by rotating the region bounded by "
                 f"$y = \\sqrt{{{c}x}}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.")
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} (\\sqrt{{{c}x}})^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {c}x \\, dx$",
                f"$V = \\pi \\left[{latex(integrate(c*x, x))}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )

        else:  # power  y = x^(3/2) or similar
            c = randint(1, 3)
            a_val = randint(0, 2)
            b_val = a_val + randint(1, 4)
            f = c * x**Rational(3, 2)

            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)

            q = (f"Find the volume of the solid obtained by rotating the region bounded by "
                 f"$y = {c}x^{{3/2}}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.")
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({c}x^{{3/2}})^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {c**2}x^3 \\, dx$",
                f"$V = \\pi \\left[\\frac{{{c**2}x^4}}{{4}}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )

        difficulty = (1300, 1450)

    elif problem_type == 'disk_y':
        # Disk around y-axis: x = f(y)
        c = randint(1, 5)
        a_val = randint(1, 4)
        b_val = a_val + randint(1, 5)
        f = c * y

        integral_expr = pi * integrate(f**2, (y, a_val, b_val))
        ans = simplify(integral_expr)

        q = (f"Find the volume of the solid obtained by rotating the region bounded by "
             f"$x = {latex(f)}$, $x = 0$, $y = {a_val}$, and $y = {b_val}$ about the $y$-axis.")
        sol = steps(
            f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{latex(f)}]^2 \\, dy$",
            f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(expand(f**2))} \\, dy$",
            f"$V = \\pi \\left[{latex(integrate(f**2, y))}\\right]_{{{a_val}}}^{{{b_val}}}$",
            f"$V = {latex(ans)}$"
        )
        difficulty = (1350, 1500)

    elif problem_type == 'washer_x':
        # Washer around x-axis: outer radius R (constant or linear), inner radius r (linear)
        R_val = randint(2, 7)
        m_inner = randint(1, 3)
        a_val = randint(0, 2)
        b_val = randint(2, 6)

        outer = R_val
        inner = m_inner * x

        # Ensure outer > inner on [a, b]
        if m_inner * b_val >= R_val:
            b_val = max(1, R_val // m_inner - 1)
            if b_val <= a_val:
                a_val = 0

        integral_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
        ans = simplify(integral_expr)

        inner_str = f"{m_inner}x" if m_inner != 1 else "x"
        q = (f"Find the volume of the solid obtained by rotating the region bounded by "
             f"$y = {R_val}$, $y = {inner_str}$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.")
        sol = steps(
            f"Using the washer method with outer radius $R = {R_val}$ and inner radius $r = {inner_str}$:",
            f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} \\left[{R_val}^2 - ({inner_str})^2\\right] \\, dx$",
            f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{R_val**2} - {m_inner**2}x^2] \\, dx$",
            f"$V = \\pi \\left[{R_val**2}x - \\frac{{{m_inner**2}x^3}}{{3}}\\right]_{{{a_val}}}^{{{b_val}}}$",
            f"$V = {latex(ans)}$"
        )
        difficulty = (1450, 1600)

    else:  # washer_y
        # Washer around y-axis: outer = b_val (constant), inner = y^2 or sqrt
        R_const = randint(2, 6)
        a_val = randint(1, 3)

        outer_sq = R_const**2
        inner = y**2  # inner radius = y², so (y²)² = y⁴ in integrand

        integral_expr = pi * integrate(outer_sq - inner**2, (y, 0, a_val))
        ans = simplify(integral_expr)

        q = (f"Find the volume of the solid obtained by rotating the region bounded by "
             f"$x = y^2$, $x = 0$, $y = 0$, $y = {a_val}$, and $x = {R_const}$ about the $y$-axis.")
        sol = steps(
            f"Using the washer method: outer radius $R = {R_const}$, inner radius $r = y^2$",
            f"$V = \\pi \\int_{{0}}^{{{a_val}}} \\left[{R_const}^2 - (y^2)^2\\right] \\, dy$",
            f"$V = \\pi \\int_{{0}}^{{{a_val}}} [{R_const**2} - y^4] \\, dy$",
            f"$V = \\pi \\left[{R_const**2}y - \\frac{{y^5}}{{5}}\\right]_{{0}}^{{{a_val}}}$",
            f"$V = {latex(ans)}$"
        )
        difficulty = (1500, 1600)

    return problem(
        question=q,
        answer=ans,
        difficulty=difficulty,
        topic="calculus/volumes_of_revolution",
        solution=sol,
        calculator="scientific"
    )

emit(generate())
