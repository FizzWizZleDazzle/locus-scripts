"""
precalculus - unit_circle (easy)
"""

from problem_utils import *

# All 16 standard angles (every 22.5° is non-exact, so stick to 30-family + 45-family)
ANGLES_DEG = [0, 30, 45, 60, 90, 120, 135, 150, 180,
              210, 225, 240, 270, 300, 315, 330, 360]
SAFE_TAN   = [d for d in ANGLES_DEG if d not in (90, 270, 360)]

# Extended Pythagorean triples for "find the other trig value" problems
TRIPLES = [(3,4,5), (5,12,13), (8,15,17), (7,24,25), (20,21,29), (9,40,41)]


def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Find exact value of sin/cos/tan
        func_choice = choice(['sin', 'cos', 'tan'])
        if func_choice == 'tan':
            angle_deg = choice(SAFE_TAN)
        else:
            angle_deg = choice(ANGLES_DEG)

        angle_rad = angle_deg * pi / 180
        if func_choice == 'sin':
            ans = simplify(sin(angle_rad))
            func_name = '\\sin'
        elif func_choice == 'cos':
            ans = simplify(cos(angle_rad))
            func_name = '\\cos'
        else:
            ans = simplify(tan(angle_rad))
            func_name = '\\tan'

        return problem(
            question=f"Find the exact value: ${func_name}\\!\\left({latex(angle_rad)}\\right)$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The angle ${latex(angle_rad)}$ rad $= {angle_deg}^\\circ$",
                f"Using the unit circle: ${func_name}({angle_deg}^\\circ) = {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Convert between degrees and radians
        convert_to = choice(['radians', 'degrees'])
        if convert_to == 'radians':
            angle_deg = choice([d for d in ANGLES_DEG if d != 0])
            ans = simplify(angle_deg * pi / 180)
            return problem(
                question=f"Convert ${angle_deg}^\\circ$ to radians.",
                answer=ans,
                difficulty=(1000, 1150),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"Multiply by $\\dfrac{{\\pi}}{{180}}$: ${angle_deg} \\times \\dfrac{{\\pi}}{{180}} = {latex(ans)}$"
                )
            )
        else:
            common_rads = [pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi,
                           7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2, 5*pi/3, 7*pi/4, 11*pi/6, 2*pi]
            angle_rad = choice(common_rads)
            ans = simplify(angle_rad * 180 / pi)
            return problem(
                question=f"Convert ${latex(angle_rad)}$ radians to degrees.",
                answer=ans,
                difficulty=(1000, 1150),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"Multiply by $\\dfrac{{180}}{{\\pi}}$: ${latex(angle_rad)} \\times \\dfrac{{180}}{{\\pi}} = {latex(ans)}^\\circ$"
                )
            )

    elif problem_type == 3:
        # Find the reference angle — varied quadrants
        angle_deg = choice([d for d in ANGLES_DEG if d not in (0, 90, 180, 270, 360)])

        if 90 < angle_deg <= 180:
            ref = 180 - angle_deg
            quad = "II"
        elif 180 < angle_deg <= 270:
            ref = angle_deg - 180
            quad = "III"
        else:
            ref = 360 - angle_deg
            quad = "IV"

        return problem(
            question=f"Find the reference angle for ${angle_deg}^\\circ$.",
            answer=ref,
            difficulty=(1100, 1200),
            topic="precalculus/unit_circle",
            solution=steps(
                f"${angle_deg}^\\circ$ is in quadrant {quad}",
                f"Reference angle $= {ref}^\\circ$"
            )
        )

    elif problem_type == 4:
        # Find (x, y) coordinates on the unit circle
        angle_deg = choice(ANGLES_DEG)
        angle_rad = angle_deg * pi / 180
        x_coord = simplify(cos(angle_rad))
        y_coord = simplify(sin(angle_rad))

        # Randomly ask for x, y, or both
        ask = choice(['x', 'y', 'both'])
        if ask == 'x':
            return problem(
                question=f"On the unit circle at angle ${latex(angle_rad)}$ rad, what is the $x$-coordinate?",
                answer=x_coord,
                difficulty=(1100, 1250),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"$x = \\cos\\theta = \\cos({angle_deg}^\\circ) = {latex(x_coord)}$"
                )
            )
        elif ask == 'y':
            return problem(
                question=f"On the unit circle at angle ${latex(angle_rad)}$ rad, what is the $y$-coordinate?",
                answer=y_coord,
                difficulty=(1100, 1250),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"$y = \\sin\\theta = \\sin({angle_deg}^\\circ) = {latex(y_coord)}$"
                )
            )
        else:
            return problem(
                question=f"Find the coordinates $(x, y)$ on the unit circle at ${latex(angle_rad)}$ radians.",
                answer=(x_coord, y_coord),
                difficulty=(1100, 1250),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"$x = \\cos({angle_deg}^\\circ) = {latex(x_coord)}$",
                    f"$y = \\sin({angle_deg}^\\circ) = {latex(y_coord)}$"
                )
            )

    else:
        # Given one trig value and quadrant, find another using Pythagorean identity
        triple = choice(TRIPLES)
        a_val, b_val, c_val = triple
        given_func = choice(['sin', 'cos'])
        quadrant = choice([1, 2, 3, 4])

        if given_func == 'sin':
            given_val = Rational(a_val, c_val)
            # cos^2 = 1 - sin^2 = b^2/c^2
            cos_mag = Rational(b_val, c_val)
            if quadrant in (1, 4):
                ans = cos_mag
                sign_str = "positive"
            else:
                ans = -cos_mag
                sign_str = "negative"
            return problem(
                question=f"If $\\sin\\theta = {latex(given_val)}$ and $\\theta$ is in quadrant {quadrant}, find $\\cos\\theta$.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"$\\cos^2\\theta = 1 - \\sin^2\\theta = 1 - {latex(given_val**2)} = {latex(cos_mag**2)}$",
                    f"$\\cos\\theta = \\pm{latex(cos_mag)}$",
                    f"Quadrant {quadrant}: cosine is {sign_str}",
                    f"$\\cos\\theta = {latex(ans)}$"
                )
            )
        else:
            given_val = Rational(b_val, c_val)
            sin_mag = Rational(a_val, c_val)
            if quadrant in (1, 2):
                ans = sin_mag
                sign_str = "positive"
            else:
                ans = -sin_mag
                sign_str = "negative"
            return problem(
                question=f"If $\\cos\\theta = {latex(given_val)}$ and $\\theta$ is in quadrant {quadrant}, find $\\sin\\theta$.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"$\\sin^2\\theta = 1 - \\cos^2\\theta = 1 - {latex(given_val**2)} = {latex(sin_mag**2)}$",
                    f"$\\sin\\theta = \\pm{latex(sin_mag)}$",
                    f"Quadrant {quadrant}: sine is {sign_str}",
                    f"$\\sin\\theta = {latex(ans)}$"
                )
            )

emit(generate())
