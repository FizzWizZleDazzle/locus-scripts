"""
arithmetic - ratios_proportions (medium)
Generated: 2026-02-22T03:45:58.431529
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple ratio equivalence (1300-1400)
        # Find x in a/b = c/x
        a = randint(2, 8)
        c = randint(2, 8)
        x_val = randint(3, 12)
        b = (a * x_val) // c
        if b * c != a * x_val:
            b = a * x_val // c
            if b == 0:
                b = a * x_val
        
        return problem(
            question=f"Solve for $x$: $\\frac{{{a}}}{{{b}}} = \\frac{{{c}}}{{x}}$",
            answer=x_val,
            difficulty=(1300, 1400),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Cross multiply: ${a} \\cdot x = {b} \\cdot {c}$",
                f"${a}x = {b * c}$",
                f"$x = \\frac{{{b * c}}}{{{a}}} = {x_val}$"
            )
        )
    
    elif problem_type == 2:
        # Word problem - recipe scaling (1400-1500)
        orig_serves = randint(4, 8)
        new_serves = randint(10, 20)
        ingredient_amt = randint(2, 6)
        
        new_amt = Rational(ingredient_amt * new_serves, orig_serves)
        
        return problem(
            question=f"A recipe that serves {orig_serves} people requires {ingredient_amt} cups of flour. How many cups of flour are needed to serve {new_serves} people?",
            answer=new_amt,
            difficulty=(1400, 1500),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Set up proportion: $\\frac{{{ingredient_amt}}}{{{orig_serves}}} = \\frac{{x}}{{{new_serves}}}$",
                f"Cross multiply: ${ingredient_amt} \\cdot {new_serves} = {orig_serves} \\cdot x$",
                f"${ingredient_amt * new_serves} = {orig_serves}x$",
                f"$x = \\frac{{{ingredient_amt * new_serves}}}{{{orig_serves}}} = {latex(new_amt)}$"
            )
        )
    
    elif problem_type == 3:
        # Ratio word problem with parts (1400-1500)
        part_a = randint(2, 5)
        part_b = randint(2, 5)
        while part_b == part_a:
            part_b = randint(2, 5)
        
        total = randint(20, 50)
        # Ensure total is divisible by sum of parts
        total = ((total // (part_a + part_b)) + 1) * (part_a + part_b)
        
        value_a = (total * part_a) // (part_a + part_b)
        
        return problem(
            question=f"Two numbers are in the ratio ${part_a}:{part_b}$. If their sum is ${total}$, what is the larger number?",
            answer=max(value_a, total - value_a),
            difficulty=(1400, 1500),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Let the numbers be ${part_a}x$ and ${part_b}x$",
                f"${part_a}x + {part_b}x = {total}$",
                f"${part_a + part_b}x = {total}$",
                f"$x = {total // (part_a + part_b)}$",
                f"The numbers are ${value_a}$ and ${total - value_a}$",
                f"The larger number is ${max(value_a, total - value_a)}$"
            )
        )
    
    else:
        # Map scale problem (1500-1600)
        map_dist = randint(3, 12)
        scale_map = randint(1, 3)
        scale_real = randint(15, 40) * 5
        
        real_dist = (map_dist * scale_real) // scale_map
        
        return problem(
            question=f"On a map, {scale_map} cm represents {scale_real} km. If two cities are {map_dist} cm apart on the map, what is the actual distance between them in kilometers?",
            answer=real_dist,
            difficulty=(1500, 1600),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Set up proportion: $\\frac{{{scale_map} \\text{{ cm}}}}{{{scale_real} \\text{{ km}}}} = \\frac{{{map_dist} \\text{{ cm}}}}{{x \\text{{ km}}}}$",
                f"Cross multiply: ${scale_map} \\cdot x = {scale_real} \\cdot {map_dist}$",
                f"${scale_map}x = {scale_real * map_dist}$",
                f"$x = {real_dist}$ km"
            )
        )

emit(generate())