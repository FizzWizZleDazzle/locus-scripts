"""
precalculus - polar_curves (easy)
Generated: 2026-02-22T04:53:21.214847
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Convert simple polar point to Cartesian (1000-1200)
        r_val = randint(2, 8)
        theta_options = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi]
        theta_val = choice(theta_options)
        
        x_coord = r_val * cos(theta_val)
        y_coord = r_val * sin(theta_val)
        
        x_simplified = simplify(x_coord)
        y_simplified = simplify(y_coord)
        
        ans = (x_simplified, y_simplified)
        
        return problem(
            question=f"Convert the polar point $\\left({r_val}, {latex(theta_val)}\\right)$ to Cartesian coordinates $(x, y)$.",
            answer=ans,
            difficulty=(1000, 1200),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Use the formulas $x = r\\cos(\\theta)$ and $y = r\\sin(\\theta)$",
                f"$x = {r_val}\\cos\\left({latex(theta_val)}\\right) = {latex(x_simplified)}$",
                f"$y = {r_val}\\sin\\left({latex(theta_val)}\\right) = {latex(y_simplified)}$",
                f"Answer: $\\left({latex(x_simplified)}, {latex(y_simplified)}\\right)$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Find r given theta for simple polar curve (1100-1200)
        a_val = randint(2, 6)
        curve_type = choice(['constant', 'cosine', 'sine'])
        
        if curve_type == 'constant':
            # r = a
            theta_val = choice([pi/4, pi/3, pi/2, 2*pi/3])
            ans = a_val
            
            return problem(
                question=f"For the polar curve $r = {a_val}$, find the value of $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1000, 1100),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"The curve $r = {a_val}$ is a circle of radius ${a_val}$ centered at the origin",
                    f"The value of $r$ is constant for all values of $\\theta$",
                    f"$r = {a_val}$"
                )
            )
        elif curve_type == 'cosine':
            # r = a*cos(theta)
            theta_val = choice([0, pi/3, pi/2])
            ans = simplify(a_val * cos(theta_val))
            
            return problem(
                question=f"For the polar curve $r = {a_val}\\cos(\\theta)$, find the value of $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1100, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Substitute $\\theta = {latex(theta_val)}$ into $r = {a_val}\\cos(\\theta)$",
                    f"$r = {a_val}\\cos\\left({latex(theta_val)}\\right) = {a_val} \\cdot {latex(cos(theta_val))} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        else:
            # r = a*sin(theta)
            theta_val = choice([pi/6, pi/4, pi/2])
            ans = simplify(a_val * sin(theta_val))
            
            return problem(
                question=f"For the polar curve $r = {a_val}\\sin(\\theta)$, find the value of $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1100, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Substitute $\\theta = {latex(theta_val)}$ into $r = {a_val}\\sin(\\theta)$",
                    f"$r = {a_val}\\sin\\left({latex(theta_val)}\\right) = {a_val} \\cdot {latex(sin(theta_val))} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 3:
        # Convert Cartesian to polar (r only, simple cases) (1100-1300)
        x_val = choice([3, 4, 5, 0])
        y_val = choice([3, 4, 5, 0])
        
        if x_val == 0 and y_val == 0:
            y_val = 4
        
        r_squared = x_val**2 + y_val**2
        ans = sqrt(r_squared)
        
        return problem(
            question=f"Find the value of $r$ for the point $({x_val}, {y_val})$ in polar coordinates.",
            answer=ans,
            difficulty=(1100, 1300),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Use the formula $r = \\sqrt{{x^2 + y^2}}$",
                f"$r = \\sqrt{{{x_val}^2 + {y_val}^2}} = \\sqrt{{{r_squared}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Identify polar curve type (1200-1300)
        curve_choice = choice(['circle', 'line_radial', 'rose'])
        
        if curve_choice == 'circle':
            a_val = randint(2, 7)
            ans = "circle"
            
            return problem(
                question=f"What type of curve does the polar equation $r = {a_val}$ represent?",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"The equation $r = {a_val}$ means the distance from the origin is constant",
                    f"This describes a circle of radius ${a_val}$ centered at the origin",
                    f"Answer: circle"
                )
            )
        elif curve_choice == 'line_radial':
            theta_val = choice([pi/6, pi/4, pi/3, pi/2])
            ans = "line"
            
            return problem(
                question=f"What type of curve does the polar equation $\\theta = {latex(theta_val)}$ represent?",
                answer=ans,
                difficulty=(1100, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"The equation $\\theta = {latex(theta_val)}$ means the angle is constant",
                    f"This describes a ray (line) from the origin at angle ${latex(theta_val)}$",
                    f"Answer: line"
                )
            )
    
    else:
        # Find when r = 0 for simple polar curve (1200-1300)
        a_val = randint(2, 5)
        trig_choice = choice(['cos', 'sin'])
        
        if trig_choice == 'cos':
            ans = pi/2
            
            return problem(
                question=f"For the polar curve $r = {a_val}\\cos(\\theta)$, find the smallest positive value of $\\theta$ where $r = 0$.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set $r = 0$: ${a_val}\\cos(\\theta) = 0$",
                    f"$\\cos(\\theta) = 0$",
                    f"The smallest positive solution is $\\theta = \\frac{{\\pi}}{{2}}$"
                ),
                calculator="scientific"
            )
        else:
            ans = pi
            
            return problem(
                question=f"For the polar curve $r = {a_val}\\sin(\\theta)$, find the smallest positive value of $\\theta$ where $r = 0$.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set $r = 0$: ${a_val}\\sin(\\theta) = 0$",
                    f"$\\sin(\\theta) = 0$",
                    f"The smallest positive solution is $\\theta = \\pi$"
                ),
                calculator="scientific"
            )

emit(generate())