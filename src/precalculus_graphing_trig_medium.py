"""
precalculus - graphing_trig (medium)
Generated: 2026-02-22T04:43:40.168982
"""

from problem_utils import *
from svg_utils import Graph

def generate():
    problem_type = choice(['amplitude_period', 'phase_shift', 'vertical_shift', 'combined_transform', 'identify_features'])
    
    if problem_type == 'amplitude_period':
        # Graph y = A*sin(Bx) or y = A*cos(Bx), find amplitude and period
        func = choice([sin, cos])
        func_name = 'sin' if func == sin else 'cos'
        A = choice([2, 3, 4, Rational(1,2), Rational(3,2)])
        B = choice([2, 3, 4, Rational(1,2), Rational(1,3)])
        
        expr = A * func(B * x)
        amplitude = abs(A)
        period = 2*pi / B
        
        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-5, 5), width=400, height=300)
        g.plot(expr)
        
        return problem(
            question=f"Find the amplitude and period of $y = {latex(expr)}$. Enter your answer as a tuple (amplitude, period).",
            answer=fmt_tuple(amplitude, period),
            difficulty=(1300, 1400),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = {latex(expr)}$:",
                f"Amplitude = $|{latex(A)}| = {latex(amplitude)}$",
                f"Period = $\\frac{{2\\pi}}{{{latex(B)}}} = {latex(period)}$",
                f"Answer: $({latex(amplitude)}, {latex(period)})$"
            ),
            image=g.render()
        )
    
    elif problem_type == 'phase_shift':
        # Graph y = sin(x - C) or y = cos(x - C), find phase shift
        func = choice([sin, cos])
        func_name = 'sin' if func == sin else 'cos'
        C = choice([pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, -pi/4, -pi/3])
        
        expr = func(x - C)
        phase_shift = C
        
        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-2, 2), width=400, height=300)
        g.plot(expr)
        
        return problem(
            question=f"Find the phase shift of $y = {latex(expr)}$.",
            answer=phase_shift,
            difficulty=(1300, 1400),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = {latex(func(x - C))}$, the phase shift is the value of $C$ in $y = f(x - C)$",
                f"Here $x - ({latex(C)})$, so phase shift = ${latex(C)}$",
                f"Positive means shift right, negative means shift left"
            ),
            image=g.render()
        )
    
    elif problem_type == 'vertical_shift':
        # Graph y = sin(x) + D or y = cos(x) + D
        func = choice([sin, cos])
        func_name = 'sin' if func == sin else 'cos'
        A = choice([1, 2, 3])
        D = choice([1, 2, 3, -1, -2])
        
        expr = A * func(x) + D
        
        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-5, 7), width=400, height=300)
        g.plot(expr)
        g.hline(D, dashed=True)
        
        return problem(
            question=f"Find the midline (vertical shift) of $y = {latex(expr)}$.",
            answer=D,
            difficulty=(1300, 1400),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = {latex(expr)}$, the vertical shift is ${latex(D)}$",
                f"The midline is $y = {latex(D)}$",
                f"The graph oscillates around this horizontal line"
            ),
            image=g.render()
        )
    
    elif problem_type == 'combined_transform':
        # y = A*sin(B(x - C)) + D, find all parameters
        func = choice([sin, cos])
        func_name = 'sin' if func == sin else 'cos'
        A = choice([2, 3, Rational(1,2)])
        B = choice([2, Rational(1,2)])
        C = choice([pi/4, pi/2, -pi/4])
        D = choice([1, -1, 2])
        
        expr = A * func(B * (x - C)) + D
        amplitude = abs(A)
        period = 2*pi / B
        
        g = Graph(x_range=(-2*pi, 3*pi), y_range=(-5, 7), width=400, height=300)
        g.plot(expr)
        g.hline(D, dashed=True)
        
        return problem(
            question=f"For $y = {latex(expr)}$, find the amplitude.",
            answer=amplitude,
            difficulty=(1400, 1500),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The function is in the form $y = A{func_name}(B(x - C)) + D$",
                f"Amplitude = $|A| = |{latex(A)}| = {latex(amplitude)}$"
            ),
            image=g.render()
        )
    
    else:  # identify_features
        # Given specific transformed function, find period
        func = choice([sin, cos])
        func_name = 'sin' if func == sin else 'cos'
        A = choice([2, 3])
        B = choice([2, 3, 4, Rational(1,2)])
        C = choice([0, pi/4, pi/2])
        D = choice([0, 1, -1])
        
        expr = A * func(B * (x - C)) + D
        period = 2*pi / B
        
        g = Graph(x_range=(-pi, 3*pi), y_range=(-5, 7), width=400, height=300)
        g.plot(expr)
        
        return problem(
            question=f"Find the period of $y = {latex(expr)}$.",
            answer=period,
            difficulty=(1400, 1500),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = {latex(expr)}$, identify $B$ from the form $y = A{func_name}(Bx + C) + D$",
                f"Here $B = {latex(B)}$",
                f"Period = $\\frac{{2\\pi}}{{B}} = \\frac{{2\\pi}}{{{latex(B)}}} = {latex(period)}$"
            ),
            image=g.render(),
            calculator="scientific"
        )

emit(generate())