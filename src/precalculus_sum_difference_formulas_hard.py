"""
precalculus - sum_difference_formulas (hard)
Generated: 2026-02-22T04:47:39.523367
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplify expressions using sum/difference formulas with multiple angles
        angle1_num = choice([1, 2, 3, 4, 5, 6])
        angle2_num = choice([1, 2, 3, 4, 5, 6])
        if angle1_num == angle2_num:
            angle2_num = (angle2_num + 1) % 6 + 1
        
        angle1_denom = choice([3, 4, 6, 12])
        angle2_denom = choice([3, 4, 6, 12])
        
        func_type = choice(['sin', 'cos', 'tan'])
        operation = choice(['+', '-'])
        
        if func_type == 'sin':
            question = f"\\sin\\left(\\frac{{{angle1_num}\\pi}}{{{angle1_denom}}}\\right)\\{operation}\\sin\\left(\\frac{{{angle2_num}\\pi}}{{{angle2_denom}}}\\right)"
            expr = sin(angle1_num*pi/angle1_denom) + sin(angle2_num*pi/angle2_denom) if operation == '+' else sin(angle1_num*pi/angle1_denom) - sin(angle2_num*pi/angle2_denom)
        elif func_type == 'cos':
            question = f"\\cos\\left(\\frac{{{angle1_num}\\pi}}{{{angle1_denom}}}\\right){operation}\\cos\\left(\\frac{{{angle2_num}\\pi}}{{{angle2_denom}}}\\right)"
            expr = cos(angle1_num*pi/angle1_denom) + cos(angle2_num*pi/angle2_denom) if operation == '+' else cos(angle1_num*pi/angle1_denom) - cos(angle2_num*pi/angle2_denom)
        else:
            question = f"\\tan\\left(\\frac{{{angle1_num}\\pi}}{{{angle1_denom}}}\\right){operation}\\tan\\left(\\frac{{{angle2_num}\\pi}}{{{angle2_denom}}}\\right)"
            expr = tan(angle1_num*pi/angle1_denom) + tan(angle2_num*pi/angle2_denom) if operation == '+' else tan(angle1_num*pi/angle1_denom) - tan(angle2_num*pi/angle2_denom)
        
        ans = simplify(expr)
        
        return problem(
            question=f"Simplify: ${question}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Evaluate each trigonometric value using exact values",
                f"Combine the results: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Prove identity or solve equation using sum/difference formulas
        angle_multiple = choice([2, 3, 4])
        base_angle = choice(['x', 'theta'])
        
        if base_angle == 'x':
            var = x
            var_str = 'x'
        else:
            var = symbols('theta')
            var_str = '\\theta'
        
        func = choice(['sin', 'cos'])
        
        if func == 'sin':
            # sin(A+B) or sin(A-B) expansion
            coeff1 = nonzero(-3, 3)
            coeff2 = nonzero(-3, 3)
            
            if choice([True, False]):
                # sin(x + pi/4) type
                angle_add = choice([pi/6, pi/4, pi/3, pi/2])
                lhs = sin(var + angle_add)
                expanded = expand_trig(lhs)
                
                question = f"Expand using sum formulas: $\\sin\\left({var_str} + {latex(angle_add)}\\right)$"
                ans = expanded
                
                sol_text = f"Use $\\sin(A + B) = \\sin A \\cos B + \\cos A \\sin B$"
                sol_steps = steps(
                    sol_text,
                    f"$\\sin\\left({var_str} + {latex(angle_add)}\\right) = \\sin {var_str} \\cos {latex(angle_add)} + \\cos {var_str} \\sin {latex(angle_add)}$",
                    f"${latex(ans)}$"
                )
            else:
                # sin(x - pi/3) type
                angle_sub = choice([pi/6, pi/4, pi/3, pi/2])
                lhs = sin(var - angle_sub)
                expanded = expand_trig(lhs)
                
                question = f"Expand using difference formulas: $\\sin\\left({var_str} - {latex(angle_sub)}\\right)$"
                ans = expanded
                
                sol_text = f"Use $\\sin(A - B) = \\sin A \\cos B - \\cos A \\sin B$"
                sol_steps = steps(
                    sol_text,
                    f"$\\sin\\left({var_str} - {latex(angle_sub)}\\right) = \\sin {var_str} \\cos {latex(angle_sub)} - \\cos {var_str} \\sin {latex(angle_sub)}$",
                    f"${latex(ans)}$"
                )
        else:
            # cos(A+B) or cos(A-B) expansion
            if choice([True, False]):
                angle_add = choice([pi/6, pi/4, pi/3, pi/2])
                lhs = cos(var + angle_add)
                expanded = expand_trig(lhs)
                
                question = f"Expand using sum formulas: $\\cos\\left({var_str} + {latex(angle_add)}\\right)$"
                ans = expanded
                
                sol_text = f"Use $\\cos(A + B) = \\cos A \\cos B - \\sin A \\sin B$"
                sol_steps = steps(
                    sol_text,
                    f"$\\cos\\left({var_str} + {latex(angle_add)}\\right) = \\cos {var_str} \\cos {latex(angle_add)} - \\sin {var_str} \\sin {latex(angle_add)}$",
                    f"${latex(ans)}$"
                )
            else:
                angle_sub = choice([pi/6, pi/4, pi/3, pi/2])
                lhs = cos(var - angle_sub)
                expanded = expand_trig(lhs)
                
                question = f"Expand using difference formulas: $\\cos\\left({var_str} - {latex(angle_sub)}\\right)$"
                ans = expanded
                
                sol_text = f"Use $\\cos(A - B) = \\cos A \\cos B + \\sin A \\sin B$"
                sol_steps = steps(
                    sol_text,
                    f"$\\cos\\left({var_str} - {latex(angle_sub)}\\right) = \\cos {var_str} \\cos {latex(angle_sub)} + \\sin {var_str} \\sin {latex(angle_sub)}$",
                    f"${latex(ans)}$"
                )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="precalculus/sum_difference_formulas",
            solution=sol_steps,
        )
    
    elif problem_type == 3:
        # Express as single trig function using sum/difference formulas
        # Given asin(x)cos(y) + bcos(x)sin(y), express as sin(x±y)
        
        angle1_num = choice([1, 2, 3, 5, 7])
        angle2_num = choice([1, 2, 3, 5, 7])
        denom = choice([12, 24])
        
        operation = choice(['+', '-'])
        
        if operation == '+':
            result_angle = (angle1_num + angle2_num) * pi / denom
            expr_str = f"\\sin\\left(\\frac{{{angle1_num}\\pi}}{{{denom}}}\\right)\\cos\\left(\\frac{{{angle2_num}\\pi}}{{{denom}}}\\right) + \\cos\\left(\\frac{{{angle1_num}\\pi}}{{{denom}}}\\right)\\sin\\left(\\frac{{{angle2_num}\\pi}}{{{denom}}}\\right)"
            ans = sin(result_angle)
            
            question = f"Express as a single trigonometric function: ${expr_str}$"
            
            sol_steps = steps(
                f"Recognize the sum formula: $\\sin(A + B) = \\sin A \\cos B + \\cos A \\sin B$",
                f"Here $A = \\frac{{{angle1_num}\\pi}}{{{denom}}}$ and $B = \\frac{{{angle2_num}\\pi}}{{{denom}}}$",
                f"Therefore the expression equals $\\sin\\left(\\frac{{{angle1_num}\\pi}}{{{denom}}} + \\frac{{{angle2_num}\\pi}}{{{denom}}}\\right) = \\sin\\left(\\frac{{{angle1_num + angle2_num}\\pi}}{{{denom}}}\\right)$",
                f"Simplified: ${latex(simplify(ans))}$"
            )
        else:
            result_angle = (angle1_num - angle2_num) * pi / denom
            expr_str = f"\\sin\\left(\\frac{{{angle1_num}\\pi}}{{{denom}}}\\right)\\cos\\left(\\frac{{{angle2_num}\\pi}}{{{denom}}}\\right) - \\cos\\left(\\frac{{{angle1_num}\\pi}}{{{denom}}}\\right)\\sin\\left(\\frac{{{angle2_num}\\pi}}{{{denom}}}\\right)"
            ans = sin(result_angle)
            
            question = f"Express as a single trigonometric function: ${expr_str}$"
            
            sol_steps = steps(
                f"Recognize the difference formula: $\\sin(A - B) = \\sin A \\cos B - \\cos A \\sin B$",
                f"Here $A = \\frac{{{angle1_num}\\pi}}{{{denom}}}$ and $B = \\frac{{{angle2_num}\\pi}}{{{denom}}}$",
                f"Therefore the expression equals $\\sin\\left(\\frac{{{angle1_num}\\pi}}{{{denom}}} - \\frac{{{angle2_num}\\pi}}{{{denom}}}\\right) = \\sin\\left(\\frac{{{angle1_num - angle2_num}\\pi}}{{{denom}}}\\right)$",
                f"Simplified: ${latex(simplify(ans))}$"
            )
        
        return problem(
            question=question,
            answer=simplify(ans),
            difficulty=(1700, 1850),
            topic="precalculus/sum_difference_formulas",
            solution=sol_steps,
        )
    
    elif problem_type == 4:
        # Solve equation using sum/difference formulas
        angle_const = choice([pi/6, pi/4, pi/3])
        operation = choice(['+', '-'])
        
        target_val = choice([Rational(1, 2), sqrt(2)/2, sqrt(3)/2, 0])
        
        if operation == '+':
            equation = Eq(sin(x + angle_const), target_val)
            
            # Find solutions in [0, 2π)
            sols_full = solve(equation, x)
            sols = [s for s in sols_full if s.is_real]
            
            question = f"Solve for $x$ in $[0, 2\\pi)$: $\\sin\\left(x + {latex(angle_const)}\\right) = {latex(target_val)}$"
            
            if len(sols) > 0:
                ans = FiniteSet(*sols)
                sol_steps = steps(
                    f"Let $u = x + {latex(angle_const)}$",
                    f"Solve $\\sin u = {latex(target_val)}$",
                    f"Find all solutions and subtract ${latex(angle_const)}$ to get $x$",
                    f"Solutions in $[0, 2\\pi)$: ${latex(ans)}$"
                )
            else:
                ans = FiniteSet()
                sol_steps = "No solutions in the given interval"
        else:
            equation = Eq(cos(x - angle_const), target_val)
            
            sols_full = solve(equation, x)
            sols = [s for s in sols_full if s.is_real]
            
            question = f"Solve for $x$ in $[0, 2\\pi)$: $\\cos\\left(x - {latex(angle_const)}\\right) = {latex(target_val)}$"
            
            if len(sols) > 0:
                ans = FiniteSet(*sols)
                sol_steps = steps(
                    f"Let $u = x - {latex(angle_const)}$",
                    f"Solve $\\cos u = {latex(target_val)}$",
                    f"Find all solutions and add ${latex(angle_const)}$ to get $x$",
                    f"Solutions in $[0, 2\\pi)$: ${latex(ans)}$"
                )
            else:
                ans = FiniteSet()
                sol_steps = "No solutions in the given interval"
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1900),
            topic="precalculus/sum_difference_formulas",
            solution=sol_steps,
        )
    
    else:
        # Compute exact value using sum/difference formulas
        # Example: sin(75°) = sin(45° + 30°)
        
        base_angles = [15, 75, 105, 165]
        angle_deg = choice(base_angles)
        
        func = choice(['sin', 'cos', 'tan'])
        
        if angle_deg == 15:
            decomp = "45° - 30°"
            angle1, angle2 = pi/4, pi/6
            op = '-'
        elif angle_deg == 75:
            decomp = "45° + 30°"
            angle1, angle2 = pi/4, pi/6
            op = '+'
        elif angle_deg == 105:
            decomp = "60° + 45°"
            angle1, angle2 = pi/3, pi/4
            op = '+'
        else:  # 165
            decomp = "120° + 45°"
            angle1, angle2 = 2*pi/3, pi/4
            op = '+'
        
        if func == 'sin':
            ans = simplify(sin(angle_deg * pi / 180))
            question = f"Find the exact value: $\\sin({angle_deg}°)$"
            
            if op == '+':
                sol_steps = steps(
                    f"Write ${angle_deg}° = {decomp}$",
                    f"Use $\\sin(A + B) = \\sin A \\cos B + \\cos A \\sin B$",
                    f"$\\sin({angle_deg}°) = \\sin({decomp})$",
                    f"Substitute exact values and simpl