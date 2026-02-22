"""
precalculus - graphing_trig (easy)
Generated: 2026-02-22T04:43:16.667736
"""

from problem_utils import *
from svg_utils import Graph

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find amplitude of basic trig function
        amp = randint(2, 5)
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        
        return problem(
            question=f"What is the amplitude of $y = {amp}\\{func_name}(x)$?",
            answer=amp,
            difficulty=(1000, 1100),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The amplitude of $y = A\\{func_name}(x)$ is $|A|$",
                f"Here $A = {amp}$, so amplitude = ${amp}$"
            )
        )
    
    elif problem_type == 2:
        # Find period of basic trig function with coefficient
        b = randint(2, 4)
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        period = 2 * pi / b
        
        return problem(
            question=f"What is the period of $y = \\{func_name}({b}x)$?",
            answer=period,
            difficulty=(1100, 1200),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The period of $y = \\{func_name}(Bx)$ is $\\frac{{2\\pi}}{{|B|}}$",
                f"Here $B = {b}$",
                f"Period = $\\frac{{2\\pi}}{{{b}}} = {latex(period)}$"
            )
        )
    
    elif problem_type == 3:
        # Identify phase shift (horizontal shift)
        h = nonzero(-4, 4)
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        
        if h > 0:
            shift_dir = "right"
            sign_str = "-"
        else:
            shift_dir = "left"
            sign_str = "+"
            h = -h
        
        return problem(
            question=f"What is the phase shift of $y = \\{func_name}(x {sign_str} {h})$?",
            answer=-h if shift_dir == "right" else h,
            difficulty=(1100, 1200),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = \\{func_name}(x - h)$, the phase shift is $h$ units to the right",
                f"For $y = \\{func_name}(x + h)$, the phase shift is $h$ units to the left",
                f"The phase shift is ${h}$ units to the {shift_dir}",
                f"Answer: ${-h if shift_dir == 'right' else h}$"
            )
        )
    
    elif problem_type == 4:
        # Find vertical shift (midline)
        k = nonzero(-5, 5)
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        
        sign = "+" if k > 0 else ""
        
        return problem(
            question=f"What is the vertical shift (midline) of $y = \\{func_name}(x) {sign} {k}$?",
            answer=k,
            difficulty=(1000, 1100),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = \\{func_name}(x) + k$, the vertical shift is $k$",
                f"The midline is $y = {k}$",
                f"Answer: ${k}$"
            )
        )
    
    else:
        # Maximum value of transformed trig function
        amp = randint(2, 4)
        k = randint(1, 4)
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        max_val = amp + k
        
        return problem(
            question=f"What is the maximum value of $y = {amp}\\{func_name}(x) + {k}$?",
            answer=max_val,
            difficulty=(1200, 1300),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The maximum value of $\\{func_name}(x)$ is $1$",
                f"So the maximum of ${amp}\\{func_name}(x)$ is ${amp} \\cdot 1 = {amp}$",
                f"Adding the vertical shift: ${amp} + {k} = {max_val}$"
            )
        )

emit(generate())