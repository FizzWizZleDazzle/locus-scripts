"""
precalculus - trig_identities (hard)
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Express sin(A)*cos(B) products as sum/difference (product-to-sum)
        # With wide variety of angle multiples
        variant = randint(1, 4)
        a_vals = [1, 2, 3, 4, 5]
        b_vals = [1, 2, 3, 4, 5]
        a = choice(a_vals)
        b = choice(b_vals)
        while a == b:
            b = choice(b_vals)

        if variant == 1:
            # 2 sin(ax) cos(bx) = sin((a+b)x) + sin((a-b)x)
            sum_c = a + b
            diff_c = a - b
            ans = sin(sum_c * x) + sin(diff_c * x)
            return problem(
                question=f"Express $2\\sin({a}x)\\cos({b}x)$ as a sum/difference of trig functions.",
                answer=simplify(ans),
                difficulty=(1600, 1750),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Product-to-sum: $2\\sin A\\cos B = \\sin(A+B) + \\sin(A-B)$",
                    f"$A = {a}x$, $B = {b}x$",
                    f"$= \\sin({sum_c}x) + \\sin({diff_c}x)$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            # 2 cos(ax) cos(bx) = cos((a-b)x) + cos((a+b)x)
            ans = cos((a - b) * x) + cos((a + b) * x)
            return problem(
                question=f"Express $2\\cos({a}x)\\cos({b}x)$ as a sum.",
                answer=simplify(ans),
                difficulty=(1600, 1750),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Product-to-sum: $2\\cos A\\cos B = \\cos(A-B) + \\cos(A+B)$",
                    f"$= \\cos({abs(a-b)}x) + \\cos({a+b}x)$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 3:
            # 2 sin(ax) sin(bx) = cos((a-b)x) - cos((a+b)x)
            ans = cos((a - b) * x) - cos((a + b) * x)
            return problem(
                question=f"Express $2\\sin({a}x)\\sin({b}x)$ as a difference.",
                answer=simplify(ans),
                difficulty=(1600, 1750),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Product-to-sum: $2\\sin A\\sin B = \\cos(A-B) - \\cos(A+B)$",
                    f"$= \\cos({abs(a-b)}x) - \\cos({a+b}x)$"
                ),
                grading_mode="equivalent"
            )
        else:
            # Verify: 2sin(3x)cos(x) = sin(4x) + sin(2x), with random a
            c1 = choice([2, 3, 4, 5])
            c2 = choice([1, 2, 3])
            sum_c = c1 + c2
            diff_c = c1 - c2
            ans = sin(sum_c * x) + sin(diff_c * x)
            return problem(
                question=f"Verify: $2\\sin({c1}x)\\cos({c2}x) = \\sin({sum_c}x) + \\sin({diff_c}x)$",
                answer=True,
                difficulty=(1700, 1850),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Use product-to-sum: $2\\sin A\\cos B = \\sin(A+B) + \\sin(A-B)$",
                    f"With $A={c1}x$, $B={c2}x$: $\\sin({sum_c}x) + \\sin({diff_c}x)$ ✓"
                ),
                answer_type="boolean"
            )

    elif problem_type == 2:
        # Sum-to-product identities
        variant = randint(1, 3)
        a = choice([2, 3, 4, 5])
        b = choice([1, 2, 3])
        while a == b:
            b = choice([1, 2, 3])
        half_sum = Rational(a + b, 2)
        half_diff = Rational(a - b, 2)

        if variant == 1:
            # sin(ax) + sin(bx) = 2 sin((a+b)/2 * x) cos((a-b)/2 * x)
            lhs_str = f"\\sin({a}x) + \\sin({b}x)"
            ans = 2 * sin(half_sum * x) * cos(half_diff * x)
            return problem(
                question=f"Express ${lhs_str}$ as a product.",
                answer=simplify(ans),
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Sum-to-product: $\\sin A + \\sin B = 2\\sin\\frac{A+B}{2}\\cos\\frac{A-B}{2}$",
                    f"$= 2\\sin({latex(half_sum)}x)\\cos({latex(half_diff)}x)$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            # sin(ax) - sin(bx) = 2 cos((a+b)/2 * x) sin((a-b)/2 * x)
            lhs_str = f"\\sin({a}x) - \\sin({b}x)"
            ans = 2 * cos(half_sum * x) * sin(half_diff * x)
            return problem(
                question=f"Express ${lhs_str}$ as a product.",
                answer=simplify(ans),
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Sum-to-product: $\\sin A - \\sin B = 2\\cos\\frac{A+B}{2}\\sin\\frac{A-B}{2}$",
                    f"$= 2\\cos({latex(half_sum)}x)\\sin({latex(half_diff)}x)$"
                ),
                grading_mode="equivalent"
            )
        else:
            # cos(ax) + cos(bx)
            lhs_str = f"\\cos({a}x) + \\cos({b}x)"
            ans = 2 * cos(half_sum * x) * cos(half_diff * x)
            return problem(
                question=f"Express ${lhs_str}$ as a product.",
                answer=simplify(ans),
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Sum-to-product: $\\cos A + \\cos B = 2\\cos\\frac{A+B}{2}\\cos\\frac{A-B}{2}$",
                    f"$= 2\\cos({latex(half_sum)}x)\\cos({latex(half_diff)}x)$"
                ),
                grading_mode="equivalent"
            )

    elif problem_type == 3:
        # Solve trig equation using identities on [0, 2pi)
        variant = randint(1, 4)

        if variant == 1:
            # cos(2x) = sin(x)
            ans = FiniteSet(pi/6, 5*pi/6, 3*pi/2)
            return problem(
                question="Solve $\\cos(2x) = \\sin(x)$ for $x \\in [0, 2\\pi)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Use $\\cos(2x) = 1 - 2\\sin^2(x)$",
                    "$1 - 2\\sin^2 x = \\sin x \\Rightarrow 2\\sin^2 x + \\sin x - 1 = 0$",
                    "$(2\\sin x - 1)(\\sin x + 1) = 0$",
                    "$\\sin x = \\frac{1}{2}$ or $\\sin x = -1$",
                    "$x = \\frac{\\pi}{6}, \\frac{5\\pi}{6}, \\frac{3\\pi}{2}$"
                ),
                answer_type="set"
            )
        elif variant == 2:
            # sin(2x) = cos(x)
            ans = FiniteSet(pi/6, pi/2, 5*pi/6, 3*pi/2)
            return problem(
                question="Solve $\\sin(2x) = \\cos(x)$ for $x \\in [0, 2\\pi)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Use $\\sin(2x) = 2\\sin x\\cos x$",
                    "$2\\sin x\\cos x - \\cos x = 0 \\Rightarrow \\cos x(2\\sin x - 1) = 0$",
                    "$\\cos x = 0$ or $\\sin x = \\frac{1}{2}$",
                    "$x = \\frac{\\pi}{2}, \\frac{3\\pi}{2}, \\frac{\\pi}{6}, \\frac{5\\pi}{6}$"
                ),
                answer_type="set"
            )
        elif variant == 3:
            # 2 sin^2(x) - sin(x) - 1 = 0
            ans = FiniteSet(7*pi/6, 3*pi/2, 11*pi/6, pi/2)
            # 2sin^2 - sin - 1 = 0 => (2sin+1)(sin-1)=0 => sin=-1/2 or sin=1
            # sin=-1/2: x=7pi/6, 11pi/6; sin=1: x=pi/2
            ans = FiniteSet(pi/2, 7*pi/6, 11*pi/6)
            return problem(
                question="Solve $2\\sin^2(x) - \\sin(x) - 1 = 0$ for $x \\in [0, 2\\pi)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Factor: $(2\\sin x + 1)(\\sin x - 1) = 0$",
                    "$\\sin x = -\\frac{1}{2}$ or $\\sin x = 1$",
                    "$x = \\frac{7\\pi}{6}, \\frac{11\\pi}{6}$ (for $-\\frac{1}{2}$); $x = \\frac{\\pi}{2}$ (for $1$)"
                ),
                answer_type="set"
            )
        else:
            # cos(2x) + cos(x) = 0
            # 2cos^2(x)-1+cos(x)=0 => (2cos(x)-1)(cos(x)+1)=0
            # cos=1/2: pi/3, 5pi/3; cos=-1: pi
            ans = FiniteSet(pi/3, pi, 5*pi/3)
            return problem(
                question="Solve $\\cos(2x) + \\cos(x) = 0$ for $x \\in [0, 2\\pi)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Use $\\cos(2x) = 2\\cos^2 x - 1$",
                    "$2\\cos^2 x - 1 + \\cos x = 0 \\Rightarrow (2\\cos x - 1)(\\cos x + 1) = 0$",
                    "$\\cos x = \\frac{1}{2}$ or $\\cos x = -1$",
                    "$x = \\frac{\\pi}{3}, \\frac{5\\pi}{3}, \\pi$"
                ),
                answer_type="set"
            )

    elif problem_type == 4:
        # Express as single trig function using sum/difference: sin(ax+bx), cos, etc.
        variant = randint(1, 3)
        a = choice([2, 3, 4, 5, 6])
        b = choice([1, 2, 3, 4])
        while a == b:
            b = choice([1, 2, 3, 4])

        if variant == 1:
            ans = sin((a + b) * x)
            return problem(
                question=f"Express $\\sin({a}x)\\cos({b}x) + \\cos({a}x)\\sin({b}x)$ as a single trig function.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Sine addition formula: $\\sin(A+B) = \\sin A\\cos B + \\cos A\\sin B$",
                    f"$A = {a}x$, $B = {b}x$: $\\sin({a+b}x)$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            ans = cos((a + b) * x)
            return problem(
                question=f"Express $\\cos({a}x)\\cos({b}x) - \\sin({a}x)\\sin({b}x)$ as a single trig function.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Cosine addition formula: $\\cos(A+B) = \\cos A\\cos B - \\sin A\\sin B$",
                    f"$A = {a}x$, $B = {b}x$: $\\cos({a+b}x)$"
                ),
                grading_mode="equivalent"
            )
        else:
            ans = sin((a - b) * x)
            return problem(
                question=f"Express $\\sin({a}x)\\cos({b}x) - \\cos({a}x)\\sin({b}x)$ as a single trig function.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Sine difference formula: $\\sin(A-B) = \\sin A\\cos B - \\cos A\\sin B$",
                    f"$= \\sin({a-b}x)$"
                ),
                grading_mode="equivalent"
            )

    elif problem_type == 5:
        # Half-angle and power reduction, varied n
        variant = randint(1, 4)
        n = choice([2, 3, 4, 5, 6])

        if variant == 1:
            ans = (1 - cos(2 * n * x)) / 2
            return problem(
                question=f"Express $\\sin^2({n}x)$ without any squared trig functions.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Power reduction: $\\sin^2\\theta = \\dfrac{{1-\\cos(2\\theta)}}{{2}}$",
                    f"$\\sin^2({n}x) = \\dfrac{{1 - \\cos({2*n}x)}}{{2}}$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            ans = (1 + cos(2 * n * x)) / 2
            return problem(
                question=f"Express $\\cos^2({n}x)$ without any squared trig functions.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Power reduction: $\\cos^2\\theta = \\dfrac{{1+\\cos(2\\theta)}}{{2}}$",
                    f"$\\cos^2({n}x) = \\dfrac{{1 + \\cos({2*n}x)}}{{2}}$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 3:
            # sin^4(x) in terms of cos(2x), cos(4x)
            # sin^4 = (sin^2)^2 = ((1-cos2x)/2)^2 = (1-2cos2x+cos^2(2x))/4
            # = (1 - 2cos2x + (1+cos4x)/2)/4 = (3/8 - cos2x/2 + cos4x/8)
            ans = Rational(3, 8) - cos(2 * x) / 2 + cos(4 * x) / 8
            return problem(
                question="Express $\\sin^4(x)$ in terms of $\\cos(2x)$ and $\\cos(4x)$ (no powers).",
                answer=ans,
                difficulty=(1750, 1900),
                topic="precalculus/trig_identities",
                solution=steps(
                    "$\\sin^4 x = (\\sin^2 x)^2 = \\left(\\dfrac{1-\\cos 2x}{2}\\right)^2$",
                    "$= \\dfrac{1 - 2\\cos 2x + \\cos^2 2x}{4}$",
                    "$\\cos^2 2x = \\dfrac{1+\\cos 4x}{2}$",
                    "$= \\dfrac{1 - 2\\cos 2x + \\frac{1+\\cos 4x}{2}}{4} = \\dfrac{3}{8} - \\dfrac{\\cos 2x}{2} + \\dfrac{\\cos 4x}{8}$"
                ),
                grading_mode="equivalent"
            )
        else:
            # half-angle: sin(x/2)^2 = (1-cos x)/2
            return problem(
                question="Use the half-angle formula to simplify $\\sin^2\\!\\left(\\dfrac{x}{2}\\right)$.",
                answer=(1 - cos(x)) / 2,
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    "$\\sin^2\\!\\left(\\dfrac{\\theta}{2}\\right) = \\dfrac{1 - \\cos\\theta}{2}$",
                    "Substitute $\\theta = x$: $\\dfrac{1 - \\cos x}{2}$"
                ),
                grading_mode="equivalent"
            )

    else:
        # Complex simplifications: (1-sin/cos+cos/(1-sin)) = 2 sec, etc.
        variant = randint(1, 4)

        if variant == 1:
            # sin^2/(1-cos) = 1 + cos
            ans = 1 + cos(x)
            return problem(
                question="Simplify $\\dfrac{\\sin^2 x}{1 - \\cos x}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Use $\\sin^2 x = (1-\\cos x)(1+\\cos x)$",
                    "$\\dfrac{(1-\\cos x)(1+\\cos x)}{1-\\cos x} = 1 + \\cos x$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            # (1-sin x)/cos x + cos x/(1-sin x) = 2 sec x
            ans = 2 / cos(x)
            return problem(
                question="Simplify $\\dfrac{1-\\sin x}{\\cos x} + \\dfrac{\\cos x}{1-\\sin x}$",
                answer=ans,
                difficulty=(1750, 1950),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Common denominator $\\cos x(1-\\sin x)$:",
                    "$\\dfrac{(1-\\sin x)^2 + \\cos^2 x}{\\cos x(1-\\sin x)}$",
                    "Numerator: $1 - 2\\sin x + \\sin^2 x + \\cos^2 x = 2 - 2\\sin x = 2(1-\\sin x)$",
                    "$= \\dfrac{2(1-\\sin x)}{\\cos x(1-\\sin x)} = \\dfrac{2}{\\cos x} = 2\\sec x$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 3:
            # sec x / (sec x - tan x) - sec x / (sec x + tan x) = 2 tan x sec x
            ans = 2 * tan(x) / cos(x)
            return problem(
                question="Simplify $\\dfrac{\\sec x}{\\sec x - \\tan x} - \\dfrac{\\sec x}{\\sec x + \\tan x}$",
                answer=ans,
                difficulty=(1750, 1950),
                topic="precalculus/trig_identities",
                solution=steps(
                    "Common denominator: $(\\sec x - \\tan x)(\\sec x + \\tan x) = \\sec^2 x - \\tan^2 x = 1$",
                    "$\\sec x(\\sec x + \\tan x) - \\sec x(\\sec x - \\tan x) = 2\\sec x\\tan x$",
                    "Answer: $2\\sec x\\tan x$"
                ),
                grading_mode="equivalent"
            )
        else:
            # (tan x + cot x)^2 = sec^2 x + csc^2 x
            ans = sec(x)**2 + csc(x)**2
            return problem(
                question="Simplify $(\\tan x + \\cot x)^2$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/trig_identities",
                solution=steps(
                    "$\\tan x + \\cot x = \\dfrac{\\sin x}{\\cos x} + \\dfrac{\\cos x}{\\sin x} = \\dfrac{\\sin^2 x+\\cos^2 x}{\\sin x\\cos x} = \\dfrac{1}{\\sin x\\cos x}$",
                    "$(\\tan x + \\cot x)^2 = \\dfrac{1}{\\sin^2 x\\cos^2 x} = \\sec^2 x\\csc^2 x$",
                    "Also equals $\\sec^2 x + \\csc^2 x$ (expanding $(\\tan+\\cot)^2$ directly)"
                ),
                grading_mode="equivalent"
            )

emit(generate())
