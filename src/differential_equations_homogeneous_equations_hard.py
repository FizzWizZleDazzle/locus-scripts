"""
differential_equations - homogeneous_equations (hard)
Generated: 2026-02-22T05:24:05.527732
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # dy/dx = (a1*x + a2*y) / (b1*x + b2*y)  — general rational homogeneous
        # Keep trying until integral is tractable
        for _ in range(20):
            a1 = nonzero(-4, 4)
            a2 = nonzero(-4, 4)
            b1 = nonzero(-4, 4)
            b2 = nonzero(-4, 4)

            if a1 * b2 == a2 * b1:
                continue  # degenerate (parallel)

            v = symbols('v')
            rhs_in_v = (a1 + a2 * v) / (b1 + b2 * v)
            separable_lhs = simplify(rhs_in_v - v)

            if separable_lhs == 0:
                continue

            try:
                left_integral = integrate(1 / separable_lhs, v)
                solution_implicit = Eq(left_integral.subs(v, y / x), log(Abs(x)) + c)

                numerator = a1 * x + a2 * y
                denominator = b1 * x + b2 * y

                question_text = f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"

                sol_steps = steps(
                    f"Degree-1 homogeneous equation. Let $v = y/x$, so $y = vx$",
                    f"$\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}} = \\frac{{{a1} + {a2}v}}{{{b1} + {b2}v}}$",
                    f"$x\\frac{{dv}}{{dx}} = {latex(rhs_in_v)} - v = {latex(separable_lhs)}$",
                    f"Separate: $\\frac{{dv}}{{{latex(separable_lhs)}}} = \\frac{{dx}}{{x}}$",
                    f"Integrate: ${latex(left_integral)} = \\ln|x| + C$",
                    f"Back-substitute $v = y/x$: ${latex(solution_implicit)}$"
                )

                return problem(
                    question=question_text,
                    answer=solution_implicit,
                    difficulty=(1650, 1800),
                    topic="differential_equations/homogeneous_equations",
                    solution=sol_steps,
                    answer_type="equation"
                )
            except Exception:
                continue

    if problem_type == 2:
        # (x + a*y)dx + (b*x + c_coef*y)dy = 0  — linear combination
        for _ in range(20):
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            c_coef = nonzero(-3, 3)

            if a == b:
                continue

            v = symbols('v')
            # dy/dx = -(1 + a*v)/(b + c_coef*v)
            rhs_in_v = -(1 + a * v) / (b + c_coef * v)
            separable_lhs = simplify(rhs_in_v - v)

            if separable_lhs == 0:
                continue

            try:
                left_integral = integrate(1 / separable_lhs, v)
                solution_implicit = Eq(left_integral.subs(v, y / x), log(Abs(x)) + c)

                numerator = x + a * y
                denominator = b * x + c_coef * y

                question_text = f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"

                sol_steps = steps(
                    f"Recognise homogeneous (both numerator and denominator degree 1). Let $v = y/x$",
                    f"$v + x\\frac{{dv}}{{dx}} = \\frac{{1 + {a}v}}{{{b} + {c_coef}v}} \\cdot (-1)$",
                    f"$x\\frac{{dv}}{{dx}} = {latex(separable_lhs)}$",
                    f"Integrate $\\int \\frac{{dv}}{{{latex(separable_lhs)}}} = \\ln|x| + C$",
                    f"Back-substitute: ${latex(solution_implicit)}$"
                )

                return problem(
                    question=question_text,
                    answer=solution_implicit,
                    difficulty=(1700, 1850),
                    topic="differential_equations/homogeneous_equations",
                    solution=sol_steps,
                    answer_type="equation"
                )
            except Exception:
                continue

    if problem_type == 3:
        # dy/dx = (x^2 + a*y^2)/(x*y)  — quadratic homogeneous
        a = choice([1, 2, 3, 4])

        v = symbols('v')
        # dy/dx = (x^2 + a*y^2)/(x*y) = 1/v + a*v  (after dividing top and bottom by x^2)
        rhs_in_v = 1 / v + a * v
        separable_lhs = simplify(rhs_in_v - v)

        try:
            left_integral = integrate(1 / separable_lhs, v)
            solution_implicit = Eq(left_integral.subs(v, y / x), log(Abs(x)) + c)

            numerator = x**2 + a * y**2
            denominator = x * y

            question_text = f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"

            sol_steps = steps(
                f"Both numerator and denominator are degree 2 — homogeneous. Let $v = y/x$",
                f"Rewrite: $\\frac{{dy}}{{dx}} = \\frac{{x^2(1 + {a}v^2)}}{{x^2 v}} = \\frac{{1 + {a}v^2}}{{v}}$",
                f"$x\\frac{{dv}}{{dx}} = {latex(separable_lhs)}$",
                f"Separate and integrate: ${latex(left_integral)} = \\ln|x| + C$",
                f"Back-substitute $v = y/x$: ${latex(solution_implicit)}$"
            )

            return problem(
                question=question_text,
                answer=solution_implicit,
                difficulty=(1750, 1900),
                topic="differential_equations/homogeneous_equations",
                solution=sol_steps,
                answer_type="equation"
            )
        except Exception:
            pass

    # Default fallback: classic (x^2 + y^2)/(x*y)
    a = 1
    v = symbols('v')
    rhs_in_v = 1 / v + a * v
    separable_lhs = simplify(rhs_in_v - v)
    left_integral = integrate(1 / separable_lhs, v)
    solution_implicit = Eq(left_integral.subs(v, y / x), log(Abs(x)) + c)

    numerator = x**2 + a * y**2
    denominator = x * y

    sol_steps = steps(
        f"Degree-2 homogeneous. Let $v = y/x$",
        f"Rewrite: $\\frac{{dy}}{{dx}} = \\frac{{1 + v^2}}{{v}}$",
        f"$x\\frac{{dv}}{{dx}} = {latex(separable_lhs)}$",
        f"Integrate and back-substitute: ${latex(solution_implicit)}$"
    )

    return problem(
        question=f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
        answer=solution_implicit,
        difficulty=(1750, 1900),
        topic="differential_equations/homogeneous_equations",
        solution=sol_steps,
        answer_type="equation"
    )


emit(generate())
