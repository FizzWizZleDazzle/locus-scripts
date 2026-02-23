"""
calculus - volumes_of_revolution (hard)
Generated: 2026-02-22T05:18:18.113839
"""

from problem_utils import *

def generate():
    problem_type = choice(['disk', 'washer', 'shell', 'mixed_region', 'shell_y'])

    if problem_type == 'disk':
        func_type = choice(['trig', 'exp', 'rational'])

        if func_type == 'trig':
            amp = randint(1, 4)
            freq = randint(1, 3)
            shift = randint(0, 2)

            func = amp * sin(freq * x) + shift
            a_val = 0
            b_val = pi / freq

            volume_expr = pi * integrate(func**2, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume of the solid obtained by rotating the region bounded by "
                          f"$y = {latex(func)}$, $y = 0$, $x = 0$, and $x = {latex(b_val)}$ about the $x$-axis."),
                answer=ans,
                difficulty=(1600, 1750),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the disk method: $V = \\pi \\int_{{0}}^{{\\pi/{freq}}} [{latex(func)}]^2 \\, dx$",
                    f"Expand $[{latex(func)}]^2 = {latex(expand(func**2))}$",
                    f"Use identity $\\sin^2(u) = \\frac{{1-\\cos(2u)}}{{2}}$ to integrate",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif func_type == 'exp':
            coeff = randint(1, 4)
            a_val = 0
            b_val = randint(1, 3)

            func = exp(coeff * x)
            volume_expr = pi * integrate(func**2, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume of the solid obtained by rotating the region bounded by "
                          f"$y = {latex(func)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis."),
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({latex(func)})^2 \\, dx$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(func**2)} \\, dx$",
                    f"$= \\pi \\left[\\frac{{1}}{{{2*coeff}}}{latex(func**2)}\\right]_{{{a_val}}}^{{{b_val}}}$",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        else:  # rational / sqrt
            coeff = randint(1, 5)
            pwr = choice([Rational(1, 2), Rational(1, 3)])
            func = coeff * x**pwr
            a_val = 0
            b_val = randint(2, 6)

            volume_expr = pi * integrate(func**2, (x, a_val, b_val))
            ans = simplify(volume_expr)

            pwr_str = "^{1/2}" if pwr == Rational(1, 2) else "^{1/3}"

            return problem(
                question=(f"Find the volume obtained by rotating $y = {coeff}x{pwr_str}$, "
                          f"$y = 0$, $x = {a_val}$, $x = {b_val}$ about the $x$-axis."),
                answer=ans,
                difficulty=(1600, 1700),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({coeff}x{pwr_str})^2 \\, dx$",
                    f"$= \\pi \\int_{{{a_val}}}^{{{b_val}}} {coeff**2}x^{{{latex(2*pwr)}}} \\, dx$",
                    f"$V = {latex(ans)}$"
                )
            )

    elif problem_type == 'washer':
        outer_type = choice(['parabola_line', 'parabola_parabola'])

        if outer_type == 'parabola_line':
            h = randint(1, 4)
            outer = -x**2 + h**2
            inner_const = randint(0, max(0, h - 1))
            inner = inner_const

            a_val = -h
            b_val = h

            volume_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume obtained by rotating the region bounded by "
                          f"$y = {latex(outer)}$ and $y = {inner_const}$ about the $x$-axis."),
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Outer radius $R = {latex(outer)}$, inner radius $r = {inner_const}$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [({latex(outer)})^2 - {inner_const}^2] \\, dx$",
                    f"Expand and integrate term by term",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        else:  # two parabolas
            a_scale = randint(1, 3)
            b_scale = randint(1, 3)
            h = randint(2, 4)
            outer = h - a_scale * x**2
            inner = b_scale * x**2

            # find intersection: h = (a+b)x^2  → x = ±sqrt(h/(a+b))
            intersect_sq = Rational(h, a_scale + b_scale)
            if not intersect_sq.is_integer and float(intersect_sq) != int(float(intersect_sq)):
                # use h divisible by a+b for clean answer
                h = a_scale + b_scale
                outer = h - a_scale * x**2
                inner = b_scale * x**2
                intersect_sq = Rational(h, a_scale + b_scale)

            a_val = -sqrt(intersect_sq)
            b_val = sqrt(intersect_sq)

            volume_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume obtained by rotating the region between "
                          f"$y = {latex(outer)}$ and $y = {latex(inner)}$ about the $x$-axis."),
                answer=ans,
                difficulty=(1700, 1850),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Find intersections: ${latex(outer)} = {latex(inner)}$",
                    f"${h} = {a_scale + b_scale}x^2$ → $x = \\pm {latex(b_val)}$",
                    f"$V = \\pi \\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} [R^2 - r^2] dx$ where $R = {latex(outer)}$, $r = {latex(inner)}$",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 'shell':
        func_choice = choice(['parabola', 'cubic', 'sqrt'])

        if func_choice == 'parabola':
            c = randint(1, 4)
            a_val = 0
            b_val = randint(1, 5)
            func = c * x**2

            volume_expr = 2 * pi * integrate(x * func, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume of the solid obtained by rotating the region bounded by "
                          f"$y = {latex(func)}$, $y = 0$, and $x = {b_val}$ about the $y$-axis "
                          f"using the shell method."),
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Shell method: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot {latex(func)} \\, dx$",
                    f"$= 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(x * func)} \\, dx$",
                    f"$= 2\\pi \\left[{latex(integrate(x*func, x))}\\right]_{{{a_val}}}^{{{b_val}}}$",
                    f"$V = {latex(ans)}$"
                )
            )

        elif func_choice == 'cubic':
            coeff = randint(1, 3)
            func = coeff * x**3
            a_val = 0
            b_val = randint(1, 3)

            volume_expr = 2 * pi * integrate(x * func, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume obtained by rotating the region bounded by "
                          f"$y = {latex(func)}$, $y = 0$, and $x = {b_val}$ about the $y$-axis "
                          f"using the shell method."),
                answer=ans,
                difficulty=(1700, 1850),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Shell method: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot ({latex(func)}) \\, dx$",
                    f"$= 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(x * func)} \\, dx$",
                    f"$V = {latex(ans)}$"
                )
            )

        else:  # sqrt
            c = randint(1, 4)
            func = sqrt(c * x)
            a_val = 0
            b_val = randint(1, 5)

            volume_expr = 2 * pi * integrate(x * func, (x, a_val, b_val))
            ans = simplify(volume_expr)

            return problem(
                question=(f"Find the volume obtained by rotating the region bounded by "
                          f"$y = \\sqrt{{{c}x}}$, $y = 0$, and $x = {b_val}$ about the $y$-axis "
                          f"using the shell method."),
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Shell method: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot \\sqrt{{{c}x}} \\, dx$",
                    f"$= 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(x * func)} \\, dx$",
                    f"$V = {latex(ans)}$"
                )
            )

    elif problem_type == 'mixed_region':
        # Rotation about y = -k or y = k (not the x-axis)
        offset = randint(1, 4)
        c = randint(1, 3)
        func = c * x**2
        a_val = 0
        b_val = randint(1, 4)

        # Rotating about y = -offset → outer = func + offset, inner = offset
        outer = func + offset
        inner = offset

        volume_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
        ans = simplify(volume_expr)

        return problem(
            question=(f"Find the volume obtained by rotating the region bounded by "
                      f"$y = {latex(func)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ "
                      f"about the line $y = {-offset}$."),
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/volumes_of_revolution",
            solution=steps(
                f"Shift to the axis of rotation $y = {-offset}$:",
                f"Outer radius: $R(x) = {latex(func)} - ({-offset}) = {latex(outer)}$",
                f"Inner radius: $r(x) = 0 - ({-offset}) = {offset}$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [R^2 - r^2] dx$",
                f"$= \\pi \\int_{{{a_val}}}^{{{b_val}}} [{latex(outer**2 - inner**2)}] dx$",
                f"$V = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:  # shell_y — shell method integrating with respect to y
        coeff = randint(1, 4)
        func = coeff * y**2  # x as function of y
        a_val = 0
        b_val = randint(1, 4)

        volume_expr = 2 * pi * integrate(y * func, (y, a_val, b_val))
        ans = simplify(volume_expr)

        return problem(
            question=(f"Find the volume obtained by rotating the region bounded by "
                      f"$x = {latex(func)}$, $x = 0$, $y = {a_val}$, and $y = {b_val}$ "
                      f"about the $x$-axis using the shell method."),
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/volumes_of_revolution",
            solution=steps(
                f"Horizontal shells: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} y \\cdot x(y) \\, dy$",
                f"$= 2\\pi \\int_{{{a_val}}}^{{{b_val}}} y \\cdot ({latex(func)}) \\, dy$",
                f"$= 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(y * func)} \\, dy$",
                f"$V = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
