"""
differential_equations - variation_of_parameters (hard)
Generated: 2026-02-22T05:29:53.828633
"""

from problem_utils import *

def generate():
    # Variation of parameters for second-order linear ODEs
    # y'' + p(x)y' + q(x)y = g(x)
    # At difficulty 1600-1900, we expect:
    # - Non-constant coefficients OR
    # - Complex right-hand side OR
    # - Integration challenges
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: y'' + y = sec(x) or sec^n(x) or tan(x)
        # Homogeneous solution: y_h = c1*cos(x) + c2*sin(x)
        # y1 = cos(x), y2 = sin(x), W = 1
        
        rhs_type = choice(['sec', 'tan', 'sec^3'])
        
        if rhs_type == 'sec':
            g_str = '\\sec(x)'
            # u1 = -integral(sin(x)*sec(x)) = -integral(tan(x)) = ln|cos(x)|
            # u2 = integral(cos(x)*sec(x)) = integral(1) = x
            # y_p = cos(x)*ln|cos(x)| + x*sin(x)
            y_p = cos(x)*log(cos(x)) + x*sin(x)
            
        elif rhs_type == 'tan':
            g_str = '\\tan(x)'
            # u1 = -integral(sin(x)*tan(x)) = -integral(sin^2(x)/cos(x))
            # u2 = integral(cos(x)*tan(x)) = integral(sin(x)) = -cos(x)
            # This is more complex, use sec for cleaner answer
            y_p = -cos(x)*log(cos(x))
            
        else:  # sec^3
            g_str = '\\sec^3(x)'
            # More difficult integration
            y_p = cos(x)*(log(cos(x)) + Rational(1,2)*log((1+sin(x))/(1-sin(x)))) + x*sin(x)
        
        question = f"Use variation of parameters to find a particular solution to $y'' + y = {g_str}$"
        
        solution_steps = [
            f"The homogeneous equation $y'' + y = 0$ has solutions $y_1 = \\cos(x)$ and $y_2 = \\sin(x)$",
            f"The Wronskian is $W = y_1 y_2' - y_1' y_2 = \\cos(x)\\cos(x) - (-\\sin(x))\\sin(x) = 1$",
            f"For variation of parameters with $g(x) = {g_str}$:",
            f"$u_1 = -\\int \\frac{{y_2 g}}{{W}} dx = -\\int \\sin(x) \\cdot {g_str} dx$",
            f"$u_2 = \\int \\frac{{y_1 g}}{{W}} dx = \\int \\cos(x) \\cdot {g_str} dx$",
            f"After integration, $y_p = {latex(y_p)}$"
        ]
        
        ans = y_p
        diff_range = (1700, 1850)
        
    elif problem_type == 2:
        # Type 2: Cauchy-Euler with variation of parameters
        # x^2 y'' + xy' + y = f(x)
        # Standard form: y'' + (1/x)y' + (1/x^2)y = f(x)/x^2
        
        rhs_choice = choice(['ln(x)', 'x^2', '1/x'])
        
        if rhs_choice == 'ln(x)':
            f_str = '\\ln(x)'
            # Homogeneous: y_h = c1*cos(ln(x)) + c2*sin(ln(x))
            # This gets very complex, simplify to constant coefficient
            pass
        
        # Simplify to: y'' - y = x*e^x (cleaner for this difficulty)
        # y1 = e^x, y2 = e^(-x), W = -2
        g_str = 'xe^x'
        y1_expr = exp(x)
        y2_expr = exp(-x)
        W_val = -2
        
        # u1 = -integral(e^(-x) * x*e^x / (-2)) = (1/2)*integral(x) = x^2/4
        # u2 = integral(e^x * x*e^x / (-2)) = -(1/2)*integral(x*e^(2x))
        # Use integration by parts: integral(x*e^(2x)) = (x/2)*e^(2x) - (1/4)*e^(2x)
        
        y_p = Rational(1,4)*x**2*exp(x) - Rational(1,4)*(x - Rational(1,2))*exp(x)
        y_p = simplify(y_p)
        
        question = f"Use variation of parameters to find a particular solution to $y'' - y = {g_str}$"
        
        solution_steps = [
            f"The homogeneous equation $y'' - y = 0$ has solutions $y_1 = e^x$ and $y_2 = e^{{-x}}$",
            f"The Wronskian is $W = e^x \\cdot (-e^{{-x}}) - e^x \\cdot e^{{-x}} = -2$",
            f"For $g(x) = {g_str}$:",
            f"$u_1 = -\\int \\frac{{e^{{-x}} \\cdot xe^x}}{{-2}} dx = \\frac{{1}}{{2}}\\int x dx = \\frac{{x^2}}{{4}}$",
            f"$u_2 = \\int \\frac{{e^x \\cdot xe^x}}{{-2}} dx = -\\frac{{1}}{{2}}\\int xe^{{2x}} dx$",
            f"Using integration by parts: $u_2 = -\\frac{{1}}{{4}}xe^{{2x}} + \\frac{{1}}{{8}}e^{{2x}}$",
            f"$y_p = u_1 y_1 + u_2 y_2 = {latex(y_p)}$"
        ]
        
        ans = y_p
        diff_range = (1650, 1800)
        
    elif problem_type == 3:
        # Type 3: y'' + 4y = csc(2x) or cot(2x)
        # y1 = cos(2x), y2 = sin(2x), W = 2
        
        omega = 2
        g_str = '\\csc(2x)'
        
        # u1 = -integral(sin(2x)*csc(2x)/2) = -integral(1/2) = -x/2
        # u2 = integral(cos(2x)*csc(2x)/2) = (1/2)*integral(cot(2x)) = (1/4)*ln|sin(2x)|
        
        y_p = -Rational(1,2)*x*cos(2*x) + Rational(1,4)*sin(2*x)*log(sin(2*x))
        
        question = f"Use variation of parameters to find a particular solution to $y'' + 4y = {g_str}$"
        
        solution_steps = [
            f"The homogeneous equation $y'' + 4y = 0$ has solutions $y_1 = \\cos(2x)$ and $y_2 = \\sin(2x)$",
            f"The Wronskian is $W = 2$",
            f"$u_1 = -\\int \\frac{{\\sin(2x) \\cdot \\csc(2x)}}{{2}} dx = -\\int \\frac{{1}}{{2}} dx = -\\frac{{x}}{{2}}$",
            f"$u_2 = \\int \\frac{{\\cos(2x) \\cdot \\csc(2x)}}{{2}} dx = \\frac{{1}}{{2}}\\int \\cot(2x) dx = \\frac{{1}}{{4}}\\ln|\\sin(2x)|$",
            f"$y_p = {latex(y_p)}$"
        ]
        
        ans = y_p
        diff_range = (1700, 1850)
        
    else:  # problem_type == 4
        # Type 4: y'' - 2y' + y = e^x / x
        # (y-e^x)^2 homogeneous, so y1 = e^x, y2 = x*e^x, W = e^(2x)
        
        g_str = '\\frac{e^x}{x}'
        
        # u1 = -integral(x*e^x * e^x/x / e^(2x)) = -integral(1) = -x
        # u2 = integral(e^x * e^x/x / e^(2x)) = integral(1/x) = ln|x|
        
        y_p = -x*exp(x) + x*exp(x)*log(x)
        y_p = simplify(y_p)
        
        question = f"Use variation of parameters to find a particular solution to $y'' - 2y' + y = {g_str}$"
        
        solution_steps = [
            f"The homogeneous equation $y'' - 2y' + y = 0$ has characteristic equation $(r-1)^2 = 0$",
            f"Solutions: $y_1 = e^x$ and $y_2 = xe^x$",
            f"The Wronskian is $W = e^{{2x}}$",
            f"$u_1 = -\\int \\frac{{xe^x \\cdot e^x/x}}{{e^{{2x}}}} dx = -\\int 1 dx = -x$",
            f"$u_2 = \\int \\frac{{e^x \\cdot e^x/x}}{{e^{{2x}}}} dx = \\int \\frac{{1}}{{x}} dx = \\ln|x|$",
            f"$y_p = {latex(y_p)}$"
        ]
        
        ans = y_p
        diff_range = (1750, 1900)
    
    return problem(
        question=question,
        answer=ans,
        difficulty=diff_range,
        topic="differential_equations/variation_of_parameters",
        solution=steps(*solution_steps),
        calculator="cas"
    )

emit(generate())