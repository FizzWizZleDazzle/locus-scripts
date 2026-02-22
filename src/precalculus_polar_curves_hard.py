"""
precalculus - polar_curves (hard)
Generated: 2026-02-22T04:54:58.523907
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'area_between_curves',
        'tangent_line_polar',
        'arc_length_polar',
        'intersection_points',
        'convert_polar_to_cartesian_curve',
        'area_enclosed_complex'
    ])
    
    if problem_type == 'area_between_curves':
        # Area between two polar curves
        # Pick clean curves that intersect
        curve_type = choice(['circles', 'cardioid_circle', 'rose_petals'])
        
        if curve_type == 'circles':
            a_val = randint(2, 5)
            b_val = randint(1, a_val - 1)
            # r = a and r = b*cos(theta)
            r1 = a_val
            r2 = 2 * b_val * cos(t)
            
            # Find intersection: a = 2b*cos(theta) => cos(theta) = a/(2b)
            # For valid intersection, need |a/(2b)| <= 1
            if a_val <= 2 * b_val:
                cos_val = Rational(a_val, 2 * b_val)
                theta_int = acos(cos_val)
                
                # Area = (1/2) * integral from -theta_int to theta_int of (r1^2 - r2^2) dtheta
                integrand = r1**2 - (2 * b_val * cos(t))**2
                area_expr = integrate(integrand, (t, -theta_int, theta_int)) / 2
                ans = simplify(area_expr)
                
                return problem(
                    question=f"Find the area inside the circle $r = {a_val}$ and outside the circle $r = {2*b_val}\\cos\\theta$.",
                    answer=ans,
                    difficulty=(1650, 1750),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"Find intersection points: ${a_val} = {2*b_val}\\cos\\theta \\Rightarrow \\cos\\theta = {latex(cos_val)}$",
                        f"$\\theta = \\pm {latex(theta_int)}$",
                        f"Area $= \\frac{{1}}{{2}}\\int_{{-{latex(theta_int)}}}^{{{latex(theta_int)}}} \\left[{a_val}^2 - ({2*b_val}\\cos\\theta)^2\\right] d\\theta$",
                        f"$= {latex(ans)}$"
                    ),
                    calculator="scientific"
                )
        
        # Default to cardioid and circle
        a_val = randint(2, 4)
        # r = a(1 + cos(theta)) and r = 3a/2
        r1_expr = a_val * (1 + cos(t))
        r2_val = Rational(3 * a_val, 2)
        
        # Intersection: a(1 + cos(theta)) = 3a/2 => cos(theta) = 1/2 => theta = pi/3
        theta_int = pi / 3
        integrand = (a_val * (1 + cos(t)))**2 - r2_val**2
        area_expr = integrate(integrand, (t, -theta_int, theta_int)) / 2
        ans = simplify(area_expr)
        
        return problem(
            question=f"Find the area inside the cardioid $r = {a_val}(1 + \\cos\\theta)$ and outside the circle $r = \\frac{{{3*a_val}}}{{2}}$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Find intersection: ${a_val}(1 + \\cos\\theta) = \\frac{{{3*a_val}}}{{2}} \\Rightarrow \\cos\\theta = \\frac{{1}}{{2}}$",
                f"$\\theta = \\pm\\frac{{\\pi}}{{3}}$",
                f"Area $= \\frac{{1}}{{2}}\\int_{{-\\pi/3}}^{{\\pi/3}} \\left[{a_val}^2(1+\\cos\\theta)^2 - \\left(\\frac{{{3*a_val}}}{{2}}\\right)^2\\right] d\\theta$",
                f"$= {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'tangent_line_polar':
        # Find equation of tangent line to polar curve at given point
        a_val = randint(2, 5)
        theta_val = choice([0, pi/6, pi/4, pi/3, pi/2])
        
        # Use r = a*theta or r = a*sin(2*theta)
        if choice([True, False]):
            r_expr = a_val * t
            r_at_theta = a_val * theta_val
            dr_dt = a_val
            
            # Cartesian coords: x = r*cos(theta), y = r*sin(theta)
            x_val = r_at_theta * cos(theta_val)
            y_val = r_at_theta * sin(theta_val)
            
            # dy/dx = (dr/dtheta * sin(theta) + r*cos(theta)) / (dr/dtheta * cos(theta) - r*sin(theta))
            numer = dr_dt * sin(theta_val) + r_at_theta * cos(theta_val)
            denom = dr_dt * cos(theta_val) - r_at_theta * sin(theta_val)
            
            if abs(denom) > 0.01:
                slope = simplify(numer / denom)
                # y - y_val = slope * (x - x_val)
                ans = Eq(y - y_val, slope * (x - x_val))
                
                return problem(
                    question=f"Find the equation of the tangent line to the polar curve $r = {a_val}\\theta$ at $\\theta = {latex(theta_val)}$.",
                    answer=ans,
                    difficulty=(1650, 1750),
                    topic="precalculus/polar_curves",
                    solution=steps(
                        f"At $\\theta = {latex(theta_val)}$: $r = {latex(r_at_theta)}$",
                        f"Point in Cartesian: $({latex(x_val)}, {latex(y_val)})$",
                        f"$\\frac{{dy}}{{dx}} = \\frac{{\\frac{{dr}}{{d\\theta}}\\sin\\theta + r\\cos\\theta}}{{\\frac{{dr}}{{d\\theta}}\\cos\\theta - r\\sin\\theta}}$",
                        f"Slope $= {latex(slope)}$",
                        f"${latex(ans)}$"
                    ),
                    answer_type="equation"
                )
        
        # Use simpler case: cardioid
        r_expr = a_val * (1 + cos(t))
        r_at_theta = a_val * (1 + cos(theta_val))
        dr_dt = -a_val * sin(theta_val)
        
        x_val = simplify(r_at_theta * cos(theta_val))
        y_val = simplify(r_at_theta * sin(theta_val))
        
        numer = dr_dt * sin(theta_val) + r_at_theta * cos(theta_val)
        denom = dr_dt * cos(theta_val) - r_at_theta * sin(theta_val)
        
        if abs(denom) > 0.01:
            slope = simplify(numer / denom)
            ans = Eq(y - y_val, slope * (x - x_val))
            
            return problem(
                question=f"Find the equation of the tangent line to the cardioid $r = {a_val}(1 + \\cos\\theta)$ at $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"At $\\theta = {latex(theta_val)}$: $r = {latex(r_at_theta)}$",
                    f"Point: $({latex(x_val)}, {latex(y_val)})$",
                    f"$\\frac{{dr}}{{d\\theta}} = {latex(dr_dt)}$",
                    f"Slope $= {latex(slope)}$",
                    f"${latex(ans)}$"
                ),
                answer_type="equation"
            )
    
    elif problem_type == 'arc_length_polar':
        # Arc length of polar curve
        a_val = randint(2, 4)
        # Use r = a*e^(b*theta) from theta = 0 to theta = pi
        b_val = Rational(1, 2)
        theta_end = pi
        
        r_expr = a_val * exp(b_val * t)
        dr_dt = a_val * b_val * exp(b_val * t)
        
        # Arc length = integral sqrt(r^2 + (dr/dtheta)^2) dtheta
        integrand_squared = r_expr**2 + dr_dt**2
        integrand = sqrt(integrand_squared)
        
        arc_length = integrate(integrand, (t, 0, theta_end))
        ans = simplify(arc_length)
        
        return problem(
            question=f"Find the arc length of the spiral $r = {a_val}e^{{{latex(b_val)}\\theta}}$ from $\\theta = 0$ to $\\theta = \\pi$.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Arc length $= \\int_0^\\pi \\sqrt{{r^2 + \\left(\\frac{{dr}}{{d\\theta}}\\right)^2}} d\\theta$",
                f"$r = {a_val}e^{{{latex(b_val)}\\theta}}, \\frac{{dr}}{{d\\theta}} = {latex(a_val * b_val)}e^{{{latex(b_val)}\\theta}}$",
                f"$r^2 + \\left(\\frac{{dr}}{{d\\theta}}\\right)^2 = {latex(simplify(integrand_squared))}$",
                f"$= {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'intersection_points':
        # Find all intersection points of two polar curves
        a_val = randint(2, 4)
        # r = a*cos(2*theta) and r = a*sin(2*theta)
        r1_expr = a_val * cos(2 * t)
        r2_expr = a_val * sin(2 * t)
        
        # Solve: a*cos(2*theta) = a*sin(2*theta)
        # cos(2*theta) = sin(2*theta) => tan(2*theta) = 1 => 2*theta = pi/4 + n*pi
        theta_solutions = [pi/8, 5*pi/8]
        
        points = []
        for theta_val in theta_solutions:
            r_val = a_val * cos(2 * theta_val)
            points.append((float(r_val), float(theta_val)))
        
        # Also check for pole
        points.append((0, 0))
        
        ans_list = [(simplify(a_val * cos(2 * pi/8)), pi/8), 
                    (simplify(a_val * cos(2 * 5*pi/8)), 5*pi/8),
                    (0, pi/4)]
        
        ans_str = fmt_set([f"({latex(r)}, {latex(theta)})" for r, theta in ans_list])
        
        return problem(
            question=f"Find all points of intersection (in polar coordinates) of the curves $r = {a_val}\\cos(2\\theta)$ and $r = {a_val}\\sin(2\\theta)$ for $0 \\leq \\theta < 2\\pi$.",
            answer=ans_str,
            difficulty=(1600, 1700),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Set ${a_val}\\cos(2\\theta) = {a_val}\\sin(2\\theta)$",
                f"$\\tan(2\\theta) = 1 \\Rightarrow 2\\theta = \\frac{{\\pi}}{{4}}, \\frac{{5\\pi}}{{4}}$",
                f"$\\theta = \\frac{{\\pi}}{{8}}, \\frac{{5\\pi}}{{8}}$",
                f"Also check pole: $r = 0$ when $\\theta = \\frac{{\\pi}}{{4}}$ (first curve) and $\\theta = 0$ (second curve)",
                f"Points: {ans_str}"
            ),
            answer_type="set"
        )
    
    elif problem_type == 'convert_polar_to_cartesian_curve':
        # Convert polar equation to Cartesian form
        curve_choice = choice(['lemniscate', 'limaçon', 'rose'])
        
        if curve_choice == 'lemniscate':
            a_val = randint(2, 5)
            # r^2 = a^2 * cos(2*theta)
            # r^2 = a^2(cos^2(theta) - sin^2(theta))
            # x^2 + y^2 = a^2 * ((x^2 - y^2)/(x^2 + y^2))
            # (x^2 + y^2)^2 = a^2(x^2 - y^2)
            
            ans = Eq((x**2 + y**2)**2, a_val**2 * (x**2 - y**2))
            
            return problem(
                question=f"Convert the polar equation $r^2 = {a_val**2}\\cos(2\\theta)$ to Cartesian form.",
                answer=ans,
                difficulty=(1650, 1750),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Use $\\cos(2\\theta) = \\cos^2\\theta - \\sin^2\\theta = \\frac{{x^2 - y^2}}{{r^2}}$",
                    f"$r^2 = {a_val**2} \\cdot \\frac{{x^2 - y^2}}{{r^2}}$",
                    f"$r^4 = {a_val**2}(x^2 - y^2)$",
                    f"$(x^2 + y^2)^2 = {a_val**2}(x^2 - y^2)$"
                ),
                answer_type="equation"
            )
        
        else:
            # Simpler conversion
            a_val = randint(2, 5)
            # r = a*cos(theta)
            # r^2 = a*r*cos(theta)
            # x^2 + y^2 = a*x
            # x^2 - a*x + y^2 = 0
            # (x - a/2)^2 + y^2 = (a/2)^2
            
            ans = Eq((x - Rational(a_val, 2))**2 + y**2, (Rational(a_val, 2)