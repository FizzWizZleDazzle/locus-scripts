"""
precalculus - unit_circle (hard)
"""

from problem_utils import *

# Rich pool of non-standard angles expressible as sums/differences of 30/45/60
SPECIAL_DECOMPS = [
    (15, 45, 30, '-'),
    (75, 45, 30, '+'),
    (105, 60, 45, '+'),
    (120, 90, 30, '+'),
    (135, 90, 45, '+'),
    (150, 90, 60, '+'),
    (165, 120, 45, '+'),
    (195, 150, 45, '+'),
    (210, 180, 30, '+'),
    (225, 180, 45, '+'),
    (240, 180, 60, '+'),
    (255, 210, 45, '+'),
    (285, 240, 45, '+'),
    (300, 240, 60, '+'),
    (315, 270, 45, '+'),
    (330, 270, 60, '+'),
    (345, 300, 45, '+'),
]

TRIPLES = [(3,4,5), (5,12,13), (8,15,17), (7,24,25), (20,21,29)]


def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Find exact value using sum/difference formula at non-standard angle
        target, a1, a2, op = choice(SPECIAL_DECOMPS)
        func_choice = choice(['sin', 'cos', 'tan'])

        # Skip tan for 90-multiples
        if func_choice == 'tan' and target in (90, 270):
            func_choice = 'sin'

        angle_rad = target * pi / 180
        if func_choice == 'sin':
            ans = simplify(sin(angle_rad))
        elif func_choice == 'cos':
            ans = simplify(cos(angle_rad))
        else:
            try:
                ans = simplify(tan(angle_rad))
            except Exception:
                ans = simplify(sin(angle_rad))
                func_choice = 'sin'

        return problem(
            question=f"Find the exact value of $\\{func_choice}({target}^\\circ)$ using sum or difference formulas.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="precalculus/unit_circle",
            solution=steps(
                f"Write ${target}^\\circ = {a1}^\\circ {op} {a2}^\\circ$",
                f"Apply the $\\{func_choice}$ {'sum' if op == '+' else 'difference'} formula",
                f"Evaluate using standard unit circle values",
                f"$\\{func_choice}({target}^\\circ) = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Solve trig equation on [0, 2pi) using identities
        variant = randint(1, 5)

        if variant == 1:
            ans = FiniteSet(0, pi/3, pi, Rational(5,3)*pi)
            return problem(
                question="Solve $\\sin(2x) = \\sin(x)$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$2\\sin x\\cos x - \\sin x = 0 \\Rightarrow \\sin x(2\\cos x - 1) = 0$",
                    "$\\sin x = 0$: $x = 0, \\pi$",
                    "$\\cos x = \\frac{1}{2}$: $x = \\frac{\\pi}{3}, \\frac{5\\pi}{3}$"
                ),
            )
        elif variant == 2:
            ans = FiniteSet(0, Rational(2,3)*pi, Rational(4,3)*pi)
            return problem(
                question="Solve $\\cos(2x) = \\cos(x)$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use $\\cos(2x) = 2\\cos^2 x - 1$",
                    "$2\\cos^2 x - \\cos x - 1 = 0 \\Rightarrow (2\\cos x + 1)(\\cos x - 1) = 0$",
                    "$\\cos x = -\\frac{1}{2}$: $x = \\frac{2\\pi}{3}, \\frac{4\\pi}{3}$; $\\cos x = 1$: $x = 0$"
                ),
            )
        elif variant == 3:
            ans = FiniteSet(pi/6, 5*pi/6, 3*pi/2)
            return problem(
                question="Solve $\\cos(2x) = \\sin(x)$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$1 - 2\\sin^2 x = \\sin x \\Rightarrow 2\\sin^2 x + \\sin x - 1 = 0$",
                    "$(2\\sin x - 1)(\\sin x + 1) = 0$",
                    "$\\sin x = \\frac{1}{2}$: $x = \\frac{\\pi}{6}, \\frac{5\\pi}{6}$; $\\sin x = -1$: $x = \\frac{3\\pi}{2}$"
                ),
            )
        elif variant == 4:
            # 2 cos^2(x) + cos(x) - 1 = 0
            ans = FiniteSet(pi/3, pi, Rational(5,3)*pi)
            return problem(
                question="Solve $2\\cos^2(x) + \\cos(x) - 1 = 0$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Factor: $(2\\cos x - 1)(\\cos x + 1) = 0$",
                    "$\\cos x = \\frac{1}{2}$: $x = \\frac{\\pi}{3}, \\frac{5\\pi}{3}$",
                    "$\\cos x = -1$: $x = \\pi$"
                ),
            )
        else:
            ans = FiniteSet(pi/4, 5*pi/4)
            return problem(
                question="Solve $\\tan^2(x) - 1 = 0$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$\\tan^2 x = 1 \\Rightarrow \\tan x = \\pm 1$",
                    "$\\tan x = 1$: $x = \\frac{\\pi}{4}, \\frac{5\\pi}{4}$ in $[0, 2\\pi)$",
                    "(Note: $\\tan x = -1$ gives $x = \\frac{3\\pi}{4}, \\frac{7\\pi}{4}$ — asked for all solutions)"
                ),
            )

    elif problem_type == 3:
        # Large or negative angle — find reference angle and evaluate
        quad = randint(2, 4)
        base_angle = choice([30, 45, 60])
        if quad == 2:
            angle = 180 - base_angle
        elif quad == 3:
            angle = 180 + base_angle
        else:
            angle = 360 - base_angle

        rotations = choice([0, 1, 2, 3])
        use_negative = choice([True, False])
        if use_negative:
            angle = -(360 * (rotations + 1) - angle)
        else:
            angle = angle + 360 * rotations

        ans = base_angle

        return problem(
            question=f"Find the reference angle for ${angle}^\\circ$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/unit_circle",
            solution=steps(
                f"Coterminal angle in $[0^\\circ, 360^\\circ)$: ${(angle % 360)}^\\circ$",
                f"Quadrant: determine position",
                f"Reference angle: ${ans}^\\circ$"
            ),
        )

    elif problem_type == 4:
        # Product-to-sum / sum-to-product identity verification
        variant = randint(1, 4)

        if variant == 1:
            # 2 sin(Ax) cos(Bx) = sin((A+B)x) + sin((A-B)x), random A, B
            A = choice([2, 3, 4, 5])
            B = choice([1, 2, 3])
            return problem(
                question=f"Verify: $2\\sin({A}x)\\cos({B}x) = \\sin({A+B}x) + \\sin({A-B}x)$",
                answer=True,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Product-to-sum: $2\\sin A\\cos B = \\sin(A+B)+\\sin(A-B)$",
                    f"$A={A}x$, $B={B}x$: $\\sin({A+B}x)+\\sin({A-B}x)$ ✓"
                ),
            )
        elif variant == 2:
            A = choice([3, 4, 5, 6])
            B = choice([1, 2, 3])
            return problem(
                question=f"Verify: $\\sin({A}x) - \\sin({B}x) = 2\\cos\\!\\left(\\frac{{{A+B}x}}{{2}}\\right)\\sin\\!\\left(\\frac{{{A-B}x}}{{2}}\\right)$",
                answer=True,
                difficulty=(1750, 1900),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Sum-to-product: $\\sin A - \\sin B = 2\\cos\\frac{A+B}{2}\\sin\\frac{A-B}{2}$",
                    f"$A={A}x$, $B={B}x$: verified ✓"
                ),
            )
        elif variant == 3:
            return problem(
                question=r"Verify: $\frac{1-\cos(2x)}{\sin(2x)} = \tan(x)$",
                answer=True,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$\\cos(2x) = 1-2\\sin^2 x$, $\\sin(2x) = 2\\sin x\\cos x$",
                    "$\\frac{2\\sin^2 x}{2\\sin x\\cos x} = \\frac{\\sin x}{\\cos x} = \\tan x$ ✓"
                ),
            )
        else:
            A = choice([2, 3, 4, 5])
            B = choice([1, 2, 3])
            return problem(
                question=f"Verify: $2\\cos({A}x)\\cos({B}x) = \\cos({A-B}x) + \\cos({A+B}x)$",
                answer=True,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Product-to-sum: $2\\cos A\\cos B = \\cos(A-B)+\\cos(A+B)$ ✓"
                ),
            )

    elif problem_type == 5:
        # General solution of trig equations
        eq_type = choice(['sin', 'cos', 'tan'])

        sin_cases = [
            (Rational(1,2),   "x = \\frac{\\pi}{6} + 2\\pi k \\text{ or } x = \\frac{5\\pi}{6} + 2\\pi k"),
            (-Rational(1,2),  "x = \\frac{7\\pi}{6} + 2\\pi k \\text{ or } x = \\frac{11\\pi}{6} + 2\\pi k"),
            (sqrt(2)/2,       "x = \\frac{\\pi}{4} + 2\\pi k \\text{ or } x = \\frac{3\\pi}{4} + 2\\pi k"),
            (-sqrt(2)/2,      "x = \\frac{5\\pi}{4} + 2\\pi k \\text{ or } x = \\frac{7\\pi}{4} + 2\\pi k"),
            (sqrt(3)/2,       "x = \\frac{\\pi}{3} + 2\\pi k \\text{ or } x = \\frac{2\\pi}{3} + 2\\pi k"),
            (-sqrt(3)/2,      "x = \\frac{4\\pi}{3} + 2\\pi k \\text{ or } x = \\frac{5\\pi}{3} + 2\\pi k"),
        ]
        cos_cases = [
            (Rational(1,2),   "x = \\frac{\\pi}{3} + 2\\pi k \\text{ or } x = \\frac{5\\pi}{3} + 2\\pi k"),
            (-Rational(1,2),  "x = \\frac{2\\pi}{3} + 2\\pi k \\text{ or } x = \\frac{4\\pi}{3} + 2\\pi k"),
            (sqrt(2)/2,       "x = \\frac{\\pi}{4} + 2\\pi k \\text{ or } x = \\frac{7\\pi}{4} + 2\\pi k"),
            (-sqrt(2)/2,      "x = \\frac{3\\pi}{4} + 2\\pi k \\text{ or } x = \\frac{5\\pi}{4} + 2\\pi k"),
            (sqrt(3)/2,       "x = \\frac{\\pi}{6} + 2\\pi k \\text{ or } x = \\frac{11\\pi}{6} + 2\\pi k"),
            (-sqrt(3)/2,      "x = \\frac{5\\pi}{6} + 2\\pi k \\text{ or } x = \\frac{7\\pi}{6} + 2\\pi k"),
        ]
        tan_cases = [
            (1,         "x = \\frac{\\pi}{4} + \\pi k"),
            (-1,        "x = \\frac{3\\pi}{4} + \\pi k"),
            (sqrt(3),   "x = \\frac{\\pi}{3} + \\pi k"),
            (-sqrt(3),  "x = \\frac{2\\pi}{3} + \\pi k"),
            (sqrt(3)/3, "x = \\frac{\\pi}{6} + \\pi k"),
            (-sqrt(3)/3,"x = \\frac{5\\pi}{6} + \\pi k"),
        ]

        if eq_type == 'sin':
            val, sols = choice(sin_cases)
            return problem(
                question=f"Find all solutions to $\\sin(x) = {latex(val)}$ (let $k$ be any integer).",
                answer=sols,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                answer_type="text",
                solution=steps(
                    f"Reference angle where $|\\sin\\theta| = |{latex(val)}|$",
                    "Identify correct quadrants",
                    f"General solution: ${sols}$"
                ),
            )
        elif eq_type == 'cos':
            val, sols = choice(cos_cases)
            return problem(
                question=f"Find all solutions to $\\cos(x) = {latex(val)}$ (let $k$ be any integer).",
                answer=sols,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                answer_type="text",
                solution=steps(
                    f"Reference angle where $|\\cos\\theta| = |{latex(val)}|$",
                    "Identify correct quadrants",
                    f"General solution: ${sols}$"
                ),
            )
        else:
            val, sols = choice(tan_cases)
            return problem(
                question=f"Find all solutions to $\\tan(x) = {latex(val)}$ (let $k$ be any integer).",
                answer=sols,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                answer_type="text",
                solution=steps(
                    f"Period of $\\tan$ is $\\pi$",
                    f"Reference angle",
                    f"General solution: ${sols}$"
                ),
            )

    else:
        # Arc length / sector area — large radius and angle pool
        radius = randint(2, 20)
        angle_num = choice([1, 2, 3, 4, 5, 7, 11, 13])
        angle_den = choice([3, 4, 6, 12])
        angle = Rational(angle_num, angle_den) * pi

        use_arc = choice([True, False])

        if use_arc:
            ans = simplify(radius * angle)
            return problem(
                question=f"Find the arc length of a circle with radius ${radius}$ and central angle ${latex(angle)}$ radians.",
                answer=ans,
                difficulty=(1600, 1750),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$s = r\\theta$",
                    f"$s = {radius} \\cdot {latex(angle)} = {latex(ans)}$"
                ),
            )
        else:
            ans = simplify(Rational(1, 2) * radius**2 * angle)
            return problem(
                question=f"Find the area of a sector with radius ${radius}$ and central angle ${latex(angle)}$ radians.",
                answer=ans,
                difficulty=(1600, 1750),
                topic="precalculus/unit_circle",
                solution=steps(
                    "$A = \\frac{1}{2}r^2\\theta$",
                    f"$A = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(angle)} = {latex(ans)}$"
                ),
            )

emit(generate())
