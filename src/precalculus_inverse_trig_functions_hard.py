"""
precalculus - inverse_trig_functions (hard)
Generated: 2026-02-22T04:49:25.626953
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Composition with inverse trig: arcsin(sin(x)) or arccos(cos(x)) with domain restrictions
        func_choice = choice(['sin', 'cos', 'tan'])
        
        if func_choice == 'sin':
            # arcsin(sin(x)) where x is outside [-pi/2, pi/2]
            quadrant = choice([2, 3, 4])
            if quadrant == 2:
                # pi - theta form
                theta_num = randint(1, 5)
                theta_den = choice([6, 4, 3])
                x_expr = pi - Rational(theta_num, theta_den) * pi
                ans = Rational(theta_num, theta_den) * pi
            elif quadrant == 3:
                # -pi - theta form
                theta_num = randint(1, 5)
                theta_den = choice([6, 4, 3])
                x_expr = -pi + Rational(theta_num, theta_den) * pi
                ans = -Rational(theta_num, theta_den) * pi
            else:
                # -theta form in Q4
                theta_num = randint(1, 5)
                theta_den = choice([6, 4, 3])
                x_expr = -Rational(theta_num, theta_den) * pi
                ans = -Rational(theta_num, theta_den) * pi
                
            return problem(
                question=f"Simplify: $\\arcsin\\left(\\sin\\left({latex(x_expr)}\\right)\\right)$",
                answer=ans,
                difficulty=(1600, 1750),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"First evaluate $\\sin\\left({latex(x_expr)}\\right)$",
                    f"The range of $\\arcsin$ is $\\left[-\\frac{{\\pi}}{{2}}, \\frac{{\\pi}}{{2}}\\right]$",
                    f"Find the angle in this range with the same sine value",
                    f"Answer: ${latex(ans)}$"
                )
            )
        
        elif func_choice == 'cos':
            # arccos(cos(x)) where x is outside [0, pi]
            quadrant = choice([3, 4])
            if quadrant == 3:
                theta_num = randint(7, 11)
                theta_den = 6
                x_expr = Rational(theta_num, theta_den) * pi
                ans = (2 - Rational(theta_num, theta_den)) * pi
            else:
                theta_num = randint(1, 5)
                theta_den = choice([6, 4, 3])
                x_expr = -Rational(theta_num, theta_den) * pi
                ans = Rational(theta_num, theta_den) * pi
                
            return problem(
                question=f"Simplify: $\\arccos\\left(\\cos\\left({latex(x_expr)}\\right)\\right)$",
                answer=ans,
                difficulty=(1600, 1750),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"The range of $\\arccos$ is $[0, \\pi]$",
                    f"Find the angle in $[0, \\pi]$ with the same cosine value as ${latex(x_expr)}$",
                    f"Answer: ${latex(ans)}$"
                )
            )
    
    elif problem_type == 2:
        # Solve equation with inverse trig: arcsin(2x-1) = pi/6
        func = choice(['arcsin', 'arccos', 'arctan'])
        
        if func == 'arcsin':
            # arcsin(ax + b) = theta
            theta_vals = [pi/6, pi/4, pi/3, -pi/6, -pi/4, -pi/3]
            theta = choice(theta_vals)
            sin_val = sin(theta)
            
            a_val = choice([2, 3, 4])
            b_val = nonzero(-3, 3)
            
            # ax + b = sin_val
            ans = (sin_val - b_val) / a_val
            
            return problem(
                question=f"Solve for $x$: $\\arcsin({a_val}x {'+' if b_val > 0 else ''}{b_val if b_val != 0 else ''}) = {latex(theta)}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Take sine of both sides: ${a_val}x {'+' if b_val > 0 else ''}{b_val if b_val != 0 else ''} = \\sin\\left({latex(theta)}\\right)$",
                    f"${a_val}x {'+' if b_val > 0 else ''}{b_val if b_val != 0 else ''} = {latex(sin_val)}$",
                    f"${a_val}x = {latex(sin_val - b_val)}$",
                    f"$x = {latex(ans)}$"
                )
            )
        
        elif func == 'arctan':
            # arctan(ax) = theta
            theta_vals = [pi/6, pi/4, pi/3, -pi/6, -pi/4]
            theta = choice(theta_vals)
            tan_val = tan(theta)
            
            a_val = choice([2, 3])
            ans = tan_val / a_val
            
            return problem(
                question=f"Solve for $x$: $\\arctan({a_val}x) = {latex(theta)}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Take tangent of both sides: ${a_val}x = \\tan\\left({latex(theta)}\\right)$",
                    f"${a_val}x = {latex(tan_val)}$",
                    f"$x = {latex(ans)}$"
                )
            )
    
    elif problem_type == 3:
        # Exact value: arcsin(sqrt(3)/2) + arccos(1/2)
        vals_sin = [(Rational(1,2), pi/6), (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/3), 
                    (-Rational(1,2), -pi/6), (-sqrt(2)/2, -pi/4)]
        vals_cos = [(Rational(1,2), pi/3), (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/6)]
        
        val1, theta1 = choice(vals_sin)
        val2, theta2 = choice(vals_cos)
        
        ans = theta1 + theta2
        
        return problem(
            question=f"Find the exact value: $\\arcsin\\left({latex(val1)}\\right) + \\arccos\\left({latex(val2)}\\right)$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"$\\arcsin\\left({latex(val1)}\\right) = {latex(theta1)}$",
                f"$\\arccos\\left({latex(val2)}\\right) = {latex(theta2)}$",
                f"${latex(theta1)} + {latex(theta2)} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Find sin(arctan(x)) type composition
        composition_type = choice(['sin_arctan', 'cos_arctan', 'tan_arcsin', 'sec_arcsin'])
        
        if composition_type == 'sin_arctan':
            # sin(arctan(a/b)) = a/sqrt(a^2 + b^2)
            a_val = randint(3, 12)
            b_val = randint(3, 12)
            while gcd(a_val, b_val) > 1:
                b_val = randint(3, 12)
            
            ans = Rational(a_val, sqrt(a_val**2 + b_val**2))
            
            return problem(
                question=f"Simplify: $\\sin\\left(\\arctan\\left(\\frac{{{a_val}}}{{{b_val}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arctan\\left(\\frac{{{a_val}}}{{{b_val}}}\\right)$, so $\\tan\\theta = \\frac{{{a_val}}}{{{b_val}}}$",
                    f"Draw a right triangle with opposite = ${a_val}$, adjacent = ${b_val}$",
                    f"Hypotenuse = $\\sqrt{{{a_val}^2 + {b_val}^2}} = {latex(sqrt(a_val**2 + b_val**2))}$",
                    f"$\\sin\\theta = \\frac{{{a_val}}}{{{latex(sqrt(a_val**2 + b_val**2))}}}$",
                    f"Rationalize: ${latex(ans)}$"
                ),
                calculator="scientific"
            )
        
        elif composition_type == 'cos_arctan':
            # cos(arctan(a/b)) = b/sqrt(a^2 + b^2)
            a_val = randint(3, 12)
            b_val = randint(3, 12)
            while gcd(a_val, b_val) > 1:
                b_val = randint(3, 12)
            
            ans = Rational(b_val, sqrt(a_val**2 + b_val**2))
            
            return problem(
                question=f"Simplify: $\\cos\\left(\\arctan\\left(\\frac{{{a_val}}}{{{b_val}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arctan\\left(\\frac{{{a_val}}}{{{b_val}}}\\right)$, so $\\tan\\theta = \\frac{{{a_val}}}{{{b_val}}}$",
                    f"Draw a right triangle with opposite = ${a_val}$, adjacent = ${b_val}$",
                    f"Hypotenuse = $\\sqrt{{{a_val}^2 + {b_val}^2}} = {latex(sqrt(a_val**2 + b_val**2))}$",
                    f"$\\cos\\theta = \\frac{{{b_val}}}{{{latex(sqrt(a_val**2 + b_val**2))}}}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )
        
        elif composition_type == 'tan_arcsin':
            # tan(arcsin(a/b)) = a/sqrt(b^2 - a^2)
            b_val = randint(5, 13)
            a_val = randint(3, b_val - 1)
            while gcd(a_val, b_val) > 1:
                a_val = randint(3, b_val - 1)
            
            ans = Rational(a_val, sqrt(b_val**2 - a_val**2))
            
            return problem(
                question=f"Simplify: $\\tan\\left(\\arcsin\\left(\\frac{{{a_val}}}{{{b_val}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arcsin\\left(\\frac{{{a_val}}}{{{b_val}}}\\right)$, so $\\sin\\theta = \\frac{{{a_val}}}{{{b_val}}}$",
                    f"Draw a right triangle with opposite = ${a_val}$, hypotenuse = ${b_val}$",
                    f"Adjacent = $\\sqrt{{{b_val}^2 - {a_val}^2}} = {latex(sqrt(b_val**2 - a_val**2))}$",
                    f"$\\tan\\theta = \\frac{{{a_val}}}{{{latex(sqrt(b_val**2 - a_val**2))}}}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 5:
        # Derivative of inverse trig function
        deriv_type = choice(['arcsin_poly', 'arctan_poly', 'arccos_chain'])
        
        if deriv_type == 'arcsin_poly':
            # d/dx[arcsin(ax + b)]
            a_val = nonzero(-5, 5)
            b_val = nonzero(-3, 3)
            
            inner = a_val * x + b_val
            expr = asin(inner)
            ans = diff(expr, x)
            
            return problem(
                question=f"Find $\\frac{{d}}{{dx}}\\left[\\arcsin({latex(inner)})\\right]$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Use chain rule: $\\frac{{d}}{{dx}}[\\arcsin(u)] = \\frac{{1}}{{\\sqrt{{1-u^2}}}} \\cdot \\frac{{du}}{{dx}}$",
                    f"Here $u = {latex(inner)}$, so $\\frac{{du}}{{dx}} = {a_val}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )
        
        elif deriv_type == 'arctan_poly':
            # d/dx[arctan(x^2)]
            power = choice([2, 3])
            expr = atan(x**power)
            ans = simplify(diff(expr, x))
            
            return problem(
                question=f"Find $\\frac{{d}}{{dx}}\\left[\\arctan(x^{{{power}}})\\right]$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Use chain rule: $\\frac{{d}}{{dx}}[\\arctan(u)] = \\frac{{1}}{{1+u^2}} \\cdot \\frac{{du}}{{dx}}$",
                    f"Here $u = x^{{{power}}}$, so $\\frac{{du}}{{dx}} = {power}x^{{{power-1}}}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )
    
    else:
        # Complex equation: arcsin(x) + arccos(x) = pi/2 verification or similar
        # Or: prove sin(arctan(x) + arctan(y)) formula
        
        # arctan(x) + arctan(y) = arctan((x+y)/(1-xy)) for xy < 1
        x_val = Rational(randint(1