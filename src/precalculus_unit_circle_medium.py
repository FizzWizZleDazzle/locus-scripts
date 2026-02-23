"""
precalculus - unit_circle (medium)
"""

from problem_utils import *

REFERENCES = [pi/6, pi/4, pi/3]
TRIPLES = [(3,4,5), (5,12,13), (8,15,17), (7,24,25), (20,21,29), (9,40,41)]


def _make_angle(quadrant, reference):
    """Return angle in [0, 2pi) in the given quadrant with given reference."""
    if quadrant == 1:
        return reference
    elif quadrant == 2:
        return pi - reference
    elif quadrant == 3:
        return pi + reference
    else:
        return 2*pi - reference


def generate():
    problem_type = choice([
        'find_angle_given_value',
        'find_trig_value',
        'find_from_point',
        'reference_angle',
        'find_coordinates',
        'find_angle_from_point',
        'find_second_trig',
        'arc_or_sector',
    ])

    if problem_type == 'find_angle_given_value':
        # Given sin or cos value, find angle in [0, 2pi)
        # Vary reference angles across pi/6, pi/4, pi/3
        # and all four quadrants
        quadrant = randint(1, 4)
        reference = choice(REFERENCES)
        angle = _make_angle(quadrant, reference)
        trig_func = choice(['sin', 'cos'])

        if trig_func == 'sin':
            value = simplify(sin(angle))
            func_name = '\\sin'
        else:
            value = simplify(cos(angle))
            func_name = '\\cos'

        return problem(
            question=f"Find $\\theta \\in [0, 2\\pi)$ such that ${func_name}(\\theta) = {latex(value)}$",
            answer=angle,
            difficulty=(1300, 1500),
            topic="precalculus/unit_circle",
            solution=steps(
                f"Reference angle: ${latex(reference)}$",
                f"Quadrant {quadrant} gives $\\theta = {latex(angle)}$"
            )
        )

    elif problem_type == 'find_trig_value':
        # Evaluate sin/cos/tan at any of 16 standard angles
        all_angles_deg = [0, 30, 45, 60, 90, 120, 135, 150, 180,
                          210, 225, 240, 270, 300, 315, 330]
        angle_deg = choice(all_angles_deg)
        angle_rad = angle_deg * pi / 180
        trig_func = choice(['sin', 'cos', 'tan'])

        if trig_func == 'tan' and angle_deg in (90, 270):
            trig_func = choice(['sin', 'cos'])

        if trig_func == 'sin':
            ans = simplify(sin(angle_rad))
            func_name = '\\sin'
        elif trig_func == 'cos':
            ans = simplify(cos(angle_rad))
            func_name = '\\cos'
        else:
            ans = simplify(tan(angle_rad))
            func_name = '\\tan'

        return problem(
            question=f"Evaluate ${func_name}\\!\\left({latex(angle_rad)}\\right)$ exactly.",
            answer=ans,
            difficulty=(1200, 1400),
            topic="precalculus/unit_circle",
            solution=steps(
                f"${angle_deg}^\\circ$ is in the standard unit circle",
                f"${func_name}({angle_deg}^\\circ) = {latex(ans)}$"
            )
        )

    elif problem_type == 'find_from_point':
        # Given a point on the unit circle, find sin/cos/tan
        quadrant = randint(1, 4)
        reference = choice(REFERENCES)
        angle = _make_angle(quadrant, reference)
        x_coord = simplify(cos(angle))
        y_coord = simplify(sin(angle))

        trig_func = choice(['sin', 'cos', 'tan'])
        if trig_func == 'sin':
            ans = y_coord
            func_name = '\\sin'
        elif trig_func == 'cos':
            ans = x_coord
            func_name = '\\cos'
        else:
            ans = simplify(tan(angle))
            func_name = '\\tan'

        return problem(
            question=f"The terminal side of $\\theta$ passes through $\\left({latex(x_coord)},\\,{latex(y_coord)}\\right)$ on the unit circle. Find ${func_name}(\\theta)$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="precalculus/unit_circle",
            solution=steps(
                f"On the unit circle $x = \\cos\\theta$, $y = \\sin\\theta$",
                f"${func_name}(\\theta) = {latex(ans)}$"
            )
        )

    elif problem_type == 'reference_angle':
        # Find reference angle, varied quadrant and reference
        quadrant = randint(2, 4)
        reference = choice(REFERENCES + [pi/2])
        angle = _make_angle(quadrant, reference)
        if reference == pi/2:
            reference = pi/2  # boundary; ref angle = 0 or pi/2

        return problem(
            question=f"Find the reference angle for $\\theta = {latex(angle)}$.",
            answer=reference,
            difficulty=(1200, 1400),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The angle ${latex(angle)}$ is in quadrant {quadrant}",
                f"Reference angle $= {latex(reference)}$"
            )
        )

    elif problem_type == 'find_coordinates':
        quadrant = randint(1, 4)
        reference = choice(REFERENCES)
        angle = _make_angle(quadrant, reference)
        x_coord = simplify(cos(angle))
        y_coord = simplify(sin(angle))

        return problem(
            question=f"Find the coordinates on the unit circle at $\\theta = {latex(angle)}$.",
            answer=fmt_tuple([x_coord, y_coord]),
            difficulty=(1300, 1500),
            topic="precalculus/unit_circle",
            answer_type="tuple",
            solution=steps(
                f"$x = \\cos({latex(angle)}) = {latex(x_coord)}$",
                f"$y = \\sin({latex(angle)}) = {latex(y_coord)}$",
                f"Point: $({latex(x_coord)}, {latex(y_coord)})$"
            )
        )

    elif problem_type == 'find_angle_from_point':
        quadrant = randint(1, 4)
        reference = choice(REFERENCES)
        angle = _make_angle(quadrant, reference)
        x_coord = simplify(cos(angle))
        y_coord = simplify(sin(angle))

        return problem(
            question=f"Find the angle $\\theta \\in [0, 2\\pi)$ for the unit-circle point $\\left({latex(x_coord)},\\,{latex(y_coord)}\\right)$.",
            answer=angle,
            difficulty=(1400, 1600),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The point is in quadrant {quadrant}",
                f"Reference angle $= {latex(reference)}$",
                f"$\\theta = {latex(angle)}$"
            )
        )

    elif problem_type == 'find_second_trig':
        # Given one trig value and quadrant, find a different one
        triple = choice(TRIPLES)
        a_val, b_val, c_val = triple
        quadrant = choice([1, 2, 3, 4])
        given_func = choice(['sin', 'cos'])
        find_func = choice(['cos', 'tan', 'sin'])
        while find_func == given_func:
            find_func = choice(['cos', 'tan', 'sin'])

        if given_func == 'sin':
            sin_mag = Rational(a_val, c_val)
            cos_mag = Rational(b_val, c_val)
            sin_val = sin_mag if quadrant in (1, 2) else -sin_mag
            cos_val = cos_mag if quadrant in (1, 4) else -cos_mag
        else:
            sin_mag = Rational(a_val, c_val)
            cos_mag = Rational(b_val, c_val)
            cos_val = cos_mag if quadrant in (1, 4) else -cos_mag
            sin_val = sin_mag if quadrant in (1, 2) else -sin_mag

        if find_func == 'cos':
            given_val = sin_val
            ans = cos_val
        elif find_func == 'sin':
            given_val = cos_val
            ans = sin_val
        else:
            given_val = sin_val if given_func == 'sin' else cos_val
            ans = sin_val / cos_val

        func_name = {'sin': '\\sin', 'cos': '\\cos', 'tan': '\\tan'}
        return problem(
            question=f"If ${func_name[given_func]}\\theta = {latex(given_val)}$ and $\\theta$ is in quadrant {quadrant}, find ${func_name[find_func]}\\theta$.",
            answer=simplify(ans),
            difficulty=(1400, 1600),
            topic="precalculus/unit_circle",
            solution=steps(
                f"$\\sin^2\\theta + \\cos^2\\theta = 1$",
                f"$\\sin\\theta = {latex(sin_val)}$, $\\cos\\theta = {latex(cos_val)}$",
                f"${func_name[find_func]}\\theta = {latex(simplify(ans))}$"
            )
        )

    else:
        # Arc length and sector area
        radius = randint(2, 15)
        angle_num = choice([1, 2, 3, 4, 5, 7, 11])
        angle_den = choice([3, 4, 6, 12])
        angle = Rational(angle_num, angle_den) * pi
        use_arc = choice([True, False])

        if use_arc:
            ans = simplify(radius * angle)
            return problem(
                question=f"Find the arc length of a circle with radius ${radius}$ subtended by a central angle of ${latex(angle)}$ radians.",
                answer=ans,
                difficulty=(1300, 1500),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$s = r\\theta$",
                    f"$s = {radius} \\cdot {latex(angle)} = {latex(ans)}$"
                )
            )
        else:
            ans = simplify(Rational(1, 2) * radius**2 * angle)
            return problem(
                question=f"Find the area of a sector with radius ${radius}$ and central angle ${latex(angle)}$ radians.",
                answer=ans,
                difficulty=(1300, 1500),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$A = \\dfrac{1}{2}r^2\\theta$",
                    f"$A = \\dfrac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(angle)} = {latex(ans)}$"
                )
            )

emit(generate())
