"""
precalculus - inverse_trig_functions (medium)
Generated: 2026-02-22T04:48:39.721043
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Evaluate arcsin/arccos/arctan at standard values
        func = choice(['arcsin', 'arccos', 'arctan'])
        
        if func == 'arcsin':
            values = [(-1, -pi/2), (-sqrt(3)/2, -pi/3), (-sqrt(2)/2, -pi/4), 
                     (-1/2, -pi/6), (0, 0), (1/2, pi/6), (sqrt(2)/2, pi/4), 
                     (sqrt(3)/2, pi/3), (1, pi/2)]
        elif func == 'arccos':
            values = [(-1, pi), (-sqrt(3)/2, 5*pi/6), (-sqrt(2)/2, 3*pi/4), 
                     (-1/2, 2*pi/3), (0, pi/2), (1/2, pi/3), (sqrt(2)/2, pi/4), 
                     (sqrt(3)/2, pi/6), (1, 0)]
        else:  # arctan
            values = [(-sqrt(3), -pi/3), (-1, -pi/4), (-sqrt(3)/3, -pi/6), 
                     (0, 0), (sqrt(3)/3, pi/6), (1, pi/4), (sqrt(3), pi/3)]
        
        val, ans = choice(values)
        
        func_latex = {'arcsin': '\\arcsin', 'arccos': '\\arccos', 'arctan': '\\arctan'}[func]
        
        return problem(
            question=f"Evaluate ${func_latex}\\left({latex(val)}\\right)$",
            answer=ans,
            difficulty=(1200, 1350),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"Recall that ${func_latex}$ returns the angle whose {func[3:]} is the input",
                f"${func_latex}\\left({latex(val)}\\right) = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Solve equation like sin(x) = value, find x in range
        trig_func = choice(['sin', 'cos', 'tan'])
        
        if trig_func == 'sin':
            values = [(1/2, pi/6), (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/3), 
                     (-1/2, -pi/6), (-sqrt(2)/2, -pi/4), (-sqrt(3)/2, -pi/3)]
        elif trig_func == 'cos':
            values = [(1/2, pi/3), (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/6),
                     (-1/2, 2*pi/3), (-sqrt(2)/2, 3*pi/4), (-sqrt(3)/2, 5*pi/6)]
        else:  # tan
            values = [(1, pi/4), (sqrt(3), pi/3), (sqrt(3)/3, pi/6),
                     (-1, -pi/4), (-sqrt(3), -pi/3), (-sqrt(3)/3, -pi/6)]
        
        val, base_ans = choice(values)
        
        if trig_func == 'sin':
            range_text = "-\\frac{\\pi}{2} \\leq x \\leq \\frac{\\pi}{2}"
        elif trig_func == 'cos':
            range_text = "0 \\leq x \\leq \\pi"
        else:
            range_text = "-\\frac{\\pi}{2} < x < \\frac{\\pi}{2}"
        
        ans = base_ans
        
        func_latex = {'sin': '\\sin', 'cos': '\\cos', 'tan': '\\tan'}[trig_func]
        inv_func_latex = {'sin': '\\arcsin', 'cos': '\\arccos', 'tan': '\\arctan'}[trig_func]
        
        return problem(
            question=f"Solve ${func_latex}(x) = {latex(val)}$ for $x$ where ${range_text}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"Apply ${inv_func_latex}$ to both sides",
                f"$x = {inv_func_latex}\\left({latex(val)}\\right)$",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Composition like arcsin(sin(θ)) where θ may or may not be in range
        angle_vals = [pi/6, pi/4, pi/3, 2*pi/3, 3*pi/4, 5*pi/6]
        theta = choice(angle_vals)
        
        if theta <= pi/2:
            ans = theta
            explanation = f"Since ${latex(theta)}$ is in $\\left[-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right]$, we have $\\arcsin(\\sin({latex(theta)})) = {latex(theta)}$"
        else:
            ans = pi - theta
            explanation = f"Since ${latex(theta)} > \\frac{{\\pi}}{{2}}$, we need to find the equivalent angle in $\\left[-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right]$"
        
        return problem(
            question=f"Simplify $\\arcsin\\left(\\sin\\left({latex(theta)}\\right)\\right)$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"First evaluate $\\sin\\left({latex(theta)}\\right) = {latex(sin(theta))}$",
                explanation,
                f"Answer: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Find domain or range of inverse trig function composition
        inner_choice = choice(['2x', 'x-1', 'x+1', '3x'])
        
        if inner_choice == '2x':
            domain_condition = '-\\frac{1}{2} \\leq x \\leq \\frac{1}{2}'
            ans_left, ans_right = Rational(-1, 2), Rational(1, 2)
        elif inner_choice == 'x-1':
            domain_condition = '0 \\leq x \\leq 2'
            ans_left, ans_right = 0, 2
        elif inner_choice == 'x+1':
            domain_condition = '-2 \\leq x \\leq 0'
            ans_left, ans_right = -2, 0
        else:  # 3x
            domain_condition = '-\\frac{1}{3} \\leq x \\leq \\frac{1}{3}'
            ans_left, ans_right = Rational(-1, 3), Rational(1, 3)
        
        ans = fmt_interval(ans_left, ans_right, False, False)
        
        return problem(
            question=f"Find the domain of $f(x) = \\arcsin({inner_choice})$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="precalculus/inverse_trig_functions",
            answer_type="interval",
            solution=steps(
                f"The domain of $\\arcsin$ is $[-1, 1]$",
                f"We need $-1 \\leq {inner_choice} \\leq 1$",
                f"Solving: ${domain_condition}$",
                f"Domain: $[{latex(ans_left)}, {latex(ans_right)}]$"
            ),
        )
    
    else:  # problem_type == 5
        # Evaluate composition like arccos(cos(θ)) with θ possibly outside [0, π]
        angle_vals = [-pi/3, -pi/4, -pi/6, pi/6, pi/4, pi/3, 5*pi/6, 7*pi/6]
        theta = choice(angle_vals)
        
        if 0 <= theta <= pi:
            ans = theta
            explanation = f"Since ${latex(theta)}$ is in $[0, \\pi]$, we have $\\arccos(\\cos({latex(theta)})) = {latex(theta)}$"
        elif theta < 0:
            ans = -theta
            explanation = f"Since ${latex(theta)} < 0$, the equivalent angle in $[0, \\pi]$ is ${latex(-theta)}$"
        else:
            ans = 2*pi - theta
            explanation = f"Since ${latex(theta)} > \\pi$, the equivalent angle in $[0, \\pi]$ is ${latex(2*pi - theta)}$"
        
        return problem(
            question=f"Simplify $\\arccos\\left(\\cos\\left({latex(theta)}\\right)\\right)$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"First evaluate $\\cos\\left({latex(theta)}\\right) = {latex(cos(theta))}$",
                explanation,
                f"Answer: ${latex(ans)}$"
            ),
        )

emit(generate())