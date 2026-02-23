"""
algebra1 - quadratic_formula (medium)
Generated: 2026-02-22T04:02:09.307734
"""

from problem_utils import *

def _latex_eq(a, b, c):
    """Build readable LaTeX string for ax^2 + bx + c = 0."""
    terms = []
    if a == 1:
        terms.append("x^2")
    elif a == -1:
        terms.append("-x^2")
    else:
        terms.append(f"{a}x^2")
    if b > 0:
        terms.append(f"+ {b}x")
    elif b < 0:
        terms.append(f"- {abs(b)}x")
    if c > 0:
        terms.append(f"+ {c}")
    elif c < 0:
        terms.append(f"- {abs(c)}")
    return " ".join(terms) + " = 0"

def generate():
    target_elo = randint(1300, 1600)

    if target_elo < 1400:
        # a=1, integer roots, wide coefficient range
        a_val = 1
        r1 = randint(-10, 10)
        r2 = randint(-10, 10)
        b_val = -(r1 + r2)
        c_val = r1 * r2
        difficulty = (1300, 1400)

    elif target_elo < 1500:
        if randint(0,1):
            # a∈{2,3,4,5}, integer roots
            a_val = choice([2, 3, 4, 5])
            r1 = randint(-6, 6)
            r2 = randint(-6, 6)
            b_val = -a_val * (r1 + r2)
            c_val = a_val * r1 * r2
        else:
            # a=1, irrational roots from varied b,c
            a_val = 1
            b_val = choice([-8,-6,-4,-2,2,4,6,8])
            c_val = choice([-5,-4,-3,-2,-1,1,2])
        difficulty = (1400, 1500)

    else:
        if randint(0,1):
            # Complex roots: force disc < 0
            a_val = choice([1, 2, 3])
            b_val = choice([-4,-2,2,4,6])
            c_val = choice([5, 8, 10, 13, 17, 20])
            disc_check = b_val**2 - 4*a_val*c_val
            if disc_check >= 0:
                c_val += abs(disc_check)//a_val + 1
        else:
            # a≠1, irrational roots
            a_val = choice([2, 3, 4])
            b_val = choice([-7,-5,-3,3,5,7])
            c_val = choice([-5,-4,-3,-2,2,3])
        difficulty = (1500, 1600)

    disc_val = b_val**2 - 4*a_val*c_val
    roots_syms = [(-b_val + sqrt(disc_val))/(2*a_val),
                  (-b_val - sqrt(disc_val))/(2*a_val)]
    roots_syms_sorted = sorted(roots_syms, key=lambda r: str(r))
    ans = FiniteSet(*roots_syms_sorted)

    eq_str = _latex_eq(a_val, b_val, c_val)

    sol_steps = [
        f"$a={a_val}$, $b={b_val}$, $c={c_val}$",
        f"Discriminant: $\\Delta = ({b_val})^2 - 4({a_val})({c_val}) = {disc_val}$",
    ]
    if disc_val < 0:
        sol_steps.append(f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc_val))}}}{{{2*a_val}}}$")
    else:
        sol_steps.append(f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc_val}}}}}{{{2*a_val}}}$")
    sol_steps.append(f"Solutions: $x = {latex(roots_syms_sorted[0])}$ and $x = {latex(roots_syms_sorted[1])}$")

    return problem(
        question=f"Solve using the quadratic formula: ${eq_str}$",
        answer=ans,
        difficulty=difficulty,
        topic="algebra1/quadratic_formula",
        solution=steps(*sol_steps),
        calculator="scientific"
    )

emit(generate())
