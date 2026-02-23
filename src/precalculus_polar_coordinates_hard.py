"""
precalculus - polar_coordinates (hard)
"""

from problem_utils import *

ALL_ANGLES = [
    0, pi/6, pi/4, pi/3, pi/2,
    2*pi/3, 3*pi/4, 5*pi/6, pi,
    7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2,
    5*pi/3, 7*pi/4, 11*pi/6,
]


def generate():
    problem_type = choice([
        'convert_to_rect_circle',
        'convert_to_rect_line',
        'convert_to_polar',
        'intersection_circle_circle',
        'intersection_circle_line',
        'area_cardioid',
        'area_rose',
        'arc_length_circle',
    ])

    if problem_type == 'convert_to_rect_circle':
        # r = 2a cos(theta) or r = 2b sin(theta)
        a = choice([1, 2, 3, 4, 5])
        use_cos = choice([True, False])
        if use_cos:
            polar_eq = f"r = {2*a}\\cos\\theta"
            rect_ans = Eq((x - a)**2 + y**2, a**2)
            sol = steps(
                f"Multiply by $r$: $r^2 = {2*a}r\\cos\\theta$",
                f"$x^2+y^2 = {2*a}x$",
                f"$(x-{a})^2+y^2={a**2}$  (circle, center $({a},0)$, radius ${a}$)"
            )
        else:
            polar_eq = f"r = {2*a}\\sin\\theta"
            rect_ans = Eq(x**2 + (y - a)**2, a**2)
            sol = steps(
                f"Multiply by $r$: $r^2 = {2*a}r\\sin\\theta$",
                f"$x^2+y^2 = {2*a}y$",
                f"$x^2+(y-{a})^2={a**2}$  (circle, center $(0,{a})$, radius ${a}$)"
            )
        return problem(
            question=f"Convert ${polar_eq}$ to rectangular form.",
            answer=rect_ans,
            difficulty=(1600, 1750),
            topic="precalculus/polar_coordinates",
            solution=sol,
            answer_type="equation"
        )

    elif problem_type == 'convert_to_rect_line':
        variant = choice(['vertical', 'horizontal', 'slant_pi4', 'normal'])
        if variant == 'vertical':
            a = randint(1, 8)
            sign = choice([-1, 1])
            a_s = sign * a
            polar_eq = f"r\\cos\\theta = {a_s}"
            rect_ans = Eq(x, a_s)
            sol = steps("$r\\cos\\theta = x$", f"$x = {a_s}$")
        elif variant == 'horizontal':
            a = randint(1, 8)
            sign = choice([-1, 1])
            a_s = sign * a
            polar_eq = f"r\\sin\\theta = {a_s}"
            rect_ans = Eq(y, a_s)
            sol = steps("$r\\sin\\theta = y$", f"$y = {a_s}$")
        elif variant == 'slant_pi4':
            a = randint(1, 6)
            sign = choice([-1, 1])
            a_s = sign * a
            polar_eq = f"r\\cos\\!\\left(\\theta - \\dfrac{{\\pi}}{{4}}\\right) = {a_s}"
            rect_ans = Eq(x + y, a_s * sqrt(2))
            sol = steps(
                f"Expand: $r\\!\\left(\\cos\\theta\\cos\\tfrac{{\\pi}}{{4}}+\\sin\\theta\\sin\\tfrac{{\\pi}}{{4}}\\right)={a_s}$",
                f"$\\tfrac{{\\sqrt2}}{{2}}(r\\cos\\theta+r\\sin\\theta)={a_s}$",
                f"$x+y = {a_s}\\sqrt{{2}} = {latex(a_s*sqrt(2))}$"
            )
        else:
            a = randint(1, 6)
            sign = choice([-1, 1])
            a_s = sign * a
            polar_eq = f"r\\cos\\!\\left(\\theta - \\dfrac{{\\pi}}{{6}}\\right) = {a_s}"
            rect_ans = Eq(sqrt(3)*x + y, 2*a_s)
            sol = steps(
                f"Expand: $r\\cos\\theta\\cos\\tfrac{{\\pi}}{{6}}+r\\sin\\theta\\sin\\tfrac{{\\pi}}{{6}}={a_s}$",
                f"$\\tfrac{{\\sqrt3}}{{2}}x+\\tfrac{{1}}{{2}}y={a_s}$",
                f"$\\sqrt{{3}}\\,x+y={2*a_s}$"
            )
        return problem(
            question=f"Convert ${polar_eq}$ to rectangular form.",
            answer=rect_ans,
            difficulty=(1650, 1800),
            topic="precalculus/polar_coordinates",
            solution=sol,
            answer_type="equation"
        )

    elif problem_type == 'convert_to_polar':
        rect_type = choice(['circle_origin', 'circle_shifted_x', 'circle_shifted_y', 'line_y_eq_mx', 'parabola'])

        if rect_type == 'circle_origin':
            r_val = randint(2, 9)
            rect_eq = f"x^2 + y^2 = {r_val**2}"
            polar_ans = Eq(symbols('r'), r_val)
            sol = steps(f"$r^2 = x^2+y^2 = {r_val**2}$", f"$r = {r_val}$")
        elif rect_type == 'circle_shifted_x':
            a = randint(1, 5)
            rect_eq = f"(x-{a})^2 + y^2 = {a**2}"
            polar_ans = Eq(symbols('r'), 2*a*cos(symbols('theta')))
            sol = steps(
                f"Expand: $x^2-{2*a}x+{a**2}+y^2={a**2}$",
                f"$x^2+y^2={2*a}x \\Rightarrow r^2={2*a}r\\cos\\theta$",
                f"$r = {2*a}\\cos\\theta$"
            )
        elif rect_type == 'circle_shifted_y':
            a = randint(1, 5)
            rect_eq = f"x^2 + (y-{a})^2 = {a**2}"
            polar_ans = Eq(symbols('r'), 2*a*sin(symbols('theta')))
            sol = steps(
                f"$x^2+y^2={2*a}y \\Rightarrow r^2={2*a}r\\sin\\theta$",
                f"$r = {2*a}\\sin\\theta$"
            )
        elif rect_type == 'line_y_eq_mx':
            m = choice([1, 2, 3, -1, -2])
            b_v = choice([1, 2, 3, -1, -2])
            rect_eq = f"y = {m}x + {b_v}"
            theta_sym = symbols('theta')
            r_sym = symbols('r')
            polar_ans = Eq(r_sym, b_v / (sin(theta_sym) - m*cos(theta_sym)))
            sol = steps(
                f"Substitute $x=r\\cos\\theta$, $y=r\\sin\\theta$:",
                f"$r\\sin\\theta = {m}r\\cos\\theta + {b_v}$",
                f"$r(\\sin\\theta - {m}\\cos\\theta) = {b_v}$",
                f"$r = \\dfrac{{{b_v}}}{{\\sin\\theta - {m}\\cos\\theta}}$"
            )
        else:
            # y^2 = 4x  parabola
            a = randint(1, 4)
            rect_eq = f"y^2 = {4*a}x"
            theta_sym = symbols('theta')
            r_sym = symbols('r')
            # r^2 sin^2 = 4a r cos => r = 4a cos / sin^2
            polar_ans = Eq(r_sym, 4*a*cos(theta_sym)/sin(theta_sym)**2)
            sol = steps(
                f"Substitute $x=r\\cos\\theta$, $y=r\\sin\\theta$:",
                f"$r^2\\sin^2\\theta = {4*a}r\\cos\\theta$",
                f"$r = \\dfrac{{{4*a}\\cos\\theta}}{{\\sin^2\\theta}}$"
            )
        return problem(
            question=f"Convert ${rect_eq}$ to polar form.",
            answer=polar_ans,
            difficulty=(1650, 1800),
            topic="precalculus/polar_coordinates",
            solution=sol,
            answer_type="equation"
        )

    elif problem_type == 'intersection_circle_circle':
        # r = a  and  r = b cos(theta), a < b
        a = randint(2, 4)
        b = randint(a + 1, a + 4)
        ratio = Rational(a, b)
        theta_pos = simplify(acos(ratio))
        theta_neg = simplify(-theta_pos)
        polar_ans = FiniteSet((a, theta_pos), (a, theta_neg))
        return problem(
            question=(f"Find the intersection points of $r = {a}$ and $r = {b}\\cos\\theta$ "
                      f"in the form $(r,\\theta)$ with $-\\pi<\\theta\\le\\pi$."),
            answer=polar_ans,
            difficulty=(1700, 1850),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Set equal: ${a} = {b}\\cos\\theta$",
                f"$\\cos\\theta = {latex(ratio)}$",
                f"$\\theta = \\pm\\arccos\\!\\left({latex(ratio)}\\right) = \\pm{latex(theta_pos)}$",
                f"Intersection points: $({a}, {latex(theta_pos)})$ and $({a}, {latex(theta_neg)})$"
            ),
            answer_type="set",
            calculator="scientific"
        )

    elif problem_type == 'intersection_circle_line':
        # r = a  and  r = b sin(theta), a < b  (same pattern)
        a = randint(2, 4)
        b = randint(a + 1, a + 4)
        ratio = Rational(a, b)
        theta1 = simplify(asin(ratio))
        theta2 = simplify(pi - theta1)
        polar_ans = FiniteSet((a, theta1), (a, theta2))
        return problem(
            question=(f"Find the intersection points of $r = {a}$ and $r = {b}\\sin\\theta$ "
                      f"with $0\\le\\theta<\\pi$."),
            answer=polar_ans,
            difficulty=(1700, 1850),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Set equal: ${a} = {b}\\sin\\theta$",
                f"$\\sin\\theta = {latex(ratio)}$",
                f"$\\theta = {latex(theta1)}$ or $\\theta = {latex(theta2)}$",
                f"Points: $({a},{latex(theta1)})$ and $({a},{latex(theta2)})$"
            ),
            answer_type="set",
            calculator="scientific"
        )

    elif problem_type == 'area_cardioid':
        a = randint(1, 6)
        use_cos = choice([True, False])
        # Area of r = a(1 + cos(theta)) or r = a(1 + sin(theta)) = (3/2)*pi*a^2
        area_ans = Rational(3, 2) * pi * a**2
        func_str = "\\cos" if use_cos else "\\sin"
        return problem(
            question=f"Find the area enclosed by the cardioid $r = {a}(1 + {func_str}\\,\\theta)$.",
            answer=area_ans,
            difficulty=(1750, 1900),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "$A = \\dfrac{1}{2}\\displaystyle\\int_0^{2\\pi} r^2\\,d\\theta$",
                f"$r^2 = {a**2}(1+{func_str}\\,\\theta)^2 = {a**2}\\!\\left(1+2{func_str}\\,\\theta+{func_str}^2\\theta\\right)$",
                f"Using $\\cos^2\\theta=\\tfrac{{1+\\cos(2\\theta)}}{{2}}$ (or $\\sin^2$):",
                f"$A = \\dfrac{{{a**2}}}{{2}}\\cdot 3\\pi = {latex(area_ans)}$"
            )
        )

    elif problem_type == 'area_rose':
        n = choice([2, 3, 4, 5])
        a = randint(1, 5)
        petals = n if n % 2 == 1 else 2 * n
        # Area of one petal of r = a sin(n theta): pi*a^2/(4n) for odd n, pi*a^2/(4n) for even
        # Total area: petals * (pi*a^2)/(4n)  ... formula: pi*a^2/2 for odd n, pi*a^2/2 for even n
        # For r = a*cos(n*theta): total area = pi*a^2/2
        total_area = Rational(1, 2) * pi * a**2
        func_str = choice(['\\cos', '\\sin'])
        return problem(
            question=f"Find the total area enclosed by the rose $r = {a}{func_str}({n}\\theta)$.",
            answer=total_area,
            difficulty=(1800, 1950),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"The rose has ${petals}$ petals",
                f"Area of one petal: $\\dfrac{{1}}{{2}}\\displaystyle\\int_0^{{\\pi/{n}}} {a**2}{func_str}^2({n}\\theta)\\,d\\theta = \\dfrac{{\\pi {a**2}}}{{4n}} \\cdot 2 = \\dfrac{{\\pi {a**2}}}{{{2*n}}}$",
                f"Total area: ${petals} \\times \\dfrac{{\\pi {a**2}}}{{{2*n}}} = {latex(total_area)}$"
            )
        )

    else:
        # Arc length of r = a (circle)
        a = randint(2, 8)
        theta1 = 0
        theta2 = choice([pi/2, pi, 3*pi/2, 2*pi])
        arc = simplify(a * theta2)
        frac_str = {pi/2: "\\pi/2", pi: "\\pi", 3*pi/2: "3\\pi/2", 2*pi: "2\\pi"}[theta2]
        return problem(
            question=f"Find the arc length of $r = {a}$ from $\\theta = 0$ to $\\theta = {frac_str}$.",
            answer=arc,
            difficulty=(1700, 1850),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "$L = \\displaystyle\\int_\\alpha^\\beta \\sqrt{r^2 + \\left(\\tfrac{dr}{d\\theta}\\right)^2}\\,d\\theta$",
                f"For $r={a}$ (constant): $\\tfrac{{dr}}{{d\\theta}}=0$",
                f"$L = \\displaystyle\\int_0^{{{frac_str}}} {a}\\,d\\theta = {a}\\cdot{frac_str} = {latex(arc)}$"
            )
        )


emit(generate())
