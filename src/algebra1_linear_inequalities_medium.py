"""
algebra1 - linear_inequalities (medium)
Generated: 2026-02-22T03:50:48.076715
"""

from problem_utils import *

def generate():
    problem_type = choice(['one_step', 'two_step', 'compound', 'word_problem'])
    
    if problem_type == 'one_step':
        # 1300-1400: Simple one or two-step inequality
        # ax + b < c or ax + b > c
        a_val = nonzero(-8, 8)
        b_val = randint(-15, 15)
        c_val = randint(-15, 15)
        
        comp = choice(['<', '>', '\\leq', '\\geq'])
        
        # Construct backward from clean answer
        # Want x comp solution_value
        solution_value = Rational(c_val - b_val, a_val)
        
        # Build inequality
        lhs = a_val * x + b_val
        
        # Solve it
        if a_val > 0:
            if comp in ['<', '\\leq']:
                ans_comp = comp
            else:
                ans_comp = comp
        else:
            # Flip inequality when dividing by negative
            if comp == '<':
                ans_comp = '>'
            elif comp == '>':
                ans_comp = '<'
            elif comp == '\\leq':
                ans_comp = '\\geq'
            else:
                ans_comp = '\\leq'
        
        question_str = f"Solve for $x$: ${latex(lhs)} {comp} {c_val}$"
        answer_str = f"x {ans_comp} {latex(solution_value)}"
        
        solution_steps = steps(
            f"Start with: ${latex(lhs)} {comp} {c_val}$",
            f"Subtract ${b_val}$ from both sides: ${latex(a_val*x)} {comp} {c_val - b_val}$",
            f"Divide by ${a_val}$: $x {ans_comp} {latex(solution_value)}$" + (
                f" (inequality flips because we divided by a negative)" if a_val < 0 else ""
            )
        )
        
        return problem(
            question=question_str,
            answer=answer_str,
            difficulty=(1300, 1400),
            topic="algebra1/linear_inequalities",
            solution=solution_steps,
            answer_type="expression"
        )
    
    elif problem_type == 'two_step':
        # 1400-1500: Two-step with parentheses or distribution
        # a(x + b) + c > d
        a_val = nonzero(-5, 5)
        b_val = nonzero(-8, 8)
        c_val = randint(-10, 10)
        d_val = randint(-15, 15)
        
        comp = choice(['<', '>', '\\leq', '\\geq'])
        
        lhs = a_val * (x + b_val) + c_val
        lhs_expanded = expand(lhs)
        
        # Solve: a*x + a*b + c comp d
        # a*x comp d - a*b - c
        # x comp (d - a*b - c) / a
        solution_value = Rational(d_val - a_val*b_val - c_val, a_val)
        
        if a_val > 0:
            ans_comp = comp
        else:
            if comp == '<':
                ans_comp = '>'
            elif comp == '>':
                ans_comp = '<'
            elif comp == '\\leq':
                ans_comp = '\\geq'
            else:
                ans_comp = '\\leq'
        
        question_str = f"Solve for $x$: ${latex(a_val)}({latex(x + b_val)}) + {c_val} {comp} {d_val}$"
        answer_str = f"x {ans_comp} {latex(solution_value)}"
        
        solution_steps = steps(
            f"Distribute: ${latex(lhs_expanded)} {comp} {d_val}$",
            f"Subtract ${c_val}$: ${latex(a_val*x + a_val*b_val)} {comp} {d_val - c_val}$",
            f"Subtract ${a_val*b_val}$: ${latex(a_val*x)} {comp} {d_val - c_val - a_val*b_val}$",
            f"Divide by ${a_val}$: $x {ans_comp} {latex(solution_value)}$" + (
                f" (inequality flips)" if a_val < 0 else ""
            )
        )
        
        return problem(
            question=question_str,
            answer=answer_str,
            difficulty=(1400, 1500),
            topic="algebra1/linear_inequalities",
            solution=solution_steps,
            answer_type="expression"
        )
    
    elif problem_type == 'compound':
        # 1500-1600: Compound inequality a < bx + c < d
        b_val = nonzero(-4, 4)
        c_val = randint(-10, 10)
        
        # Choose clean endpoints
        left_bound = Rational(randint(-8, 2), 1)
        right_bound = Rational(randint(3, 12), 1)
        
        # Compute a and d
        a_val = b_val * left_bound + c_val
        d_val = b_val * right_bound + c_val
        
        # Make sure a < d
        if a_val > d_val:
            a_val, d_val = d_val, a_val
            left_bound, right_bound = right_bound, left_bound
        
        question_str = f"Solve for $x$: ${latex(a_val)} < {latex(b_val*x + c_val)} < {latex(d_val)}$"
        
        if b_val > 0:
            answer_str = f"{latex(left_bound)} < x < {latex(right_bound)}"
            solution_steps = steps(
                f"Start with: ${latex(a_val)} < {latex(b_val*x + c_val)} < {latex(d_val)}$",
                f"Subtract ${c_val}$ from all parts: ${latex(a_val - c_val)} < {latex(b_val*x)} < {latex(d_val - c_val)}$",
                f"Divide all parts by ${b_val}$: ${latex(left_bound)} < x < {latex(right_bound)}$"
            )
        else:
            # Inequality flips
            answer_str = f"{latex(right_bound)} < x < {latex(left_bound)}"
            solution_steps = steps(
                f"Start with: ${latex(a_val)} < {latex(b_val*x + c_val)} < {latex(d_val)}$",
                f"Subtract ${c_val}$ from all parts: ${latex(a_val - c_val)} < {latex(b_val*x)} < {latex(d_val - c_val)}$",
                f"Divide all parts by ${b_val}$ (inequalities flip): ${latex(right_bound)} < x < {latex(left_bound)}$"
            )
        
        return problem(
            question=question_str,
            answer=answer_str,
            difficulty=(1500, 1600),
            topic="algebra1/linear_inequalities",
            solution=solution_steps,
            answer_type="expression"
        )
    
    else:  # word_problem
        # 1500-1600: Word problem requiring setup
        scenarios = [
            {
                'context': 'test_score',
                'var': 'test score',
                'unit': 'points'
            },
            {
                'context': 'budget',
                'var': 'total cost',
                'unit': 'dollars'
            },
            {
                'context': 'time',
                'var': 'hours worked',
                'unit': 'hours'
            }
        ]
        
        scenario = choice(scenarios)
        
        if scenario['context'] == 'test_score':
            current_avg = randint(75, 90)
            desired_avg = randint(current_avg + 1, 95)
            num_tests = randint(3, 5)
            
            # num_tests * current_avg + x >= (num_tests + 1) * desired_avg
            # x >= (num_tests + 1) * desired_avg - num_tests * current_avg
            min_score = (num_tests + 1) * desired_avg - num_tests * current_avg
            
            question_str = f"A student has an average of ${current_avg}$ on ${num_tests}$ tests. What score must they earn on the next test to have an average of at least ${desired_avg}$?"
            answer_str = f"x \\geq {min_score}"
            
            solution_steps = steps(
                f"Total points needed: $({num_tests + 1}) \\times {desired_avg} = {(num_tests + 1) * desired_avg}$",
                f"Points already earned: ${num_tests} \\times {current_avg} = {num_tests * current_avg}$",
                f"Points needed on next test: $x \\geq {(num_tests + 1) * desired_avg} - {num_tests * current_avg}$",
                f"$x \\geq {min_score}$"
            )
            
        elif scenario['context'] == 'budget':
            fixed_cost = randint(20, 50)
            per_item = randint(3, 12)
            budget = randint(80, 150)
            
            # fixed_cost + per_item * x <= budget
            # x <= (budget - fixed_cost) / per_item
            max_items = (budget - fixed_cost) // per_item
            
            question_str = f"A party costs $\\${fixed_cost}$ to rent a venue plus $\\${per_item}$ per person. If the budget is $\\${budget}$, what is the maximum number of people that can attend?"
            answer_str = f"x \\leq {max_items}"
            
            solution_steps = steps(
                f"Set up inequality: ${fixed_cost} + {per_item}x \\leq {budget}$",
                f"Subtract ${fixed_cost}$: ${per_item}x \\leq {budget - fixed_cost}$",
                f"Divide by ${per_item}$: $x \\leq {Rational(budget - fixed_cost, per_item)}$",
                f"Maximum whole number: $x \\leq {max_items}$"
            )
            
        else:  # time
            hourly_rate = randint(12, 25)
            target = randint(300, 600)
            
            # hourly_rate * x >= target
            # x >= target / hourly_rate
            min_hours = Rational(target, hourly_rate)
            
            question_str = f"If you earn $\\${hourly_rate}$ per hour, how many hours must you work to earn at least $\\${target}$?"
            answer_str = f"x \\geq {latex(min_hours)}"
            
            solution_steps = steps(
                f"Set up inequality: ${hourly_rate}x \\geq {target}$",
                f"Divide by ${hourly_rate}$: $x \\geq {latex(min_hours)}$"
            )
        
        return problem(
            question=question_str,
            answer=answer_str,
            difficulty=(1500, 1600),
            topic="algebra1/linear_inequalities",
            solution=solution_steps,
            answer_type="expression"
        )

emit(generate())