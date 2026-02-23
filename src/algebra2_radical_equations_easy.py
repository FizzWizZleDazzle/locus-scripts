"""
algebra2 - radical_equations (easy)
Generated: 2026-02-22T04:26:46.270545
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # sqrt(x) = c
        c = randint(2, 12)
        ans = c**2
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x}} = {c}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $(\\sqrt{{x}})^2 = {c}^2$",
                f"$x = {ans}$",
                f"Check: $\\sqrt{{{ans}}} = {c}$ ✓"
            ),
        )

    elif problem_type == 2:
        # sqrt(x + a) = b, ensure answer > 0
        b = randint(2, 10)
        a = randint(1, b**2 - 1)
        ans = b**2 - a
        if ans < 1:
            b = randint(3, 10)
            a = randint(1, 8)
            ans = b**2 - a
            if ans < 1:
                a = 1
                ans = b**2 - a
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x + {a}}} = {b}$",
            answer=ans,
            difficulty=(1050, 1200),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $x + {a} = {b}^2 = {b**2}$",
                f"$x = {b**2} - {a} = {ans}$",
                f"Check: $\\sqrt{{{ans} + {a}}} = \\sqrt{{{b**2}}} = {b}$ ✓"
            ),
        )

    elif problem_type == 3:
        # sqrt(ax) = b where b^2 divisible by a
        a = choice([2, 3, 4, 5, 6])
        b = a * randint(1, 4)  # ensure b^2 / a is integer
        ans = b**2 // a
        return problem(
            question=f"Solve for $x$: $\\sqrt{{{a}x}} = {b}$",
            answer=ans,
            difficulty=(1050, 1200),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: ${a}x = {b}^2 = {b**2}$",
                f"$x = \\frac{{{b**2}}}{{{a}}} = {ans}$",
                f"Check: $\\sqrt{{{a} \\cdot {ans}}} = \\sqrt{{{b**2}}} = {b}$ ✓"
            ),
        )

    elif problem_type == 4:
        # sqrt(x) + a = b
        sqrt_ans = randint(2, 8)
        ans = sqrt_ans**2
        a = randint(1, 6)
        b = sqrt_ans + a
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x}} + {a} = {b}$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Isolate the radical: $\\sqrt{{x}} = {b} - {a} = {b - a}$",
                f"Square both sides: $x = {b - a}^2 = {ans}$",
                f"Check: $\\sqrt{{{ans}}} + {a} = {sqrt_ans} + {a} = {b}$ ✓"
            ),
        )

    elif problem_type == 5:
        # sqrt(x - a) = b, ensure a >= 0
        b = randint(2, 8)
        a = randint(1, 10)
        ans = b**2 + a
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x - {a}}} = {b}$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $x - {a} = {b}^2 = {b**2}$",
                f"$x = {b**2} + {a} = {ans}$",
                f"Check: $\\sqrt{{{ans} - {a}}} = \\sqrt{{{b**2}}} = {b}$ ✓"
            ),
        )

    else:
        # cbrt(x) = c  (cube root)
        c = choice([-4, -3, -2, 2, 3, 4, 5])
        ans = c**3
        return problem(
            question=f"Solve for $x$: $\\sqrt[3]{{x}} = {c}$",
            answer=ans,
            difficulty=(1150, 1300),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Cube both sides: $x = {c}^3 = {ans}$",
                f"Check: $\\sqrt[3]{{{ans}}} = {c}$ ✓"
            ),
        )

emit(generate())
