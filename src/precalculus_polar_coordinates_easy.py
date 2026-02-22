"""
precalculus - polar_coordinates (easy)
Generated: 2026-02-22T04:51:35.612492
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Convert from polar to rectangular coordinates (straightforward)
        r_val = randint(2, 8)
        theta_options = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi]
        theta_val = choice(theta_options)
        
        x_val = r_val * cos(theta_val)
        y_val = r_val * sin(theta_val)
        
        # Simplify the answer
        x_val = simplify(x_val)
        y_val = simplify(y_val)
        
        ans = fmt_tuple([x_val, y_val])
        
        return problem(
            question=f"Convert the polar coordinates $\\left({r_val}, {latex(theta_val)}\\right)$ to rectangular coordinates $(x, y)$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Use the conversion formulas: $x = r\\cos(\\theta)$ and $y = r\\sin(\\theta)$",
                f"$x = {r_val}\\cos\\left({latex(theta_val)}\\right) = {latex(x_val)}$",
                f"$y = {r_val}\\sin\\left({latex(theta_val)}\\right) = {latex(y_val)}$",
                f"Answer: $\\left({latex(x_val)}, {latex(y_val)}\\right)$"
            ),
            answer_type="tuple"
        )
    
    elif problem_type == 2:
        # Convert from rectangular to polar (r only, simple cases)
        coord_options = [(3, 0), (0, 4), (1, 1), (1, sqrt(3)), (sqrt(3), 1), (-2, 0), (0, -3)]
        x_val, y_val = choice(coord_options)
        
        r_val = sqrt(x_val**2 + y_val**2)
        r_val = simplify(r_val)
        
        return problem(
            question=f"Find the distance $r$ from the origin to the point $({latex(x_val)}, {latex(y_val)})$ in polar coordinates.",
            answer=r_val,
            difficulty=(1050, 1200),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Use the formula: $r = \\sqrt{{x^2 + y^2}}$",
                f"$r = \\sqrt{{({latex(x_val)})^2 + ({latex(y_val)})^2}}$",
                f"$r = \\sqrt{{{latex(x_val**2 + y_val**2)}}} = {latex(r_val)}$"
            )
        )
    
    elif problem_type == 3:
        # Simple polar equation plotting - identify shape
        equation_type = randint(1, 3)
        
        if equation_type == 1:
            # Circle: r = constant
            r_val = randint(2, 6)
            return problem(
                question=f"What shape is represented by the polar equation $r = {r_val}$?",
                answer="circle",
                difficulty=(1000, 1100),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"The equation $r = {r_val}$ means every point is at a constant distance ${r_val}$ from the origin",
                    f"This describes a circle with center at the origin and radius ${r_val}$"
                ),
                answer_type="expression"
            )
        
        elif equation_type == 2:
            # Line through origin: theta = constant
            theta_options = [pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4]
            theta_val = choice(theta_options)
            return problem(
                question=f"What shape is represented by the polar equation $\\theta = {latex(theta_val)}$?",
                answer="line",
                difficulty=(1050, 1150),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"The equation $\\theta = {latex(theta_val)}$ means the angle is constant",
                    f"This describes a line (ray) passing through the origin at angle ${latex(theta_val)}$ from the positive $x$-axis"
                ),
                answer_type="expression"
            )
        
        else:
            # Cardioid identification: r = a(1 + cos(theta))
            a_val = randint(1, 4)
            return problem(
                question=f"What is the name of the curve given by the polar equation $r = {a_val}(1 + \\cos(\\theta))$?",
                answer="cardioid",
                difficulty=(1200, 1300),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"The equation $r = {a_val}(1 + \\cos(\\theta))$ is in the form $r = a(1 + \\cos(\\theta))$",
                    f"This is the standard form of a cardioid, which is heart-shaped"
                ),
                answer_type="expression"
            )
    
    elif problem_type == 4:
        # Evaluate r for given theta in simple polar equation
        a_val = randint(2, 6)
        theta_options = [0, pi/4, pi/2, 3*pi/4, pi]
        theta_val = choice(theta_options)
        
        # r = a*cos(theta)
        r_result = a_val * cos(theta_val)
        r_result = simplify(r_result)
        
        return problem(
            question=f"If $r = {a_val}\\cos(\\theta)$, find the value of $r$ when $\\theta = {latex(theta_val)}$.",
            answer=r_result,
            difficulty=(1000, 1150),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Substitute $\\theta = {latex(theta_val)}$ into $r = {a_val}\\cos(\\theta)$",
                f"$r = {a_val}\\cos\\left({latex(theta_val)}\\right)$",
                f"$r = {latex(r_result)}$"
            )
        )
    
    else:
        # Given x and y, find r^2 (avoids complex theta calculation)
        x_val = randint(1, 5)
        y_val = randint(1, 5)
        
        r_squared = x_val**2 + y_val**2
        
        return problem(
            question=f"For the point $({x_val}, {y_val})$ in rectangular coordinates, find $r^2$ where $r$ is the distance from the origin.",
            answer=r_squared,
            difficulty=(1000, 1100),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Use the relationship: $r^2 = x^2 + y^2$",
                f"$r^2 = {x_val}^2 + {y_val}^2$",
                f"$r^2 = {x_val**2} + {y_val**2} = {r_squared}$"
            )
        )

emit(generate())