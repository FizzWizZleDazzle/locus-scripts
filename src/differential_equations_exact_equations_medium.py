"""
differential_equations - exact_equations (medium)
Generated: 2026-02-22T05:22:03.153996
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # F = a*x^2 + b*x*y + c*y^2  (quadratic potential)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        c_val = nonzero(-5, 5)

        F = a_val * x**2 + b_val * x * y + c_val * y**2
        M = diff(F, x)
        N = diff(F, y)

        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        is_exact = simplify(dM_dy - dN_dx) == 0

        ans = is_exact

        question = f"Determine if ${latex(M)}\\,dx + ({latex(N)})\\,dy = 0$ is exact."

        sol_steps = steps(
            f"$M = {latex(M)}$, $\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
            f"$N = {latex(N)}$, $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
            f"{'Equal — the equation is exact.' if is_exact else 'Not equal — the equation is not exact.'}"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1420),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="boolean"
        )

    elif problem_type == 2:
        # Solve: F = a*x^n + b*x*y + c*y^m  (polynomial potential)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        n = randint(2, 4)
        m = randint(2, 4)

        F = a_val * x**n + b_val * x * y + c_val * y**m
        M = diff(F, x)
        N = diff(F, y)

        ans = Eq(F, c)

        question = f"Solve the exact differential equation ${latex(M)}\\,dx + ({latex(N)})\\,dy = 0$."

        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        integral_M = integrate(M, x)
        g_prime = simplify(N - diff(integral_M, y))

        sol_steps = steps(
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)} = \\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$ ✓",
            f"Integrate $M$ w.r.t. $x$: $\\int M\\,dx = {latex(integral_M)} + g(y)$",
            f"$g'(y) = N - \\frac{{\\partial}}{{\\partial y}}[{latex(integral_M)}] = {latex(g_prime)}$",
            f"$g(y) = {latex(integrate(g_prime, y))}$",
            f"Solution: ${latex(F)} = c$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1520),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )

    elif problem_type == 3:
        # Solve: F = a*x*e^(b*y) or a*e^(b*x)*y
        a_val = nonzero(-4, 4)
        b_val = nonzero(-3, 3)
        form = choice(['xe^y', 'e^xy'])

        if form == 'xe^y':
            F = a_val * x * exp(b_val * y)
        else:
            F = a_val * exp(b_val * x) * y

        M = diff(F, x)
        N = diff(F, y)

        ans = Eq(F, c)

        question = f"Solve the exact differential equation $({latex(M)})\\,dx + ({latex(N)})\\,dy = 0$."

        integral_M = integrate(M, x)
        g_prime = simplify(N - diff(integral_M, y))

        sol_steps = steps(
            f"Verify exactness: $M_y = {latex(diff(M, y))}$, $N_x = {latex(diff(N, x))}$ ✓",
            f"Integrate $M$ w.r.t. $x$: $F = {latex(integral_M)} + g(y)$",
            f"$g'(y) = {latex(g_prime)}$, $g(y) = {latex(integrate(g_prime, y))}$",
            f"Solution: ${latex(F)} = c$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )

    else:
        # Check if exact (non-exact case with random coefficients)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        d_val = nonzero(-4, 4)

        M = a_val * x + b_val * y**2
        N = c_val * x * y + d_val

        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        is_exact = simplify(dM_dy - dN_dx) == 0
        ans = is_exact

        question = f"Is $({latex(M)})\\,dx + ({latex(N)})\\,dy = 0$ exact?"

        sol_steps = steps(
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
            f"$\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
            f"{'Equal — exact.' if is_exact else f'Not equal ({latex(dM_dy)} ≠ {latex(dN_dx)}) — not exact.'}"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1420, 1530),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="boolean"
        )


emit(generate())
