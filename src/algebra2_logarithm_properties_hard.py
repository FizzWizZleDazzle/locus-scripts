"""
algebra2 - logarithm_properties (hard)
Generated: 2026-02-22T04:31:54.116186
"""

from problem_utils import *

def generate():
    problem_type = choice([
        'expand_logs',
        'condense_logs', 
        'solve_log_equation',
        'change_of_base',
        'mixed_properties',
        'exponential_form'
    ])
    
    if problem_type == 'expand_logs':
        # Expand complex logarithmic expressions
        base = choice([2, 3, 5, 10])
        p1 = randint(2, 4)
        p2 = randint(2, 4)
        p3 = randint(2, 4)
        coeff = randint(2, 4)
        
        if choice([True, False]):
            # Type: log_b((x^p1 * y^p2) / z^p3)
            expr_inside = (x**p1 * y**p2) / z**p3
            if base == 10:
                expr_str = f"\\log\\left(\\frac{{{latex(x**p1 * y**p2)}}}{{{latex(z**p3)}}}\\right)"
                ans = p1*log(x, 10) + p2*log(y, 10) - p3*log(z, 10)
                ans_str = f"{p1}\\log(x) + {p2}\\log(y) - {p3}\\log(z)"
            else:
                expr_str = f"\\log_{{{base}}}\\left(\\frac{{{latex(x**p1 * y**p2)}}}{{{latex(z**p3)}}}\\right)"
                ans = p1*log(x, base) + p2*log(y, base) - p3*log(z, base)
                ans_str = f"{p1}\\log_{{{base}}}(x) + {p2}\\log_{{{base}}}(y) - {p3}\\log_{{{base}}}(z)"
            
            return problem(
                question=f"Expand using logarithm properties: ${expr_str}$",
                answer=ans,
                difficulty=(1600, 1750),
                topic="algebra2/logarithm_properties",
                solution=steps(
                    f"Apply quotient rule: $\\log_b\\left(\\frac{{A}}{{B}}\\right) = \\log_b(A) - \\log_b(B)$",
                    f"Apply product rule to numerator: $\\log_b(xy) = \\log_b(x) + \\log_b(y)$",
                    f"Apply power rule: $\\log_b(x^n) = n\\log_b(x)$",
                    f"${ans_str}$"
                )
            )
        else:
            # Type: log_b(x^p1 * sqrt[p2](y) / z^p3)
            if base == 10:
                expr_str = f"\\log\\left(\\frac{{x^{{{p1}}} \\cdot \\sqrt[{p2}]{{y}}}}{{z^{{{p3}}}}}\\right)"
                ans = p1*log(x, 10) + log(y, 10)/p2 - p3*log(z, 10)
                ans_str = f"{p1}\\log(x) + \\frac{{1}}{{{p2}}}\\log(y) - {p3}\\log(z)"
            else:
                expr_str = f"\\log_{{{base}}}\\left(\\frac{{x^{{{p1}}} \\cdot \\sqrt[{p2}]{{y}}}}{{z^{{{p3}}}}}\\right)"
                ans = p1*log(x, base) + log(y, base)/p2 - p3*log(z, base)
                ans_str = f"{p1}\\log_{{{base}}}(x) + \\frac{{1}}{{{p2}}}\\log_{{{base}}}(y) - {p3}\\log_{{{base}}}(z)"
            
            return problem(
                question=f"Expand using logarithm properties: ${expr_str}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="algebra2/logarithm_properties",
                solution=steps(
                    f"Rewrite root as fractional exponent: $\\sqrt[{p2}]{{y}} = y^{{1/{p2}}}$",
                    f"Apply quotient and product rules",
                    f"Apply power rule: $\\log_b(x^n) = n\\log_b(x)$",
                    f"${ans_str}$"
                )
            )
    
    elif problem_type == 'condense_logs':
        # Condense multiple logarithms into one
        base = choice([2, 3, 5, 10])
        c1 = randint(2, 5)
        c2 = randint(2, 5)
        c3 = randint(2, 5)
        
        if base == 10:
            question_str = f"{c1}\\log(x) + {c2}\\log(y) - {c3}\\log(z)"
            ans = log(x**c1 * y**c2 / z**c3, 10)
            ans_str = f"\\log\\left(\\frac{{x^{{{c1}}} y^{{{c2}}}}}{{z^{{{c3}}}}}\\right)"
        else:
            question_str = f"{c1}\\log_{{{base}}}(x) + {c2}\\log_{{{base}}}(y) - {c3}\\log_{{{base}}}(z)"
            ans = log(x**c1 * y**c2 / z**c3, base)
            ans_str = f"\\log_{{{base}}}\\left(\\frac{{x^{{{c1}}} y^{{{c2}}}}}{{z^{{{c3}}}}}\\right)"
        
        return problem(
            question=f"Write as a single logarithm: ${question_str}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply power rule: $n\\log_b(x) = \\log_b(x^n)$",
                f"Apply product rule: $\\log_b(x) + \\log_b(y) = \\log_b(xy)$",
                f"Apply quotient rule: $\\log_b(x) - \\log_b(y) = \\log_b(x/y)$",
                f"${ans_str}$"
            )
        )
    
    elif problem_type == 'solve_log_equation':
        # Solve equations using logarithm properties
        base = choice([2, 3, 4, 5])
        if choice([True, False]):
            # Type: log_b(x) + log_b(x-a) = log_b(c)
            a_val = randint(2, 5)
            # Want x(x-a) = c with nice solution
            # Let x = a_val + b_val
            b_val = randint(2, 6)
            x_sol = a_val + b_val
            c_val = x_sol * (x_sol - a_val)
            
            if base == 2:
                question_str = f"\\log_2(x) + \\log_2(x - {a_val}) = \\log_2({c_val})"
            else:
                question_str = f"\\log_{{{base}}}(x) + \\log_{{{base}}}(x - {a_val}) = \\log_{{{base}}}({c_val})"
            
            ans = x_sol
            
            return problem(
                question=f"Solve for $x$: ${question_str}$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="algebra2/logarithm_properties",
                solution=steps(
                    f"Apply product rule: $\\log_b(A) + \\log_b(B) = \\log_b(AB)$",
                    f"$\\log_{{{base}}}(x(x - {a_val})) = \\log_{{{base}}}({c_val})$",
                    f"Since logs are equal, arguments are equal: $x(x - {a_val}) = {c_val}$",
                    f"$x^2 - {a_val}x - {c_val} = 0$",
                    f"Solving: $x = {x_sol}$ (rejecting negative solution)",
                    f"$x = {x_sol}$"
                )
            )
        else:
            # Type: log_b(x+a) - log_b(x-b) = c
            result = choice([2, 3, 4])
            numerator_add = randint(3, 8)
            denominator_sub = randint(1, 3)
            # Want (x+a)/(x-b) = base^c
            # Pick x that makes this work
            x_val = randint(denominator_sub + 2, 10)
            needed_ratio = base**result
            # (x+a)/(x-b) = needed_ratio
            # x + a = needed_ratio * (x - b)
            # a = needed_ratio * x - needed_ratio * b - x
            # a = x(needed_ratio - 1) - needed_ratio * b
            a_val = needed_ratio * (x_val - denominator_sub) - x_val
            
            if a_val > 0 and a_val < 20:
                ans = x_val
                question_str = f"\\log_{{{base}}}(x + {a_val}) - \\log_{{{base}}}(x - {denominator_sub}) = {result}"
                
                return problem(
                    question=f"Solve for $x$: ${question_str}$",
                    answer=ans,
                    difficulty=(1750, 1900),
                    topic="algebra2/logarithm_properties",
                    solution=steps(
                        f"Apply quotient rule: $\\log_b(A) - \\log_b(B) = \\log_b(A/B)$",
                        f"$\\log_{{{base}}}\\left(\\frac{{x + {a_val}}}{{x - {denominator_sub}}}\\right) = {result}$",
                        f"Convert to exponential form: $\\frac{{x + {a_val}}}{{x - {denominator_sub}}} = {base}^{{{result}}} = {base**result}$",
                        f"$x + {a_val} = {base**result}(x - {denominator_sub})$",
                        f"Solving: $x = {x_val}$"
                    )
                )
            else:
                # Fallback to simpler problem
                a_val = randint(3, 8)
                b_val = randint(1, 3)
                x_sol = randint(b_val + 2, 12)
                ratio = (x_sol + a_val) / (x_sol - b_val)
                if abs(log(ratio, base) - round(log(ratio, base))) < 0.01:
                    result = round(log(ratio, base))
                else:
                    result = 2
                    x_sol = base**2 * b_val + a_val - base**2 + 1
                
                question_str = f"\\log_{{{base}}}(x + {a_val}) - \\log_{{{base}}}(x - {b_val}) = {result}"
                ans = x_sol
                
                return problem(
                    question=f"Solve for $x$: ${question_str}$",
                    answer=ans,
                    difficulty=(1750, 1900),
                    topic="algebra2/logarithm_properties",
                    solution=steps(
                        f"Apply quotient rule",
                        f"Convert to exponential form",
                        f"Solve the resulting equation",
                        f"$x = {x_sol}$"
                    )
                )
    
    elif problem_type == 'change_of_base':
        # Change of base formula problems
        old_base = choice([2, 3, 5, 7])
        new_base = choice([b for b in [2, 3, 5, 7, 10] if b != old_base])
        arg = randint(3, 20)
        
        question_str = f"\\log_{{{old_base}}}({arg})"
        if new_base == 10:
            ans_str = f"\\frac{{\\log({arg})}}{{\\log({old_base})}}"
            ans = log(arg, old_base)
        else:
            ans_str = f"\\frac{{\\log_{{{new_base}}}({arg})}}{{\\log_{{{new_base}}}({old_base})}}"
            ans = log(arg, old_base)
        
        return problem(
            question=f"Use the change of base formula to rewrite $\\displaystyle {question_str}$ using base ${new_base}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply change of base formula: $\\log_b(x) = \\frac{{\\log_c(x)}}{{\\log_c(b)}}$",
                f"${ans_str}$"
            )
        )
    
    elif problem_type == 'mixed_properties':
        # Complex problems requiring multiple properties
        base = choice([2, 3, 5])
        p1 = randint(2, 4)
        p2 = randint(2, 4)
        
        # Simplify log_b(b^p1 * x^p2)
        if base == 2:
            question_str = f"\\log_2(2^{{{p1}}} x^{{{p2}}})"
            ans = p1 + p2*log(x, 2)
            ans_str = f"{p1} + {p2}\\log_2(x)"
        else:
            question_str = f"\\log_{{{base}}}({base}^{{{p1}}} x^{{{p2}}})"
            ans = p1 + p2*log(x, base)
            ans_str = f"{p1} + {p2}\\log_{{{base}}}(x)"
        
        return problem(
            question=f"Simplify: ${question_str}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra2/logarithm_properties",
            solution=steps(
                f"Apply product rule: $\\log_b(AB) = \\log_b(A) + \\log_b(B)$",
                f"$\\log_{{{base}}}({base}^{{{p1}}}) + \\log_{{{base}}}(x^{{{p2}}})$",
                f"Use $\\log_b(b^n) = n$ and power rule",
                f"${ans_str}$"
            )
        )
    
    else:  # exponential_form
        # Convert between logarithmic and exponential forms with algebra
        base = choice([2, 3, 4, 5])
        result = randint(3, 5)
        coeff = randint(2, 4)
        const = randint(1, 5)
        
        # Solve: log_b(coeff*x + const) = result
        # coeff*x + const = base^result
        # x = (base^result - const) / coeff
        x_sol = (base**result - const) / coeff
        
        if x_sol == int(x_sol) and x_sol > 0:
            x_sol = int(x