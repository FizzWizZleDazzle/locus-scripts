"""
precalculus - polar_curves (medium)
"""

from problem_utils import *

THETA_ALL = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6,
             pi, 7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2, 5*pi/3, 7*pi/4, 11*pi/6]


def generate():
    problem_type = choice([
        'convert_polar_to_rect',
        'convert_rect_to_polar',
        'symmetry_test',
        'area_polar',
        'rose_petals',
        'limacon_properties',
    ])

    if problem_type == 'convert_polar_to_rect':
        equation_choice = choice(['circle_r', 'rcos', 'rsin', 'r_acos', 'r_asin'])

        if equation_choice == 'circle_r':
            a_val = randint(1, 10)
            ans = Eq(x**2 + y**2, a_val**2)
            return problem(
                question=f"Convert the polar equation $r = {a_val}$ to rectangular form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $r^2 = x^2 + y^2$: $r = {a_val} \\Rightarrow r^2 = {a_val**2}$",
                    f"${latex(ans)}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

        elif equation_choice == 'rcos':
            a_val = nonzero(-8, 8)
            ans = Eq(x, a_val)
            return problem(
                question=f"Convert $r\\cos\\theta = {a_val}$ to rectangular form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Since $x = r\\cos\\theta$: $x = {a_val}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

        elif equation_choice == 'rsin':
            b_val = nonzero(-8, 8)
            ans = Eq(y, b_val)
            return problem(
                question=f"Convert $r\\sin\\theta = {b_val}$ to rectangular form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(f"Since $y = r\\sin\\theta$: $y = {b_val}$"),
                grading_mode="equivalent",
                answer_type="equation"
            )

        elif equation_choice == 'r_acos':
            a_val = 2 * randint(1, 6)
            ans = Eq(x**2 + y**2, a_val * x)
            return problem(
                question=f"Convert $r = {a_val}\\cos\\theta$ to rectangular form.",
                answer=ans,
                difficulty=(1400, 1550),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Multiply both sides by $r$: $r^2 = {a_val}r\\cos\\theta$",
                    f"Substitute $r^2 = x^2+y^2$, $r\\cos\\theta = x$: ${latex(ans)}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

        else:  # r_asin
            a_val = 2 * randint(1, 6)
            ans = Eq(x**2 + y**2, a_val * y)
            return problem(
                question=f"Convert $r = {a_val}\\sin\\theta$ to rectangular form.",
                answer=ans,
                difficulty=(1400, 1550),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Multiply both sides by $r$: $r^2 = {a_val}r\\sin\\theta$",
                    f"Substitute $r^2 = x^2+y^2$, $r\\sin\\theta = y$: ${latex(ans)}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

    elif problem_type == 'convert_rect_to_polar':
        equation_choice = choice(['circle_origin', 'vertical_line', 'horizontal_line', 'circle_x', 'circle_y'])

        if equation_choice == 'circle_origin':
            a_val = randint(1, 9)
            ans = Eq(Symbol('r'), a_val)
            return problem(
                question=f"Convert $x^2 + y^2 = {a_val**2}$ to polar form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$x^2+y^2 = r^2 \\Rightarrow r^2 = {a_val**2} \\Rightarrow r = {a_val}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

        elif equation_choice == 'vertical_line':
            a_val = nonzero(-6, 6)
            theta = Symbol('theta')
            ans = Eq(Symbol('r') * cos(theta), a_val)
            return problem(
                question=f"Convert $x = {a_val}$ to polar form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(f"$x = r\\cos\\theta$, so $r\\cos\\theta = {a_val}$"),
                grading_mode="equivalent",
                answer_type="equation"
            )

        elif equation_choice == 'horizontal_line':
            b_val = nonzero(-6, 6)
            theta = Symbol('theta')
            ans = Eq(Symbol('r') * sin(theta), b_val)
            return problem(
                question=f"Convert $y = {b_val}$ to polar form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(f"$y = r\\sin\\theta$, so $r\\sin\\theta = {b_val}$"),
                grading_mode="equivalent",
                answer_type="equation"
            )

        elif equation_choice == 'circle_x':
            a_val = 2 * randint(1, 5)
            theta = Symbol('theta')
            ans = Eq(Symbol('r'), a_val * cos(theta))
            return problem(
                question=f"Convert $x^2 + y^2 = {a_val}x$ to polar form.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r^2 = {a_val} \\cdot r\\cos\\theta$, divide by $r$: $r = {a_val}\\cos\\theta$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

        else:  # circle_y
            a_val = 2 * randint(1, 5)
            theta = Symbol('theta')
            ans = Eq(Symbol('r'), a_val * sin(theta))
            return problem(
                question=f"Convert $x^2 + y^2 = {a_val}y$ to polar form.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r^2 = {a_val} \\cdot r\\sin\\theta$, divide by $r$: $r = {a_val}\\sin\\theta$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )

    elif problem_type == 'symmetry_test':
        curve_type = choice(['cos_rose', 'sin_rose', 'cardioid_cos', 'cardioid_sin', 'lemniscate'])
        n = choice([2, 3, 4, 5, 6])
        a_val = randint(1, 5)

        if curve_type == 'cos_rose':
            return problem(
                question=f"Is the polar curve $r = {a_val}\\cos({n}\\theta)$ symmetric about the polar axis (the $x$-axis)?",
                answer=True,
                difficulty=(1400, 1550),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Test: replace $\\theta$ with $-\\theta$",
                    f"$r = {a_val}\\cos({n}(-\\theta)) = {a_val}\\cos({n}\\theta)$: equation unchanged",
                    "Symmetric about polar axis."
                ),
                answer_type="boolean"
            )
        elif curve_type == 'sin_rose':
            return problem(
                question=f"Is the polar curve $r = {a_val}\\sin({n}\\theta)$ symmetric about the line $\\theta = \\pi/2$ (the $y$-axis)?",
                answer=True,
                difficulty=(1400, 1550),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Test: replace $\\theta$ with $\\pi - \\theta$",
                    f"$\\sin(n(\\pi-\\theta)) = \\sin(n\\pi - n\\theta)$: for odd $n$ equals $\\sin(n\\theta)$",
                    "Symmetric about $\\theta = \\pi/2$."
                ),
                answer_type="boolean"
            )
        elif curve_type == 'cardioid_cos':
            return problem(
                question=f"Is the cardioid $r = {a_val}(1 + \\cos\\theta)$ symmetric about the polar axis?",
                answer=True,
                difficulty=(1400, 1500),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Replace $\\theta$ with $-\\theta$: $\\cos(-\\theta) = \\cos\\theta$, equation unchanged",
                    "Symmetric about the polar axis."
                ),
                answer_type="boolean"
            )
        elif curve_type == 'cardioid_sin':
            return problem(
                question=f"Is the cardioid $r = {a_val}(1 + \\sin\\theta)$ symmetric about the line $\\theta = \\pi/2$?",
                answer=True,
                difficulty=(1400, 1500),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Replace $\\theta$ with $\\pi - \\theta$: $\\sin(\\pi-\\theta) = \\sin\\theta$, equation unchanged",
                    "Symmetric about $\\theta = \\pi/2$."
                ),
                answer_type="boolean"
            )
        else:  # lemniscate
            return problem(
                question=f"Is the lemniscate $r^2 = {a_val**2}\\cos(2\\theta)$ symmetric about both axes?",
                answer=True,
                difficulty=(1500, 1600),
                topic="precalculus/polar_curves",
                solution=steps(
                    "Replace $\\theta \\to -\\theta$: $\\cos(-2\\theta) = \\cos(2\\theta)$ ✓ (polar axis)",
                    "Replace $(r,\\theta) \\to (-r,\\theta)$: $(-r)^2 = r^2$ ✓ (pole)",
                    "Symmetric about both axes and the pole."
                ),
                answer_type="boolean"
            )

    elif problem_type == 'area_polar':
        a_val = randint(1, 7)
        curve_choice = choice(['circle', 'semicircle', 'rose2'])

        if curve_choice == 'circle':
            ans = pi * a_val**2
            return problem(
                question=f"Find the area enclosed by the polar curve $r = {a_val}$.",
                answer=ans,
                difficulty=(1400, 1550),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$A = \\dfrac{1}{2}\\int_0^{2\\pi} r^2\\, d\\theta$",
                    f"$= \\dfrac{1}{2} \\cdot {a_val**2} \\cdot 2\\pi = {a_val**2}\\pi$"
                ),
                calculator="scientific"
            )
        elif curve_choice == 'semicircle':
            # Area of r = a from 0 to pi: pi*a^2/2
            ans = pi * a_val**2 / 2
            return problem(
                question=f"Find the area swept by $r = {a_val}$ from $\\theta = 0$ to $\\theta = \\pi$.",
                answer=ans,
                difficulty=(1400, 1550),
                topic="precalculus/polar_curves",
                solution=steps(
                    "$A = \\dfrac{1}{2}\\int_0^{\\pi} {a_val**2}\\, d\\theta = \\dfrac{{{a_val**2}\\pi}}{{2}}$"
                ),
                calculator="scientific"
            )
        else:
            # Area of one petal of r = a*cos(2*theta): pi*a^2/8 per petal
            ans = pi * a_val**2 / 8
            return problem(
                question=f"Find the area enclosed by one petal of the rose $r = {a_val}\\cos(2\\theta)$.",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/polar_curves",
                solution=steps(
                    "One petal lies in $-\\pi/4 \\leq \\theta \\leq \\pi/4$",
                    f"$A = \\dfrac{{1}}{{2}}\\int_{{-\\pi/4}}^{{\\pi/4}} {a_val**2}\\cos^2(2\\theta)\\, d\\theta$",
                    f"$= \\dfrac{{{a_val**2}\\pi}}{{8}}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 'rose_petals':
        # Identify number of petals
        n = choice([2, 3, 4, 5, 6])
        a_val = randint(1, 6)
        trig_str = choice(['\\cos', '\\sin'])
        petals = n if n % 2 == 1 else 2 * n

        return problem(
            question=f"How many petals does the rose curve $r = {a_val}{trig_str}({n}\\theta)$ have?",
            answer=petals,
            difficulty=(1300, 1500),
            topic="precalculus/polar_curves",
            solution=steps(
                f"For $r = a\\,f(n\\theta)$: if $n$ is odd there are $n$ petals; if $n$ is even there are $2n$ petals",
                f"$n = {n}$ ({'odd' if n % 2 == 1 else 'even'}): $\\mathbf{{{petals}}}$ petals"
            )
        )

    else:
        # Limaçon: identify inner loop vs. cardioid vs. dimpled vs. convex
        a_val = randint(1, 6)
        b_val = randint(1, 6)
        trig_str = choice(['\\cos', '\\sin'])
        ratio = Rational(a_val, b_val)

        if a_val < b_val:
            shape = "limaçon with inner loop"
        elif a_val == b_val:
            shape = "cardioid"
        elif a_val < 2 * b_val:
            shape = "dimpled limaçon"
        else:
            shape = "convex limaçon"

        return problem(
            question=f"Classify the polar curve $r = {a_val} + {b_val}{trig_str}(\\theta)$.",
            answer=shape,
            difficulty=(1450, 1600),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Form $r = a + b\\,f(\\theta)$ with $a = {a_val}$, $b = {b_val}$",
                f"Ratio $a/b = {latex(ratio)}$",
                f"$a < b$: inner loop; $a = b$: cardioid; $b < a < 2b$: dimpled; $a \\geq 2b$: convex",
                f"Classification: **{shape}**"
            )
        )

emit(generate())
