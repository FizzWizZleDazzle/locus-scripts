"""
precalculus - polar_coordinates (medium)
Generated: 2026-02-22T04:52:06.160815
"""

from problem_utils import *

def generate():
    problem_type = choice([
        "rect_to_polar",
        "polar_to_rect", 
        "polar_distance",
        "polar_equation_convert",
        "polar_symmetry"
    ])
    
    if problem_type == "rect_to_polar":
        # Convert rectangular coordinates to polar
        # Pick nice angles for clean answers
        angles = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi, 
                  7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2, 5*pi/3, 7*pi/4, 11*pi/6]
        theta = choice(angles)
        r_val = randint(2, 6)
        
        x_val = r_val * cos(theta)
        y_val = r_val * sin(theta)
        
        # Simplify to get exact values
        x_val = simplify(x_val)
        y_val = simplify(y_val)
        
        ans = fmt_tuple([r_val, theta])
        
        return problem(
            question=f"Convert the rectangular coordinates $\\left({latex(x_val)}, {latex(y_val)}\\right)$ to polar coordinates $(r, \\theta)$ where $r > 0$ and $0 \\leq \\theta < 2\\pi$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="precalculus/polar_coordinates",
            answer_type="tuple",
            solution=steps(
                f"$r = \\sqrt{{x^2 + y^2}} = \\sqrt{{({latex(x_val)})^2 + ({latex(y_val)})^2}} = \\sqrt{{{latex(simplify(x_val**2 + y_val**2))}}} = {r_val}$",
                f"$\\theta = \\arctan\\left(\\frac{{y}}{{x}}\\right) = \\arctan\\left(\\frac{{{latex(y_val)}}}{{{latex(x_val)}}}\\right) = {latex(theta)}$",
                f"Therefore, $(r, \\theta) = ({r_val}, {latex(theta)})$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == "polar_to_rect":
        # Convert polar coordinates to rectangular
        angles = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi]
        theta = choice(angles)
        r_val = randint(2, 8)
        
        x_val = simplify(r_val * cos(theta))
        y_val = simplify(r_val * sin(theta))
        
        ans = fmt_tuple([x_val, y_val])
        
        return problem(
            question=f"Convert the polar coordinates $\\left({r_val}, {latex(theta)}\\right)$ to rectangular coordinates $(x, y)$.",
            answer=ans,
            difficulty=(1200, 1400),
            topic="precalculus/polar_coordinates",
            answer_type="tuple",
            solution=steps(
                f"$x = r\\cos(\\theta) = {r_val}\\cos\\left({latex(theta)}\\right) = {latex(x_val)}$",
                f"$y = r\\sin(\\theta) = {r_val}\\sin\\left({latex(theta)}\\right) = {latex(y_val)}$",
                f"Therefore, $(x, y) = ({latex(x_val)}, {latex(y_val)})$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == "polar_distance":
        # Distance between two points in polar coordinates
        r1 = randint(2, 6)
        r2 = randint(2, 6)
        angles = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4]
        theta1 = choice(angles)
        theta2 = choice([a for a in angles if a != theta1])
        
        # Distance formula: d = sqrt(r1^2 + r2^2 - 2*r1*r2*cos(theta2 - theta1))
        distance_squared = r1**2 + r2**2 - 2*r1*r2*cos(theta2 - theta1)
        distance = simplify(sqrt(distance_squared))
        
        return problem(
            question=f"Find the distance between the points with polar coordinates $({r1}, {latex(theta1)})$ and $({r2}, {latex(theta2)})$.",
            answer=distance,
            difficulty=(1400, 1600),
            topic="precalculus/polar_coordinates",
            solution=steps(
                f"Use the distance formula: $d = \\sqrt{{r_1^2 + r_2^2 - 2r_1r_2\\cos(\\theta_2 - \\theta_1)}}$",
                f"$d = \\sqrt{{{r1}^2 + {r2}^2 - 2({r1})({r2})\\cos\\left({latex(theta2)} - {latex(theta1)}\\right)}}$",
                f"$d = \\sqrt{{{r1**2} + {r2**2} - {2*r1*r2}\\cos\\left({latex(simplify(theta2 - theta1))}\\right)}}$",
                f"$d = \\sqrt{{{latex(simplify(distance_squared))}}} = {latex(distance)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == "polar_equation_convert":
        # Convert rectangular equation to polar or vice versa
        if choice([True, False]):
            # Rectangular to polar: x^2 + y^2 = a^2 becomes r = a
            a_val = randint(2, 8)
            
            return problem(
                question=f"Convert the rectangular equation $x^2 + y^2 = {a_val**2}$ to polar form.",
                answer=Eq(Symbol('r'), a_val),
                difficulty=(1300, 1500),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    f"Substitute $x = r\\cos(\\theta)$ and $y = r\\sin(\\theta)$",
                    f"$(r\\cos(\\theta))^2 + (r\\sin(\\theta))^2 = {a_val**2}$",
                    f"$r^2\\cos^2(\\theta) + r^2\\sin^2(\\theta) = {a_val**2}$",
                    f"$r^2(\\cos^2(\\theta) + \\sin^2(\\theta)) = {a_val**2}$",
                    f"$r^2 = {a_val**2}$",
                    f"$r = {a_val}$ (taking positive value)"
                )
            )
        else:
            # Polar to rectangular: r = a*cos(theta) becomes (x-a/2)^2 + y^2 = (a/2)^2
            a_val = choice([2, 4, 6, 8])
            r_var = Symbol('r')
            theta_var = Symbol('theta')
            
            return problem(
                question=f"Convert the polar equation $r = {a_val}\\cos(\\theta)$ to rectangular form.",
                answer=Eq(x**2 + y**2, a_val*x),
                difficulty=(1400, 1600),
                topic="precalculus/polar_coordinates",
                answer_type="equation",
                solution=steps(
                    f"Multiply both sides by $r$: $r^2 = {a_val}r\\cos(\\theta)$",
                    f"Substitute $r^2 = x^2 + y^2$ and $r\\cos(\\theta) = x$",
                    f"$x^2 + y^2 = {a_val}x$"
                )
            )
    
    else:  # polar_symmetry
        # Test for symmetry in polar equations
        eq_types = [
            ("r = \\cos(\\theta)", "polar axis", "Replace θ with -θ: r = cos(-θ) = cos(θ), equation unchanged"),
            ("r = \\sin(\\theta)", "line \\theta = \\frac{\\pi}{2}", "Replace θ with π-θ: r = sin(π-θ) = sin(θ), equation unchanged"),
            ("r^2 = \\cos(2\\theta)", "polar axis, line \\theta = \\frac{\\pi}{2}, and pole", "Symmetric about all three")
        ]
        
        eq_str, sym_type, explanation = choice(eq_types)
        
        return problem(
            question=f"Determine if the polar equation ${eq_str}$ is symmetric with respect to the polar axis, the line $\\theta = \\frac{{\\pi}}{{2}}$, or the pole.",
            answer=sym_type,
            difficulty=(1400, 1600),
            topic="precalculus/polar_coordinates",
            answer_type="expression",
            solution=steps(
                f"Test for symmetry by substitution:",
                explanation,
                f"The equation is symmetric with respect to: {sym_type}"
            )
        )

emit(generate())