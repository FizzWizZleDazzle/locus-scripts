"""
calculus - area_between_curves (hard)
Generated: 2026-02-22T05:16:53.762015
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'polynomial_intersection',
        'trig_polynomial',
        'exponential_polynomial',
        'multiple_intersections',
        'vertical_line_bounds'
    ])

    if problem_type == 'polynomial_intersection':
        # Two polynomials that share the same two roots (constructed)
        root1 = randint(-4, -1)
        root2 = randint(1, 4)
        a1 = choice([-3, -2, -1, 1, 2, 3])
        baseline = randint(-3, 3)

        f = expand(a1 * (x - root1) * (x - root2)) + baseline

        # g is either linear through same roots, or another parabola
        if choice([True, False]):
            y1 = f.subs(x, root1)
            y2 = f.subs(x, root2)
            m = (y2 - y1) / (root2 - root1)
            b_lin = y1 - m * root1
            g = m * x + b_lin
        else:
            a2 = a1 + choice([-2, -1, 1, 2])
            g = expand(a2 * (x - root1) * (x - root2)) + baseline

        integrand = simplify(f - g)
        integral = integrate(integrand, (x, root1, root2))
        area = abs(integral)

        question = f"Find the area between the curves $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$."

        solution = steps(
            f"Find intersections: ${latex(f)} = {latex(g)}$",
            f"${latex(simplify(f - g))} = 0$ → $x = {root1}$ and $x = {root2}$",
            f"$A = \\left|\\int_{{{root1}}}^{{{root2}}} [{latex(integrand)}]\\, dx\\right|$",
            f"$= \\left|{latex(integral)}\\right| = {latex(area)}$"
        )

        return problem(
            question=question,
            answer=area,
            difficulty=randint(1600, 1750),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 'trig_polynomial':
        # A*sin(bx) or A*cos(bx) vs linear polynomial on given interval
        A = randint(1, 4)
        b = randint(1, 3)
        m_coef = choice([Rational(1, 4), Rational(1, 2), Rational(3, 4), 1])
        const = randint(-2, 2)

        trig_choice = choice(['sin', 'cos'])
        if trig_choice == 'sin':
            f = A * sin(b * x)
            lower = 0
            upper = pi / b
        else:
            f = A * cos(b * x)
            lower = 0
            upper = pi / (2 * b)

        g = m_coef * x + const

        integrand = f - g
        integral = integrate(integrand, (x, lower, upper))
        area = simplify(abs(integral))

        question = (f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$ "
                    f"from $x = {latex(lower)}$ to $x = {latex(upper)}$.")

        solution = steps(
            f"Area $= \\left|\\int_{{{latex(lower)}}}^{{{latex(upper)}}} \\left({latex(integrand)}\\right) dx\\right|$",
            f"Integrate: $\\int {latex(f)} dx = {latex(integrate(f, x))}$",
            f"$\\int {latex(g)} dx = {latex(integrate(g, x))}$",
            f"$= \\left|{latex(simplify(integral))}\\right| = {latex(area)}$"
        )

        return problem(
            question=question,
            answer=area,
            difficulty=randint(1650, 1800),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 'exponential_polynomial':
        # e^(kx) vs polynomial  on given interval
        k = choice([1, -1, 2, -2])
        a_lin = randint(1, 3)
        b_const = randint(-3, 3)

        f = exp(k * x)
        g = a_lin * x + b_const

        lower = 0
        upper = randint(1, 3)

        integrand = f - g
        integral = integrate(integrand, (x, lower, upper))
        area = simplify(abs(integral))

        question = (f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$ "
                    f"from $x = {lower}$ to $x = {upper}$.")

        solution = steps(
            f"Area $= \\left|\\int_{{{lower}}}^{{{upper}}} \\left({latex(f)} - ({latex(g)})\\right) dx\\right|$",
            f"$\\int {latex(f)} dx = {latex(integrate(f, x))}$",
            f"$\\int ({latex(g)}) dx = {latex(integrate(g, x))}$",
            f"$= \\left|{latex(simplify(integral))}\\right| = {latex(area)}$"
        )

        return problem(
            question=question,
            answer=area,
            difficulty=randint(1700, 1850),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 'multiple_intersections':
        # f(x) = c*(x³ - a*x),  g = 0 — sign changes, must split
        a = randint(1, 5)
        c = randint(1, 3)

        f = c * (x**3 - a * x)
        g = 0

        root = sqrt(a)

        int1 = integrate(f - g, (x, -root, 0))
        int2 = integrate(f - g, (x, 0, root))
        area = simplify(abs(int1) + abs(int2))

        question = f"Find the total area enclosed between $f(x) = {latex(f)}$ and the $x$-axis."

        solution = steps(
            f"Find roots: ${latex(f)} = 0$ → $x = 0, \\pm\\sqrt{{{a}}}$",
            f"Function changes sign at each root — split the integral",
            f"$A = \\left|\\int_{{-\\sqrt{{{a}}}}}^{{0}} {latex(f)}\\, dx\\right| + \\left|\\int_{{0}}^{{\\sqrt{{{a}}}}} {latex(f)}\\, dx\\right|$",
            f"$= \\left|{latex(int1)}\\right| + \\left|{latex(int2)}\\right| = {latex(area)}$"
        )

        return problem(
            question=question,
            answer=area,
            difficulty=randint(1750, 1900),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    else:  # vertical_line_bounds
        # Area between y = c*x and y = d*x²  (parabola and line through origin)
        c = randint(2, 7)
        d = randint(1, 4)

        f = c * x   # line (above on [0, c/d])
        g = d * x**2

        # Intersect at x = 0 and x = c/d
        x_right = Rational(c, d)

        integrand = f - g
        integral = integrate(integrand, (x, 0, x_right))
        area = simplify(abs(integral))

        question = f"Find the area of the region bounded by $y = {latex(f)}$ and $y = {latex(g)}$."

        solution = steps(
            f"Find intersection: ${latex(f)} = {latex(g)}$",
            f"${c}x = {d}x^2$ → $x = 0$ or $x = {latex(x_right)}$",
            f"On $[0, {latex(x_right)}]$: $y = {latex(f)}$ is above $y = {latex(g)}$",
            f"$A = \\int_{{0}}^{{{latex(x_right)}}} [{latex(integrand)}]\\, dx$",
            f"$= {latex(integral)} = {latex(area)}$"
        )

        return problem(
            question=question,
            answer=area,
            difficulty=randint(1650, 1850),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

emit(generate())
