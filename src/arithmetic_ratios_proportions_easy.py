"""
arithmetic - ratios_proportions (easy)
Generated: 2026-02-22T03:45:39.185643
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple ratio identification (1000-1100)
        # "Express the ratio of a to b in simplest form"
        a_val = randint(2, 12)
        b_val = randint(2, 12)
        
        # Make sure they have a common factor sometimes
        if randint(1, 3) == 1:
            gcd_val = randint(2, 4)
            a_val *= gcd_val
            b_val *= gcd_val
        
        from math import gcd
        g = gcd(a_val, b_val)
        ans_a = a_val // g
        ans_b = b_val // g
        
        ans = f"{ans_a}:{ans_b}"
        
        return problem(
            question=f"Express the ratio ${a_val}:{b_val}$ in simplest form.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/ratios_proportions",
            answer_type="string",
            solution=steps(
                f"Find GCD of ${a_val}$ and ${b_val}$: ${g}$",
                f"Divide both terms by ${g}$: ${a_val} \\div {g} = {ans_a}$ and ${b_val} \\div {g} = {ans_b}$",
                f"Simplest form: ${ans_a}:{ans_b}$"
            )
        )
    
    elif problem_type == 2:
        # Simple proportion solving (1100-1200)
        # "If 3/4 = x/12, find x"
        a_val = randint(2, 8)
        b_val = randint(2, 8)
        multiplier = randint(2, 6)
        
        c_val = a_val * multiplier
        d_val = b_val * multiplier
        
        # Hide one of the two products
        if randint(1, 2) == 1:
            # x / d_val = a_val / b_val
            ans = c_val
            return problem(
                question=f"Solve for $x$: $\\frac{{x}}{{{d_val}}} = \\frac{{{a_val}}}{{{b_val}}}$",
                answer=ans,
                difficulty=(1100, 1200),
                topic="arithmetic/ratios_proportions",
                solution=steps(
                    f"Cross multiply: ${b_val} \\cdot x = {a_val} \\cdot {d_val}$",
                    f"${b_val}x = {a_val * d_val}$",
                    f"$x = \\frac{{{a_val * d_val}}}{{{b_val}}} = {ans}$"
                )
            )
        else:
            # a_val / x = c_val / d_val
            ans = b_val
            return problem(
                question=f"Solve for $x$: $\\frac{{{a_val}}}{{x}} = \\frac{{{c_val}}}{{{d_val}}}$",
                answer=ans,
                difficulty=(1100, 1200),
                topic="arithmetic/ratios_proportions",
                solution=steps(
                    f"Cross multiply: ${c_val} \\cdot x = {a_val} \\cdot {d_val}$",
                    f"${c_val}x = {a_val * d_val}$",
                    f"$x = \\frac{{{a_val * d_val}}}{{{c_val}}} = {ans}$"
                )
            )
    
    elif problem_type == 3:
        # Unit rate problem (1100-1200)
        # "If 6 apples cost $12, how much does 1 apple cost?"
        items = choice(["apples", "oranges", "pencils", "notebooks", "cookies"])
        quantity = randint(3, 10)
        total_cost = quantity * randint(2, 8)
        
        ans = total_cost // quantity
        
        return problem(
            question=f"If ${quantity}$ {items} cost $\\${total_cost}$, what is the cost per item?",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Divide total cost by number of items",
                f"$\\frac{{{total_cost}}}{{{quantity}}} = {ans}$",
                f"Each item costs $\\${ans}$"
            )
        )
    
    else:
        # Part-to-whole ratio (1200-1300)
        # "In a class, the ratio of boys to girls is 3:5. If there are 24 students, how many are boys?"
        part1 = randint(2, 7)
        part2 = randint(2, 7)
        
        while part1 == part2:
            part2 = randint(2, 7)
        
        multiplier = randint(2, 5)
        total = (part1 + part2) * multiplier
        ans = part1 * multiplier
        
        contexts = [
            ("boys", "girls", "students in a class"),
            ("red marbles", "blue marbles", "marbles"),
            ("cats", "dogs", "pets"),
            ("fiction books", "non-fiction books", "books")
        ]
        
        context = choice(contexts)
        
        return problem(
            question=f"The ratio of {context[0]} to {context[1]} is ${part1}:{part2}$. If there are ${total}$ {context[2]} in total, how many {context[0]} are there?",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Total parts in ratio: ${part1} + {part2} = {part1 + part2}$",
                f"Each part represents: $\\frac{{{total}}}{{{part1 + part2}}} = {multiplier}$ {context[2]}",
                f"Number of {context[0]}: ${part1} \\times {multiplier} = {ans}$"
            )
        )

emit(generate())