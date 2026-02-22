"""
precalculus - polar_curves (medium)
Generated: 2026-02-22T04:54:07.257009
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'convert_polar_to_rect',
        'convert_rect_to_polar', 
        'find_distance_polar',
        'symmetry_test',
        'find_tangent_slope',
        'area_polar_region'
    ])
    
    if problem_type == 'convert_polar_to_rect':
        # Convert polar equation to rectangular
        equation_choice = choice(['circle', 'line', 'cardioid'])
        
        if equation_choice == 'circle':
            # r = a -> x^2 + y^2 = a^2
            a_val = randint(2, 8)
            ans = Eq(x**2 + y**2, a_val**2)
            return problem(
                question=f"Convert the polar equation $r = {a_val}$ to rectangular form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $r^2 = x^2 + y^2$",
                    f"$r = {a_val}$ means $r^2 = {a_val**2}$",
                    f"${latex(ans)}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )
        
        elif equation_choice == 'line':
            # r cos(theta) = a -> x = a or r sin(theta) = b -> y = b
            if choice([True, False]):
                a_val = nonzero(-6, 6)
                ans = Eq(x, a_val)
                return problem(
                    question=f"Convert the polar equation $r\\cos\\theta = {a_val}$ to rectangular form.",
                    answer=ans,
                    difficulty=(1300, 1400),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"Use $x = r\\cos\\theta$",
                        f"${latex(ans)}$"
                    ),
                    grading_mode="equivalent",
                    answer_type="equation"
                )
            else:
                b_val = nonzero(-6, 6)
                ans = Eq(y, b_val)
                return problem(
                    question=f"Convert the polar equation $r\\sin\\theta = {b_val}$ to rectangular form.",
                    answer=ans,
                    difficulty=(1300, 1400),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"Use $y = r\\sin\\theta$",
                        f"${latex(ans)}$"
                    ),
                    grading_mode="equivalent",
                    answer_type="equation"
                )
        
        else:  # cardioid
            # r = a(1 + cos(theta))
            a_val = randint(1, 4)
            # (x^2 + y^2 - ax)^2 = a^2(x^2 + y^2)
            ans = Eq((x**2 + y**2 - a_val*x)**2, a_val**2 * (x**2 + y**2))
            return problem(
                question=f"Convert the polar equation $r = {a_val}(1 + \\cos\\theta)$ to rectangular form.",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $r = {a_val}(1 + \\cos\\theta)$",
                    f"$r = {a_val} + {a_val}\\cos\\theta$",
                    f"$r = {a_val} + {a_val} \\cdot \\frac{{x}}{{r}}$",
                    f"$r^2 = {a_val}r + {a_val}x$",
                    f"$x^2 + y^2 = {a_val}\\sqrt{{x^2 + y^2}} + {a_val}x$",
                    f"$x^2 + y^2 - {a_val}x = {a_val}\\sqrt{{x^2 + y^2}}$",
                    f"${latex(ans)}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )
    
    elif problem_type == 'convert_rect_to_polar':
        # Convert rectangular to polar
        equation_choice = choice(['circle_origin', 'vertical_line', 'circle_shifted'])
        
        if equation_choice == 'circle_origin':
            # x^2 + y^2 = a^2 -> r = a
            a_val = randint(2, 7)
            ans = Eq(r, a_val)
            return problem(
                question=f"Convert the rectangular equation $x^2 + y^2 = {a_val**2}$ to polar form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $x^2 + y^2 = r^2$",
                    f"$r^2 = {a_val**2}$",
                    f"${latex(ans)}$ (taking positive root)"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )
        
        elif equation_choice == 'vertical_line':
            # x = a -> r cos(theta) = a
            a_val = nonzero(-5, 5)
            theta = Symbol('theta')
            ans = Eq(r*cos(theta), a_val)
            return problem(
                question=f"Convert the rectangular equation $x = {a_val}$ to polar form.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $x = r\\cos\\theta$",
                    f"${latex(ans)}$"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )
        
        else:  # circle_shifted
            # x^2 + y^2 = ax -> r = a cos(theta)
            a_val = 2 * randint(1, 4)
            theta = Symbol('theta')
            ans = Eq(r, a_val*cos(theta))
            return problem(
                question=f"Convert the rectangular equation $x^2 + y^2 = {a_val}x$ to polar form.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $x^2 + y^2 = r^2$ and $x = r\\cos\\theta$",
                    f"$r^2 = {a_val}r\\cos\\theta$",
                    f"$r = {a_val}\\cos\\theta$ (dividing by $r$)"
                ),
                grading_mode="equivalent",
                answer_type="equation"
            )
    
    elif problem_type == 'find_distance_polar':
        # Find distance from origin to point in polar coordinates
        r_val = randint(3, 10)
        theta_deg = choice([30, 45, 60, 90, 120, 135, 150])
        ans = r_val
        return problem(
            question=f"Find the distance from the origin to the point with polar coordinates $\\left({r_val}, {theta_deg}^\\circ\\right)$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/polar_curves",
            solution=steps(
                f"In polar coordinates $(r, \\theta)$, the distance from the origin is simply $r$",
                f"Distance = ${ans}$"
            )
        )
    
    elif problem_type == 'symmetry_test':
        # Test for symmetry in polar curves
        curve_type = choice(['rose', 'circle', 'line'])
        
        if curve_type == 'rose':
            n = choice([3, 4, 5])
            theta = Symbol('theta')
            a_val = randint(2, 5)
            symmetry = choice(['polar_axis', 'line_theta_pi_2', 'origin'])
            
            if symmetry == 'polar_axis':
                # r = a cos(n theta) is symmetric about polar axis
                return problem(
                    question=f"Is the polar curve $r = {a_val}\\cos({n}\\theta)$ symmetric about the polar axis (the line $\\theta = 0$)?",
                    answer=True,
                    difficulty=(1400, 1500),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"Test: Replace $\\theta$ with $-\\theta$",
                        f"$r = {a_val}\\cos({n}(-\\theta)) = {a_val}\\cos(-{n}\\theta) = {a_val}\\cos({n}\\theta)$",
                        f"The equation is unchanged, so the curve is symmetric about the polar axis."
                    ),
                    answer_type="boolean"
                )
            elif symmetry == 'line_theta_pi_2':
                # r = a sin(n theta) is symmetric about theta = pi/2
                return problem(
                    question=f"Is the polar curve $r = {a_val}\\sin({n}\\theta)$ symmetric about the line $\\theta = \\frac{{\\pi}}{{2}}$?",
                    answer=True,
                    difficulty=(1400, 1500),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"Test: Replace $\\theta$ with $\\pi - \\theta$",
                        f"$r = {a_val}\\sin({n}(\\pi - \\theta)) = {a_val}\\sin({n}\\pi - {n}\\theta)$",
                        f"For odd $n$, this equals ${a_val}\\sin({n}\\theta)$ (using symmetry of sine)",
                        f"The curve is symmetric about $\\theta = \\frac{{\\pi}}{{2}}$."
                    ),
                    answer_type="boolean"
                )
            else:
                # Test a curve not symmetric about origin
                return problem(
                    question=f"Is the polar curve $r = {a_val}\\cos({n}\\theta)$ symmetric about the origin?",
                    answer=False if n % 2 == 1 else True,
                    difficulty=(1500, 1600),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"Test: Replace $r$ with $-r$ and $\\theta$ with $\\theta$",
                        f"$-r = {a_val}\\cos({n}\\theta)$, or $r = -{a_val}\\cos({n}\\theta)$",
                        f"This {'equals' if n % 2 == 0 else 'does not equal'} the original equation.",
                        f"The curve is {'symmetric' if n % 2 == 0 else 'not symmetric'} about the origin."
                    ),
                    answer_type="boolean"
                )
    
    elif problem_type == 'find_tangent_slope':
        # Find slope of tangent line at a point
        theta_val = choice([0, pi/6, pi/4, pi/3, pi/2])
        a_val = randint(2, 6)
        
        # Use r = a (circle)
        # dy/dx = (dr/dtheta * sin(theta) + r*cos(theta)) / (dr/dtheta * cos(theta) - r*sin(theta))
        # For r = a, dr/dtheta = 0
        # dy/dx = a*cos(theta) / (-a*sin(theta)) = -cot(theta)
        
        if theta_val == pi/4:
            ans = -1
            return problem(
                question=f"Find the slope of the tangent line to the polar curve $r = {a_val}$ at $\\theta = \\frac{{\\pi}}{{4}}$.",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $\\frac{{dy}}{{dx}} = \\frac{{\\frac{{dr}}{{d\\theta}}\\sin\\theta + r\\cos\\theta}}{{\\frac{{dr}}{{d\\theta}}\\cos\\theta - r\\sin\\theta}}$",
                    f"For $r = {a_val}$, $\\frac{{dr}}{{d\\theta}} = 0$",
                    f"$\\frac{{dy}}{{dx}} = \\frac{{{a_val}\\cos\\theta}}{{-{a_val}\\sin\\theta}} = -\\cot\\theta$",
                    f"At $\\theta = \\frac{{\\pi}}{{4}}$: $\\frac{{dy}}{{dx}} = -\\cot\\frac{{\\pi}}{{4}} = -1$"
                ),
                calculator="scientific"
            )
        elif theta_val == pi/3:
            ans = -sqrt(3)/3
            return problem(
                question=f"Find the slope of the tangent line to the polar curve $r = {a_val}$ at $\\theta = \\frac{{\\pi}}{{3}}$.",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $\\frac{{dy}}{{dx}} = \\frac{{\\frac{{dr}}{{d\\theta}}\\sin\\theta + r\\cos\\theta}}{{\\frac{{dr}}{{d\\theta}}\\cos\\theta - r\\sin\\theta}}$",
                    f"For $r = {a_val}$, $\\frac{{dr}}{{d\\theta}} = 0$",
                    f"$\\frac{{dy}}{{dx}} = \\frac{{{a_val}\\cos\\theta}}{{-{a_val}\\sin\\theta}} = -\\cot\\theta$",
                    f"At $\\theta = \\frac{{\\pi}}{{3}}$: $\\frac{{dy}}{{dx}} = -\\cot\\frac{{\\pi}}{{3}} = -\\frac{{1}}{{\\sqrt{{3}}}} = -\\frac{{\\sqrt{{3}}}}{{3}}$"
                ),
                calculator="scientific"
            )
    
    else:  # area_polar_region
        # Find area enclosed by polar curve
        a_val = randint(2, 6)
        curve_choice = choice(['circle', 'cardioid_partial'])
        
        if curve_choice == 'circle':
            # Area of r = a from 0 to 2pi is pi*a^2
            ans = pi * a_val**2
            return problem(
                question=f"Find the area enclosed by the polar curve $r = {a_val}$.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $A = \\frac{{1}}{{2}}\\int_{{\\alpha}}^{{\\beta}} r^2 \\, d\\theta$",
                    f"$A = \\frac{{1}}{{2}}\\int_0^{{2\\pi}} {a_val**2} \\, d\\theta$",
                    f"$A = \\frac{{{a_val**2}}}{{2}} \\cdot 2\\pi = {a_val**2}\\pi$"
                ),
                calculator="scientific"
            )
        
        else:  # cardioid_partial
            # Area of one petal of r = a cos