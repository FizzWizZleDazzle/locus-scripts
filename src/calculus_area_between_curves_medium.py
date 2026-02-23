"""
calculus - area_between_curves (medium)
Generated: 2026-02-22T05:16:14.607216
"""

from problem_utils import *

def generate():
    problem_type = choice(['given_bounds', 'parabolas_intersect', 'sqrt_linear', 'trig_const'])

    if problem_type == 'given_bounds':
        # Two polynomials on given interval, coefficients varied widely
        # f(x) = a1*x^2 + b1*x + c1  (upper)
        # g(x) = a2*x^2 + b2*x + c2  (lower, c2 < c1 to ensure f > g at interval start)
        a1 = randint(1, 4)
        b1 = randint(-4, 4)
        c1 = randint(1, 8)

        a2 = randint(1, 3)
        b2 = randint(-4, 4)
        c2 = c1 - randint(2, 8)   # ensures f above g on short intervals

        f = a1 * x**2 + b1 * x + c1
        g = a2 * x**2 + b2 * x + c2

        x_left = randint(0, 3)
        x_right = x_left + randint(1, 3)

        integrand = simplify(f - g)
        ans = integrate(integrand, (x, x_left, x_right))
        ans = simplify(ans)

        question = (f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$ "
                    f"from $x = {x_left}$ to $x = {x_right}$.")

        solution = steps(
            f"Area $= \\int_{{{x_left}}}^{{{x_right}}} [f(x) - g(x)] \\, dx$",
            f"$f(x) - g(x) = {latex(integrand)}$",
            f"$= \\left[{latex(integrate(integrand, x))}\\right]_{{{x_left}}}^{{{x_right}}}$",
            f"$= {latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1450),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 'parabolas_intersect':
        # f(x) = -a*x² + p,  g(x) = b*x² - q  — find intersections then integrate
        a_coeff = randint(1, 4)
        b_coeff = randint(1, 4)
        # Choose p, q so intersection at x = ±r for integer r
        r = randint(1, 4)
        total = (a_coeff + b_coeff) * r**2
        p = total // 2 + randint(0, 3)
        q = total - p

        f = -a_coeff * x**2 + p
        g = b_coeff * x**2 - q

        intersections = solve(Eq(f, g), x)
        intersections_sorted = sorted([pt for pt in intersections], key=lambda v: float(v.evalf()))
        x_left, x_right = intersections_sorted[0], intersections_sorted[-1]

        integrand = simplify(f - g)
        ans = simplify(integrate(integrand, (x, x_left, x_right)))

        question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$."

        solution = steps(
            f"Find intersections: ${latex(f)} = {latex(g)}$",
            f"${latex(simplify(f - g))} = 0$",
            f"$x = {latex(x_left)},\\; x = {latex(x_right)}$",
            f"Area $= \\int_{{{latex(x_left)}}}^{{{latex(x_right)}}} [{latex(integrand)}] \\, dx$",
            f"$= {latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 'sqrt_linear':
        # f(x) = c*√x  and  g(x) = m*x  on [0, c²/m²] (their intersection)
        c = randint(1, 5)
        m = randint(1, 4)

        # Intersect: c√x = mx → c²x = m²x² → x = c²/m²
        x_right_val = Rational(c**2, m**2)
        x_left_val = 0

        f = c * sqrt(x)
        g = m * x

        integrand = simplify(f - g)
        ans = simplify(integrate(integrand, (x, x_left_val, x_right_val)))

        question = f"Find the area enclosed between $f(x) = {c}\\sqrt{{x}}$ and $g(x) = {m}x$."

        solution = steps(
            f"Find intersections: ${c}\\sqrt{{x}} = {m}x$",
            f"Square: ${c**2}x = {m**2}x^2$ → $x = 0$ or $x = {latex(x_right_val)}$",
            f"For $0 \\leq x \\leq {latex(x_right_val)}$: $f(x) \\geq g(x)$",
            f"Area $= \\int_{{0}}^{{{latex(x_right_val)}}} [{c}\\sqrt{{x}} - {m}x] \\, dx$",
            f"$= {latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1450, 1600),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    else:  # trig_const
        # Area between A*sin(bx) and constant k on [0, π/b]
        A = randint(1, 5)
        b = randint(1, 4)
        k = randint(0, A - 1) if A > 1 else 0

        f = A * sin(b * x)
        g = k
        lower = 0
        upper = pi / b

        integrand = f - g
        ans = simplify(integrate(integrand, (x, lower, upper)))

        question = (f"Find the area between $f(x) = {A}\\sin({b}x)$ and $y = {k}$ "
                    f"from $x = 0$ to $x = \\dfrac{{\\pi}}{{{b}}}$.")

        solution = steps(
            f"On $[0, \\pi/{b}]$, $\\sin({b}x) \\geq 0$ so $f(x) \\geq {k}$ (check endpoints)",
            f"Area $= \\int_{{0}}^{{\\pi/{b}}} [{A}\\sin({b}x) - {k}] \\, dx$",
            f"$= \\left[-\\frac{{{A}}}{{{b}}}\\cos({b}x) - {k}x\\right]_{{0}}^{{\\pi/{b}}}$",
            f"$= {latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1350, 1550),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

emit(generate())
