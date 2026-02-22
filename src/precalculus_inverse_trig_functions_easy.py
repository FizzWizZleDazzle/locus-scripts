"""
precalculus - inverse_trig_functions (easy)
Generated: 2026-02-22T04:48:08.827818
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Direct evaluation of arcsin, arccos, arctan at standard values
        func_choice = randint(1, 3)
        
        if func_choice == 1:
            # arcsin
            values = [
                (0, 0),
                (Rational(1, 2), pi/6),
                (sqrt(2)/2, pi/4),
                (sqrt(3)/2, pi/3),
                (1, pi/2),
                (-Rational(1, 2), -pi/6),
                (-sqrt(2)/2, -pi/4),
                (-sqrt(3)/2, -pi/3),
                (-1, -pi/2)
            ]
            val, ans = choice(values)
            
            return problem(
                question=f"Evaluate $\\arcsin\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"We need to find the angle $\\theta$ such that $\\sin(\\theta) = {latex(val)}$ where $\\theta \\in \\left[-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right]$",
                    f"$\\arcsin\\left({latex(val)}\\right) = {latex(ans)}$"
                ),
            )
        
        elif func_choice == 2:
            # arccos
            values = [
                (0, pi/2),
                (Rational(1, 2), pi/3),
                (sqrt(2)/2, pi/4),
                (sqrt(3)/2, pi/6),
                (1, 0),
                (-Rational(1, 2), 2*pi/3),
                (-sqrt(2)/2, 3*pi/4),
                (-sqrt(3)/2, 5*pi/6),
                (-1, pi)
            ]
            val, ans = choice(values)
            
            return problem(
                question=f"Evaluate $\\arccos\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"We need to find the angle $\\theta$ such that $\\cos(\\theta) = {latex(val)}$ where $\\theta \\in [0, \\pi]$",
                    f"$\\arccos\\left({latex(val)}\\right) = {latex(ans)}$"
                ),
            )
        
        else:
            # arctan
            values = [
                (0, 0),
                (1, pi/4),
                (sqrt(3), pi/3),
                (sqrt(3)/3, pi/6),
                (-1, -pi/4),
                (-sqrt(3), -pi/3),
                (-sqrt(3)/3, -pi/6)
            ]
            val, ans = choice(values)
            
            return problem(
                question=f"Evaluate $\\arctan\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"We need to find the angle $\\theta$ such that $\\tan(\\theta) = {latex(val)}$ where $\\theta \\in \\left(-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right)$",
                    f"$\\arctan\\left({latex(val)}\\right) = {latex(ans)}$"
                ),
            )
    
    elif problem_type == 2:
        # Composition: sin(arcsin(x)), cos(arccos(x)), tan(arctan(x))
        func_choice = randint(1, 3)
        val = choice([Rational(1, 3), Rational(2, 5), Rational(3, 7), Rational(4, 9)])
        
        if randint(0, 1):
            val = -val
        
        if func_choice == 1:
            return problem(
                question=f"Evaluate $\\sin\\left(\\arcsin\\left({latex(val)}\\right)\\right)$",
                answer=val,
                difficulty=(1100, 1250),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Since $\\arcsin$ and $\\sin$ are inverse functions,",
                    f"$\\sin\\left(\\arcsin\\left({latex(val)}\\right)\\right) = {latex(val)}$ for ${latex(val)} \\in [-1, 1]$"
                ),
            )
        elif func_choice == 2:
            val_pos = abs(val)
            return problem(
                question=f"Evaluate $\\cos\\left(\\arccos\\left({latex(val_pos)}\\right)\\right)$",
                answer=val_pos,
                difficulty=(1100, 1250),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Since $\\arccos$ and $\\cos$ are inverse functions,",
                    f"$\\cos\\left(\\arccos\\left({latex(val_pos)}\\right)\\right) = {latex(val_pos)}$ for ${latex(val_pos)} \\in [-1, 1]$"
                ),
            )
        else:
            return problem(
                question=f"Evaluate $\\tan\\left(\\arctan\\left({latex(val)}\\right)\\right)$",
                answer=val,
                difficulty=(1100, 1250),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Since $\\arctan$ and $\\tan$ are inverse functions,",
                    f"$\\tan\\left(\\arctan\\left({latex(val)}\\right)\\right) = {latex(val)}$ for all real ${latex(val)}$"
                ),
            )
    
    elif problem_type == 3:
        # Reverse composition: arcsin(sin(theta)), arccos(cos(theta)), arctan(tan(theta))
        # for angles in the principal range
        func_choice = randint(1, 3)
        
        if func_choice == 1:
            # arcsin(sin(theta)) where theta in [-pi/2, pi/2]
            angles = [0, pi/6, pi/4, pi/3, -pi/6, -pi/4, -pi/3]
            theta = choice(angles)
            
            return problem(
                question=f"Evaluate $\\arcsin\\left(\\sin\\left({latex(theta)}\\right)\\right)$",
                answer=theta,
                difficulty=(1200, 1300),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Since ${latex(theta)} \\in \\left[-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right]$, it is in the range of $\\arcsin$",
                    f"Therefore, $\\arcsin\\left(\\sin\\left({latex(theta)}\\right)\\right) = {latex(theta)}$"
                ),
            )
        
        elif func_choice == 2:
            # arccos(cos(theta)) where theta in [0, pi]
            angles = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6]
            theta = choice(angles)
            
            return problem(
                question=f"Evaluate $\\arccos\\left(\\cos\\left({latex(theta)}\\right)\\right)$",
                answer=theta,
                difficulty=(1200, 1300),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Since ${latex(theta)} \\in [0, \\pi]$, it is in the range of $\\arccos$",
                    f"Therefore, $\\arccos\\left(\\cos\\left({latex(theta)}\\right)\\right) = {latex(theta)}$"
                ),
            )
        
        else:
            # arctan(tan(theta)) where theta in (-pi/2, pi/2)
            angles = [0, pi/6, pi/4, pi/3, -pi/6, -pi/4, -pi/3]
            theta = choice(angles)
            
            return problem(
                question=f"Evaluate $\\arctan\\left(\\tan\\left({latex(theta)}\\right)\\right)$",
                answer=theta,
                difficulty=(1200, 1300),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Since ${latex(theta)} \\in \\left(-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right)$, it is in the range of $\\arctan$",
                    f"Therefore, $\\arctan\\left(\\tan\\left({latex(theta)}\\right)\\right) = {latex(theta)}$"
                ),
            )
    
    else:
        # Simple domain questions
        func_choice = randint(1, 3)
        
        if func_choice == 1:
            val = choice([Rational(3, 2), 2, Rational(5, 3), -Rational(3, 2), -2])
            
            return problem(
                question=f"Is ${latex(val)}$ in the domain of $\\arcsin(x)$?",
                answer=False,
                difficulty=(1000, 1150),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"The domain of $\\arcsin(x)$ is $[-1, 1]$",
                    f"Since $|{latex(val)}| > 1$, ${latex(val)}$ is not in the domain"
                ),
            )
        
        elif func_choice == 2:
            val = choice([Rational(1, 2), Rational(3, 4), Rational(4, 5), -Rational(1, 2)])
            
            return problem(
                question=f"Is ${latex(val)}$ in the domain of $\\arccos(x)$?",
                answer=True,
                difficulty=(1000, 1150),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"The domain of $\\arccos(x)$ is $[-1, 1]$",
                    f"Since ${latex(val)} \\in [-1, 1]$, it is in the domain"
                ),
            )
        
        else:
            val = nonzero(-5, 5)
            
            return problem(
                question=f"Is ${val}$ in the domain of $\\arctan(x)$?",
                answer=True,
                difficulty=(1000, 1150),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"The domain of $\\arctan(x)$ is all real numbers $(-\\infty, \\infty)$",
                    f"Therefore, ${val}$ is in the domain"
                ),
            )

emit(generate())