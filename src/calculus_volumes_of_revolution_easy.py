"""
calculus - volumes_of_revolution (easy)
Generated: 2026-02-22T05:17:11.456789
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # Disk method: revolve y = h (constant) around x-axis from 0 to b
        height = randint(1, 8)
        b_bound = randint(1, 8)

        volume = pi * height**2 * b_bound

        question = (f"Find the volume when the region bounded by $y = {height}$, $y = 0$, "
                    f"$x = 0$, and $x = {b_bound}$ is revolved around the $x$-axis.")

        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{0}}^{{{b_bound}}} [{height}]^2 \\, dx$",
            f"$V = \\pi \\cdot {height**2} \\int_{{0}}^{{{b_bound}}} dx$",
            f"$V = \\pi \\cdot {height**2} \\cdot {b_bound}$",
            f"$V = {latex(volume)}$"
        )

        return problem(
            question=question,
            answer=volume,
            difficulty=(1000, 1100),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )

    elif problem_type == 2:
        # Disk method: revolve y = mx around x-axis from 0 to b
        m_val = randint(1, 5)
        b_bound = randint(1, 8)

        # V = π * m² * b³/3
        volume = pi * m_val**2 * b_bound**3 / 3

        func_str = f"y = {m_val}x" if m_val != 1 else "y = x"

        question = (f"Find the volume when the region bounded by ${func_str}$, $y = 0$, "
                    f"and $x = {b_bound}$ is revolved around the $x$-axis.")

        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{0}}^{{{b_bound}}} ({m_val}x)^2 \\, dx$",
            f"$V = \\pi \\cdot {m_val**2} \\int_{{0}}^{{{b_bound}}} x^2 \\, dx$",
            f"$V = \\pi \\cdot {m_val**2} \\cdot \\left[\\frac{{x^3}}{{3}}\\right]_{{0}}^{{{b_bound}}}$",
            f"$V = \\pi \\cdot {m_val**2} \\cdot \\frac{{{b_bound**3}}}{{3}}$",
            f"$V = {latex(volume)}$"
        )

        return problem(
            question=question,
            answer=volume,
            difficulty=(1100, 1250),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )

    elif problem_type == 3:
        # Disk method: revolve y = √x around x-axis from 0 to b
        b_bound = randint(1, 8)

        volume = pi * b_bound**2 / 2

        question = (f"Find the volume when the region bounded by $y = \\sqrt{{x}}$, $y = 0$, "
                    f"and $x = {b_bound}$ is revolved around the $x$-axis.")

        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{0}}^{{{b_bound}}} (\\sqrt{{x}})^2 \\, dx$",
            f"$V = \\pi \\int_{{0}}^{{{b_bound}}} x \\, dx$",
            f"$V = \\pi \\left[\\frac{{x^2}}{{2}}\\right]_{{0}}^{{{b_bound}}}$",
            f"$V = \\pi \\cdot \\frac{{{b_bound**2}}}{{2}}$",
            f"$V = {latex(volume)}$"
        )

        return problem(
            question=question,
            answer=volume,
            difficulty=(1200, 1300),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )

    else:
        # Disk method: revolve y = x^(1/n) around x-axis from 0 to b
        # n in {3, 4} so the exponent is 1/3 or 1/4
        n = choice([3, 4])
        b_bound = randint(1, 6)

        # y^2 = x^(2/n), ∫₀ᵇ x^(2/n) dx = b^(2/n+1)/(2/n+1)
        from sympy import Rational as Rat
        exp_sq = Rat(2, n)
        volume = pi * b_bound**(exp_sq + 1) / (exp_sq + 1)
        volume = simplify(volume)

        root_str = f"\\sqrt[{n}]{{x}}"

        question = (f"Find the volume when the region bounded by $y = {root_str}$, $y = 0$, "
                    f"and $x = {b_bound}$ is revolved around the $x$-axis.")

        solution = steps(
            f"Using the disk method: $V = \\pi \\int_{{0}}^{{{b_bound}}} \\left({root_str}\\right)^2 \\, dx$",
            f"$V = \\pi \\int_{{0}}^{{{b_bound}}} x^{{2/{n}}} \\, dx$",
            f"$V = \\pi \\left[\\frac{{x^{{2/{n}+1}}}}{{2/{n}+1}}\\right]_{{0}}^{{{b_bound}}}$",
            f"$V = {latex(volume)}$"
        )

        return problem(
            question=question,
            answer=volume,
            difficulty=(1200, 1300),
            topic="calculus/volumes_of_revolution",
            solution=solution
        )

emit(generate())
