"""
multivariable_calculus - line_integrals (easy)
Generated: 2026-02-22T05:43:28.436916
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Line integral of a constant along a straight line segment
        # Difficulty: 1000-1150 (simplest - just constant times arc length)
        c = nonzero(-5, 5)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        x2, y2 = randint(-3, 3), randint(-3, 3)
        while x1 == x2 and y1 == y2:
            x2, y2 = randint(-3, 3), randint(-3, 3)
        
        arc_length = sqrt((x2 - x1)**2 + (y2 - y1)**2)
        ans = c * arc_length
        
        return problem(
            question=f"Evaluate the line integral $\\int_C {c} \\, ds$ where $C$ is the line segment from $({x1}, {y1})$ to $({x2}, {y2})$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"For a constant function, $\\int_C {c} \\, ds = {c} \\cdot \\text{{(arc length)}}$",
                f"Arc length = $\\sqrt{{({x2} - {x1})^2 + ({y2} - {y1})^2}} = \\sqrt{{{(x2-x1)**2 + (y2-y1)**2}}} = {latex(arc_length)}$",
                f"Therefore, $\\int_C {c} \\, ds = {c} \\cdot {latex(arc_length)} = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Line integral of x or y along a horizontal or vertical line
        # Difficulty: 1100-1250 (simple parameterization)
        orientation = choice(['horizontal', 'vertical'])
        
        if orientation == 'horizontal':
            y_val = nonzero(-4, 4)
            x_start = randint(-3, 0)
            x_end = randint(1, 4)
            
            ans = Rational(x_end**2 - x_start**2, 2)
            
            return problem(
                question=f"Evaluate $\\int_C x \\, ds$ where $C$ is the line segment from $({x_start}, {y_val})$ to $({x_end}, {y_val})$.",
                answer=ans,
                difficulty=(1100, 1250),
                topic="multivariable_calculus/line_integrals",
                solution=steps(
                    f"Parameterize $C$ as $\\mathbf{{r}}(t) = (t, {y_val})$ for ${x_start} \\leq t \\leq {x_end}$",
                    f"$\\frac{{d\\mathbf{{r}}}}{{dt}} = (1, 0)$, so $\\left|\\frac{{d\\mathbf{{r}}}}{{dt}}\\right| = 1$",
                    f"$\\int_C x \\, ds = \\int_{{{x_start}}}^{{{x_end}}} t \\cdot 1 \\, dt = \\left[\\frac{{t^2}}{{2}}\\right]_{{{x_start}}}^{{{x_end}}}$",
                    f"$= \\frac{{{x_end}^2}}{{2}} - \\frac{{{x_start}^2}}{{2}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        else:
            x_val = nonzero(-4, 4)
            y_start = randint(-3, 0)
            y_end = randint(1, 4)
            
            ans = Rational(y_end**2 - y_start**2, 2)
            
            return problem(
                question=f"Evaluate $\\int_C y \\, ds$ where $C$ is the line segment from $({x_val}, {y_start})$ to $({x_val}, {y_end})$.",
                answer=ans,
                difficulty=(1100, 1250),
                topic="multivariable_calculus/line_integrals",
                solution=steps(
                    f"Parameterize $C$ as $\\mathbf{{r}}(t) = ({x_val}, t)$ for ${y_start} \\leq t \\leq {y_end}$",
                    f"$\\frac{{d\\mathbf{{r}}}}{{dt}} = (0, 1)$, so $\\left|\\frac{{d\\mathbf{{r}}}}{{dt}}\\right| = 1$",
                    f"$\\int_C y \\, ds = \\int_{{{y_start}}}^{{{y_end}}} t \\cdot 1 \\, dt = \\left[\\frac{{t^2}}{{2}}\\right]_{{{y_start}}}^{{{y_end}}}$",
                    f"$= \\frac{{{y_end}^2}}{{2}} - \\frac{{{y_start}^2}}{{2}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 3:
        # Type 3: Simple vector field line integral F·dr with constant F along straight line
        # Difficulty: 1150-1300
        fx = nonzero(-4, 4)
        fy = nonzero(-4, 4)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        x2, y2 = randint(-3, 3), randint(-3, 3)
        while x1 == x2 and y1 == y2:
            x2, y2 = randint(-3, 3), randint(-3, 3)
        
        ans = fx * (x2 - x1) + fy * (y2 - y1)
        
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {fx}, {fy} \\rangle$ and $C$ is the line segment from $({x1}, {y1})$ to $({x2}, {y2})$.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize $C$ as $\\mathbf{{r}}(t) = ({x1}, {y1}) + t\\langle {x2-x1}, {y2-y1} \\rangle$ for $0 \\leq t \\leq 1$",
                f"$\\frac{{d\\mathbf{{r}}}}{{dt}} = \\langle {x2-x1}, {y2-y1} \\rangle$",
                f"$\\mathbf{{F}} \\cdot \\frac{{d\\mathbf{{r}}}}{{dt}} = \\langle {fx}, {fy} \\rangle \\cdot \\langle {x2-x1}, {y2-y1} \\rangle = {fx}({x2-x1}) + {fy}({y2-y1}) = {fx*(x2-x1) + fy*(y2-y1)}$",
                f"$\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\int_0^1 {fx*(x2-x1) + fy*(y2-y1)} \\, dt = {ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Type 4: Line integral along x-axis from 0 to a of simple polynomial
        # Difficulty: 1200-1300
        a_val = randint(1, 4)
        coeff = nonzero(-3, 3)
        power = randint(1, 2)
        
        if power == 1:
            ans = coeff * Rational(a_val**2, 2)
            integrand_str = f"{coeff}x"
        else:
            ans = coeff * Rational(a_val**3, 3)
            integrand_str = f"{coeff}x^2"
        
        return problem(
            question=f"Evaluate $\\int_C {integrand_str} \\, ds$ where $C$ is the line segment from $(0, 0)$ to $({a_val}, 0)$.",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize $C$ as $\\mathbf{{r}}(t) = (t, 0)$ for $0 \\leq t \\leq {a_val}$",
                f"$\\frac{{d\\mathbf{{r}}}}{{dt}} = (1, 0)$, so $ds = \\left|\\frac{{d\\mathbf{{r}}}}{{dt}}\\right| dt = 1 \\, dt$",
                f"$\\int_C {integrand_str} \\, ds = \\int_0^{{{a_val}}} {integrand_str} \\, dt = {coeff}\\left[\\frac{{t^{{{power+1}}}}}{{{power+1}}}\\right]_0^{{{a_val}}}$",
                f"$= {coeff} \\cdot \\frac{{{a_val}^{{{power+1}}}}}{{{power+1}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())