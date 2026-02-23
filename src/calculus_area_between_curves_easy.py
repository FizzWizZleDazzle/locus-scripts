"""
calculus - area_between_curves (easy)
Generated: 2026-02-22T05:15:47.519777
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # ∫₀ᵃ (k - c*x²) dx  — horizontal line above parabola
        # a in {1..4}, k in {1..8}, c in {1..3}
        a_val = randint(1, 4)
        c = randint(1, 3)
        k = c * a_val**2 + randint(1, 6)   # ensure k > c*a² so line is above

        area_val = k * a_val - c * a_val**3 / 3
        area_val = Rational(int(3 * k * a_val - c * a_val**3), 3)

        c_str = f"{c}" if c != 1 else ""
        question = f"Find the area between $y = {k}$ and $y = {c_str}x^2$ from $x = 0$ to $x = {a_val}$."

        solution = steps(
            f"Area $= \\int_0^{{{a_val}}} \\left({k} - {c_str}x^2\\right) dx$",
            f"$= \\left[{k}x - \\frac{{{c}x^3}}{{3}}\\right]_0^{{{a_val}}}$",
            f"$= {k}({a_val}) - \\frac{{{c}({a_val})^3}}{{3}}$",
            f"$= {latex(area_val)}$"
        )

        return problem(
            question=question,
            answer=area_val,
            difficulty=(1000, 1150),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 2:
        # Area between y = h and y = m*x on [0, h/m] (the natural intersection)
        m = randint(1, 5)
        h = m * randint(1, 6)  # ensure h divisible by m for integer bound
        x2 = h // m

        area_val = Rational(h * x2, 2)

        m_str = f"{m}x" if m != 1 else "x"
        question = f"Find the area between $y = {h}$ and $y = {m_str}$ from $x = 0$ to $x = {x2}$."

        solution = steps(
            f"Area $= \\int_0^{{{x2}}} \\left({h} - {m}x\\right) dx$",
            f"$= \\left[{h}x - \\frac{{{m}x^2}}{{2}}\\right]_0^{{{x2}}}$",
            f"$= {h}({x2}) - \\frac{{{m}({x2})^2}}{{2}}$",
            f"$= {latex(area_val)}$"
        )

        return problem(
            question=question,
            answer=area_val,
            difficulty=(1100, 1250),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 3:
        # Parabola c - x² above x-axis on [-a, a]  (symmetric)
        a_val = randint(1, 4)
        c = randint(1, 6)
        # Ensure c > a² so the parabola stays positive
        c = max(c, a_val**2 + 1)

        area_val = Rational(2 * a_val * (3 * c - a_val**2), 3)

        question = f"Find the area between $y = {c} - x^2$ and the $x$-axis from $x = -{a_val}$ to $x = {a_val}$."

        solution = steps(
            f"Area $= \\int_{{{-a_val}}}^{{{a_val}}} ({c} - x^2) dx$",
            f"By symmetry: $= 2\\int_0^{{{a_val}}} ({c} - x^2) dx$",
            f"$= 2\\left[{c}x - \\frac{{x^3}}{{3}}\\right]_0^{{{a_val}}}$",
            f"$= 2\\left({c * a_val} - \\frac{{{a_val**3}}}{{3}}\\right) = {latex(area_val)}$"
        )

        return problem(
            question=question,
            answer=area_val,
            difficulty=(1150, 1300),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    elif problem_type == 4:
        # Area between two lines on given interval
        # Upper: y = m1*x + b1, Lower: y = m2*x + b2  (m1 > m2 so upper is above)
        m1 = randint(2, 6)
        m2 = randint(1, m1 - 1)
        b_offset = randint(1, 5)  # upper is at least this far above lower at x=0
        b1 = b_offset
        b2 = 0

        x_left = randint(0, 2)
        x_right = x_left + randint(2, 5)

        f_upper = m1 * x + b1
        f_lower = m2 * x + b2
        diff_expr = f_upper - f_lower

        area_val = integrate(diff_expr, (x, x_left, x_right))

        question = (f"Find the area between $y = {latex(f_upper)}$ and $y = {latex(f_lower)}$ "
                    f"from $x = {x_left}$ to $x = {x_right}$.")

        solution = steps(
            f"The upper curve is $y = {latex(f_upper)}$ and the lower is $y = {latex(f_lower)}$",
            f"Area $= \\int_{{{x_left}}}^{{{x_right}}} \\left[{latex(diff_expr)}\\right] dx$",
            f"$= \\left[{latex(integrate(diff_expr, x))}\\right]_{{{x_left}}}^{{{x_right}}}$",
            f"$= {latex(area_val)}$"
        )

        return problem(
            question=question,
            answer=area_val,
            difficulty=(1100, 1250),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

    else:
        # Area between y = k - c*x² and y = c*x² - k on [-a, a]
        # (two symmetric parabolas)
        a_val = randint(1, 3)
        c = randint(1, 3)
        k = c * a_val**2  # so they intersect at ±a_val

        area_val = Rational(8 * c * a_val**3, 3)

        question = (f"Find the area between $y = {k} - {c}x^2$ and $y = {c}x^2 - {k}$ "
                    f"from $x = -{a_val}$ to $x = {a_val}$.")

        solution = steps(
            f"Area $= \\int_{{{-a_val}}}^{{{a_val}}} \\left[({k} - {c}x^2) - ({c}x^2 - {k})\\right] dx$",
            f"$= \\int_{{{-a_val}}}^{{{a_val}}} ({2*k} - {2*c}x^2) dx$",
            f"By symmetry: $= 2\\int_0^{{{a_val}}} ({2*k} - {2*c}x^2) dx$",
            f"$= 2\\left[{2*k}x - \\frac{{{2*c}x^3}}{{3}}\\right]_0^{{{a_val}}}$",
            f"$= {latex(area_val)}$"
        )

        return problem(
            question=question,
            answer=area_val,
            difficulty=(1200, 1300),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

emit(generate())
