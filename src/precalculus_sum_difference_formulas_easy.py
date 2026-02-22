"""
precalculus - sum_difference_formulas (easy)
Generated: 2026-02-22T04:46:19.733920
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Direct application of sin(A + B) with special angles
        angles = [0, 30, 45, 60, 90, 120, 135, 150, 180]
        angle1 = choice(angles)
        angle2 = choice(angles)
        
        # Make sure we get a nice sum/difference
        if randint(0, 1) == 0:
            operation = "+"
            result_angle = angle1 + angle2
            formula_type = "sum"
        else:
            operation = "-"
            result_angle = angle1 - angle2
            formula_type = "difference"
        
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        
        # Calculate the answer
        ans = func(pi * result_angle / 180)
        ans_simplified = simplify(ans)
        
        question = f"Use a {formula_type} formula to find the exact value of ${func_name}({angle1}° {operation} {angle2}°)$"
        
        if func == sin:
            if operation == "+":
                formula = f"\\sin(A + B) = \\sin A \\cos B + \\cos A \\sin B"
                expansion = f"\\sin({angle1}°)\\cos({angle2}°) + \\cos({angle1}°)\\sin({angle2}°)"
            else:
                formula = f"\\sin(A - B) = \\sin A \\cos B - \\cos A \\sin B"
                expansion = f"\\sin({angle1}°)\\cos({angle2}°) - \\cos({angle1}°)\\sin({angle2}°)"
        else:
            if operation == "+":
                formula = f"\\cos(A + B) = \\cos A \\cos B - \\sin A \\sin B"
                expansion = f"\\cos({angle1}°)\\cos({angle2}°) - \\sin({angle1}°)\\sin({angle2}°)"
            else:
                formula = f"\\cos(A - B) = \\cos A \\cos B + \\sin A \\sin B"
                expansion = f"\\cos({angle1}°)\\cos({angle2}°) + \\sin({angle1}°)\\sin({angle2}°)"
        
        return problem(
            question=question,
            answer=ans_simplified,
            difficulty=(1000, 1200),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Apply the formula: ${formula}$",
                f"${func_name}({angle1}° {operation} {angle2}°) = {expansion}$",
                f"Evaluating gives ${latex(ans_simplified)}$"
            ),
        )
    
    elif problem_type == 2:
        # Simplify using sum/difference formulas (pattern recognition)
        angle1 = choice([30, 45, 60])
        angle2 = choice([30, 45, 60])
        
        if randint(0, 1) == 0:
            # sin(A)cos(B) + cos(A)sin(B) = sin(A+B)
            result_angle = angle1 + angle2
            ans = sin(pi * result_angle / 180)
            ans_simplified = simplify(ans)
            
            question = f"Simplify $\\sin({angle1}°)\\cos({angle2}°) + \\cos({angle1}°)\\sin({angle2}°)$"
            
            return problem(
                question=question,
                answer=ans_simplified,
                difficulty=(1100, 1250),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    f"Recognize the sum formula: $\\sin(A + B) = \\sin A \\cos B + \\cos A \\sin B$",
                    f"This equals $\\sin({angle1}° + {angle2}°) = \\sin({result_angle}°)$",
                    f"$\\sin({result_angle}°) = {latex(ans_simplified)}$"
                ),
            )
        else:
            # cos(A)cos(B) - sin(A)sin(B) = cos(A+B)
            result_angle = angle1 + angle2
            ans = cos(pi * result_angle / 180)
            ans_simplified = simplify(ans)
            
            question = f"Simplify $\\cos({angle1}°)\\cos({angle2}°) - \\sin({angle1}°)\\sin({angle2}°)$"
            
            return problem(
                question=question,
                answer=ans_simplified,
                difficulty=(1100, 1250),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    f"Recognize the sum formula: $\\cos(A + B) = \\cos A \\cos B - \\sin A \\sin B$",
                    f"This equals $\\cos({angle1}° + {angle2}°) = \\cos({result_angle}°)$",
                    f"$\\cos({result_angle}°) = {latex(ans_simplified)}$"
                ),
            )
    
    elif problem_type == 3:
        # Express as a single trig function (given exact value expression)
        angle1 = choice([15, 75, 105, 165])
        
        # Express angle as sum/difference of special angles
        if angle1 == 15:
            a1, a2 = 45, 30
            op = "-"
        elif angle1 == 75:
            a1, a2 = 45, 30
            op = "+"
        elif angle1 == 105:
            a1, a2 = 60, 45
            op = "+"
        else:  # 165
            a1, a2 = 135, 30
            op = "+"
        
        func = choice([sin, cos])
        func_name = "sin" if func == sin else "cos"
        
        ans = func(pi * angle1 / 180)
        ans_simplified = simplify(ans)
        
        question = f"Find the exact value of ${func_name}({angle1}°)$ by writing it as ${func_name}({a1}° {op} {a2}°)$"
        
        return problem(
            question=question,
            answer=ans_simplified,
            difficulty=(1150, 1300),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Write ${func_name}({angle1}°) = {func_name}({a1}° {op} {a2}°)$",
                f"Apply the appropriate {func_name} {'sum' if op == '+' else 'difference'} formula",
                f"Evaluate to get ${latex(ans_simplified)}$"
            ),
        )
    
    else:
        # Verify an identity (simple verification)
        angle_pair = choice([(30, 60), (45, 45), (60, 30)])
        a1, a2 = angle_pair
        
        # Create a simple identity to verify
        lhs_expr = sin(pi * a1 / 180) * cos(pi * a2 / 180) + cos(pi * a1 / 180) * sin(pi * a2 / 180)
        rhs_expr = sin(pi * (a1 + a2) / 180)
        
        lhs_val = simplify(lhs_expr)
        rhs_val = simplify(rhs_expr)
        
        ans = lhs_val.equals(rhs_val)
        
        question = f"Does $\\sin({a1}°)\\cos({a2}°) + \\cos({a1}°)\\sin({a2}°) = \\sin({a1 + a2}°)$?"
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1150),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"The left side matches the sum formula: $\\sin(A + B) = \\sin A \\cos B + \\cos A \\sin B$",
                f"Therefore $\\sin({a1}°)\\cos({a2}°) + \\cos({a1}°)\\sin({a2}°) = \\sin({a1}° + {a2}°) = \\sin({a1 + a2}°)$",
                f"The statement is {ans}"
            ),
        )

emit(generate())