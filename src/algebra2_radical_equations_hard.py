"""
algebra2 - radical_equations (hard)
Generated: 2026-02-22T04:27:45.035985
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # sqrt(x + a) + sqrt(x + b) = c  (double radical, square twice)
        # Construct with known integer x_val
        a = randint(1, 8)
        b = randint(a + 1, a + 10)
        # pick x_val such that both x+a and x+b are perfect squares
        x_val = choice([0, 1, 3, 6, 10, 15, 21])
        # try to find one where both radicands are perfect squares
        for trial in range(2, 30):
            xa = trial + a
            xb = trial + b
            sqrt_xa = int(xa**0.5)
            sqrt_xb = int(xb**0.5)
            if sqrt_xa**2 == xa and sqrt_xb**2 == xb:
                x_val = trial
                c = sqrt_xa + sqrt_xb
                break
        else:
            # fallback: non-perfect-square, let SymPy solve
            x_val = randint(5, 12)
            c_sym = sqrt(x_val + a) + sqrt(x_val + b)
            c = int(float(c_sym))
            if c <= 0:
                a, b, x_val = 3, 7, 9
                c = int(float(sqrt(9 + 3) + sqrt(9 + 7)))

        equation = Eq(sqrt(x + a) + sqrt(x + b), c)
        solutions = solve(equation, x)
        valid_sols = [s for s in solutions if s.is_real and s + a >= 0 and s + b >= 0
                      and simplify(sqrt(s + a) + sqrt(s + b) - c) == 0]
        ans = valid_sols[0] if len(valid_sols) == 1 else (FiniteSet(*valid_sols) if valid_sols else x_val)

        return problem(
            question=f"Solve for $x$: $\\sqrt{{x+{a}}} + \\sqrt{{x+{b}}} = {c}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Isolate one radical: $\\sqrt{{x+{a}}} = {c} - \\sqrt{{x+{b}}}$",
                f"Square both sides: $x+{a} = {c**2} - {2*c}\\sqrt{{x+{b}}} + x+{b}$",
                f"Simplify: ${2*c}\\sqrt{{x+{b}}} = {c**2 + b - a}$",
                f"Square again: ${4*c**2}(x+{b}) = {(c**2 + b - a)**2}$",
                f"Solve for $x$ and check in original equation",
                f"$x = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # sqrt(ax + b) = x + c  (quadratic, may have two solutions)
        a = choice([2, 3, 4, 5, 6])
        c = randint(-3, 4)
        # Construct guaranteed valid solution
        x_val = randint(2, 10)
        rhs = x_val + c
        if rhs < 0:
            x_val = max(3, -c + 1)
            rhs = x_val + c
        b = rhs**2 - a * x_val

        equation = Eq(sqrt(a*x + b), x + c)
        solutions = solve(equation, x)
        valid_sols = [s for s in solutions if s.is_real and a*s + b >= 0 and s + c >= 0
                      and simplify(sqrt(a*s + b) - (s + c)) == 0]
        ans = valid_sols[0] if len(valid_sols) == 1 else (FiniteSet(*valid_sols) if valid_sols else x_val)

        return problem(
            question=f"Solve for $x$: $\\sqrt{{{a}x + {b}}} = x + {c}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Require $x + {c} \\ge 0$ (RHS must be non-negative)",
                f"Square both sides: ${a}x + {b} = (x+{c})^2 = x^2 + {2*c}x + {c**2}$",
                f"Rearrange: $x^2 + {2*c - a}x + {c**2 - b} = 0$",
                f"Solve quadratic and reject extraneous roots",
                f"$x = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # sqrt(x^2 + ax + b) = cx + d  (quadratic inside radical)
        c_coeff = choice([1, 2])
        d_coeff = randint(1, 4)
        x_val = randint(1, 7)
        rhs = c_coeff * x_val + d_coeff
        a = randint(1, 8)
        b = rhs**2 - x_val**2 - a * x_val

        equation = Eq(sqrt(x**2 + a*x + b), c_coeff*x + d_coeff)
        solutions = solve(equation, x)
        valid_sols = [s for s in solutions if s.is_real
                      and s**2 + a*s + b >= 0
                      and c_coeff*s + d_coeff >= 0
                      and simplify(sqrt(s**2 + a*s + b) - (c_coeff*s + d_coeff)) == 0]
        ans = valid_sols[0] if len(valid_sols) == 1 else (FiniteSet(*valid_sols) if valid_sols else x_val)

        return problem(
            question=f"Solve for $x$: $\\sqrt{{x^2 + {a}x + {b}}} = {latex(c_coeff*x + d_coeff)}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Require $x + {d_coeff} \\ge 0$ so RHS is non-negative",
                f"Square both sides: $x^2 + {a}x + {b} = {latex(expand((c_coeff*x + d_coeff)**2))}$",
                f"Simplify and solve",
                f"Check all solutions in original equation",
                f"$x = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # cbrt(ax + b) = c  (cube root equation, no domain issues)
        a = choice([2, 3, 4, 5, 6])
        c = choice([-3, -2, -1, 2, 3, 4])
        x_val = randint(-5, 8)
        b = c**3 - a * x_val
        ans = x_val

        return problem(
            question=f"Solve for $x$: $\\sqrt[3]{{{a}x + {b}}} = {c}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Cube both sides: ${a}x + {b} = {c}^3 = {c**3}$",
                f"${a}x = {c**3 - b}$",
                f"$x = \\frac{{{c**3 - b}}}{{{a}}} = {ans}$",
                f"Check: $\\sqrt[3]{{{a * ans + b}}} = \\sqrt[3]{{{c**3}}} = {c}$ ✓"
            ),
        )

    else:
        # sqrt(x + a) - sqrt(x - b) = c  (both radicals, square twice)
        # Construct: pick x_val, both radicands must be perfect squares
        b = randint(1, 6)
        for x_val in range(b + 1, 40):
            xpa = x_val + randint(1, 6)
            xa = x_val - b
            if xa >= 0:
                sq_xpa = int(xpa**0.5)
                sq_xa = int(xa**0.5)
                if sq_xpa**2 == xpa and sq_xa**2 == xa:
                    a_val = xpa - x_val
                    c = sq_xpa - sq_xa
                    if c > 0:
                        break
        else:
            # fallback
            x_val, a_val, b, c = 16, 9, 7, 1

        equation = Eq(sqrt(x + a_val) - sqrt(x - b), c)
        solutions = solve(equation, x)
        valid_sols = [s for s in solutions if s.is_real and s + a_val >= 0 and s - b >= 0
                      and simplify(sqrt(s + a_val) - sqrt(s - b) - c) == 0]
        ans = valid_sols[0] if len(valid_sols) == 1 else (FiniteSet(*valid_sols) if valid_sols else x_val)

        return problem(
            question=f"Solve for $x$: $\\sqrt{{x+{a_val}}} - \\sqrt{{x-{b}}} = {c}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Isolate one radical: $\\sqrt{{x+{a_val}}} = {c} + \\sqrt{{x-{b}}}$",
                f"Square: $x+{a_val} = {c**2} + {2*c}\\sqrt{{x-{b}}} + x-{b}$",
                f"Simplify: ${a_val + b - c**2} = {2*c}\\sqrt{{x-{b}}}$",
                f"Square again and solve for $x$",
                f"$x = {latex(ans)}$"
            ),
        )

emit(generate())
