"""
precalculus - unit_circle (medium)
Generated: 2026-02-22T04:42:10.364734
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'find_angle_value',
        'find_trig_value_given_angle',
        'find_trig_value_given_point',
        'reference_angle',
        'find_coordinates',
        'find_angle_from_point'
    ])
    
    if problem_type == 'find_angle_value':
        # Given sin(θ) or cos(θ), find θ in [0, 2π)
        quadrant = randint(1, 4)
        
        # Pick special angles: π/6, π/4, π/3
        reference = choice([pi/6, pi/4, pi/3])
        
        if quadrant == 1:
            angle = reference
        elif quadrant == 2:
            angle = pi - reference
        elif quadrant == 3:
            angle = pi + reference
        else:
            angle = 2*pi - reference
        
        trig_func = choice(['sin', 'cos'])
        
        if trig_func == 'sin':
            value = sin(angle)
            func_name = '\\sin'
        else:
            value = cos(angle)
            func_name = '\\cos'
        
        return problem(
            question=f"Find $\\theta$ in $[0, 2\\pi)$ such that ${func_name}(\\theta) = {latex(value)}$",
            answer=angle,
            difficulty=(1300, 1500),
            topic="precalculus/unit_circle",
            solution=steps(
                f"We need to find where ${func_name}(\\theta) = {latex(value)}$ on the unit circle",
                f"The reference angle is ${latex(reference)}$",
                f"The angle is in quadrant {quadrant}",
                f"$\\theta = {latex(angle)}$"
            )
        )
    
    elif problem_type == 'find_trig_value_given_angle':
        # Given an angle, find sin, cos, or tan
        quadrant = randint(1, 4)
        reference = choice([pi/6, pi/4, pi/3])
        
        if quadrant == 1:
            angle = reference
        elif quadrant == 2:
            angle = pi - reference
        elif quadrant == 3:
            angle = pi + reference
        else:
            angle = 2*pi - reference
        
        trig_func = choice(['sin', 'cos', 'tan'])
        
        if trig_func == 'sin':
            ans = sin(angle)
            func_name = '\\sin'
        elif trig_func == 'cos':
            ans = cos(angle)
            func_name = '\\cos'
        else:
            ans = tan(angle)
            func_name = '\\tan'
        
        return problem(
            question=f"Evaluate ${func_name}\\left({latex(angle)}\\right)$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The angle ${latex(angle)}$ is in quadrant {quadrant}",
                f"The reference angle is ${latex(reference)}$",
                f"Using the unit circle, ${func_name}\\left({latex(angle)}\\right) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'find_trig_value_given_point':
        # Given a point on unit circle, find trig values
        quadrant = randint(1, 4)
        reference = choice([pi/6, pi/4, pi/3])
        
        if quadrant == 1:
            angle = reference
        elif quadrant == 2:
            angle = pi - reference
        elif quadrant == 3:
            angle = pi + reference
        else:
            angle = 2*pi - reference
        
        x_coord = cos(angle)
        y_coord = sin(angle)
        
        trig_func = choice(['sin', 'cos', 'tan'])
        
        if trig_func == 'sin':
            ans = y_coord
            func_name = '\\sin'
            explanation = "sine is the y-coordinate"
        elif trig_func == 'cos':
            ans = x_coord
            func_name = '\\cos'
            explanation = "cosine is the x-coordinate"
        else:
            ans = tan(angle)
            func_name = '\\tan'
            explanation = "tangent is y/x"
        
        return problem(
            question=f"If the terminal side of angle $\\theta$ passes through the point $\\left({latex(x_coord)}, {latex(y_coord)}\\right)$ on the unit circle, find ${func_name}(\\theta)$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="precalculus/unit_circle",
            solution=steps(
                f"On the unit circle, the point is $\\left({latex(x_coord)}, {latex(y_coord)}\\right)$",
                f"By definition, {explanation}",
                f"${func_name}(\\theta) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'reference_angle':
        # Find reference angle
        quadrant = randint(2, 4)
        reference = choice([pi/6, pi/4, pi/3, pi/2])
        
        if quadrant == 2:
            angle = pi - reference
        elif quadrant == 3:
            angle = pi + reference
        else:
            angle = 2*pi - reference
        
        return problem(
            question=f"Find the reference angle for $\\theta = {latex(angle)}$",
            answer=reference,
            difficulty=(1200, 1400),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The angle ${latex(angle)}$ is in quadrant {quadrant}",
                f"The reference angle is the acute angle to the x-axis",
                f"Reference angle = ${latex(reference)}$"
            )
        )
    
    elif problem_type == 'find_coordinates':
        # Find coordinates on unit circle for given angle
        quadrant = randint(1, 4)
        reference = choice([pi/6, pi/4, pi/3])
        
        if quadrant == 1:
            angle = reference
        elif quadrant == 2:
            angle = pi - reference
        elif quadrant == 3:
            angle = pi + reference
        else:
            angle = 2*pi - reference
        
        x_coord = cos(angle)
        y_coord = sin(angle)
        ans = (x_coord, y_coord)
        
        return problem(
            question=f"Find the coordinates of the point on the unit circle corresponding to the angle $\\theta = {latex(angle)}$",
            answer=fmt_tuple(ans),
            difficulty=(1300, 1500),
            topic="precalculus/unit_circle",
            answer_type="tuple",
            solution=steps(
                f"On the unit circle, coordinates are $(\\cos(\\theta), \\sin(\\theta))$",
                f"$\\cos\\left({latex(angle)}\\right) = {latex(x_coord)}$",
                f"$\\sin\\left({latex(angle)}\\right) = {latex(y_coord)}$",
                f"Point: $\\left({latex(x_coord)}, {latex(y_coord)}\\right)$"
            )
        )
    
    else:  # find_angle_from_point
        # Given coordinates, find angle in [0, 2π)
        quadrant = randint(1, 4)
        reference = choice([pi/6, pi/4, pi/3])
        
        if quadrant == 1:
            angle = reference
        elif quadrant == 2:
            angle = pi - reference
        elif quadrant == 3:
            angle = pi + reference
        else:
            angle = 2*pi - reference
        
        x_coord = cos(angle)
        y_coord = sin(angle)
        
        return problem(
            question=f"Find the angle $\\theta$ in $[0, 2\\pi)$ corresponding to the point $\\left({latex(x_coord)}, {latex(y_coord)}\\right)$ on the unit circle",
            answer=angle,
            difficulty=(1400, 1600),
            topic="precalculus/unit_circle",
            solution=steps(
                f"The point is $\\left({latex(x_coord)}, {latex(y_coord)}\\right)$",
                f"This point is in quadrant {quadrant}",
                f"The reference angle is ${latex(reference)}$",
                f"$\\theta = {latex(angle)}$"
            )
        )

emit(generate())