"""
differential_equations - laplace_transforms (hard)
Generated: 2026-02-22T05:31:47.642846
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Laplace transform with partial fractions
        # L^{-1}[F(s)] where F(s) requires partial fraction decomposition
        a = randint(2, 5)
        b = randint(1, 4)
        c = randint(1, 3)
        
        # Create F(s) = (As + B) / ((s-a)(s+b))
        A = nonzero(-4, 4)
        B = randint(1, 6)
        
        # Partial fractions: (As + B)/((s-a)(s+b)) = C1/(s-a) + C2/(s+b)
        # As + B = C1(s+b) + C2(s-a)
        # At s=a: Aa + B = C1(a+b) => C1 = (Aa+B)/(a+b)
        # At s=-b: -Ab + B = C2(-b-a) => C2 = (-Ab+B)/(-b-a) = (Ab-B)/(b+a)
        
        C1 = Rational(A*a + B, a+b)
        C2 = Rational(A*(-b) + B, -(b+a))
        
        # Inverse Laplace: C1*e^(at) + C2*e^(-bt)
        ans = C1*exp(a*t) + C2*exp(-b*t)
        
        numerator_latex = f"{A}s + {B}" if B > 0 else f"{A}s {B}"
        
        return problem(
            question=f"Find the inverse Laplace transform: $\\mathcal{{L}}^{{-1}}\\left[\\frac{{{numerator_latex}}}{{(s-{a})(s+{b})}}\\right]$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Use partial fraction decomposition: $\\frac{{{numerator_latex}}}{{(s-{a})(s+{b})}} = \\frac{{C_1}}{{s-{a}}} + \\frac{{C_2}}{{s+{b}}}$",
                f"Solving for constants: $C_1 = {latex(C1)}$, $C_2 = {latex(C2)}$",
                f"Apply inverse Laplace: $\\mathcal{{L}}^{{-1}}\\left[\\frac{{1}}{{s-{a}}}\\right] = e^{{{a}t}}$ and $\\mathcal{{L}}^{{-1}}\\left[\\frac{{1}}{{s+{b}}}\\right] = e^{{-{b}t}}$",
                f"Final answer: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Solve IVP using Laplace transforms with discontinuous forcing
        # y'' + ay' + by = step function, y(0) = y0, y'(0) = v0
        a_coef = randint(2, 5)
        b_coef = randint(1, 4)
        y0 = nonzero(-2, 2)
        v0 = nonzero(-2, 2)
        t0 = randint(1, 3)
        
        # For simplicity, create a problem with known structure
        # y'' + 5y' + 6y = u(t-t0), y(0)=0, y'(0)=0
        # This factors as (s^2 + 5s + 6) = (s+2)(s+3)
        
        a_coef = 5
        b_coef = 6
        y0 = 0
        v0 = 0
        
        # Y(s) = e^(-st0)/(s(s+2)(s+3))
        # Using partial fractions: 1/(s(s+2)(s+3)) = A/s + B/(s+2) + C/(s+3)
        # A = 1/6, B = -1/2, C = 1/3
        
        A_pf = Rational(1, 6)
        B_pf = Rational(-1, 2)
        C_pf = Rational(1, 3)
        
        # y(t) = u(t-t0)[1/6 - (1/2)e^(-2(t-t0)) + (1/3)e^(-3(t-t0))]
        ans_expr = A_pf - B_pf*exp(-2*(t-t0)) + C_pf*exp(-3*(t-t0))
        
        return problem(
            question=f"Solve the IVP using Laplace transforms: $y'' + 5y' + 6y = u(t-{t0})$, $y(0) = 0$, $y'(0) = 0$, where $u(t-{t0})$ is the unit step function. Give $y(t)$ for $t \\geq {t0}$.",
            answer=ans_expr,
            difficulty=(1700, 1850),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Take Laplace transform: $(s^2Y(s) - sy(0) - y'(0)) + 5(sY(s) - y(0)) + 6Y(s) = e^{{-{t0}s}}/s$",
                f"With initial conditions: $(s^2 + 5s + 6)Y(s) = e^{{-{t0}s}}/s$",
                f"$Y(s) = \\frac{{e^{{-{t0}s}}}}{{s(s+2)(s+3)}}$",
                f"Partial fractions: $\\frac{{1}}{{s(s+2)(s+3)}} = \\frac{{{latex(A_pf)}}}{{s}} + \\frac{{{latex(B_pf)}}}{{s+2}} + \\frac{{{latex(C_pf)}}}{{s+3}}$",
                f"Apply inverse Laplace and shifting theorem:",
                f"$y(t) = u(t-{t0})\\left[{latex(ans_expr)}\\right]$ for $t \\geq {t0}$: ${latex(ans_expr)}$"
            ),
        )
    
    elif problem_type == 3:
        # Laplace transform of t^n * f(t) using frequency differentiation
        # Find L[t^2 * sin(omega*t)]
        omega = randint(2, 5)
        
        # L[sin(omega*t)] = omega/(s^2 + omega^2)
        # L[t*sin(omega*t)] = -d/ds[omega/(s^2 + omega^2)] = 2*omega*s/(s^2+omega^2)^2
        # L[t^2*sin(omega*t)] = d^2/ds^2[omega/(s^2+omega^2)]
        
        s_sym = symbols('s')
        F_s = omega / (s_sym**2 + omega**2)
        dF = -diff(F_s, s_sym)
        d2F = diff(dF, s_sym)
        ans = simplify(d2F)
        
        return problem(
            question=f"Find the Laplace transform: $\\mathcal{{L}}[t^2 \\sin({omega}t)]$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Use the frequency differentiation property: $\\mathcal{{L}}[t^n f(t)] = (-1)^n \\frac{{d^n}}{{ds^n}}F(s)$",
                f"We know $\\mathcal{{L}}[\\sin({omega}t)] = \\frac{{{omega}}}{{s^2 + {omega**2}}}$",
                f"First derivative: $\\frac{{d}}{{ds}}\\left[\\frac{{{omega}}}{{s^2 + {omega**2}}}\\right] = {latex(simplify(-diff(F_s, s_sym)))}$",
                f"Second derivative: $\\frac{{d}}{{ds}}\\left[{latex(simplify(-diff(F_s, s_sym)))}\\right] = {latex(ans)}$",
                f"Therefore: $\\mathcal{{L}}[t^2 \\sin({omega}t)] = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Convolution theorem problem
        # Find L^-1[F(s)*G(s)] = f*g
        a = randint(2, 4)
        b = randint(2, 4)
        
        # L^-1[1/(s-a) * 1/(s+b)] using convolution
        # f(t) = e^(at), g(t) = e^(-bt)
        # (f*g)(t) = integral from 0 to tau of e^(a*tau)*e^(-b(t-tau)) d_tau
        # = e^(-bt) * integral e^((a+b)tau) dtau
        # = e^(-bt) * [e^((a+b)tau)/(a+b)] from 0 to t
        # = e^(-bt) * (e^((a+b)t) - 1)/(a+b)
        # = (e^(at) - e^(-bt))/(a+b)
        
        ans = (exp(a*t) - exp(-b*t)) / (a + b)
        
        return problem(
            question=f"Use the convolution theorem to find: $\\mathcal{{L}}^{{-1}}\\left[\\frac{{1}}{{(s-{a})(s+{b})}}\\right]$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Write as product: $\\frac{{1}}{{s-{a}}} \\cdot \\frac{{1}}{{s+{b}}}$",
                f"By convolution theorem: $f(t) = e^{{{a}t}}$, $g(t) = e^{{-{b}t}}$",
                f"$(f * g)(t) = \\int_0^t e^{{{a}\\tau}} e^{{-{b}(t-\\tau)}} d\\tau$",
                f"$= e^{{-{b}t}} \\int_0^t e^{{({a}+{b})\\tau}} d\\tau = e^{{-{b}t}} \\left[\\frac{{e^{{({a}+{b})\\tau}}}}{{{a+b}}}\\right]_0^t$",
                f"$= \\frac{{e^{{{a}t}} - e^{{-{b}t}}}}{{{a+b}}}$"
            ),
        )
    
    else:
        # System of ODEs using Laplace
        # x' = ax + by, y' = cx + dy with initial conditions
        # Simpler system: x' = x + 2y, y' = 3x + 2y, x(0)=1, y(0)=0
        
        x0 = nonzero(-2, 2)
        y0 = 0
        
        # sX - 1 = X + 2Y => (s-1)X - 2Y = 1
        # sY = 3X + 2Y => -3X + (s-2)Y = 0
        
        # Solving: X = (s-2)/((s-1)(s-2) - 6) = (s-2)/(s^2-3s-4) = (s-2)/((s-4)(s+1))
        
        s_sym = symbols('s')
        # Using Cramer's rule or substitution
        # From second eq: Y = 3X/(s-2)
        # Substitute: (s-1)X - 6X/(s-2) = 1
        # (s-1)(s-2)X - 6X = (s-2)
        # X[(s-1)(s-2) - 6] = s-2
        # X(s^2 - 3s + 2 - 6) = s-2
        # X(s^2 - 3s - 4) = s-2
        # X = (s-2)/((s-4)(s+1))
        
        # Partial fractions: (s-2)/((s-4)(s+1)) = A/(s-4) + B/(s+1)
        # s-2 = A(s+1) + B(s-4)
        # s=4: 2 = 5A => A = 2/5
        # s=-1: -3 = -5B => B = 3/5
        
        A_x = Rational(2, 5)
        B_x = Rational(3, 5)
        
        ans_x = A_x * exp(4*t) + B_x * exp(-t)
        
        return problem(
            question=f"Solve for $x(t)$ using Laplace transforms: $x' = x + 2y$, $y' = 3x + 2y$, with $x(0) = 1$, $y(0) = 0$",
            answer=ans_x,
            difficulty=(1750, 1900),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Take Laplace transforms: $(sX(s) - 1) = X(s) + 2Y(s)$ and $sY(s) = 3X(s) + 2Y(s)$",
                f"Rearrange: $(s-1)X(s) - 2Y(s) = 1$ and $-3X(s) + (s-2)Y(s) = 0$",
                f"From second equation: $Y(s) = \\frac{{3X(s)}}{{s-2}}$",
                f"Substitute: $(s-1)X(s) - \\frac{{6X(s)}}{{s-2}} = 1$",
                f"Simplify: $X(s)(s^2 - 3s - 4) = s - 2$, so $X(s) = \\frac{{s-2}}{{(s-4)(s+1)}}$",
                f"Partial fractions: $X(s) = \\frac{{{latex(A_x)}}}{{s-4}} + \\frac{{{latex(B_x)}}}{{s+1}}$",
                f"Inverse Laplace: $x(t) = {latex(ans_x)}$"
            ),
        )

emit(generate())