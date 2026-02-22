"""
precalculus - trig_identities (easy)
Generated: 2026-02-22T04:44:42.394440
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Evaluate basic trig values at special angles
        angles_deg = [0, 30, 45, 60, 90, 180, 270, 360]
        angle_deg = choice(angles_deg)
        trig_func = choice(['sin', 'cos', 'tan'])
        
        # Skip tan at 90 and 270
        while trig_func == 'tan' and angle_deg in [90, 270]:
            angle_deg = choice(angles_deg)
        
        angle_rad = angle_deg * pi / 180
        
        if trig_func == 'sin':
            ans = sin(angle_rad)
            func_name = '\\sin'
        elif trig_func == 'cos':
            ans = cos(angle_rad)
            func_name = '\\cos'
        else:
            ans = tan(angle_rad)
            func_name = '\\tan'
        
        ans = simplify(ans)
        
        return problem(
            question=f"Evaluate ${func_name}({angle_deg}^\\circ)$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Convert ${angle_deg}^\\circ$ to radians: ${latex(angle_rad)}$",
                f"${func_name}({latex(angle_rad)}) = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Simplify sin^2 + cos^2 = 1 with coefficient
        coeff = randint(1, 5)
        expr = coeff * (sin(x)**2 + cos(x)**2)
        ans = coeff
        
        return problem(
            question=f"Simplify ${latex(expr)}$ using the Pythagorean identity",
            answer=ans,
            difficulty=(1100, 1200),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Use the identity $\\sin^2(x) + \\cos^2(x) = 1$",
                f"${latex(expr)} = {coeff} \\cdot 1 = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Use tan = sin/cos to simplify
        angle_deg = choice([30, 45, 60])
        angle_rad = angle_deg * pi / 180
        
        numerator = sin(angle_rad)
        denominator = cos(angle_rad)
        ans = simplify(numerator / denominator)
        
        return problem(
            question=f"Simplify $\\frac{{\\sin({angle_deg}^\\circ)}}{{\\cos({angle_deg}^\\circ)}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Use the identity $\\tan(\\theta) = \\frac{{\\sin(\\theta)}}{{\\cos(\\theta)}}$",
                f"$\\frac{{\\sin({angle_deg}^\\circ)}}{{\\cos({angle_deg}^\\circ)}} = \\tan({angle_deg}^\\circ) = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Verify simple identity is true (boolean answer)
        identity_type = randint(1, 3)
        
        if identity_type == 1:
            lhs = sin(x)**2 + cos(x)**2
            rhs = 1
            identity_str = "\\sin^2(x) + \\cos^2(x) = 1"
        elif identity_type == 2:
            lhs = tan(x)
            rhs = sin(x) / cos(x)
            identity_str = "\\tan(x) = \\frac{\\sin(x)}{\\cos(x)}"
        else:
            lhs = 1 + tan(x)**2
            rhs = 1 / cos(x)**2
            identity_str = "1 + \\tan^2(x) = \\sec^2(x)"
        
        ans = True
        
        return problem(
            question=f"Is the following a valid trigonometric identity? ${identity_str}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/trig_identities",
            solution=f"Yes, this is a fundamental trigonometric identity.",
            answer_type="boolean"
        )
    
    else:
        # Simplify cos^2(x) using Pythagorean identity
        expr = 1 - sin(x)**2
        ans = cos(x)**2
        
        return problem(
            question=f"Simplify $1 - \\sin^2(x)$ using the Pythagorean identity",
            answer=ans,
            difficulty=(1200, 1300),
            topic="precalculus/trig_identities",
            solution=steps(
                f"Use the Pythagorean identity: $\\sin^2(x) + \\cos^2(x) = 1$",
                f"Rearrange to get: $\\cos^2(x) = 1 - \\sin^2(x)$",
                f"Therefore: $1 - \\sin^2(x) = {latex(ans)}$"
            )
        )

emit(generate())