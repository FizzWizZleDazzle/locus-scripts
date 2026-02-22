"""
differential_equations - first_order_linear (hard)
Generated: 2026-02-22T05:21:07.079289
"""

from problem_utils import *

def generate():
    problem_type = choice(['integrating_factor', 'bernoulli', 'exact_after_factor', 'variable_coefficients'])
    
    if problem_type == 'integrating_factor':
        # dy/dx + P(x)y = Q(x) with non-constant P(x)
        # Choose P(x) and Q(x) to make integrable
        p_type = choice(['polynomial', 'rational', 'trig'])
        
        if p_type == 'polynomial':
            a_val = nonzero(-3, 3)
            # dy/dx + ax*y = x^n or e^x
            q_type = choice(['poly', 'exp'])
            if q_type == 'poly':
                n_val = randint(1, 3)
                P_x = a_val * x
                Q_x = x**n_val
            else:
                P_x = a_val * x
                Q_x = exp(x)
            
            mu = exp(integrate(P_x, x))
            mu_simplified = exp(Rational(a_val, 2) * x**2)
            
            # Solution: y = 1/mu * integral(mu * Q(x) dx)
            integrand = mu_simplified * Q_x
            
            question = f"Solve the differential equation $\\frac{{dy}}{{dx}} + {latex(P_x)}y = {latex(Q_x)}$"
            
            solution_steps = steps(
                f"This is a first-order linear equation of the form $\\frac{{dy}}{{dx}} + P(x)y = Q(x)$ where $P(x) = {latex(P_x)}$",
                f"Find the integrating factor: $\\mu(x) = e^{{\\int {latex(P_x)} dx}} = e^{{{latex(Rational(a_val, 2) * x**2)}}}$",
                f"Multiply both sides by $\\mu(x)$: $e^{{{latex(Rational(a_val, 2) * x**2)}}}\\frac{{dy}}{{dx}} + e^{{{latex(Rational(a_val, 2) * x**2)}}}\\cdot {latex(P_x)}y = e^{{{latex(Rational(a_val, 2) * x**2)}}}\\cdot {latex(Q_x)}$",
                f"The left side is $\\frac{{d}}{{dx}}\\left[ye^{{{latex(Rational(a_val, 2) * x**2)}}}\\right] = e^{{{latex(Rational(a_val, 2) * x**2)}}}\\cdot {latex(Q_x)}$",
                f"Integrate both sides with respect to $x$ and solve for $y$"
            )
            
            diff_eq = Eq(diff(y, x) + P_x * y, Q_x)
            
        elif p_type == 'rational':
            # dy/dx + (a/x)y = Q(x)
            a_val = nonzero(-4, 4)
            P_x = a_val / x
            
            q_choice = choice(['poly', 'log'])
            if q_choice == 'poly':
                n_val = randint(1, 3)
                Q_x = x**n_val
            else:
                Q_x = log(x)
            
            mu_simplified = x**a_val
            
            question = f"Solve the differential equation $\\frac{{dy}}{{dx}} + \\frac{{{a_val}}}{{x}}y = {latex(Q_x)}$ for $x > 0$"
            
            solution_steps = steps(
                f"This is a first-order linear equation with $P(x) = \\frac{{{a_val}}}{{x}}$",
                f"Integrating factor: $\\mu(x) = e^{{\\int \\frac{{{a_val}}}{{x}} dx}} = e^{{{a_val}\\ln|x|}} = x^{{{a_val}}}$",
                f"Multiply by $\\mu(x)$: $\\frac{{d}}{{dx}}\\left[y x^{{{a_val}}}\\right] = x^{{{a_val}}} \\cdot {latex(Q_x)}$",
                f"Integrate both sides: $y x^{{{a_val}}} = \\int x^{{{a_val}}} \\cdot {latex(Q_x)} dx$",
                f"Solve for $y$ and include the constant of integration $C$"
            )
            
            diff_eq = Eq(diff(y, x) + P_x * y, Q_x)
        
        else:  # trig
            # dy/dx + tan(x)y = Q(x)
            Q_x = choice([sin(x), cos(x), sec(x)**2])
            P_x = tan(x)
            
            question = f"Solve the differential equation $\\frac{{dy}}{{dx}} + \\tan(x)y = {latex(Q_x)}$"
            
            solution_steps = steps(
                f"First-order linear equation with $P(x) = \\tan(x)$",
                f"Integrating factor: $\\mu(x) = e^{{\\int \\tan(x) dx}} = e^{{-\\ln|\\cos(x)|}} = \\sec(x)$",
                f"Multiply by $\\mu(x) = \\sec(x)$",
                f"Left side becomes $\\frac{{d}}{{dx}}[y\\sec(x)] = \\sec(x) \\cdot {latex(Q_x)}$",
                f"Integrate and solve for $y$ with constant $C$"
            )
            
            diff_eq = Eq(diff(y, x) + P_x * y, Q_x)
    
    elif problem_type == 'bernoulli':
        # Bernoulli equation: dy/dx + P(x)y = Q(x)y^n, n != 0, 1
        n_val = choice([2, 3, -1])
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        P_x = a_val / x if choice([True, False]) else a_val
        Q_x = b_val * x if choice([True, False]) else b_val
        
        if isinstance(P_x, int):
            p_str = str(a_val) if a_val != 1 else ""
            if a_val == -1:
                p_str = "-"
        else:
            p_str = f"\\frac{{{a_val}}}{{x}}"
        
        question = f"Solve the Bernoulli equation $\\frac{{dy}}{{dx}} + {p_str}y = {latex(Q_x)}y^{{{n_val}}}$"
        
        solution_steps = steps(
            f"This is a Bernoulli equation with $n = {n_val}$",
            f"Divide by $y^{{{n_val}}}$: $y^{{-{n_val}}}\\frac{{dy}}{{dx}} + {p_str}y^{{1-{n_val}}} = {latex(Q_x)}$",
            f"Substitute $v = y^{{1-{n_val}}} = y^{{{1-n_val}}}$, so $\\frac{{dv}}{{dx}} = {1-n_val}y^{{-{n_val}}}\\frac{{dy}}{{dx}}$",
            f"This transforms to a linear equation in $v$: $\\frac{{dv}}{{dx}} + {latex((1-n_val)*P_x)}v = {latex((1-n_val)*Q_x)}$",
            f"Solve using integrating factor method, then substitute back $y = v^{{1/{1-n_val}}}$"
        )
        
        diff_eq = Eq(diff(y, x) + P_x * y, Q_x * y**n_val)
    
    elif problem_type == 'exact_after_factor':
        # Give equation that becomes exact after multiplying by integrating factor
        mu_type = choice(['x_power', 'y_power', 'xy_power'])
        
        if mu_type == 'x_power':
            n_val = randint(1, 2)
            a_val = nonzero(-2, 2)
            b_val = nonzero(-2, 2)
            
            M = a_val * y
            N = b_val * x
            
            question = f"Find an integrating factor of the form $\\mu(x) = x^n$ for the equation ${latex(M)}dx + {latex(N)}dy = 0$, then solve"
            
            solution_steps = steps(
                f"For $\\mu(x) = x^n$, we need $\\frac{{\\partial}}{{\\partial y}}[\\mu M] = \\frac{{\\partial}}{{\\partial x}}[\\mu N]$",
                f"$M = {latex(M)}$ and $N = {latex(N)}$",
                f"After multiplying by $x^n$: $\\frac{{\\partial}}{{\\partial y}}[{latex(M)}x^n] = {latex(a_val)}x^n$ and $\\frac{{\\partial}}{{\\partial x}}[{latex(N)}x^n] = {latex(b_val)}nx^{{n-1}}$",
                f"Setting equal: ${latex(a_val)}x^n = {latex(b_val)}nx^{{n-1}}$, solve for $n$",
                f"Use integrating factor to make equation exact and solve"
            )
            
            diff_eq = Eq(M + N * diff(y, x), 0)
        
        else:
            # More complex case
            a_val = nonzero(-2, 2)
            b_val = nonzero(-2, 2)
            
            M = a_val * x + y
            N = b_val * y + x
            
            question = f"Solve the differential equation ${latex(M)}dx + {latex(N)}dy = 0$ by finding an appropriate integrating factor"
            
            solution_steps = steps(
                f"Check if exact: $\\frac{{\\partial M}}{{\\partial y}} = 1$ and $\\frac{{\\partial N}}{{\\partial x}} = 1$",
                f"The equation is exact. Find $F(x,y)$ such that $\\frac{{\\partial F}}{{\\partial x}} = {latex(M)}$ and $\\frac{{\\partial F}}{{\\partial y}} = {latex(N)}$",
                f"Integrate to find $F(x,y)$ and set $F(x,y) = C$"
            )
            
            diff_eq = Eq(M + N * diff(y, x), 0)
    
    else:  # variable_coefficients
        # More complex P(x) and Q(x)
        coeff_type = choice(['polynomial_high', 'product'])
        
        if coeff_type == 'polynomial_high':
            a_val = nonzero(-2, 2)
            b_val = nonzero(-2, 2)
            
            P_x = a_val * x**2
            Q_x = b_val * x
            
            question = f"Solve $\\frac{{dy}}{{dx}} + {latex(P_x)}y = {latex(Q_x)}$"
            
            solution_steps = steps(
                f"Linear first-order equation with $P(x) = {latex(P_x)}$",
                f"Integrating factor: $\\mu(x) = e^{{\\int {latex(P_x)} dx}} = e^{{{latex(a_val * x**3 / 3)}}}$",
                f"Multiply and recognize left side as derivative: $\\frac{{d}}{{dx}}[ye^{{{latex(a_val * x**3 / 3)}}}] = {latex(Q_x)}e^{{{latex(a_val * x**3 / 3)}}}$",
                f"Integrate right side (may need numerical or special function methods)",
                f"General solution involves integral and constant $C$"
            )
            
            diff_eq = Eq(diff(y, x) + P_x * y, Q_x)
        
        else:
            # Product form
            a_val = nonzero(-2, 2)
            b_val = nonzero(-2, 2)
            
            P_x = a_val * x * exp(x)
            Q_x = b_val * exp(x)
            
            question = f"Solve $\\frac{{dy}}{{dx}} + {latex(P_x)}y = {latex(Q_x)}$"
            
            solution_steps = steps(
                f"First-order linear with $P(x) = {latex(P_x)}$ and $Q(x) = {latex(Q_x)}$",
                f"Find integrating factor $\\mu(x) = e^{{\\int {latex(P_x)} dx}}$",
                f"Note: $\\int {latex(P_x)} dx$ requires integration by parts",
                f"Apply integrating factor method to obtain general solution with constant $C$"
            )
            
            diff_eq = Eq(diff(y, x) + P_x * y, Q_x)
    
    return problem(
        question=question,
        answer=diff_eq,
        difficulty=(1600, 1900),
        topic="differential_equations/first_order_linear",
        solution=solution_steps,
        answer_type="equation"
    )

emit(generate())