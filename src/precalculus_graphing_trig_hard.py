"""
precalculus - graphing_trig (hard)
Generated: 2026-02-22T04:44:23.909888
"""

from problem_utils import *
from svg_utils import Graph

def generate():
    problem_type = choice([
        'amplitude_phase_shift',
        'vertical_shift_reflection',
        'period_change',
        'combined_transformations',
        'inverse_trig_graph',
        'parametric_elimination'
    ])
    
    if problem_type == 'amplitude_phase_shift':
        # Graph with amplitude and phase shift
        func_choice = choice(['sin', 'cos'])
        A = choice([2, 3, 4, Rational(1,2), Rational(3,2)])
        phase = choice([pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4])
        phase_sign = choice([-1, 1])
        phase = phase_sign * phase
        
        if func_choice == 'sin':
            expr = A * sin(x - phase)
            base_func = "\\sin"
        else:
            expr = A * cos(x - phase)
            base_func = "\\cos"
        
        # Find a specific point on the graph
        if func_choice == 'sin':
            # sin(x - phase) = 0 when x = phase
            x_val = phase
            y_val = 0
        else:
            # cos(x - phase) = 1 when x = phase
            x_val = phase
            y_val = A
        
        g = Graph(x_range=(-pi, 3*pi), y_range=(-5, 5), width=400, height=300)
        g.plot(expr)
        g.point(float(x_val), float(y_val), f"({latex(x_val)}, {latex(y_val)})")
        
        question = f"The graph shows $y = {latex(expr)}$. What is the phase shift (horizontal shift) of this function compared to $y = {base_func}(x)$? Express as a multiple of $\\pi$ (positive for right, negative for left)."
        
        ans = phase
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The function is $y = {latex(A)}{base_func}(x - ({latex(phase)}))$",
                f"The phase shift is the value that makes the argument zero",
                f"Phase shift = ${latex(phase)}$",
                "Positive means shift right, negative means shift left"
            ),
            image=g.render()
        )
    
    elif problem_type == 'vertical_shift_reflection':
        # Trig function with vertical shift and possible reflection
        func_choice = choice(['sin', 'cos', 'tan'])
        reflect = choice([True, False])
        A = choice([2, 3, 4]) if not reflect else choice([-2, -3, -4])
        D = nonzero(-3, 3)
        
        if func_choice == 'sin':
            expr = A * sin(x) + D
            base_name = "sine"
        elif func_choice == 'cos':
            expr = A * cos(x) + D
            base_name = "cosine"
        else:
            expr = A * tan(x) + D
            base_name = "tangent"
        
        if func_choice != 'tan':
            max_val = abs(A) + D
            min_val = -abs(A) + D
            midline = D
            
            g = Graph(x_range=(-2*pi, 2*pi), y_range=(min_val-2, max_val+2), width=400, height=300)
            g.plot(expr)
            g.hline(float(midline), dashed=True)
            
            question = f"The graph shows a transformed {base_name} function. What is the equation of the midline (horizontal line halfway between max and min)?"
            ans = Eq(y, midline)
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1650, 1750),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Maximum value: ${max_val}$",
                    f"Minimum value: ${min_val}$",
                    f"Midline: $y = \\frac{{{max_val} + {min_val}}}{2} = {midline}$"
                ),
                image=g.render()
            )
        else:
            g = Graph(x_range=(-pi, pi), y_range=(-10, 10), width=400, height=300)
            g.plot(expr)
            g.hline(float(D), dashed=True)
            
            question = f"The graph shows a transformed tangent function with vertical shift. What is the $y$-value of the horizontal asymptote's midline?"
            ans = D
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1600, 1700),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"The function is vertically shifted by ${D}$ units",
                    f"The center line is at $y = {D}$"
                ),
                image=g.render()
            )
    
    elif problem_type == 'period_change':
        # Period change problems
        func_choice = choice(['sin', 'cos'])
        B = choice([2, 3, 4, Rational(1,2), Rational(1,3), Rational(2,3)])
        
        if func_choice == 'sin':
            expr = sin(B * x)
            base_func = "\\sin"
            period_formula = "2\\pi"
        else:
            expr = cos(B * x)
            base_func = "\\cos"
            period_formula = "2\\pi"
        
        period = 2*pi / B
        
        g = Graph(x_range=(0, float(2*period)), y_range=(-2, 2), width=400, height=300)
        g.plot(expr)
        
        question = f"The graph shows $y = {base_func}({latex(B)}x)$. What is the period of this function?"
        ans = period
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = {base_func}(Bx)$, the period is $\\frac{{{period_formula}}}{{|B|}}$",
                f"Here $B = {latex(B)}$",
                f"Period = $\\frac{{{period_formula}}}{{{latex(B)}}} = {latex(period)}$"
            ),
            image=g.render()
        )
    
    elif problem_type == 'combined_transformations':
        # Complex transformation
        A = choice([2, 3, Rational(1,2)])
        B = choice([2, 3, Rational(1,2)])
        C = choice([pi/4, pi/3, pi/2])
        D = nonzero(-2, 2)
        
        func_choice = choice(['sin', 'cos'])
        if func_choice == 'sin':
            expr = A * sin(B*x - C) + D
        else:
            expr = A * cos(B*x - C) + D
        
        # Ask for amplitude
        amplitude = abs(A)
        
        question = f"Given the function $f(x) = {latex(expr)}$, what is its amplitude?"
        ans = amplitude
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The amplitude is the absolute value of the coefficient of the trig function",
                f"From $f(x) = {latex(expr)}$",
                f"Amplitude = $|{latex(A)}| = {latex(amplitude)}$"
            )
        )
    
    elif problem_type == 'inverse_trig_graph':
        # Inverse trig function domain/range
        func_choice = choice(['arcsin', 'arccos', 'arctan'])
        
        if func_choice == 'arcsin':
            g = Graph(x_range=(-2, 2), y_range=(-2, 2), width=400, height=300)
            g.plot(asin(x))
            g.hline(float(pi/2), dashed=True)
            g.hline(float(-pi/2), dashed=True)
            
            question = "The graph shows $y = \\arcsin(x)$. What is the range of this function? Express your answer as an interval in the form [a,b] using multiples of $\\pi$."
            ans = fmt_interval(-pi/2, pi/2, False, False)
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1700, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The arcsine function has range restricted to $[-\\frac{\\pi}{2}, \\frac{\\pi}{2}]$",
                    "This is the principal branch of the inverse sine function"
                ),
                image=g.render()
            )
        
        elif func_choice == 'arccos':
            g = Graph(x_range=(-2, 2), y_range=(-1, 4), width=400, height=300)
            g.plot(acos(x))
            g.hline(float(pi), dashed=True)
            g.hline(0, dashed=True)
            
            question = "The graph shows $y = \\arccos(x)$. What is the range of this function?"
            ans = fmt_interval(0, pi, False, False)
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1700, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The arccosine function has range $[0, \\pi]$",
                    "This is the principal branch of the inverse cosine function"
                ),
                image=g.render()
            )
        
        else:  # arctan
            g = Graph(x_range=(-5, 5), y_range=(-2, 2), width=400, height=300)
            g.plot(atan(x))
            g.hline(float(pi/2), dashed=True)
            g.hline(float(-pi/2), dashed=True)
            
            question = "The graph shows $y = \\arctan(x)$. What are the equations of the two horizontal asymptotes? Enter the upper asymptote value."
            ans = pi/2
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1750, 1850),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The arctangent function has horizontal asymptotes at $y = \\pm\\frac{\\pi}{2}$",
                    "As $x \\to \\infty$, $\\arctan(x) \\to \\frac{\\pi}{2}$",
                    "As $x \\to -\\infty$, $\\arctan(x) \\to -\\frac{\\pi}{2}$",
                    f"Upper asymptote: $y = \\frac{{\\pi}}{{2}}$"
                ),
                image=g.render()
            )
    
    else:  # parametric_elimination
        # Parametric equations that form a trig curve
        A = choice([2, 3, 4])
        B = choice([2, 3, 4])
        
        # x = A*cos(t), y = B*sin(t) gives ellipse
        question = f"A curve is defined parametrically by $x = {A}\\cos(t)$ and $y = {B}\\sin(t)$ for $0 \\le t \\le 2\\pi$. Eliminate the parameter to find a Cartesian equation relating $x$ and $y$."
        
        # (x/A)^2 + (y/B)^2 = 1
        ans = Eq((x/A)**2 + (y/B)**2, 1)
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1800, 1900),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"From $x = {A}\\cos(t)$, we get $\\cos(t) = \\frac{{x}}{{{A}}}$",
                f"From $y = {B}\\sin(t)$, we get $\\sin(t) = \\frac{{y}}{{{B}}}$",
                f"Using $\\cos^2(t) + \\sin^2(t) = 1$:",
                f"$\\left(\\frac{{x}}{{{A}}}\\right)^2 + \\left(\\frac{{y}}{{{B}}}\\right)^2 = 1$",
                f"${latex(ans)}$"
            )
        )

emit(generate())