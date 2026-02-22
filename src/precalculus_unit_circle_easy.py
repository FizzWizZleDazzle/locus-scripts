"""
precalculus - unit_circle (easy)
Generated: 2026-02-22T04:41:45.265964
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Find exact value of sin, cos, or tan at a standard angle (1000-1100)
        angles_deg = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        angle_deg = choice(angles_deg)
        angle_rad = angle_deg * pi / 180
        
        func_choice = choice(['sin', 'cos', 'tan'])
        
        if func_choice == 'sin':
            ans = sin(angle_rad)
            func_name = '\\sin'
        elif func_choice == 'cos':
            ans = cos(angle_rad)
            func_name = '\\cos'
        else:  # tan
            if angle_deg in [90, 270]:
                # Avoid undefined tan values for easiest problems
                angle_deg = choice([0, 30, 45, 60, 120, 135, 150, 180, 210, 225, 240, 300, 315, 330])
                angle_rad = angle_deg * pi / 180
            ans = tan(angle_rad)
            func_name = '\\tan'
        
        # Convert to simplified form
        ans = simplify(ans)
        
        return problem(
            question=f"Find the exact value: ${func_name}\\left({latex(angle_rad)}\\right)$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The angle ${latex(angle_rad)}$ radians is ${angle_deg}^\\circ$",
                f"Using the unit circle, ${func_name}({angle_deg}^\\circ) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Convert degrees to radians or radians to degrees (1000-1150)
        convert_to = choice(['radians', 'degrees'])
        
        if convert_to == 'radians':
            angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330, 360])
            ans = angle_deg * pi / 180
            ans = simplify(ans)
            
            return problem(
                question=f"Convert ${angle_deg}^\\circ$ to radians.",
                answer=ans,
                difficulty=(1000, 1150),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"Use the conversion formula: radians $= \\text{{degrees}} \\times \\frac{{\\pi}}{{180}}$",
                    f"${angle_deg}^\\circ \\times \\frac{{\\pi}}{{180}} = {latex(ans)}$"
                )
            )
        else:
            # radians to degrees
            common_rads = [pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi, 
                          7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2, 5*pi/3, 7*pi/4, 11*pi/6, 2*pi]
            angle_rad = choice(common_rads)
            ans = angle_rad * 180 / pi
            ans = simplify(ans)
            
            return problem(
                question=f"Convert ${latex(angle_rad)}$ radians to degrees.",
                answer=ans,
                difficulty=(1000, 1150),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"Use the conversion formula: degrees $= \\text{{radians}} \\times \\frac{{180}}{{\\pi}}$",
                    f"${latex(angle_rad)} \\times \\frac{{180}}{{\\pi}} = {latex(ans)}^\\circ$"
                )
            )
    
    elif problem_type == 3:
        # Type 3: Find the reference angle (1100-1200)
        angle_deg = choice([120, 135, 150, 210, 225, 240, 300, 315, 330])
        
        if angle_deg <= 180:
            ref_angle = 180 - angle_deg
        else:
            ref_angle = angle_deg - 180 if angle_deg <= 270 else 360 - angle_deg
        
        return problem(
            question=f"Find the reference angle for ${angle_deg}^\\circ$.",
            answer=ref_angle,
            difficulty=(1100, 1200),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The angle ${angle_deg}^\\circ$ is in quadrant " + 
                ("II" if 90 < angle_deg <= 180 else "III" if 180 < angle_deg <= 270 else "IV"),
                f"Reference angle = ${ref_angle}^\\circ$"
            )
        )
    
    elif problem_type == 4:
        # Type 4: Find coordinates on unit circle at standard angle (1100-1250)
        angles_deg = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        angle_deg = choice(angles_deg)
        angle_rad = angle_deg * pi / 180
        
        x_coord = simplify(cos(angle_rad))
        y_coord = simplify(sin(angle_rad))
        
        ans = (x_coord, y_coord)
        
        return problem(
            question=f"Find the coordinates $(x, y)$ on the unit circle at angle ${latex(angle_rad)}$ radians.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="precalculus/unit_circle",
            solution=steps(
                f"On the unit circle, $x = \\cos\\theta$ and $y = \\sin\\theta$",
                f"$x = \\cos({latex(angle_rad)}) = {latex(x_coord)}$",
                f"$y = \\sin({latex(angle_rad)}) = {latex(y_coord)}$",
                f"Coordinates: $({latex(x_coord)}, {latex(y_coord)})$"
            )
        )
    
    else:
        # Type 5: Given sin or cos, find the other using Pythagorean identity (1200-1300)
        # Use simple Pythagorean triples
        triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17)]
        triple = choice(triples)
        a_val, b_val, c_val = triple
        
        given_func = choice(['sin', 'cos'])
        quadrant = choice([1, 2])  # Keep it simple, quadrants I or II
        
        if given_func == 'sin':
            given_value = Rational(b_val, c_val)
            if quadrant == 1:
                ans = Rational(a_val, c_val)
            else:
                ans = Rational(-a_val, c_val)
            
            return problem(
                question=f"If $\\sin\\theta = {latex(given_value)}$ and $\\theta$ is in quadrant {quadrant}, find $\\cos\\theta$.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"Use the Pythagorean identity: $\\sin^2\\theta + \\cos^2\\theta = 1$",
                    f"$\\left({latex(given_value)}\\right)^2 + \\cos^2\\theta = 1$",
                    f"$\\cos^2\\theta = 1 - {latex(given_value**2)} = {latex(1 - given_value**2)}$",
                    f"$\\cos\\theta = \\pm {latex(sqrt(1 - given_value**2))}$",
                    f"In quadrant {quadrant}, cosine is " + ("positive" if quadrant == 1 else "negative"),
                    f"$\\cos\\theta = {latex(ans)}$"
                )
            )
        else:
            given_value = Rational(a_val, c_val)
            if quadrant == 1:
                ans = Rational(b_val, c_val)
            else:
                ans = Rational(b_val, c_val)
            
            return problem(
                question=f"If $\\cos\\theta = {latex(given_value)}$ and $\\theta$ is in quadrant {quadrant}, find $\\sin\\theta$.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="precalculus/unit_circle",
                solution=steps(
                    f"Use the Pythagorean identity: $\\sin^2\\theta + \\cos^2\\theta = 1$",
                    f"$\\sin^2\\theta + \\left({latex(given_value)}\\right)^2 = 1$",
                    f"$\\sin^2\\theta = 1 - {latex(given_value**2)} = {latex(1 - given_value**2)}$",
                    f"$\\sin\\theta = \\pm {latex(sqrt(1 - given_value**2))}$",
                    f"In quadrant {quadrant}, sine is positive",
                    f"$\\sin\\theta = {latex(ans)}$"
                )
            )

emit(generate())