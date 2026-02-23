"""
precalculus - sum_difference_formulas (hard)
"""

from problem_utils import *

# Wide pool of special angle decompositions
SPECIAL = [
    (15,  45, 30, '-'),
    (75,  45, 30, '+'),
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
    (300, 270, 30, '+'),
    (315, 270, 45, '+'),
    (330, 300, 30, '+'),
]

TRIPLES = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25), (20, 21, 29)]


def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Given sin and cos of two angles in different quadrants, find sin/cos of sum/difference
        triple1 = choice(TRIPLES)
        triple2 = choice(TRIPLES)
        while triple2 == triple1:
            triple2 = choice(TRIPLES)

        a1, b1, c1 = triple1
        a2, b2, c2 = triple2

        quad1 = choice([1, 2, 3, 4])
        quad2 = choice([1, 2, 3, 4])

        sin1 = Rational(a1, c1) if quad1 in (1, 2) else -Rational(a1, c1)
        cos1 = Rational(b1, c1) if quad1 in (1, 4) else -Rational(b1, c1)
        sin2 = Rational(a2, c2) if quad2 in (1, 2) else -Rational(a2, c2)
        cos2 = Rational(b2, c2) if quad2 in (1, 4) else -Rational(b2, c2)

        find_func = choice(['sin_sum', 'sin_diff', 'cos_sum', 'cos_diff'])

        if find_func == 'sin_sum':
            ans = sin1 * cos2 + cos1 * sin2
            question = (f"If $\\sin\\alpha = {latex(sin1)}$ (quadrant {quad1}) and "
                        f"$\\sin\\beta = {latex(sin2)}$ (quadrant {quad2}), "
                        f"find $\\sin(\\alpha + \\beta)$.")
            sol = steps(
                f"$\\cos\\alpha = {latex(cos1)}$, $\\cos\\beta = {latex(cos2)}$ (using Pythagorean identity + quadrant signs)",
                r"$\sin(\alpha+\beta)=\sin\alpha\cos\beta+\cos\alpha\sin\beta$",
                f"$= ({latex(sin1)})({latex(cos2)}) + ({latex(cos1)})({latex(sin2)}) = {latex(ans)}$"
            )
        elif find_func == 'sin_diff':
            ans = sin1 * cos2 - cos1 * sin2
            question = (f"If $\\sin\\alpha = {latex(sin1)}$ (quadrant {quad1}) and "
                        f"$\\sin\\beta = {latex(sin2)}$ (quadrant {quad2}), "
                        f"find $\\sin(\\alpha - \\beta)$.")
            sol = steps(
                f"$\\cos\\alpha = {latex(cos1)}$, $\\cos\\beta = {latex(cos2)}$",
                r"$\sin(\alpha-\beta)=\sin\alpha\cos\beta-\cos\alpha\sin\beta$",
                f"$= ({latex(sin1)})({latex(cos2)}) - ({latex(cos1)})({latex(sin2)}) = {latex(ans)}$"
            )
        elif find_func == 'cos_sum':
            ans = cos1 * cos2 - sin1 * sin2
            question = (f"If $\\cos\\alpha = {latex(cos1)}$ (quadrant {quad1}) and "
                        f"$\\cos\\beta = {latex(cos2)}$ (quadrant {quad2}), "
                        f"find $\\cos(\\alpha + \\beta)$.")
            sol = steps(
                f"$\\sin\\alpha = {latex(sin1)}$, $\\sin\\beta = {latex(sin2)}$",
                r"$\cos(\alpha+\beta)=\cos\alpha\cos\beta-\sin\alpha\sin\beta$",
                f"$= ({latex(cos1)})({latex(cos2)}) - ({latex(sin1)})({latex(sin2)}) = {latex(ans)}$"
            )
        else:
            ans = cos1 * cos2 + sin1 * sin2
            question = (f"If $\\cos\\alpha = {latex(cos1)}$ (quadrant {quad1}) and "
                        f"$\\cos\\beta = {latex(cos2)}$ (quadrant {quad2}), "
                        f"find $\\cos(\\alpha - \\beta)$.")
            sol = steps(
                f"$\\sin\\alpha = {latex(sin1)}$, $\\sin\\beta = {latex(sin2)}$",
                r"$\cos(\alpha-\beta)=\cos\alpha\cos\beta+\sin\alpha\sin\beta$",
                f"$= ({latex(cos1)})({latex(cos2)}) + ({latex(sin1)})({latex(sin2)}) = {latex(ans)}$"
            )

        return problem(
            question=question,
            answer=simplify(ans),
            difficulty=(1700, 1850),
            topic="precalculus/sum_difference_formulas",
            solution=sol,
        )

    elif problem_type == 2:
        # Given sin(A) and quadrant, find tan(A+B) or tan(A-B) with a known special angle B
        triple = choice(TRIPLES)
        a_val, b_val, c_val = triple
        quad = choice([1, 2, 3, 4])

        sin_A = Rational(a_val, c_val) if quad in (1, 2) else -Rational(a_val, c_val)
        cos_A = Rational(b_val, c_val) if quad in (1, 4) else -Rational(b_val, c_val)
        # Guard against zero cosine
        if cos_A == 0:
            cos_A = Rational(b_val, c_val)
        tan_A = sin_A / cos_A

        B_deg = choice([30, 45, 60])
        B_rad = B_deg * pi / 180
        tan_B = simplify(tan(B_rad))
        is_sum = choice([True, False])

        if is_sum:
            # tan(A+B) = (tan_A + tan_B) / (1 - tan_A*tan_B)
            denom = 1 - tan_A * tan_B
            if denom == 0:
                B_deg = 30
                B_rad = pi / 6
                tan_B = simplify(tan(B_rad))
                denom = 1 - tan_A * tan_B
            ans = simplify((tan_A + tan_B) / denom)
            formula = r"\tan(A+B)=\frac{\tan A+\tan B}{1-\tan A\tan B}"
            op = '+'
        else:
            denom = 1 + tan_A * tan_B
            ans = simplify((tan_A - tan_B) / denom)
            formula = r"\tan(A-B)=\frac{\tan A-\tan B}{1+\tan A\tan B}"
            op = '-'

        return problem(
            question=(f"If $\\sin A = {latex(sin_A)}$ and $A$ is in quadrant {quad}, "
                      f"find $\\tan(A {op} {B_deg}^\\circ)$ exactly."),
            answer=ans,
            difficulty=(1750, 1900),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"$\\cos A = {latex(cos_A)}$, $\\tan A = {latex(simplify(tan_A))}$",
                f"$\\tan {B_deg}^\\circ = {latex(tan_B)}$",
                f"Formula: ${formula}$",
                f"$= {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Verify / collapse product-to-sum using sum and difference formulas
        # sin(A+B) + sin(A-B) = 2 sin(A) cos(B)  or  cos(A-B) - cos(A+B) = 2 sin(A) sin(B)
        A = choice([2, 3, 4, 5])
        B = choice([1, 2, 3])
        variant = choice(['sin_plus', 'sin_minus', 'cos_minus', 'cos_plus'])

        if variant == 'sin_plus':
            # sin(Ax+Bx) + sin(Ax-Bx) = 2sin(Ax)cos(Bx)
            ans = 2 * sin(A * x) * cos(B * x)
            q = f"Simplify $\\sin({A+B}x) + \\sin({A-B}x)$ using sum/difference formulas."
            sol = steps(
                r"$\sin(P+Q)+\sin(P-Q) = 2\sin P\cos Q$",
                f"Here $P={A}x$, $Q={B}x$",
                f"$= 2\\sin({A}x)\\cos({B}x)$"
            )
        elif variant == 'sin_minus':
            # sin(Ax+Bx) - sin(Ax-Bx) = 2cos(Ax)sin(Bx)
            ans = 2 * cos(A * x) * sin(B * x)
            q = f"Simplify $\\sin({A+B}x) - \\sin({A-B}x)$ using sum/difference formulas."
            sol = steps(
                r"$\sin(P+Q)-\sin(P-Q)=2\cos P\sin Q$",
                f"$P={A}x$, $Q={B}x$",
                f"$= 2\\cos({A}x)\\sin({B}x)$"
            )
        elif variant == 'cos_minus':
            # cos(Ax-Bx) - cos(Ax+Bx) = 2sin(Ax)sin(Bx)
            ans = 2 * sin(A * x) * sin(B * x)
            q = f"Simplify $\\cos({A-B}x) - \\cos({A+B}x)$ using sum/difference formulas."
            sol = steps(
                r"$\cos(P-Q)-\cos(P+Q)=2\sin P\sin Q$",
                f"$P={A}x$, $Q={B}x$",
                f"$= 2\\sin({A}x)\\sin({B}x)$"
            )
        else:
            # cos(Ax-Bx) + cos(Ax+Bx) = 2cos(Ax)cos(Bx)
            ans = 2 * cos(A * x) * cos(B * x)
            q = f"Simplify $\\cos({A-B}x) + \\cos({A+B}x)$ using sum/difference formulas."
            sol = steps(
                r"$\cos(P-Q)+\cos(P+Q)=2\cos P\cos Q$",
                f"$P={A}x$, $Q={B}x$",
                f"$= 2\\cos({A}x)\\cos({B}x)$"
            )

        return problem(
            question=q,
            answer=ans,
            difficulty=(1700, 1850),
            topic="precalculus/sum_difference_formulas",
            solution=sol,
        )

    elif problem_type == 4:
        # Solve sin(x + c1) = sin(x + c2) on [0, 2pi) — uses cos identity
        # sin(x+c1)-sin(x+c2)=0 => 2cos((2x+c1+c2)/2)sin((c1-c2)/2)=0
        # Easier: just solve cos/sin shifted equations
        angle_const = choice([pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4])
        target_val = choice([Rational(1, 2), sqrt(2)/2, sqrt(3)/2, 0, -Rational(1, 2), -sqrt(2)/2, -sqrt(3)/2])
        is_sin = choice([True, False])
        pm = choice(['+', '-'])

        if is_sin:
            if pm == '+':
                equation = Eq(sin(x + angle_const), target_val)
                q = f"Solve $\\sin\\!\\left(x + {latex(angle_const)}\\right) = {latex(target_val)}$ for $x \\in [0, 2\\pi)$."
            else:
                equation = Eq(sin(x - angle_const), target_val)
                q = f"Solve $\\sin\\!\\left(x - {latex(angle_const)}\\right) = {latex(target_val)}$ for $x \\in [0, 2\\pi)$."
        else:
            if pm == '+':
                equation = Eq(cos(x + angle_const), target_val)
                q = f"Solve $\\cos\\!\\left(x + {latex(angle_const)}\\right) = {latex(target_val)}$ for $x \\in [0, 2\\pi)$."
            else:
                equation = Eq(cos(x - angle_const), target_val)
                q = f"Solve $\\cos\\!\\left(x - {latex(angle_const)}\\right) = {latex(target_val)}$ for $x \\in [0, 2\\pi)$."

        sols_full = solve(equation, x)
        extended = []
        for s in sols_full:
            if not s.is_real:
                continue
            for k in range(-2, 4):
                cand = simplify(s + 2 * pi * k)
                if cand.is_real and 0 <= cand < 2 * pi:
                    extended.append(cand)
        if extended:
            ans = FiniteSet(*[simplify(v) for v in set(extended)])
        else:
            ans = FiniteSet()

        func_name = 'sin' if is_sin else 'cos'
        return problem(
            question=q,
            answer=ans,
            difficulty=(1750, 1900),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Let $u = x {pm} {latex(angle_const)}$",
                f"Solve $\\{func_name}(u) = {latex(target_val)}$",
                f"Find all $u$ solutions, then back-substitute to get $x \\in [0, 2\\pi)$",
                f"$x \\in {latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # Write A sin(x) + B cos(x) = R sin(x + phi)
        A = choice([1, 2, 3, 4, 5, 6])
        B = choice([1, 2, 3, 4, 5, 6])
        while A == 0 and B == 0:
            B = choice([1, 2, 3, 4, 5, 6])
        R = simplify(sqrt(A**2 + B**2))
        phi = simplify(atan(Rational(B, A)))

        ask = choice(['R', 'phi'])
        if ask == 'R':
            ans = R
            q = f"Write ${A}\\sin x + {B}\\cos x$ in the form $R\\sin(x+\\phi)$. Find $R$ (the amplitude)."
            sol = steps(
                f"$R\\sin(x+\\phi) = R\\sin x\\cos\\phi + R\\cos x\\sin\\phi$",
                f"Match: $R\\cos\\phi = {A}$, $R\\sin\\phi = {B}$",
                f"$R = \\sqrt{{{A}^2 + {B}^2}} = \\sqrt{{{A**2 + B**2}}} = {latex(R)}$"
            )
        else:
            ans = phi
            q = f"Write ${A}\\sin x + {B}\\cos x$ in the form $R\\sin(x+\\phi)$. Find $\\phi$ (the phase shift)."
            sol = steps(
                f"$R\\cos\\phi = {A}$, $R\\sin\\phi = {B}$",
                f"$\\tan\\phi = \\dfrac{{{B}}}{{{A}}}$",
                f"$\\phi = \\arctan\\!\\left(\\dfrac{{{B}}}{{{A}}}\\right) = {latex(phi)}$"
            )

        return problem(
            question=q,
            answer=ans,
            difficulty=(1800, 1950),
            topic="precalculus/sum_difference_formulas",
            solution=sol,
        )

    else:
        # Evaluate trig of a sum/difference where both components are non-standard
        # e.g. sin(alpha + beta) given cos(alpha), sin(beta) and their quadrants
        triple1 = choice(TRIPLES)
        triple2 = choice(TRIPLES)
        a1, b1, c1 = triple1
        a2, b2, c2 = triple2

        quad1 = choice([1, 2, 3, 4])
        quad2 = choice([1, 2, 3, 4])

        sin1 = Rational(a1, c1) if quad1 in (1, 2) else -Rational(a1, c1)
        cos1 = Rational(b1, c1) if quad1 in (1, 4) else -Rational(b1, c1)
        sin2 = Rational(a2, c2) if quad2 in (1, 2) else -Rational(a2, c2)
        cos2 = Rational(b2, c2) if quad2 in (1, 4) else -Rational(b2, c2)

        # Ask for sin(2*alpha) or cos(alpha + beta) — use double angle as a special case
        variant = choice(['double_sin', 'double_cos', 'cross_sum', 'cross_diff'])

        if variant == 'double_sin':
            ans = 2 * sin1 * cos1
            q = (f"If $\\sin\\alpha = {latex(sin1)}$ and $\\alpha$ is in quadrant {quad1}, "
                 f"find $\\sin(2\\alpha)$.")
            sol = steps(
                f"$\\cos\\alpha = {latex(cos1)}$ (from Pythagorean identity, quadrant {quad1})",
                r"$\sin(2\alpha)=2\sin\alpha\cos\alpha$",
                f"$= 2({latex(sin1)})({latex(cos1)}) = {latex(simplify(ans))}$"
            )
        elif variant == 'double_cos':
            ans = cos1**2 - sin1**2
            q = (f"If $\\cos\\alpha = {latex(cos1)}$ and $\\alpha$ is in quadrant {quad1}, "
                 f"find $\\cos(2\\alpha)$.")
            sol = steps(
                f"$\\sin\\alpha = {latex(sin1)}$",
                r"$\cos(2\alpha)=\cos^2\alpha-\sin^2\alpha$",
                f"$= ({latex(cos1)})^2 - ({latex(sin1)})^2 = {latex(simplify(ans))}$"
            )
        elif variant == 'cross_sum':
            ans = sin1 * cos2 + cos1 * sin2
            q = (f"Given $\\sin\\alpha = {latex(sin1)}$ (quadrant {quad1}) and "
                 f"$\\cos\\beta = {latex(cos2)}$ (quadrant {quad2}), "
                 f"find $\\sin(\\alpha+\\beta)$.")
            sol = steps(
                f"$\\cos\\alpha = {latex(cos1)}$, $\\sin\\beta = {latex(sin2)}$",
                r"$\sin(\alpha+\beta)=\sin\alpha\cos\beta+\cos\alpha\sin\beta$",
                f"$= {latex(simplify(ans))}$"
            )
        else:
            ans = cos1 * cos2 + sin1 * sin2
            q = (f"Given $\\cos\\alpha = {latex(cos1)}$ (quadrant {quad1}) and "
                 f"$\\cos\\beta = {latex(cos2)}$ (quadrant {quad2}), "
                 f"find $\\cos(\\alpha-\\beta)$.")
            sol = steps(
                f"$\\sin\\alpha = {latex(sin1)}$, $\\sin\\beta = {latex(sin2)}$",
                r"$\cos(\alpha-\beta)=\cos\alpha\cos\beta+\sin\alpha\sin\beta$",
                f"$= {latex(simplify(ans))}$"
            )

        return problem(
            question=q,
            answer=simplify(ans),
            difficulty=(1750, 1900),
            topic="precalculus/sum_difference_formulas",
            solution=sol,
        )


emit(generate())
