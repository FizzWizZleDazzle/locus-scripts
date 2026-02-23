"""
differential_equations - exact_equations (easy)
Generated: 2026-02-22T05:21:35.471571
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 3)

    if difficulty_choice == 1:
        # Build from F = a*x^2/2 + b*x*y (M = a*x + b*y, N = b*x)
        a = randint(2, 8)
        b = randint(1, 6)

        M = a * x + b * y
        N = b * x

        dM_dy = diff(M, y)
        dN_dx = diff(N, x)

        f = integrate(M, x)
        g_prime = N - diff(f, y)
        g = integrate(g_prime, y)
        C_const = symbols('C')
        solution = Eq(f + g, C_const)

        question = f"Verify that $({latex(M)})dx + ({latex(N)})dy = 0$ is exact and find its implicit solution."

        sol_steps = steps(
            f"$M = {latex(M)}$, $N = {latex(N)}$",
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$, $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$ — equal, so exact",
            f"Integrate $M$ w.r.t. $x$: $F = {latex(f)} + g(y)$",
            f"Differentiate w.r.t. $y$: $\\frac{{\\partial F}}{{\\partial y}} = {latex(diff(f,y))} + g'(y) = N = {latex(N)}$",
            f"$g'(y) = {latex(g_prime)}$, $g(y) = {latex(g)}$",
            f"Implicit solution: ${latex(solution)}$"
        )

        return problem(
            question=question,
            answer=solution,
            difficulty=(1000, 1100),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )

    elif difficulty_choice == 2:
        # F = a*x*y + b*x^2/2 + c*y^2/2  =>  M = a*y + b*x, N = a*x + c*y
        a = randint(1, 5)
        b = randint(1, 5)
        c = randint(1, 5)

        F = a * x * y + Rational(b, 2) * x**2 + Rational(c, 2) * y**2
        M = diff(F, x)
        N = diff(F, y)

        dM_dy = diff(M, y)
        dN_dx = diff(N, x)

        C_const = symbols('C')
        solution = Eq(F, C_const)

        question = f"Solve the exact differential equation $({latex(M)})dx + ({latex(N)})dy = 0$."

        integral_M = integrate(M, x)

        sol_steps = steps(
            f"$M = {latex(M)}$, $N = {latex(N)}$",
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)} = \\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$ ✓",
            f"Integrate $M$ w.r.t. $x$: ${latex(integral_M)} + g(y)$",
            f"$g'(y) = N - {latex(diff(integral_M, y))} = {latex(simplify(N - diff(integral_M, y)))}$",
            f"$g(y) = {latex(integrate(simplify(N - diff(integral_M, y)), y))}$",
            f"Solution: ${latex(solution)}$"
        )

        return problem(
            question=question,
            answer=solution,
            difficulty=(1100, 1200),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )

    else:
        # Check exactness (yes/no)
        is_exact = choice([True, False])

        if is_exact:
            a = randint(1, 5)
            b = randint(1, 5)
            c = randint(1, 5)
            # Ensure exact: M_y = N_x
            M = a * x * y + b * x
            N = Rational(a, 2) * x**2 + c * y
            ans = True
        else:
            a = randint(2, 6)
            b = randint(1, 5)
            c = randint(1, 5)
            M = a * x + b * y
            N = c * x + b * y + 1  # M_y = b, N_x = c; if a != c then not exact
            while diff(M, y) == diff(N, x):
                c = randint(1, 8)
                N = c * x + b * y + 1
            ans = False

        dM_dy = diff(M, y)
        dN_dx = diff(N, x)

        question = f"Is the differential equation $({latex(M)})dx + ({latex(N)})dy = 0$ exact?"

        sol_steps = steps(
            f"$M = {latex(M)}$, $N = {latex(N)}$",
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
            f"$\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
            f"Since $\\frac{{\\partial M}}{{\\partial y}} {'=' if ans else '\\neq'} \\frac{{\\partial N}}{{\\partial x}}$, the equation is {'exact' if ans else 'not exact'}."
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="boolean"
        )


emit(generate())
