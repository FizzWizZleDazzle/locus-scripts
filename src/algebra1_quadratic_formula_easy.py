"""
algebra1 - quadratic_formula (easy)
Generated: 2026-02-22T04:01:47.330615
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 3)

    if difficulty_choice == 1:
        # Easiest: a=1, integer roots, wide range of root pairs
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        # Allow equal roots for variety
        a_val = 1
        b_val = -(r1 + r2)
        c_val = r1 * r2

        equation = Eq(x**2 + b_val*x + c_val, 0)
        disc = b_val**2 - 4*a_val*c_val
        sol1 = (-b_val + sqrt(disc)) / 2
        sol2 = (-b_val - sqrt(disc)) / 2
        ans = FiniteSet(sol1, sol2)

        return problem(
            question=f"Solve using the quadratic formula: ${latex(equation)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"$x = \\frac{{-({b_val}) \\pm \\sqrt{{({b_val})^2 - 4(1)({c_val})}}}}{{2}}$",
                f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc}}}}}{{2}}$",
                f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc))}}}{{2}}$",
                f"$x = {latex(sol1)}$ or $x = {latex(sol2)}$"
            ),
            calculator="scientific"
        )

    elif difficulty_choice == 2:
        # Medium-easy: a=1, wider range of roots including negative
        r1 = randint(-10, 10)
        r2 = randint(-10, 10)
        a_val = 1
        b_val = -(r1 + r2)
        c_val = r1 * r2

        equation = Eq(x**2 + b_val*x + c_val, 0)
        disc = b_val**2 - 4*a_val*c_val
        sol1 = (-b_val + sqrt(disc)) / 2
        sol2 = (-b_val - sqrt(disc)) / 2
        ans = FiniteSet(sol1, sol2)

        return problem(
            question=f"Use the quadratic formula to solve: ${latex(equation)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"Discriminant: $b^2-4ac = ({b_val})^2 - 4({a_val})({c_val}) = {disc}$",
                f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc}}}}}{{2}}$",
                f"$x = {latex(sol1)}$ or $x = {latex(sol2)}$"
            ),
            calculator="scientific"
        )

    else:
        # Harder in easy range: a∈{1..5}, b∈{-10..10}, c∈{-20..20} with perfect square disc
        a_val = choice([2, 3, 4, 5])
        r1 = randint(-5, 5)
        r2 = randint(-5, 5)
        b_val = -a_val * (r1 + r2)
        c_val = a_val * r1 * r2

        equation = Eq(a_val*x**2 + b_val*x + c_val, 0)
        disc = b_val**2 - 4*a_val*c_val
        sol1 = (-b_val + sqrt(disc)) / (2*a_val)
        sol2 = (-b_val - sqrt(disc)) / (2*a_val)
        ans = FiniteSet(sol1, sol2)

        return problem(
            question=f"Solve using the quadratic formula: ${latex(equation)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/quadratic_formula",
            solution=steps(
                f"$a={a_val}$, $b={b_val}$, $c={c_val}$",
                f"Discriminant: $({b_val})^2 - 4({a_val})({c_val}) = {disc}$",
                f"$x = \\frac{{-({b_val}) \\pm \\sqrt{{{disc}}}}}{{2({a_val})}}$",
                f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc))}}}{{{2*a_val}}}$",
                f"$x = {latex(sol1)}$ or $x = {latex(sol2)}$"
            ),
            calculator="scientific"
        )

emit(generate())
