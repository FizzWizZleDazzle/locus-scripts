"""
differential_equations - separable_equations (hard)
Generated: 2026-02-22T05:19:41.525814
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Initial value problem with non-trivial integration
        # dy/dx = f(x)g(y) with IVP
        k = nonzero(-3, 3)
        m = choice([2, 3, 4])
        x0 = choice([0, 1])
        y0 = nonzero(1, 4)
        
        # dy/dx = k*x^(m-1) / y^2
        # Separable: y^2 dy = k*x^(m-1) dx
        # y^3/3 = k*x^m/m + C
        # At x=x0, y=y0: C = y0^3/3 - k*x0^m/m
        C_val = Rational(y0**3, 3) - k * Rational(x0**m, m)
        
        question = f"Solve the initial value problem: $\\frac{{dy}}{{dx}} = \\frac{{{latex(k*x**(m-1))}}}{{y^2}}$, $y({x0}) = {y0}$"
        
        # Solution: y^3 = 3k*x^m/m + 3C
        # y = (3k*x^m/m + 3C)^(1/3)
        general_implicit = Eq(y**3 / 3, k * x**m / m + C_val)
        ans = solve(general_implicit, y)[0]
        
        sol_steps = steps(
            f"Separate variables: $y^2\\,dy = {latex(k*x**(m-1))}\\,dx$",
            f"Integrate both sides: $\\int y^2\\,dy = \\int {latex(k*x**(m-1))}\\,dx$",
            f"$\\frac{{y^3}}{{3}} = {latex(k*x**m/m)} + C$",
            f"Apply initial condition $y({x0}) = {y0}$: $\\frac{{{y0**3}}}{{3}} = {latex(k*x0**m/m)} + C$",
            f"$C = {latex(C_val)}$",
            f"$\\frac{{y^3}}{{3}} = {latex(k*x**m/m + C_val)}$",
            f"$y = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1750),
            topic="differential_equations/separable_equations",
            solution=sol_steps
        )
    
    elif problem_type == 2:
        # dy/dx = y(a - by) logistic-type equation
        a = nonzero(1, 4)
        b = choice([1, 2])
        
        question = f"Solve the differential equation: $\\frac{{dy}}{{dx}} = y({a} - {b}y)$"
        
        # Separable: dy/(y(a - by)) = dx
        # Partial fractions: 1/(y(a-by)) = 1/a * (1/y + b/(a-by))
        # Integrate: (1/a)*ln|y| - (1/a)*ln|a-by| = x + C
        # ln|y/(a-by)| = ax + aC
        # y/(a-by) = K*e^(ax) where K = e^(aC)
        
        # General solution (explicit form with arbitrary constant)
        # y = K*a*e^(ax) / (1 + K*b*e^(ax))
        # We'll use C1 as the arbitrary constant
        C1 = symbols('C_1')
        ans = a * C1 * exp(a*x) / (1 + b * C1 * exp(a*x))
        
        sol_steps = steps(
            f"Separate variables: $\\frac{{dy}}{{y({a} - {b}y)}} = dx$",
            f"Use partial fractions: $\\frac{{1}}{{y({a} - {b}y)}} = \\frac{{1}}{{{a}y}} + \\frac{{{b}}}{{{a}({a} - {b}y)}}$",
            f"Integrate: $\\frac{{1}}{{{a}}}\\ln|y| - \\frac{{1}}{{{a}}}\\ln|{a} - {b}y| = x + C$",
            f"Simplify: $\\ln\\left|\\frac{{y}}{{{a} - {b}y}}\\right| = {a}x + {a}C$",
            f"Exponentiate: $\\frac{{y}}{{{a} - {b}y}} = C_1 e^{{{a}x}}$ where $C_1 = e^{{{a}C}}$",
            f"Solve for $y$: $y = \\frac{{{a}C_1 e^{{{a}x}}}}{{1 + {b}C_1 e^{{{a}x}}}}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1800),
            topic="differential_equations/separable_equations",
            solution=sol_steps
        )
    
    elif problem_type == 3:
        # Equation with trig: dy/dx = sec^2(y) * f(x)
        k = nonzero(-4, 4)
        m = choice([1, 2])
        
        if m == 1:
            f_x = k * x
            F_x = k * x**2 / 2
        else:
            f_x = k * x**2
            F_x = k * x**3 / 3
        
        question = f"Solve the differential equation: $\\frac{{dy}}{{dx}} = {latex(f_x)} \\sec^2(y)$"
        
        # Separable: cos^2(y) dy = f(x) dx
        # Integrate: Use identity cos^2(y) = (1 + cos(2y))/2
        # (y/2 + sin(2y)/4) = F(x) + C
        # tan(y) = F(x) + C (simpler approach)
        
        C1 = symbols('C_1')
        ans_implicit = Eq(tan(y), F_x + C1)
        
        sol_steps = steps(
            f"Separate variables: $\\cos^2(y)\\,dy = {latex(f_x)}\\,dx$",
            f"Note: $\\frac{{1}}{{\\sec^2(y)}} = \\cos^2(y)$",
            f"Integrate both sides: $\\int \\cos^2(y)\\,dy = \\int {latex(f_x)}\\,dx$",
            f"Use $\\int \\cos^2(y)\\,dy = \\frac{{y}}{2} + \\frac{{\\sin(2y)}}{4} + C$",
            f"Or equivalently, since $\\frac{{d}}{{dy}}[\\tan(y)] = \\sec^2(y)$, we get:",
            f"$\\tan(y) = {latex(F_x)} + C_1$"
        )
        
        return problem(
            question=question,
            answer=ans_implicit,
            difficulty=(1600, 1700),
            topic="differential_equations/separable_equations",
            solution=sol_steps,
            answer_type="equation"
        )
    
    elif problem_type == 4:
        # dy/dt = ky(M - y) with IVP (limited growth model)
        k = choice([Rational(1,10), Rational(1,5), Rational(1,4)])
        M = choice([100, 50, 200])
        t0 = 0
        y0 = choice([5, 10, 20])
        
        question = f"Solve the initial value problem: $\\frac{{dy}}{{dt}} = {latex(k)}y({M} - y)$, $y({t0}) = {y0}$"
        
        # Solution: 1/(y(M-y)) = 1/(My) + 1/(M(M-y))
        # Integrate: (1/M)ln|y/(M-y)| = kt + C
        # y/(M-y) = K*e^(Mkt)
        # y = M*K*e^(Mkt)/(1 + K*e^(Mkt))
        # At t=0, y=y0: y0/(M-y0) = K
        K_val = Rational(y0, M - y0)
        
        ans = M * K_val * exp(M * k * t) / (1 + K_val * exp(M * k * t))
        
        sol_steps = steps(
            f"Separate variables: $\\frac{{dy}}{{y({M} - y)}} = {latex(k)}\\,dt$",
            f"Partial fractions: $\\frac{{1}}{{y({M} - y)}} = \\frac{{1}}{{{M}y}} + \\frac{{1}}{{{M}({M} - y)}}$",
            f"Integrate: $\\frac{{1}}{{{M}}}\\ln\\left|\\frac{{y}}{{{M} - y}}\\right| = {latex(k)}t + C$",
            f"Exponentiate: $\\frac{{y}}{{{M} - y}} = Ke^{{{latex(M*k)}t}}$",
            f"Apply $y({t0}) = {y0}$: $K = \\frac{{{y0}}}{{{M - y0}}} = {latex(K_val)}$",
            f"Solve for $y$: $y = \\frac{{{M} \\cdot {latex(K_val)} \\cdot e^{{{latex(M*k)}t}}}}{{1 + {latex(K_val)} \\cdot e^{{{latex(M*k)}t}}}}$",
            f"$y = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1850),
            topic="differential_equations/separable_equations",
            solution=sol_steps
        )
    
    else:  # problem_type == 5
        # dy/dx = e^(ax + by) type equation
        a = nonzero(-2, 2)
        b = nonzero(-2, 2)
        
        question = f"Solve the differential equation: $\\frac{{dy}}{{dx}} = e^{{{latex(a*x + b*y)}}}$"
        
        # e^(ax + by) = e^(ax) * e^(by)
        # Separable: e^(-by) dy = e^(ax) dx
        # Integrate: -1/b * e^(-by) = 1/a * e^(ax) + C
        
        C1 = symbols('C_1')
        if b != -1:
            ans_implicit = Eq(-exp(-b*y)/b, exp(a*x)/a + C1)
        else:
            ans_implicit = Eq(exp(y), exp(a*x)/a + C1)
        
        sol_steps = steps(
            f"Rewrite: $\\frac{{dy}}{{dx}} = e^{{{latex(a*x)}}} \\cdot e^{{{latex(b*y)}}}$",
            f"Separate variables: $e^{{{latex(-b*y)}}}\\,dy = e^{{{latex(a*x)}}}\\,dx$",
            f"Integrate both sides: $\\int e^{{{latex(-b*y)}}}\\,dy = \\int e^{{{latex(a*x)}}}\\,dx$",
            f"${latex(-exp(-b*y)/b)} = {latex(exp(a*x)/a)} + C_1$"
        )
        
        return problem(
            question=question,
            answer=ans_implicit,
            difficulty=(1650, 1750),
            topic="differential_equations/separable_equations",
            solution=sol_steps,
            answer_type="equation"
        )

emit(generate())