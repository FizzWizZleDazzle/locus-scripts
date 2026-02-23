"""
precalculus - polar_curves (hard)
"""

from problem_utils import *


def generate():
    problem_type = choice([
        'area_enclosed',
        'area_between_curves',
        'tangent_line_polar',
        'arc_length_polar',
        'convert_complex',
        'intersection_points',
    ])

    if problem_type == 'area_enclosed':
        # Area of various polar regions
        curve_type = choice(['rose_n3', 'rose_n4', 'cardioid', 'lemniscate_half'])
        a_val = randint(1, 5)

        if curve_type == 'rose_n3':
            # 3-petal rose r=a cos(3theta), area = pi*a^2/4
            ans = pi * a_val**2 / 4
            return problem(
                question=f"Find the total area enclosed by the rose curve $r = {a_val}\\cos(3\\theta)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Three petals; each petal area $= \\dfrac{1}{2}\\int_{-\\pi/6}^{\\pi/6} a^2\\cos^2(3\\theta)\\,d\\theta$",
                    f"Each petal area $= \\dfrac{{{a_val**2}\\pi}}{{12}}$, total $= 3 \\cdot \\dfrac{{{a_val**2}\\pi}}{{12}} = \\dfrac{{{a_val**2}\\pi}}{{4}}$"
                ),
                calculator="scientific"
            )
        elif curve_type == 'rose_n4':
            # 4-petal rose r=a cos(2theta), area of all petals = pi*a^2/2
            ans = pi * a_val**2 / 2
            return problem(
                question=f"Find the total area enclosed by the rose curve $r = {a_val}\\cos(2\\theta)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Four petals; each petal area $= \\dfrac{1}{2}\\int_{-\\pi/4}^{\\pi/4} a^2\\cos^2(2\\theta)\\,d\\theta$",
                    f"Each petal area $= \\dfrac{{{a_val**2}\\pi}}{{8}}$, total $= 4 \\cdot \\dfrac{{{a_val**2}\\pi}}{{8}} = \\dfrac{{{a_val**2}\\pi}}{{2}}$"
                ),
                calculator="scientific"
            )
        elif curve_type == 'cardioid':
            # r = a(1+cos theta), area = 3 pi a^2 / 2
            ans = Rational(3, 2) * pi * a_val**2
            return problem(
                question=f"Find the area enclosed by the cardioid $r = {a_val}(1 + \\cos\\theta)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$A = \\dfrac{1}{2}\\int_0^{2\\pi} a^2(1+\\cos\\theta)^2\\,d\\theta$",
                    "$\\int_0^{2\\pi}(1+\\cos\\theta)^2\\,d\\theta = \\int_0^{2\\pi}(\\tfrac{3}{2}+2\\cos\\theta+\\tfrac{\\cos 2\\theta}{2})\\,d\\theta = 3\\pi$",
                    f"$A = \\dfrac{{{a_val**2}}}{{2}} \\cdot 3\\pi = \\dfrac{{3{a_val**2}\\pi}}{{2}}$"
                ),
                calculator="scientific"
            )
        else:
            # lemniscate r^2 = a^2 cos(2theta), total area = a^2
            ans = a_val**2
            return problem(
                question=f"Find the total area enclosed by the lemniscate $r^2 = {a_val**2}\\cos(2\\theta)$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$A = \\dfrac{1}{2}\\int_{-\\pi/4}^{\\pi/4} r^2\\,d\\theta \\times 2 = \\int_{-\\pi/4}^{\\pi/4} a^2\\cos(2\\theta)\\,d\\theta$",
                    f"$= {a_val**2}[\\tfrac{{\\sin(2\\theta)}}{{2}}]_{{-\\pi/4}}^{{\\pi/4}} = {a_val**2}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 'area_between_curves':
        a_val = randint(1, 4)
        variant = choice(['circle_cardioid', 'two_circles', 'rose_circle'])

        if variant == 'circle_cardioid':
            # Inside r=a(1+cos) and outside r=a
            # Intersection: 1+cos=1 => cos=0 => theta=pi/2, 3pi/2
            # Area = integral from -pi/2 to pi/2 of (cardioid^2 - circle^2)/2
            inner_integrand = (a_val*(1+cos(t)))**2 - a_val**2
            area_part = integrate(inner_integrand, (t, -pi/2, pi/2)) / 2
            ans = simplify(area_part)
            return problem(
                question=f"Find the area inside the cardioid $r = {a_val}(1+\\cos\\theta)$ and outside the circle $r = {a_val}$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Intersection: $\\cos\\theta = 0$, so $\\theta = \\pm\\pi/2$",
                    f"$A = \\dfrac{{1}}{{2}}\\int_{{-\\pi/2}}^{{\\pi/2}}\\left[({a_val}(1+\\cos\\theta))^2 - {a_val}^2\\right]d\\theta = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif variant == 'two_circles':
            b_val = randint(a_val+1, a_val+4)
            # Area inside r=b_val and outside r=a_val cos(theta)
            # Intersection: b_val = a_val cos(theta) => cos(theta) = b_val/a_val
            # Only valid if b_val < a_val
            a_circ = a_val + 2
            b_circ = randint(1, a_circ - 1)
            if a_circ <= 2 * b_circ:
                cos_val = Rational(b_circ, a_circ)
                theta_int = acos(cos_val)
                ans = simplify(
                    (integrate(b_circ**2, (t, theta_int, 2*pi - theta_int)) +
                     integrate((a_circ*cos(t))**2, (t, -theta_int, theta_int))) / 2
                )
            else:
                ans = pi * b_circ**2
            return problem(
                question=f"Find the area inside $r = {b_circ}$ and outside $r = {a_circ}\\cos\\theta$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Find intersections and integrate the appropriate regions",
                    f"$A = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        else:
            # Area of one petal of r = a*cos(2theta), already computed
            ans = pi * a_val**2 / 8
            return problem(
                question=f"Find the area of one petal of the four-petaled rose $r = {a_val}\\cos(2\\theta)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_curves",
                solution=steps(
                    "One petal: $-\\pi/4 \\leq \\theta \\leq \\pi/4$",
                    f"$A = \\dfrac{{1}}{{2}}\\int_{{-\\pi/4}}^{{\\pi/4}} {a_val**2}\\cos^2(2\\theta)\\,d\\theta = \\dfrac{{{a_val**2}\\pi}}{{8}}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 'tangent_line_polar':
        a_val = randint(1, 5)
        theta_opts = [pi/6, pi/4, pi/3, pi/2, 2*pi/3]
        theta_val = choice(theta_opts)

        # Use cardioid r = a(1+cos theta)
        r_at = a_val * (1 + cos(theta_val))
        dr = -a_val * sin(theta_val)

        numer = dr * sin(theta_val) + r_at * cos(theta_val)
        denom = dr * cos(theta_val) - r_at * sin(theta_val)

        if simplify(denom) == 0:
            # Vertical tangent — fall back
            theta_val = pi/6
            r_at = a_val * (1 + cos(theta_val))
            dr = -a_val * sin(theta_val)
            numer = dr * sin(theta_val) + r_at * cos(theta_val)
            denom = dr * cos(theta_val) - r_at * sin(theta_val)

        slope = simplify(numer / denom)
        x_pt = simplify(r_at * cos(theta_val))
        y_pt = simplify(r_at * sin(theta_val))

        return problem(
            question=f"Find the slope of the tangent line to the cardioid $r = {a_val}(1+\\cos\\theta)$ at $\\theta = {latex(theta_val)}$.",
            answer=slope,
            difficulty=(1700, 1850),
            topic="precalculus/polar_curves",
            solution=steps(
                f"At $\\theta = {latex(theta_val)}$: $r = {latex(r_at)}$, $\\frac{{dr}}{{d\\theta}} = {latex(dr)}$",
                f"$\\frac{{dy}}{{dx}} = \\frac{{\\frac{{dr}}{{d\\theta}}\\sin\\theta + r\\cos\\theta}}{{\\frac{{dr}}{{d\\theta}}\\cos\\theta - r\\sin\\theta}}$",
                f"Slope $= {latex(slope)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'arc_length_polar':
        a_val = randint(1, 5)
        variant = choice(['spiral', 'circle_full'])

        if variant == 'spiral':
            # r = a*theta from 0 to 2pi: L = a*integral sqrt(1+theta^2) — complex, use r=a*e^(b theta)
            b_val = Rational(1, 2)
            r_expr = a_val * exp(b_val * t)
            dr_dt = diff(r_expr, t)
            integrand = sqrt(r_expr**2 + dr_dt**2)
            arc_length = integrate(integrand, (t, 0, pi))
            ans = simplify(arc_length)
            return problem(
                question=f"Find the arc length of $r = {a_val}e^{{\\theta/2}}$ from $\\theta=0$ to $\\theta=\\pi$.",
                answer=ans,
                difficulty=(1800, 1950),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$L = \\int_0^\\pi \\sqrt{r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2}\\,d\\theta$",
                    f"$r = {a_val}e^{{\\theta/2}},\\; \\frac{{dr}}{{d\\theta}} = \\frac{{{a_val}}}{{2}}e^{{\\theta/2}}$",
                    f"$r^2 + \\left(\\frac{{dr}}{{d\\theta}}\\right)^2 = {a_val**2}e^\\theta\\left(1 + \\frac{{1}}{{4}}\\right) = \\frac{{5{a_val**2}}}{{4}}e^\\theta$",
                    f"$L = \\frac{{\\sqrt{{5}}{a_val}}}{{2}}[e^{{\\theta/2}}]_0^\\pi = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        else:
            # Arc length of r = a from 0 to 2pi = 2 pi a
            ans = 2 * pi * a_val
            return problem(
                question=f"Find the arc length (circumference) of the circle $r = {a_val}$.",
                answer=ans,
                difficulty=(1650, 1750),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$L = \\int_0^{2\\pi} \\sqrt{r^2 + 0^2}\\,d\\theta = \\int_0^{2\\pi} a\\,d\\theta = 2\\pi a$",
                    f"$= 2\\pi \\cdot {a_val} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 'convert_complex':
        curve_choice = choice(['lemniscate', 'r_cos_theta', 'r_sin_cos'])

        if curve_choice == 'lemniscate':
            a_val = randint(2, 6)
            ans = Eq((x**2 + y**2)**2, a_val**2 * (x**2 - y**2))
            return problem(
                question=f"Convert the polar equation $r^2 = {a_val**2}\\cos(2\\theta)$ to Cartesian form.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$\\cos(2\\theta) = \\cos^2\\theta - \\sin^2\\theta = \\frac{x^2-y^2}{r^2}$",
                    f"$r^4 = {a_val**2}(x^2-y^2)$",
                    f"$(x^2+y^2)^2 = {a_val**2}(x^2-y^2)$"
                ),
                answer_type="equation"
            )

        elif curve_choice == 'r_cos_theta':
            a_val = nonzero(-5, 5)
            rect_ans = Eq((x - a_val)**2 + y**2, a_val**2)
            return problem(
                question=f"Convert $r = {2*a_val}\\cos\\theta$ to Cartesian form (complete the square).",
                answer=rect_ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r^2 = {2*a_val}r\\cos\\theta \\Rightarrow x^2+y^2 = {2*a_val}x$",
                    f"Complete the square: $(x-{a_val})^2 + y^2 = {a_val**2}$"
                ),
                answer_type="equation"
            )

        else:
            # cardioid to rectangular
            a_val = randint(1, 4)
            ans = Eq((x**2 + y**2 - a_val*x)**2, a_val**2*(x**2+y**2))
            return problem(
                question=f"Convert the cardioid $r = {a_val}(1 + \\cos\\theta)$ to Cartesian form.",
                answer=ans,
                difficulty=(1750, 1950),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r = {a_val} + {a_val}\\cos\\theta$",
                    f"$r - {a_val} = {a_val}\\frac{{x}}{{r}}$",
                    f"$(r - {a_val})r = {a_val}x$",
                    f"$(r^2 - {a_val}r)^2 = ({a_val}x)^2 \\Rightarrow (x^2+y^2-{a_val}x)^2 = {a_val**2}(x^2+y^2)$"
                ),
                answer_type="equation"
            )

    else:
        # Intersection points of two polar curves
        a_val = randint(1, 4)
        variant = choice(['cos_sin_same_a', 'circle_rose'])

        if variant == 'cos_sin_same_a':
            # r = a*cos(theta), r = a*sin(theta) => tan(theta)=1, theta=pi/4
            r_at = a_val * sin(pi/4)
            ans = FiniteSet((simplify(r_at), pi/4))
            return problem(
                question=f"Find the non-zero intersection of $r = {a_val}\\cos\\theta$ and $r = {a_val}\\sin\\theta$ in polar form $(r>0)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set equal: ${a_val}\\cos\\theta = {a_val}\\sin\\theta \\Rightarrow \\tan\\theta = 1 \\Rightarrow \\theta = \\pi/4$",
                    f"$r = {a_val}\\sin(\\pi/4) = {latex(simplify(r_at))}$",
                    f"Intersection: $({latex(simplify(r_at))}, \\pi/4)$"
                ),
                answer_type="set"
            )
        else:
            # r = a and r = 2a cos(theta): a = 2a cos => cos = 1/2 => theta = pm pi/3
            ans = FiniteSet((a_val, pi/3), (a_val, -pi/3))
            return problem(
                question=f"Find the intersection points of $r = {a_val}$ and $r = {2*a_val}\\cos\\theta$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set equal: ${a_val} = {2*a_val}\\cos\\theta \\Rightarrow \\cos\\theta = \\frac{{1}}{{2}}$",
                    f"$\\theta = \\pm\\dfrac{{\\pi}}{{3}}$",
                    f"Points: $({a_val}, \\pi/3)$ and $({a_val}, -\\pi/3)$"
                ),
                answer_type="set"
            )

emit(generate())
