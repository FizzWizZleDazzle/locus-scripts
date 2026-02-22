"""
algebra2 - logarithmic_equations (medium)
Generated: 2026-02-22T04:32:40.054385
"""

from problem_utils import *

def generate():
    problem_type = choice(['basic_log', 'exponential_form', 'combining_logs', 'log_both_sides'])
    
    if problem_type == 'basic_log':
        # Solve log_b(x) = c where answer is a clean integer or simple power
        base = choice([2, 3, 4, 5, 10])
        power = randint(2, 4)
        answer_val = base ** power
        
        question = f"\\log_{{{base}}}(x) = {power}"
        ans = answer_val
        
        solution = steps(
            f"Convert logarithmic equation to exponential form",
            f"$x = {base}^{{{power}}}$",
            f"$x = {answer_val}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1350),
            topic="algebra2/logarithmic_equations",
            solution=solution
        )
    
    elif problem_type == 'exponential_form':
        # Solve log(ax + b) = c where log is base 10
        a_val = nonzero(-3, 3)
        b_val = nonzero(-10, 10)
        c_val = randint(1, 2)
        
        # Answer: x = (10^c - b) / a
        answer_val = (10**c_val - b_val) / a_val
        
        # Only use if answer is an integer
        if answer_val != int(answer_val):
            a_val = 1
            answer_val = 10**c_val - b_val
        
        answer_val = int(answer_val)
        
        if a_val == 1:
            expr_str = f"x + {b_val}" if b_val > 0 else f"x - {-b_val}"
        else:
            if b_val >= 0:
                expr_str = f"{a_val}x + {b_val}"
            else:
                expr_str = f"{a_val}x - {-b_val}"
        
        question = f"\\log({expr_str}) = {c_val}"
        ans = answer_val
        
        solution_steps = [
            f"Convert to exponential form: ${expr_str} = 10^{{{c_val}}}$",
            f"${expr_str} = {10**c_val}$"
        ]
        
        if a_val == 1:
            solution_steps.append(f"$x = {10**c_val} - {b_val}$" if b_val > 0 else f"$x = {10**c_val} + {-b_val}$")
        else:
            solution_steps.append(f"${a_val}x = {10**c_val - b_val}$")
            solution_steps.append(f"$x = {answer_val}$")
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1450),
            topic="algebra2/logarithmic_equations",
            solution=steps(*solution_steps)
        )
    
    elif problem_type == 'combining_logs':
        # log(x) + log(something) = c or log(x) - log(something) = c
        use_addition = choice([True, False])
        
        if use_addition:
            # log(x) + log(k) = c, so log(kx) = c, so kx = 10^c
            k_val = choice([2, 3, 4, 5])
            c_val = randint(1, 2)
            answer_val = (10**c_val) // k_val
            
            # Make sure it divides evenly
            answer_val = (10**c_val) // k_val
            if (10**c_val) % k_val != 0:
                k_val = choice([2, 5])
                if k_val == 2:
                    c_val = randint(1, 2)
                    answer_val = (10**c_val) // 2
                else:
                    c_val = randint(1, 2)
                    answer_val = (10**c_val) // 5
            
            question = f"\\log(x) + \\log({k_val}) = {c_val}"
            ans = answer_val
            
            solution = steps(
                f"Use the product rule: $\\log(x \\cdot {k_val}) = {c_val}$",
                f"Convert to exponential form: ${k_val}x = 10^{{{c_val}}}$",
                f"${k_val}x = {10**c_val}$",
                f"$x = {answer_val}$"
            )
        else:
            # log(x) - log(k) = c, so log(x/k) = c, so x/k = 10^c
            k_val = choice([2, 5, 10])
            c_val = randint(1, 2)
            answer_val = k_val * (10**c_val)
            
            question = f"\\log(x) - \\log({k_val}) = {c_val}"
            ans = answer_val
            
            solution = steps(
                f"Use the quotient rule: $\\log\\left(\\frac{{x}}{{{k_val}}}\\right) = {c_val}$",
                f"Convert to exponential form: $\\frac{{x}}{{{k_val}}} = 10^{{{c_val}}}$",
                f"$x = {k_val} \\cdot {10**c_val}$",
                f"$x = {answer_val}$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1550),
            topic="algebra2/logarithmic_equations",
            solution=solution
        )
    
    else:  # log_both_sides
        # Equation like 2^x = 16 or 3^(x+1) = 27
        base = choice([2, 3, 5])
        power_type = choice(['simple', 'linear'])
        
        if power_type == 'simple':
            # b^x = b^k, answer is k
            k_val = randint(2, 4)
            rhs = base ** k_val
            
            question = f"{base}^x = {rhs}"
            ans = k_val
            
            solution = steps(
                f"Take $\\log_{{{base}}}$ of both sides",
                f"$x = \\log_{{{base}}}({rhs})$",
                f"$x = \\log_{{{base}}}({base}^{{{k_val}}})$",
                f"$x = {k_val}$"
            )
        else:
            # b^(x+c) = b^k, answer is k-c
            c_val = nonzero(-2, 2)
            k_val = randint(2, 4)
            rhs = base ** k_val
            answer_val = k_val - c_val
            
            if c_val > 0:
                exp_str = f"x + {c_val}"
            else:
                exp_str = f"x - {-c_val}"
            
            question = f"{base}^{{{exp_str}}} = {rhs}"
            ans = answer_val
            
            solution = steps(
                f"Take $\\log_{{{base}}}$ of both sides",
                f"${exp_str} = \\log_{{{base}}}({rhs})$",
                f"${exp_str} = {k_val}$",
                f"$x = {answer_val}$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1350, 1500),
            topic="algebra2/logarithmic_equations",
            solution=solution
        )

emit(generate())