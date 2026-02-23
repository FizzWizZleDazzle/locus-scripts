"""
precalculus - trig_identities (easy)
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    # Expanded angle pool including multiples of 15 degrees
    ALL_ANGLES_DEG = [0, 15, 30, 45, 60, 75, 90, 120, 135, 150, 180,
                      210, 225, 240, 270, 300, 315, 330, 360]
    SAFE_TAN_DEG   = [d for d in ALL_ANGLES_DEG if d not in (90, 270)]

    if problem_type == 1:
        # Evaluate basic trig values at a wide pool of special angles
        func_choice = choice(['sin', 'cos', 'tan'])

        if func_choice == 'tan':
            angle_deg = choice(SAFE_TAN_DEG)
        else:
            angle_deg = choice(ALL_ANGLES_DEG)

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
            question=f"Evaluate ${func_name}({angle_deg}^\\circ)$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Convert ${angle_deg}^\\circ$ to radians: ${latex(angle_rad)}$",
                f"${func_name}({latex(angle_rad)}) = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Simplify c*(sin^2 + cos^2) with random coefficient; also vary inner angle multiple
        coeff = randint(1, 9)
        n = randint(1, 5)
        var_str = f"{n}x" if n > 1 else "x"
        expr_str = f"{coeff}(\\sin^2({var_str}) + \\cos^2({var_str}))"

        return problem(
            question=f"Simplify ${expr_str}$ using the Pythagorean identity",
            answer=coeff,
            difficulty=(1100, 1200),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Use the identity $\\sin^2(\\theta) + \\cos^2(\\theta) = 1$",
                f"${expr_str} = {coeff} \\cdot 1 = {coeff}$"
            )
        )

    elif problem_type == 3:
        # Use tan = sin/cos to simplify at a wide range of angles
        ANGLES = [15, 30, 45, 60, 75, 120, 135, 150, 210, 225, 240, 300, 315, 330]
        angle_deg = choice(ANGLES)
        angle_rad = angle_deg * pi / 180
        ans = simplify(tan(angle_rad))

        return problem(
            question=f"Simplify $\\dfrac{{\\sin({angle_deg}^\\circ)}}{{\\cos({angle_deg}^\\circ)}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Use the identity $\\tan(\\theta) = \\dfrac{{\\sin(\\theta)}}{{\\cos(\\theta)}}$",
                f"$\\dfrac{{\\sin({angle_deg}^\\circ)}}{{\\cos({angle_deg}^\\circ)}} = \\tan({angle_deg}^\\circ) = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Pythagorean identity rearrangements with varied form
        variant = randint(1, 4)

        if variant == 1:
            # 1 - sin^2(nx) = cos^2(nx)
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            ans = cos(n * x)**2
            return problem(
                question=f"Simplify $1 - \\sin^2({var_str})$ using the Pythagorean identity",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Pythagorean identity: $\\sin^2(\\theta) + \\cos^2(\\theta) = 1$",
                    f"Rearranged: $\\cos^2(\\theta) = 1 - \\sin^2(\\theta)$",
                    f"Therefore: $1 - \\sin^2({var_str}) = \\cos^2({var_str})$"
                )
            )
        elif variant == 2:
            # 1 - cos^2(nx) = sin^2(nx)
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            ans = sin(n * x)**2
            return problem(
                question=f"Simplify $1 - \\cos^2({var_str})$ using the Pythagorean identity",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Pythagorean identity: $\\sin^2(\\theta) + \\cos^2(\\theta) = 1$",
                    f"Rearranged: $\\sin^2(\\theta) = 1 - \\cos^2(\\theta)$",
                    f"Therefore: $1 - \\cos^2({var_str}) = \\sin^2({var_str})$"
                )
            )
        elif variant == 3:
            # sec^2 - 1 = tan^2
            n = randint(1, 3)
            var_str = f"{n}x" if n > 1 else "x"
            ans = tan(n * x)**2
            return problem(
                question=f"Simplify $\\sec^2({var_str}) - 1$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Use the identity $\\tan^2(\\theta) + 1 = \\sec^2(\\theta)$",
                    f"Rearranged: $\\sec^2(\\theta) - 1 = \\tan^2(\\theta)$",
                    f"Therefore: $\\sec^2({var_str}) - 1 = \\tan^2({var_str})$"
                )
            )
        else:
            # csc^2 - 1 = cot^2
            n = randint(1, 3)
            var_str = f"{n}x" if n > 1 else "x"
            ans = cot(n * x)**2
            return problem(
                question=f"Simplify $\\csc^2({var_str}) - 1$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Use the identity $1 + \\cot^2(\\theta) = \\csc^2(\\theta)$",
                    f"Rearranged: $\\csc^2(\\theta) - 1 = \\cot^2(\\theta)$",
                    f"Therefore: $\\csc^2({var_str}) - 1 = \\cot^2({var_str})$"
                )
            )

    elif problem_type == 5:
        # Reciprocal identities: identify sec, csc, cot from their definitions
        variant = randint(1, 3)

        if variant == 1:
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            return problem(
                question=f"Simplify $\\dfrac{{1}}{{\\cos({var_str})}}$",
                answer=sec(n * x),
                difficulty=(1000, 1100),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"By definition, $\\sec(\\theta) = \\dfrac{{1}}{{\\cos(\\theta)}}$",
                    f"So $\\dfrac{{1}}{{\\cos({var_str})}} = \\sec({var_str})$"
                )
            )
        elif variant == 2:
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            return problem(
                question=f"Simplify $\\dfrac{{1}}{{\\sin({var_str})}}$",
                answer=csc(n * x),
                difficulty=(1000, 1100),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"By definition, $\\csc(\\theta) = \\dfrac{{1}}{{\\sin(\\theta)}}$",
                    f"So $\\dfrac{{1}}{{\\sin({var_str})}} = \\csc({var_str})$"
                )
            )
        else:
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            return problem(
                question=f"Simplify $\\dfrac{{\\cos({var_str})}}{{\\sin({var_str})}}$",
                answer=cot(n * x),
                difficulty=(1000, 1100),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"By definition, $\\cot(\\theta) = \\dfrac{{\\cos(\\theta)}}{{\\sin(\\theta)}}$",
                    f"So $\\dfrac{{\\cos({var_str})}}{{\\sin({var_str})}} = \\cot({var_str})$"
                )
            )

    else:
        # Double-angle identity recognition: 2*sin*cos = sin(2*angle)
        variant = randint(1, 3)
        n = randint(1, 4)
        var_str = f"{n}x" if n > 1 else "x"

        if variant == 1:
            # 2*sin(nx)*cos(nx) = sin(2nx)
            double_n = 2 * n
            double_var = f"{double_n}x"
            ans = sin(double_n * x)
            return problem(
                question=f"Simplify $2\\sin({var_str})\\cos({var_str})$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Use the double-angle identity: $\\sin(2\\theta) = 2\\sin(\\theta)\\cos(\\theta)$",
                    f"Here $\\theta = {var_str}$",
                    f"$2\\sin({var_str})\\cos({var_str}) = \\sin({double_var})$"
                )
            )
        elif variant == 2:
            # cos^2(nx) - sin^2(nx) = cos(2nx)
            double_n = 2 * n
            double_var = f"{double_n}x"
            ans = cos(double_n * x)
            return problem(
                question=f"Simplify $\\cos^2({var_str}) - \\sin^2({var_str})$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Use the double-angle identity: $\\cos(2\\theta) = \\cos^2(\\theta) - \\sin^2(\\theta)$",
                    f"Here $\\theta = {var_str}$",
                    f"$\\cos^2({var_str}) - \\sin^2({var_str}) = \\cos({double_var})$"
                )
            )
        else:
            # half-angle: sin^2(nx) = (1 - cos(2nx))/2
            double_n = 2 * n
            double_var = f"{double_n}x"
            ans = (1 - cos(double_n * x)) / 2
            return problem(
                question=f"Use a power reduction formula to express $\\sin^2({var_str})$ without squares.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Power reduction: $\\sin^2(\\theta) = \\dfrac{{1 - \\cos(2\\theta)}}{{2}}$",
                    f"Substitute $\\theta = {var_str}$:",
                    f"$\\sin^2({var_str}) = \\dfrac{{1 - \\cos({double_var})}}{{2}}$"
                )
            )

emit(generate())
