"""
precalculus - sum_difference_formulas (medium)
Generated: 2026-02-22T04:46:52.715841
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Evaluate sin or cos of sum/difference of special angles
        # Difficulty: 1300-1400
        angles = [30, 45, 60]
        angle1 = choice(angles)
        angle2 = choice(angles)
        
        # Choose sum or difference
        is_sum = choice([True, False])
        
        # Choose sin or cos
        func = choice(['sin', 'cos'])
        
        if is_sum:
            angle_expr = angle1 + angle2
            op = "+"
        else:
            angle_expr = angle1 - angle2
            op = "-"
        
        # Convert to radians for SymPy
        angle1_rad = angle1 * pi / 180
        angle2_rad = angle2 * pi / 180
        
        if func == 'sin':
            if is_sum:
                ans = simplify(sin(angle1_rad)*cos(angle2_rad) + cos(angle1_rad)*sin(angle2_rad))
            else:
                ans = simplify(sin(angle1_rad)*cos(angle2_rad) - cos(angle1_rad)*sin(angle2_rad))
            
            formula = r"\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta" if is_sum else r"\sin(\alpha - \beta) = \sin\alpha\cos\beta - \cos\alpha\sin\beta"
            
            solution_steps = steps(
                f"Use the formula: ${formula}$",
                f"$\\sin({angle1}°)\\cos({angle2}°) {op} \\cos({angle1}°)\\sin({angle2}°)$",
                f"$= {latex(ans)}$"
            )
        else:
            if is_sum:
                ans = simplify(cos(angle1_rad)*cos(angle2_rad) - sin(angle1_rad)*sin(angle2_rad))
            else:
                ans = simplify(cos(angle1_rad)*cos(angle2_rad) + sin(angle1_rad)*sin(angle2_rad))
            
            formula = r"\cos(\alpha + \beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta" if is_sum else r"\cos(\alpha - \beta) = \cos\alpha\cos\beta + \sin\alpha\sin\beta"
            
            solution_steps = steps(
                f"Use the formula: ${formula}$",
                f"$\\cos({angle1}°)\\cos({angle2}°) {'+' if not is_sum else '-'} \\sin({angle1}°)\\sin({angle2}°)$",
                f"$= {latex(ans)}$"
            )
        
        question = f"Evaluate $\\{func}({angle1}° {op} {angle2}°)$ exactly."
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/sum_difference_formulas",
            solution=solution_steps
        )
    
    elif problem_type == 2:
        # Simplify using sum/difference formula (with variables)
        # Difficulty: 1400-1500
        func = choice(['sin', 'cos'])
        
        # Choose whether to expand or verify identity
        expand_problem = choice([True, False])
        
        if expand_problem:
            if func == 'sin':
                is_sum = choice([True, False])
                if is_sum:
                    question = f"Expand $\\sin(x + y)$ using the sum formula."
                    ans = sin(x)*cos(y) + cos(x)*sin(y)
                    solution_steps = steps(
                        r"Use the formula: $\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta$",
                        f"$= {latex(ans)}$"
                    )
                else:
                    question = f"Expand $\\sin(x - y)$ using the difference formula."
                    ans = sin(x)*cos(y) - cos(x)*sin(y)
                    solution_steps = steps(
                        r"Use the formula: $\sin(\alpha - \beta) = \sin\alpha\cos\beta - \cos\alpha\sin\beta$",
                        f"$= {latex(ans)}$"
                    )
            else:
                is_sum = choice([True, False])
                if is_sum:
                    question = f"Expand $\\cos(x + y)$ using the sum formula."
                    ans = cos(x)*cos(y) - sin(x)*sin(y)
                    solution_steps = steps(
                        r"Use the formula: $\cos(\alpha + \beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta$",
                        f"$= {latex(ans)}$"
                    )
                else:
                    question = f"Expand $\\cos(x - y)$ using the difference formula."
                    ans = cos(x)*cos(y) + sin(x)*sin(y)
                    solution_steps = steps(
                        r"Use the formula: $\cos(\alpha - \beta) = \cos\alpha\cos\beta + \sin\alpha\sin\beta$",
                        f"$= {latex(ans)}$"
                    )
        else:
            # Simplify a specific expression
            coeff = choice([2, 3, 4])
            if func == 'sin':
                question = f"Simplify $\\sin({coeff}x)\\cos(x) - \\cos({coeff}x)\\sin(x)$"
                ans = sin((coeff - 1)*x)
                solution_steps = steps(
                    r"Recognize the difference formula: $\sin\alpha\cos\beta - \cos\alpha\sin\beta = \sin(\alpha - \beta)$",
                    f"Let $\\alpha = {coeff}x$ and $\\beta = x$",
                    f"$= \\sin({coeff}x - x) = \\sin({coeff-1}x)$"
                )
            else:
                question = f"Simplify $\\cos({coeff}x)\\cos(x) + \\sin({coeff}x)\\sin(x)$"
                ans = cos((coeff - 1)*x)
                solution_steps = steps(
                    r"Recognize the difference formula: $\cos\alpha\cos\beta + \sin\alpha\sin\beta = \cos(\alpha - \beta)$",
                    f"Let $\\alpha = {coeff}x$ and $\\beta = x$",
                    f"$= \\cos({coeff}x - x) = \\cos({coeff-1}x)$"
                )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/sum_difference_formulas",
            solution=solution_steps
        )
    
    elif problem_type == 3:
        # Evaluate tan using sum/difference formula
        # Difficulty: 1400-1500
        angles = [30, 45, 60]
        angle1 = choice(angles)
        angle2 = choice(angles)
        is_sum = choice([True, False])
        
        angle1_rad = angle1 * pi / 180
        angle2_rad = angle2 * pi / 180
        
        tan1 = tan(angle1_rad)
        tan2 = tan(angle2_rad)
        
        if is_sum:
            ans = simplify((tan1 + tan2) / (1 - tan1*tan2))
            op = "+"
            formula = r"\tan(\alpha + \beta) = \frac{\tan\alpha + \tan\beta}{1 - \tan\alpha\tan\beta}"
        else:
            ans = simplify((tan1 - tan2) / (1 + tan1*tan2))
            op = "-"
            formula = r"\tan(\alpha - \beta) = \frac{\tan\alpha - \tan\beta}{1 + \tan\alpha\tan\beta}"
        
        question = f"Evaluate $\\tan({angle1}° {op} {angle2}°)$ exactly using the {'sum' if is_sum else 'difference'} formula."
        
        solution_steps = steps(
            f"Use the formula: ${formula}$",
            f"$\\tan({angle1}°) = {latex(tan1)}$, $\\tan({angle2}°) = {latex(tan2)}$",
            f"$= {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/sum_difference_formulas",
            solution=solution_steps,
            calculator="scientific"
        )
    
    else:
        # Apply sum/difference formula to find exact value
        # More complex: sin(15°) or cos(75°), etc.
        # Difficulty: 1500-1600
        target_angles = [15, 75, 105, 165]
        target = choice(target_angles)
        func = choice(['sin', 'cos'])
        
        # Decompose into difference or sum of standard angles
        if target == 15:
            angle1, angle2 = 45, 30
            op = "-"
        elif target == 75:
            angle1, angle2 = 45, 30
            op = "+"
        elif target == 105:
            angle1, angle2 = 60, 45
            op = "+"
        else:  # 165
            angle1, angle2 = 135, 30
            op = "+"
        
        angle1_rad = angle1 * pi / 180
        angle2_rad = angle2 * pi / 180
        
        if func == 'sin':
            if op == "+":
                ans = simplify(sin(angle1_rad)*cos(angle2_rad) + cos(angle1_rad)*sin(angle2_rad))
                formula = r"\sin(\alpha + \beta) = \sin\alpha\cos\beta + \cos\alpha\sin\beta"
            else:
                ans = simplify(sin(angle1_rad)*cos(angle2_rad) - cos(angle1_rad)*sin(angle2_rad))
                formula = r"\sin(\alpha - \beta) = \sin\alpha\cos\beta - \cos\alpha\sin\beta"
        else:
            if op == "+":
                ans = simplify(cos(angle1_rad)*cos(angle2_rad) - sin(angle1_rad)*sin(angle2_rad))
                formula = r"\cos(\alpha + \beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta"
            else:
                ans = simplify(cos(angle1_rad)*cos(angle2_rad) + sin(angle1_rad)*sin(angle2_rad))
                formula = r"\cos(\alpha - \beta) = \cos\alpha\cos\beta + \sin\alpha\sin\beta"
        
        question = f"Find the exact value of $\\{func}({target}°)$ using a sum or difference formula."
        
        solution_steps = steps(
            f"Express ${target}°$ as ${angle1}° {op} {angle2}°$",
            f"Use the formula: ${formula}$",
            f"$= {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/sum_difference_formulas",
            solution=solution_steps
        )

emit(generate())