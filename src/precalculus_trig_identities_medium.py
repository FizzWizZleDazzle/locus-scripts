"""
precalculus - trig_identities (medium)
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 7)

    if problem_type == 1:
        # Pythagorean identity simplification with coefficient and angle multiplier
        variant = randint(1, 4)
        n = randint(1, 5)
        var_str = f"{n}x" if n > 1 else "x"
        coeff = randint(2, 8)

        if variant == 1:
            # coeff*(sin^2 + cos^2) = coeff
            expr_str = f"{coeff}\\sin^2({var_str}) + {coeff}\\cos^2({var_str})"
            ans = coeff
            sol = steps(
                f"Factor: ${coeff}(\\sin^2({var_str}) + \\cos^2({var_str}))$",
                f"Use $\\sin^2 + \\cos^2 = 1$: $= {coeff}$"
            )
        elif variant == 2:
            # coeff - coeff*sin^2 = coeff*cos^2
            expr_str = f"{coeff} - {coeff}\\sin^2({var_str})"
            ans = coeff * cos(n * x)**2
            sol = steps(
                f"Factor: ${coeff}(1 - \\sin^2({var_str}))$",
                f"Use $1 - \\sin^2 = \\cos^2$: $= {coeff}\\cos^2({var_str})$"
            )
        elif variant == 3:
            # coeff - coeff*cos^2 = coeff*sin^2
            expr_str = f"{coeff} - {coeff}\\cos^2({var_str})"
            ans = coeff * sin(n * x)**2
            sol = steps(
                f"Factor: ${coeff}(1 - \\cos^2({var_str}))$",
                f"Use $1 - \\cos^2 = \\sin^2$: $= {coeff}\\sin^2({var_str})$"
            )
        else:
            # coeff*(sec^2 - tan^2) = coeff
            expr_str = f"{coeff}\\sec^2({var_str}) - {coeff}\\tan^2({var_str})"
            ans = coeff
            sol = steps(
                f"Factor: ${coeff}(\\sec^2({var_str}) - \\tan^2({var_str}))$",
                f"Use $\\sec^2 - \\tan^2 = 1$: $= {coeff}$"
            )

        return problem(
            question=f"Simplify: ${expr_str}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/trig_identities",
            solution=sol,
            grading_mode="equivalent"
        )

    elif problem_type == 2:
        # Double-angle identities with randomised multiplier
        variant = randint(1, 4)
        n = randint(1, 5)
        var_str = f"{n}x" if n > 1 else "x"
        double_n = 2 * n
        dbl_var = f"{double_n}x"

        if variant == 1:
            # 2 sin(nx) cos(nx) = sin(2nx)
            ans = sin(double_n * x)
            return problem(
                question=f"Simplify $2\\sin({var_str})\\cos({var_str})$",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Double-angle identity: $\\sin(2\\theta) = 2\\sin\\theta\\cos\\theta$",
                    f"Substitute $\\theta = {var_str}$: $\\sin({dbl_var})$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            # cos^2 - sin^2 = cos(2n x)
            ans = cos(double_n * x)
            return problem(
                question=f"Simplify $\\cos^2({var_str}) - \\sin^2({var_str})$",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Double-angle identity: $\\cos(2\\theta) = \\cos^2\\theta - \\sin^2\\theta$",
                    f"Substitute $\\theta = {var_str}$: $\\cos({dbl_var})$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 3:
            # 1 - 2 sin^2 = cos(2nx)
            ans = cos(double_n * x)
            return problem(
                question=f"Simplify $1 - 2\\sin^2({var_str})$",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Double-angle identity: $\\cos(2\\theta) = 1 - 2\\sin^2\\theta$",
                    f"Substitute $\\theta = {var_str}$: $\\cos({dbl_var})$"
                ),
                grading_mode="equivalent"
            )
        else:
            # 2 cos^2 - 1 = cos(2nx)
            ans = cos(double_n * x)
            return problem(
                question=f"Simplify $2\\cos^2({var_str}) - 1$",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Double-angle identity: $\\cos(2\\theta) = 2\\cos^2\\theta - 1$",
                    f"Substitute $\\theta = {var_str}$: $\\cos({dbl_var})$"
                ),
                grading_mode="equivalent"
            )

    elif problem_type == 3:
        # Ratio / reciprocal simplifications with varied angle multiples
        variant = randint(1, 4)
        n = randint(1, 4)
        var_str = f"{n}x" if n > 1 else "x"

        if variant == 1:
            return problem(
                question=f"Simplify $\\dfrac{{\\sin({var_str})}}{{\\cos({var_str})}}$",
                answer=tan(n * x),
                difficulty=(1300, 1450),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"$\\tan\\theta = \\dfrac{{\\sin\\theta}}{{\\cos\\theta}}$",
                    f"Answer: $\\tan({var_str})$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            return problem(
                question=f"Simplify $\\dfrac{{1}}{{\\cos({var_str})}}$",
                answer=sec(n * x),
                difficulty=(1300, 1450),
                topic="precalculus/trig_identities",
                solution=steps(f"$\\sec\\theta = \\dfrac{{1}}{{\\cos\\theta}}$; Answer: $\\sec({var_str})$"),
                grading_mode="equivalent"
            )
        elif variant == 3:
            return problem(
                question=f"Simplify $\\dfrac{{1}}{{\\sin({var_str})}}$",
                answer=csc(n * x),
                difficulty=(1300, 1450),
                topic="precalculus/trig_identities",
                solution=steps(f"$\\csc\\theta = \\dfrac{{1}}{{\\sin\\theta}}$; Answer: $\\csc({var_str})$"),
                grading_mode="equivalent"
            )
        else:
            return problem(
                question=f"Simplify $\\dfrac{{\\cos({var_str})}}{{\\sin({var_str})}}$",
                answer=cot(n * x),
                difficulty=(1300, 1450),
                topic="precalculus/trig_identities",
                solution=steps(f"$\\cot\\theta = \\dfrac{{\\cos\\theta}}{{\\sin\\theta}}$; Answer: $\\cot({var_str})$"),
                grading_mode="equivalent"
            )

    elif problem_type == 4:
        # Pythagorean identity variants: tan^2+1=sec^2, 1+cot^2=csc^2, with coefficient
        variant = randint(1, 3)
        coeff = randint(1, 6)
        n = randint(1, 4)
        var_str = f"{n}x" if n > 1 else "x"

        if variant == 1:
            expr_str = f"{coeff}\\tan^2({var_str}) + {coeff}"
            ans = coeff * sec(n * x)**2
            return problem(
                question=f"Simplify ${expr_str}$",
                answer=ans,
                difficulty=(1450, 1550),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Factor: ${coeff}(\\tan^2({var_str}) + 1)$",
                    f"Use $\\tan^2 + 1 = \\sec^2$: $= {coeff}\\sec^2({var_str})$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            expr_str = f"{coeff} + {coeff}\\cot^2({var_str})"
            ans = coeff * csc(n * x)**2
            return problem(
                question=f"Simplify ${expr_str}$",
                answer=ans,
                difficulty=(1450, 1550),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Factor: ${coeff}(1 + \\cot^2({var_str}))$",
                    f"Use $1 + \\cot^2 = \\csc^2$: $= {coeff}\\csc^2({var_str})$"
                ),
                grading_mode="equivalent"
            )
        else:
            # sec^2 - 1 = tan^2 with coefficient
            expr_str = f"{coeff}\\sec^2({var_str}) - {coeff}"
            ans = coeff * tan(n * x)**2
            return problem(
                question=f"Simplify ${expr_str}$",
                answer=ans,
                difficulty=(1450, 1550),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Factor: ${coeff}(\\sec^2({var_str}) - 1)$",
                    f"Use $\\sec^2 - 1 = \\tan^2$: $= {coeff}\\tan^2({var_str})$"
                ),
                grading_mode="equivalent"
            )

    elif problem_type == 5:
        # Power reduction formulas (sin^2 and cos^2 in terms of cos(2*angle))
        variant = randint(1, 2)
        n = randint(1, 5)
        var_str = f"{n}x" if n > 1 else "x"
        double_n = 2 * n
        dbl_var = f"{double_n}x"

        if variant == 1:
            ans = (1 - cos(double_n * x)) / 2
            return problem(
                question=f"Express $\\sin^2({var_str})$ using a power reduction formula (no squares).",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Power reduction: $\\sin^2\\theta = \\dfrac{{1 - \\cos(2\\theta)}}{{2}}$",
                    f"Substitute $\\theta = {var_str}$: $\\dfrac{{1 - \\cos({dbl_var})}}{{2}}$"
                ),
                grading_mode="equivalent"
            )
        else:
            ans = (1 + cos(double_n * x)) / 2
            return problem(
                question=f"Express $\\cos^2({var_str})$ using a power reduction formula (no squares).",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Power reduction: $\\cos^2\\theta = \\dfrac{{1 + \\cos(2\\theta)}}{{2}}$",
                    f"Substitute $\\theta = {var_str}$: $\\dfrac{{1 + \\cos({dbl_var})}}{{2}}$"
                ),
                grading_mode="equivalent"
            )

    elif problem_type == 6:
        # Co-function identities: sin = cos(90 - x), etc.
        variant = randint(1, 4)
        n = randint(1, 4)
        var_str = f"{n}x" if n > 1 else "x"

        if variant == 1:
            ans = cos(n * x)
            return problem(
                question=f"Use a co-function identity to simplify $\\sin\\left(\\dfrac{{\\pi}}{{2}} - {var_str}\\right)$",
                answer=ans,
                difficulty=(1350, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Co-function identity: $\\sin\\left(\\dfrac{{\\pi}}{{2}} - \\theta\\right) = \\cos\\theta$",
                    f"Answer: $\\cos({var_str})$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            ans = sin(n * x)
            return problem(
                question=f"Use a co-function identity to simplify $\\cos\\left(\\dfrac{{\\pi}}{{2}} - {var_str}\\right)$",
                answer=ans,
                difficulty=(1350, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Co-function identity: $\\cos\\left(\\dfrac{{\\pi}}{{2}} - \\theta\\right) = \\sin\\theta$",
                    f"Answer: $\\sin({var_str})$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 3:
            ans = cot(n * x)
            return problem(
                question=f"Use a co-function identity to simplify $\\tan\\left(\\dfrac{{\\pi}}{{2}} - {var_str}\\right)$",
                answer=ans,
                difficulty=(1350, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Co-function identity: $\\tan\\left(\\dfrac{{\\pi}}{{2}} - \\theta\\right) = \\cot\\theta$",
                    f"Answer: $\\cot({var_str})$"
                ),
                grading_mode="equivalent"
            )
        else:
            ans = tan(n * x)
            return problem(
                question=f"Use a co-function identity to simplify $\\cot\\left(\\dfrac{{\\pi}}{{2}} - {var_str}\\right)$",
                answer=ans,
                difficulty=(1350, 1500),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Co-function identity: $\\cot\\left(\\dfrac{{\\pi}}{{2}} - \\theta\\right) = \\tan\\theta$",
                    f"Answer: $\\tan({var_str})$"
                ),
                grading_mode="equivalent"
            )

    else:
        # Multi-step simplifications combining identities
        variant = randint(1, 4)

        if variant == 1:
            # c*(sin(x)+cos(x))^2 + c*(sin(x)-cos(x))^2 = 2c
            c = randint(2, 7)
            ans = 2 * c
            return problem(
                question=f"Simplify ${c}(\\sin x + \\cos x)^2 + {c}(\\sin x - \\cos x)^2$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Expand both squares and combine: $2{c}(\\sin^2 x + \\cos^2 x)$",
                    f"Apply $\\sin^2 + \\cos^2 = 1$: $= 2{c}$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 2:
            # sin^2(nx) / (1 - cos^2(nx)) = 1
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            return problem(
                question=f"Simplify $\\dfrac{{\\sin^2({var_str})}}{{1 - \\cos^2({var_str})}}$",
                answer=1,
                difficulty=(1500, 1600),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Use $1 - \\cos^2 = \\sin^2$",
                    f"$\\dfrac{{\\sin^2({var_str})}}{{\\sin^2({var_str})}} = 1$"
                ),
                grading_mode="equivalent"
            )
        elif variant == 3:
            # (tan(x) + cot(x))*sin(x)*cos(x) = 1
            return problem(
                question=r"Simplify $(\tan x + \cot x)\sin x \cos x$",
                answer=1,
                difficulty=(1500, 1600),
                topic="precalculus/trig_identities",
                solution=steps(
                    r"Write $\tan x = \frac{\sin x}{\cos x}$, $\cot x = \frac{\cos x}{\sin x}$",
                    r"$\left(\frac{\sin^2 x + \cos^2 x}{\sin x \cos x}\right)\sin x\cos x = \frac{1}{\sin x\cos x}\cdot\sin x\cos x = 1$"
                ),
                grading_mode="equivalent"
            )
        else:
            # sin^2 - cos^2 = -cos(2x)
            n = randint(1, 4)
            var_str = f"{n}x" if n > 1 else "x"
            ans = -cos(2 * n * x)
            return problem(
                question=f"Simplify $\\sin^2({var_str}) - \\cos^2({var_str})$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/trig_identities",
                solution=steps(
                    f"Double-angle: $\\cos(2\\theta) = \\cos^2\\theta - \\sin^2\\theta$",
                    f"So $\\sin^2\\theta - \\cos^2\\theta = -\\cos(2\\theta)$",
                    f"Answer: $-\\cos(2 \\cdot {var_str}) = {latex(ans)}$"
                ),
                grading_mode="equivalent"
            )

emit(generate())
