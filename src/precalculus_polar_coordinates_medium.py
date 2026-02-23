"""
precalculus - polar_coordinates (medium)
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
        'rect_to_polar',
        'polar_to_rect',
        'polar_distance',
        'polar_equation_convert',
        'polar_symmetry',
        'negative_r',
        'area_circle',
    ])

    if problem_type == 'rect_to_polar':
        # Randomize r and theta, compute (x, y), ask to convert back
        theta = choice(ALL_ANGLES)
        r_val = randint(2, 10)
        x_val = simplify(r_val * cos(theta))
        y_val = simplify(r_val * sin(theta))
        ans = fmt_tuple([r_val, theta])
        return problem(
            question=f"Convert $\\left({latex(x_val)},\\,{latex(y_val)}\\right)$ to polar $(r,\\theta)$ with $r>0$ and $0\\le\\theta<2\\pi$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="precalculus/polar_coordinates",
            answer_type="tuple",
            solution=steps(
                f"$r = \\sqrt{{({latex(x_val)})^2 + ({latex(y_val)})^2}} = {r_val}$",
                f"$\\theta = \\operatorname{{atan2}}({latex(y_val)},\\,{latex(x_val)}) = {latex(theta)}$",
                f"$(r,\\theta) = ({r_val},\\,{latex(theta)})$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'polar_to_rect':
        theta = choice(ALL_ANGLES)
        r_val = randint(2, 12)
        x_val = simplify(r_val * cos(theta))
        y_val = simplify(r_val * sin(theta))
        ans = fmt_tuple([x_val, y_val])
        return problem(
            question=f"Convert the polar coordinates $\\left({r_val},\\,{latex(theta)}\\right)$ to rectangular $(x,y)$.",
            answer=ans,
            difficulty=(1200, 1400),
            topic="precalculus/polar_coordinates",
            answer_type="tuple",
            solution=steps(
                f"$x = {r_val}\\cos\\!\\left({latex(theta)}\\right) = {latex(x_val)}$",
                f"$y = {r_val}\\sin\\!\\left({latex(theta)}\\right) = {latex(y_val)}$",
                f"$(x,y) = ({latex(x_val)},\\,{latex(y_val)})$"
            )
        )

    elif problem_type == 'polar_distance':
        # Distance between two polar points
        r1 = randint(2, 8)
        r2 = randint(2, 8)
        theta1 = choice(ALL_ANGLES[:8])  # 0..pi
        theta2 = choice([a for a in ALL_ANGLES[:8] if a != theta1])
        dist_sq = r1**2 + r2**2 - 2 * r1 * r2 * cos(theta2 - theta1)
        distance = simplify(sqrt(dist_sq))
        return problem(
            question=f"Find the distance between the polar points $({r1},\\,{latex(theta1)})$ and $({r2},\\,{latex(theta2)})$.",
            answer=distance,
            difficulty=(1400, 1600),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "$d = \\sqrt{r_1^2 + r_2^2 - 2r_1r_2\\cos(\\theta_2-\\theta_1)}$",
                f"$d = \\sqrt{{{r1}^2 + {r2}^2 - 2({r1})({r2})\\cos\\!\\left({latex(simplify(theta2-theta1))}\\right)}}$",
                f"$d = {latex(distance)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'polar_equation_convert':
        variant = choice(['x2y2_to_r', 'r_cos_to_x', 'r_sin_to_y',
                          'r_equals_acos', 'r_equals_asin', 'line_to_polar'])

        if variant == 'x2y2_to_r':
            a_val = randint(2, 9)
            return problem(
                question=f"Convert $x^2 + y^2 = {a_val**2}$ to polar form.",
                answer=Eq(symbols('r'), a_val),
                difficulty=(1300, 1450),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    "Substitute $x^2+y^2=r^2$: $r^2={a_val**2}$",
                    f"$r = {a_val}$ (positive)"
                )
            )
        elif variant == 'r_cos_to_x':
            a_val = randint(1, 7)
            return problem(
                question=f"Convert $r\\cos\\theta = {a_val}$ to rectangular form.",
                answer=Eq(x, a_val),
                difficulty=(1200, 1350),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    "$r\\cos\\theta = x$",
                    f"$x = {a_val}$"
                )
            )
        elif variant == 'r_sin_to_y':
            a_val = randint(1, 7)
            return problem(
                question=f"Convert $r\\sin\\theta = {a_val}$ to rectangular form.",
                answer=Eq(y, a_val),
                difficulty=(1200, 1350),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    "$r\\sin\\theta = y$",
                    f"$y = {a_val}$"
                )
            )
        elif variant == 'r_equals_acos':
            a_val = choice([2, 4, 6, 8, 10])
            return problem(
                question=f"Convert $r = {a_val}\\cos\\theta$ to rectangular form.",
                answer=Eq(x**2 + y**2, a_val * x),
                difficulty=(1400, 1550),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    f"Multiply by $r$: $r^2 = {a_val}r\\cos\\theta$",
                    "$r^2=x^2+y^2$, $r\\cos\\theta=x$",
                    f"$x^2+y^2 = {a_val}x$"
                )
            )
        elif variant == 'r_equals_asin':
            a_val = choice([2, 4, 6, 8, 10])
            return problem(
                question=f"Convert $r = {a_val}\\sin\\theta$ to rectangular form.",
                answer=Eq(x**2 + y**2, a_val * y),
                difficulty=(1400, 1550),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    f"Multiply by $r$: $r^2 = {a_val}r\\sin\\theta$",
                    "$r^2=x^2+y^2$, $r\\sin\\theta=y$",
                    f"$x^2+y^2 = {a_val}y$"
                )
            )
        else:
            # y = mx -> r sin = m r cos -> tan(theta) = m
            m = choice([1, 2, 3, -1, -2])
            return problem(
                question=f"Convert $y = {m}x$ to polar form.",
                answer=Eq(symbols('theta'), simplify(atan(m))),
                difficulty=(1350, 1500),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    "$y = mx$ becomes $r\\sin\\theta = m\\,r\\cos\\theta$",
                    "$\\tan\\theta = m$",
                    f"$\\theta = \\arctan({m}) = {latex(simplify(atan(m)))}$"
                )
            )

    elif problem_type == 'polar_symmetry':
        curves = [
            ("r = \\cos\\theta",         "polar axis",
             "Replace $\\theta\\to-\\theta$: $\\cos(-\\theta)=\\cos\\theta$, unchanged"),
            ("r = \\sin\\theta",          "line $\\theta=\\frac{\\pi}{2}$",
             "Replace $\\theta\\to\\pi-\\theta$: $\\sin(\\pi-\\theta)=\\sin\\theta$, unchanged"),
            ("r^2 = \\sin(2\\theta)",     "pole",
             "Replace $(r,\\theta)\\to(-r,\\theta)$: $(-r)^2=r^2$, unchanged"),
            ("r = 1 + \\cos\\theta",      "polar axis",
             "$\\cos(-\\theta)=\\cos\\theta$: symmetric about polar axis"),
            ("r = 2\\sin(3\\theta)",      "line $\\theta=\\frac{\\pi}{2}$",
             "Replace $\\theta\\to\\pi-\\theta$: $\\sin(3(\\pi-\\theta))=\\sin(3\\pi-3\\theta)=\\sin(3\\theta)$ for rose; test by substitution"),
            ("r = 3\\cos(2\\theta)",      "polar axis and line $\\theta=\\frac{\\pi}{2}$",
             "$\\cos(2(-\\theta))=\\cos(2\\theta)$ and $\\cos(2(\\pi-\\theta))=\\cos(2\\pi-2\\theta)=\\cos(2\\theta)$"),
            ("r^2 = \\cos(2\\theta)",     "polar axis, line $\\theta=\\frac{\\pi}{2}$, and pole",
             "Symmetric about all three axes"),
        ]
        eq_str, sym_type, explanation = choice(curves)
        return problem(
            question=f"Determine the symmetry of the polar curve ${eq_str}$.",
            answer=sym_type,
            difficulty=(1400, 1600),
            topic="precalculus/polar_coordinates",
            answer_type="expression",
            solution=steps(
                "Test symmetry by substituting $\\theta\\to-\\theta$, $\\theta\\to\\pi-\\theta$, or $(r,\\theta)\\to(-r,\\theta)$",
                explanation,
                f"Symmetric about: {sym_type}"
            )
        )

    elif problem_type == 'negative_r':
        r_val = randint(2, 9)
        theta_val = choice(ALL_ANGLES)
        pos_theta = simplify(theta_val + pi)
        if pos_theta >= 2 * pi:
            pos_theta = simplify(pos_theta - 2 * pi)
        # Ask for the equivalent point with positive r
        return problem(
            question=(f"Write the polar point $\\left(-{r_val},\\,{latex(theta_val)}\\right)$ "
                      f"as $(r,\\theta)$ with $r>0$ and $0\\le\\theta<2\\pi$."),
            answer=fmt_tuple([r_val, pos_theta]),
            difficulty=(1300, 1450),
            topic="precalculus/polar_coordinates",
            answer_type="tuple",
            solution=steps(
                "Negate $r$ and add $\\pi$ to $\\theta$",
                f"$\\left(-{r_val},\\,{latex(theta_val)}\\right) = \\left({r_val},\\,{latex(theta_val)}+\\pi\\right) = \\left({r_val},\\,{latex(pos_theta)}\\right)$"
            )
        )

    else:
        # Area of circle r = a
        a_val = randint(2, 10)
        area_ans = pi * a_val**2
        return problem(
            question=f"Find the area enclosed by the polar curve $r = {a_val}$.",
            answer=area_ans,
            difficulty=(1400, 1550),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "$A = \\dfrac{1}{2}\\displaystyle\\int_0^{2\\pi} r^2\\,d\\theta$",
                f"$A = \\dfrac{{1}}{{2}}\\int_0^{{2\\pi}} {a_val**2}\\,d\\theta = \\dfrac{{{a_val**2}}}{{2}}\\cdot 2\\pi = {latex(area_ans)}$"
            )
        )


emit(generate())
