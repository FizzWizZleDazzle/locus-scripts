"""
precalculus - polar_coordinates (hard)
Generated: 2026-02-22T04:52:53.885414
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'convert_to_rectangular',
        'convert_to_polar',
        'polar_equation_graph',
        'intersection_polar_curves',
        'area_polar_region',
        'distance_between_polar_points'
    ])
    
    if problem_type == 'convert_to_rectangular':
        # Convert polar equation to rectangular form
        polar_type = choice(['circle', 'line', 'cardioid', 'rose'])
        
        if polar_type == 'circle':
            a = nonzero(-5, 5)
            # r = 2a cos(theta) or r = 2a sin(theta)
            if choice([True, False]):
                # r = 2a cos(theta) => (x-a)^2 + y^2 = a^2
                polar_eq = f"r = {latex(2*a)}\\cos\\theta"
                rect_ans = Eq((x - a)**2 + y**2, a**2)
                sol_steps = steps(
                    f"Given: ${polar_eq}$",
                    f"Multiply both sides by $r$: $r^2 = {latex(2*a)}r\\cos\\theta$",
                    f"Substitute $r^2 = x^2 + y^2$ and $r\\cos\\theta = x$: $x^2 + y^2 = {latex(2*a)}x$",
                    f"Rearrange: $x^2 - {latex(2*a)}x + y^2 = 0$",
                    f"Complete the square: $(x - {a})^2 + y^2 = {a**2}$"
                )
            else:
                # r = 2a sin(theta) => x^2 + (y-a)^2 = a^2
                polar_eq = f"r = {latex(2*a)}\\sin\\theta"
                rect_ans = Eq(x**2 + (y - a)**2, a**2)
                sol_steps = steps(
                    f"Given: ${polar_eq}$",
                    f"Multiply both sides by $r$: $r^2 = {latex(2*a)}r\\sin\\theta$",
                    f"Substitute $r^2 = x^2 + y^2$ and $r\\sin\\theta = y$: $x^2 + y^2 = {latex(2*a)}y$",
                    f"Rearrange: $x^2 + y^2 - {latex(2*a)}y = 0$",
                    f"Complete the square: $x^2 + (y - {a})^2 = {a**2}$"
                )
            
            return problem(
                question=f"Convert the polar equation ${polar_eq}$ to rectangular form.",
                answer=rect_ans,
                difficulty=(1600, 1750),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="equation"
            )
        
        elif polar_type == 'line':
            a = nonzero(-6, 6)
            # r cos(theta - alpha) = a for various alpha
            angle_choice = choice([0, pi/4, pi/3, pi/6])
            if angle_choice == 0:
                # r cos(theta) = a => x = a
                polar_eq = f"r\\cos\\theta = {a}"
                rect_ans = Eq(x, a)
                sol_steps = steps(
                    f"Given: ${polar_eq}$",
                    f"Substitute $r\\cos\\theta = x$",
                    f"$x = {a}$"
                )
            elif angle_choice == pi/4:
                # r cos(theta - pi/4) = a
                polar_eq = f"r\\cos\\left(\\theta - \\frac{{\\pi}}{{4}}\\right) = {a}"
                # x + y = a*sqrt(2)
                rect_ans = Eq(x + y, a*sqrt(2))
                sol_steps = steps(
                    f"Given: ${polar_eq}$",
                    f"Expand: $r\\left(\\cos\\theta\\cos\\frac{{\\pi}}{{4}} + \\sin\\theta\\sin\\frac{{\\pi}}{{4}}\\right) = {a}$",
                    f"$r\\left(\\frac{{\\sqrt{{2}}}}{{2}}\\cos\\theta + \\frac{{\\sqrt{{2}}}}{{2}}\\sin\\theta\\right) = {a}$",
                    f"$\\frac{{\\sqrt{{2}}}}{{2}}(r\\cos\\theta + r\\sin\\theta) = {a}$",
                    f"Substitute $r\\cos\\theta = x$, $r\\sin\\theta = y$",
                    f"$x + y = {latex(a*sqrt(2))}$"
                )
            else:
                # Simplified case
                polar_eq = f"r\\cos\\theta = {a}"
                rect_ans = Eq(x, a)
                sol_steps = steps(
                    f"Given: ${polar_eq}$",
                    f"Substitute $r\\cos\\theta = x$",
                    f"$x = {a}$"
                )
            
            return problem(
                question=f"Convert the polar equation ${polar_eq}$ to rectangular form.",
                answer=rect_ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="equation"
            )
    
    elif problem_type == 'convert_to_polar':
        # Convert rectangular equation to polar
        rect_type = choice(['circle_origin', 'circle_shifted', 'line'])
        
        if rect_type == 'circle_origin':
            r = randint(2, 7)
            rect_eq = f"x^2 + y^2 = {r**2}"
            polar_ans = Eq(Symbol('r'), r)
            sol_steps = steps(
                f"Given: ${rect_eq}$",
                f"Substitute $x^2 + y^2 = r^2$",
                f"$r^2 = {r**2}$",
                f"$r = {r}$"
            )
            
            return problem(
                question=f"Convert the rectangular equation ${rect_eq}$ to polar form.",
                answer=polar_ans,
                difficulty=(1600, 1700),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="equation"
            )
        
        elif rect_type == 'circle_shifted':
            a = nonzero(-5, 5)
            # (x-a)^2 + y^2 = a^2 => r = 2a cos(theta)
            rect_eq = f"(x - {a})^2 + y^2 = {a**2}"
            polar_ans = Eq(Symbol('r'), 2*a*cos(Symbol('theta')))
            sol_steps = steps(
                f"Given: ${rect_eq}$",
                f"Expand: $x^2 - {latex(2*a)}x + {a**2} + y^2 = {a**2}$",
                f"Simplify: $x^2 + y^2 = {latex(2*a)}x$",
                f"Substitute $x^2 + y^2 = r^2$ and $x = r\\cos\\theta$",
                f"$r^2 = {latex(2*a)}r\\cos\\theta$",
                f"$r = {latex(2*a)}\\cos\\theta$"
            )
            
            return problem(
                question=f"Convert the rectangular equation ${rect_eq}$ to polar form.",
                answer=polar_ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="equation"
            )
        
        else:  # line
            m = nonzero(-3, 3)
            b_val = nonzero(-5, 5)
            rect_eq = f"y = {m}x + {b_val}"
            # y = mx + b => r sin(theta) = m r cos(theta) + b
            # r(sin(theta) - m cos(theta)) = b
            # r = b / (sin(theta) - m cos(theta))
            theta_sym = Symbol('theta')
            polar_ans = Eq(Symbol('r'), b_val / (sin(theta_sym) - m*cos(theta_sym)))
            sol_steps = steps(
                f"Given: ${rect_eq}$",
                f"Substitute $y = r\\sin\\theta$ and $x = r\\cos\\theta$",
                f"$r\\sin\\theta = {m}r\\cos\\theta + {b_val}$",
                f"$r\\sin\\theta - {m}r\\cos\\theta = {b_val}$",
                f"$r(\\sin\\theta - {m}\\cos\\theta) = {b_val}$",
                f"$r = \\frac{{{b_val}}}{{\\sin\\theta - {m}\\cos\\theta}}$"
            )
            
            return problem(
                question=f"Convert the rectangular equation ${rect_eq}$ to polar form.",
                answer=polar_ans,
                difficulty=(1750, 1900),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="equation"
            )
    
    elif problem_type == 'intersection_polar_curves':
        # Find intersection points of two polar curves
        a = randint(2, 5)
        b = randint(2, 5)
        
        # r = a and r = b cos(theta)
        # a = b cos(theta) => cos(theta) = a/b
        if a < b:
            theta_val = acos(Rational(a, b))
            polar_ans = FiniteSet(
                (a, theta_val),
                (a, -theta_val)
            )
            
            sol_steps = steps(
                f"Set $r = {a}$ equal to $r = {b}\\cos\\theta$",
                f"${a} = {b}\\cos\\theta$",
                f"$\\cos\\theta = {latex(Rational(a, b))}$",
                f"$\\theta = \\pm\\cos^{{-1}}\\left({latex(Rational(a, b))}\\right)$",
                f"$\\theta = \\pm{latex(theta_val)}$",
                f"Intersection points: $(r, \\theta) = ({a}, {latex(theta_val)})$ and $({a}, {latex(-theta_val)})$"
            )
            
            return problem(
                question=f"Find all intersection points of the polar curves $r = {a}$ and $r = {b}\\cos\\theta$ in the form $(r, \\theta)$ where $-\\pi < \\theta \\leq \\pi$. Give your answer as a set.",
                answer=polar_ans,
                difficulty=(1650, 1800),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="set",
                calculator="scientific"
            )
        else:
            # Different intersection: r = a sin(theta) and r = a cos(theta)
            theta_val = pi/4
            r_val = a*sqrt(2)/2
            polar_ans = FiniteSet((r_val, theta_val))
            
            sol_steps = steps(
                f"Set $r = {a}\\sin\\theta$ equal to $r = {a}\\cos\\theta$",
                f"${a}\\sin\\theta = {a}\\cos\\theta$",
                f"$\\sin\\theta = \\cos\\theta$",
                f"$\\tan\\theta = 1$",
                f"$\\theta = \\frac{{\\pi}}{{4}}$",
                f"$r = {a}\\sin\\left(\\frac{{\\pi}}{{4}}\\right) = {latex(r_val)}$",
                f"Intersection point: $(r, \\theta) = ({latex(r_val)}, {latex(theta_val)})$",
                f"Note: The pole $(0, 0)$ is also an intersection but in polar form this depends on the domain considered."
            )
            
            return problem(
                question=f"Find the non-zero intersection point(s) of the polar curves $r = {a}\\sin\\theta$ and $r = {a}\\cos\\theta$ in the form $(r, \\theta)$ where $0 \\leq \\theta < 2\\pi$ and $r > 0$. Give your answer as a set.",
                answer=polar_ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_coordinates",
                solution=sol_steps,
                answer_type="set"
            )
    
    elif problem_type == 'area_polar_region':
        # Area enclosed by polar curve
        a = randint(2, 6)
        curve_type = choice(['circle', 'cardioid'])
        
        if curve_type == 'circle':
            # r = a, area = pi*a^2
            area_ans = pi * a**2
            sol_steps = steps(
                f"Area formula: $A = \\frac{{1}}{{2}}\\int_{{\\alpha}}^{{\\beta}} r^2 \\, d\\theta$",
                f"For $r = {a}$, integrate from $\\theta = 0$ to $\\theta = 2\\pi$",
                f"$A = \\frac{{1}}{{2}}\\int_{{0}}^{{2\\pi}} {a**2} \\, d\\theta$",
                f"$A = \\frac{{{a**2}}}{{2}} \\cdot 2\\pi = {latex(area_ans)}$"
            )
            
            return problem(
                question=f"Find the area enclosed by the polar curve $r = {a}$.",
                answer=area_ans,
                difficulty=(1600, 1700),
                topic="precalculus/polar_coordinates",
                solution=sol_steps
            )
        
        else:  # cardioid
            # r = a(1 + cos(theta)), area = (3/2)*pi*a^2
            area_ans = Rational(3, 2) * pi * a**2
            sol_steps = steps(
                f"Area formula: $A = \\frac{{1}}{{2}}\\int_{{0}}^{{2\\pi}} r^2 \\, d\\theta$",
                f"For $r = {a}(1 + \\cos\\theta)$, we have $r^2 = {a**2}(1 + \\cos\\theta)^2$",
                f"$A = \\frac{{{a**2}}}{{2}}\\int_{{0}}^{{2\\pi}} (1 + 2\\cos\\theta + \\cos^2\\theta) \\, d\\theta$",
                f"Using $\\cos^2\\theta = \\frac{{1 + \\cos(2\\theta)}}{{2}}$",
                f"$A = \\frac{{{a**2}}}{{2}}\\int_{{0}}^{{2\\pi}} \\left(\\frac{{3}}{{2}} + 2\\cos\\theta + \\frac{{\\cos(2\\theta)}}{{2}}\\right) d\\theta$",
                f"$A = \\frac{{{a**2}}}{{2}} \\cdot 3\\pi = {latex(area_ans)}$"
            )
            
            return problem(
                question=f"Find the area enclosed by the cardioid $r = {a}(1 + \\cos\\theta)$.",
                answer=area