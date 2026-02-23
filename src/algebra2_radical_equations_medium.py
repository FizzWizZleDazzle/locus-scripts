"""
algebra2 - radical_equations (medium)
Generated: 2026-02-22T04:27:05.963949
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # sqrt(ax + b) = c, integer solution
        a = choice([2, 3, 4, 5, 6])
        c = randint(2, 8)
        # choose x_val then compute b
        x_val = randint(1, 10)
        b = c**2 - a * x_val
        # ensure b is reasonable
        if b < 0:
            x_val = 1
            b = c**2 - a * x_val
        ans = x_val
        return problem(
            question=f"Solve for $x$: $\\sqrt{{{a}x + {b}}} = {c}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: ${a}x + {b} = {c}^2 = {c**2}$",
                f"${a}x = {c**2} - {b} = {c**2 - b}$",
                f"$x = \\frac{{{c**2 - b}}}{{{a}}} = {ans}$",
                f"Check: $\\sqrt{{{a * ans + b}}} = {c}$ ✓"
            ),
        )

    elif problem_type == 2:
        # sqrt(ax + b) + c = d, isolate then square
        a = choice([2, 3, 4, 5])
        d = randint(4, 10)
        c = randint(1, d - 1)
        radical_val = d - c
        x_val = randint(1, 10)
        b = radical_val**2 - a * x_val
        ans = x_val
        return problem(
            question=f"Solve for $x$: $\\sqrt{{{a}x + {b}}} + {c} = {d}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Isolate the radical: $\\sqrt{{{a}x + {b}}} = {d} - {c} = {radical_val}$",
                f"Square both sides: ${a}x + {b} = {radical_val**2}$",
                f"${a}x = {radical_val**2 - b}$",
                f"$x = {ans}$",
                f"Check: $\\sqrt{{{a * ans + b}}} + {c} = {radical_val} + {c} = {d}$ ✓"
            ),
        )

    elif problem_type == 3:
        # sqrt(x + a) = sqrt(2x + b), square and solve linear
        x_val = randint(3, 15)
        a = randint(2, 12)
        b = x_val + a - 2 * x_val   # = a - x_val
        # verify b < a so x = a - b > 0
        if x_val <= 0 or (x_val + a) < 0:
            x_val = 5
            a = 8
            b = a - x_val
        ans = x_val
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x + {a}}} = \\sqrt{{2x + {b}}}$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $x + {a} = 2x + {b}$",
                f"${a} - {b} = x$",
                f"$x = {a - b}$",
                f"Check: $\\sqrt{{{ans + a}}} = \\sqrt{{{2*ans + b}}}$ ✓"
            ),
        )

    elif problem_type == 4:
        # sqrt(ax + b) = x + c  (quadratic after squaring)
        # construct: pick x_val, then a, c, compute b
        x_val = randint(1, 8)
        c = randint(1, 4)
        rhs = x_val + c
        a = choice([2, 3, 4, 5])
        b = rhs**2 - a * x_val
        if b < 0:
            c = 2
            rhs = x_val + c
            b = rhs**2 - a * x_val
        ans = x_val
        return problem(
            question=f"Solve for $x$: $\\sqrt{{{a}x + {b}}} = x + {c}$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: ${a}x + {b} = (x + {c})^2 = x^2 + {2*c}x + {c**2}$",
                f"Rearrange: $x^2 + {2*c - a}x + {c**2 - b} = 0$",
                f"Solve the quadratic and check that $x + {c} \\ge 0$",
                f"$x = {ans}$ (check: $\\sqrt{{{a*ans+b}}} = {rhs}$ and ${ans} + {c} = {rhs}$ ✓)"
            ),
        )

    elif problem_type == 5:
        # 2*sqrt(x + a) = b, b even
        b = choice([4, 6, 8, 10, 12])
        a = randint(0, 8)
        # sqrt(x + a) = b/2
        half_b = b // 2
        ans = half_b**2 - a
        if ans < 0:
            a = 0
            ans = half_b**2
        return problem(
            question=f"Solve for $x$: $2\\sqrt{{x + {a}}} = {b}$",
            answer=ans,
            difficulty=(1300, 1430),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Divide both sides by 2: $\\sqrt{{x + {a}}} = {half_b}$",
                f"Square both sides: $x + {a} = {half_b**2}$",
                f"$x = {half_b**2} - {a} = {ans}$",
                f"Check: $2\\sqrt{{{ans + a}}} = 2 \\cdot {half_b} = {b}$ ✓"
            ),
        )

    else:
        # sqrt(x) - a = b
        sqrt_ans = randint(3, 10)
        ans = sqrt_ans**2
        a = randint(1, 5)
        b = sqrt_ans - a
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x}} - {a} = {b}$",
            answer=ans,
            difficulty=(1300, 1420),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Add ${a}$ to both sides: $\\sqrt{{x}} = {b} + {a} = {b + a}$",
                f"Square both sides: $x = {b + a}^2 = {ans}$",
                f"Check: $\\sqrt{{{ans}}} - {a} = {sqrt_ans} - {a} = {b}$ ✓"
            ),
        )

emit(generate())
