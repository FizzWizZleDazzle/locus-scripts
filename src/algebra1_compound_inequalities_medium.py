"""
algebra1 - compound_inequalities (medium)
Generated: 2026-02-22T03:52:13.609327
"""

from problem_utils import *

def generate():
    problem_type = choice(['and', 'or'])
    
    if problem_type == 'and':
        # Generate "and" compound inequality: a < x < b or a ≤ x ≤ b
        use_strict = choice([True, False])
        
        # Pick clean boundary values
        lower = randint(-10, 5)
        upper = lower + randint(3, 8)
        
        # Create coefficient and constant for transformations
        coeff = choice([2, 3, 4, 5])
        const = randint(-8, 8)
        
        # Difficulty based on complexity
        if const == 0 and coeff == 1:
            # Simple: just x between two values
            diff = (1200, 1300)
            if use_strict:
                question = f"${lower} < x < {upper}$"
                answer = fmt_interval(lower, upper, True, True)
                solution_steps = steps(
                    f"The inequality ${lower} < x < {upper}$ means $x$ is between ${lower}$ and ${upper}$ (not including endpoints)",
                    f"Interval notation: $({lower}, {upper})$"
                )
            else:
                question = f"${lower} \\leq x \\leq {upper}$"
                answer = fmt_interval(lower, upper, False, False)
                solution_steps = steps(
                    f"The inequality ${lower} \\leq x \\leq {upper}$ means $x$ is between ${lower}$ and ${upper}$ (including endpoints)",
                    f"Interval notation: $[{lower}, {upper}]$"
                )
        else:
            # More complex: need to solve for x
            diff = (1400, 1600)
            
            # Work backward: if solution is lower < x < upper, then
            # lower < (x - const)/coeff < upper becomes
            # coeff*lower + const < x < coeff*upper + const
            left_bound = coeff * lower + const
            right_bound = coeff * upper + const
            
            if use_strict:
                question = f"${left_bound} < {coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} < {right_bound}$"
                answer = fmt_interval(lower, upper, True, True)
                solution_steps = steps(
                    f"Solve ${left_bound} < {coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} < {right_bound}$",
                    f"Subtract ${const}$ from all parts: ${left_bound - const} < {coeff}x < {right_bound - const}$" if const != 0 else f"We have ${left_bound} < {coeff}x < {right_bound}$",
                    f"Divide all parts by ${coeff}$: ${lower} < x < {upper}$",
                    f"Interval notation: $({lower}, {upper})$"
                )
            else:
                question = f"${left_bound} \\leq {coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} \\leq {right_bound}$"
                answer = fmt_interval(lower, upper, False, False)
                solution_steps = steps(
                    f"Solve ${left_bound} \\leq {coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} \\leq {right_bound}$",
                    f"Subtract ${const}$ from all parts: ${left_bound - const} \\leq {coeff}x \\leq {right_bound - const}$" if const != 0 else f"We have ${left_bound} \\leq {coeff}x \\leq {right_bound}$",
                    f"Divide all parts by ${coeff}$: ${lower} \\leq x \\leq {upper}$",
                    f"Interval notation: $[{lower}, {upper}]$"
                )
        
        question_text = f"Solve the compound inequality and write your answer in interval notation: {question}"
        
    else:  # 'or' type
        # Generate "or" compound inequality: x < a or x > b
        use_strict = choice([True, False])
        
        # Pick clean boundary values (ensure gap between them)
        lower = randint(-8, 0)
        upper = lower + randint(5, 10)
        
        # Create coefficient and constant
        coeff = choice([2, 3, 4, 5])
        const = randint(-8, 8)
        
        if const == 0 and coeff == 1:
            # Simple form
            diff = (1300, 1400)
            if use_strict:
                question = f"$x < {lower}$ or $x > {upper}$"
                answer = f"union:{{interval:{{open:{lower},neg_inf:true}}}},{{interval:{{open:{upper},pos_inf:true}}}}"
                solution_steps = steps(
                    f"The inequality $x < {lower}$ or $x > {upper}$ represents all values less than ${lower}$ or greater than ${upper}$",
                    f"Interval notation: $(-\\infty, {lower}) \\cup ({upper}, \\infty)$"
                )
            else:
                question = f"$x \\leq {lower}$ or $x \\geq {upper}$"
                answer = f"union:{{interval:{{closed:{lower},neg_inf:true}}}},{{interval:{{closed:{upper},pos_inf:true}}}}"
                solution_steps = steps(
                    f"The inequality $x \\leq {lower}$ or $x \\geq {upper}$ represents all values at most ${lower}$ or at least ${upper}$",
                    f"Interval notation: $(-\\infty, {lower}] \\cup [{upper}, \\infty)$"
                )
        else:
            # More complex
            diff = (1500, 1600)
            
            # If solution is x < lower or x > upper, then
            # (x - const)/coeff < lower or (x - const)/coeff > upper becomes
            # x < coeff*lower + const or x > coeff*upper + const
            left_bound = coeff * lower + const
            right_bound = coeff * upper + const
            
            if use_strict:
                question = f"${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} < {left_bound}$ or ${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} > {right_bound}$"
                answer = f"union:{{interval:{{open:{lower},neg_inf:true}}}},{{interval:{{open:{upper},pos_inf:true}}}}"
                solution_steps = steps(
                    f"Solve each inequality separately:",
                    f"First: ${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} < {left_bound}$" + (f" → ${coeff}x < {left_bound - const}$" if const != 0 else "") + f" → $x < {lower}$",
                    f"Second: ${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} > {right_bound}$" + (f" → ${coeff}x > {right_bound - const}$" if const != 0 else "") + f" → $x > {upper}$",
                    f"Interval notation: $(-\\infty, {lower}) \\cup ({upper}, \\infty)$"
                )
            else:
                question = f"${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} \\leq {left_bound}$ or ${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} \\geq {right_bound}$"
                answer = f"union:{{interval:{{closed:{lower},neg_inf:true}}}},{{interval:{{closed:{upper},pos_inf:true}}}}"
                solution_steps = steps(
                    f"Solve each inequality separately:",
                    f"First: ${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} \\leq {left_bound}$" + (f" → ${coeff}x \\leq {left_bound - const}$" if const != 0 else "") + f" → $x \\leq {lower}$",
                    f"Second: ${coeff}x {'+' if const >= 0 else ''}{const if const != 0 else ''} \\geq {right_bound}$" + (f" → ${coeff}x \\geq {right_bound - const}$" if const != 0 else "") + f" → $x \\geq {upper}$",
                    f"Interval notation: $(-\\infty, {lower}] \\cup [{upper}, \\infty)$"
                )
        
        question_text = f"Solve the compound inequality and write your answer in interval notation: {question}"
    
    return problem(
        question=question_text,
        answer=answer,
        difficulty=diff,
        topic="algebra1/compound_inequalities",
        solution=solution_steps,
        answer_type="interval"
    )

emit(generate())