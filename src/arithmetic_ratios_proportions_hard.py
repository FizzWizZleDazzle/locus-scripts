"""
arithmetic - ratios_proportions (hard)
Generated: 2026-02-22T03:46:42.460841
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Complex ratio problem with three quantities
        a_parts = randint(3, 7)
        b_parts = randint(3, 7)
        c_parts = randint(3, 7)
        while a_parts == b_parts or b_parts == c_parts or a_parts == c_parts:
            b_parts = randint(3, 7)
            c_parts = randint(3, 7)
        
        total_given = randint(200, 600)
        while total_given % (a_parts + b_parts + c_parts) != 0:
            total_given = randint(200, 600)
        
        part_value = total_given // (a_parts + b_parts + c_parts)
        a_val = a_parts * part_value
        b_val = b_parts * part_value
        c_val = c_parts * part_value
        
        target_letter = choice(['A', 'B', 'C'])
        if target_letter == 'A':
            ans = a_val
        elif target_letter == 'B':
            ans = b_val
        else:
            ans = c_val
        
        return problem(
            question=f"Three quantities $A$, $B$, and $C$ are in the ratio ${a_parts}:{b_parts}:{c_parts}$. If the sum of all three quantities is ${total_given}$, find the value of ${target_letter}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Let the common ratio factor be $k$. Then $A = {a_parts}k$, $B = {b_parts}k$, $C = {c_parts}k$",
                f"Sum: ${a_parts}k + {b_parts}k + {c_parts}k = {total_given}$",
                f"${a_parts + b_parts + c_parts}k = {total_given}$",
                f"$k = {part_value}$",
                f"${target_letter} = {a_parts if target_letter == 'A' else (b_parts if target_letter == 'B' else c_parts)} \\cdot {part_value} = {ans}$"
            )
        )
    
    elif problem_type == 2:
        # Inverse proportion problem
        workers1 = randint(4, 12)
        days1 = randint(6, 20)
        workers2 = randint(4, 12)
        while workers2 == workers1:
            workers2 = randint(4, 12)
        
        # Work is constant: workers1 * days1 = workers2 * days2
        work = workers1 * days1
        if work % workers2 == 0:
            ans = work // workers2
        else:
            ans = Rational(work, workers2)
        
        return problem(
            question=f"If ${workers1}$ workers can complete a job in ${days1}$ days, how many days will it take ${workers2}$ workers to complete the same job, assuming all workers work at the same rate?",
            answer=ans,
            difficulty=(1650, 1750),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"This is an inverse proportion: more workers means fewer days",
                f"Total work = workers $\\times$ days = ${workers1} \\times {days1} = {work}$ worker-days",
                f"With ${workers2}$ workers: days = $\\frac{{{work}}}{{{workers2}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Mixture problem with ratios
        ratio_a = randint(2, 5)
        ratio_b = randint(2, 5)
        while ratio_a == ratio_b:
            ratio_b = randint(2, 5)
        
        amount_added = randint(10, 40)
        
        # After adding amount_added of substance B, find new ratio
        # Start with ratio_a : ratio_b
        # Let k be the multiplier, so we have ratio_a*k of A and ratio_b*k of B
        # After adding: ratio_a*k of A and (ratio_b*k + amount_added) of B
        
        new_ratio_a = randint(1, 4)
        new_ratio_b = randint(3, 7)
        while new_ratio_a >= new_ratio_b or new_ratio_a * ratio_b >= new_ratio_b * ratio_a:
            new_ratio_a = randint(1, 4)
            new_ratio_b = randint(3, 7)
        
        # ratio_a*k / (ratio_b*k + amount_added) = new_ratio_a / new_ratio_b
        # ratio_a*k*new_ratio_b = new_ratio_a*(ratio_b*k + amount_added)
        # ratio_a*k*new_ratio_b = new_ratio_a*ratio_b*k + new_ratio_a*amount_added
        # k*(ratio_a*new_ratio_b - new_ratio_a*ratio_b) = new_ratio_a*amount_added
        
        numerator = new_ratio_a * amount_added
        denominator = ratio_a * new_ratio_b - new_ratio_a * ratio_b
        
        if denominator > 0 and numerator % denominator == 0:
            k = numerator // denominator
            initial_B = ratio_b * k
            ans = initial_B
        else:
            # Reconstruct with clean numbers
            k = randint(3, 8)
            initial_A = ratio_a * k
            initial_B = ratio_b * k
            # After adding amount_added: A stays initial_A, B becomes initial_B + amount_added
            ans = initial_B
        
        return problem(
            question=f"A mixture contains substances $A$ and $B$ in the ratio ${ratio_a}:{ratio_b}$. After adding ${amount_added}$ units of substance $B$, the new ratio becomes ${new_ratio_a}:{new_ratio_b}$. How many units of substance $B$ were in the original mixture?",
            answer=ans,
            difficulty=(1700, 1850),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"Let the original amounts be ${ratio_a}k$ and ${ratio_b}k$ for substances $A$ and $B$ respectively",
                f"After adding ${amount_added}$ units of $B$: $A = {ratio_a}k$, $B = {ratio_b}k + {amount_added}$",
                f"New ratio: $\\frac{{{ratio_a}k}}{{{ratio_b}k + {amount_added}}} = \\frac{{{new_ratio_a}}}{{{new_ratio_b}}}$",
                f"Cross-multiply: ${ratio_a}k \\cdot {new_ratio_b} = {new_ratio_a}({ratio_b}k + {amount_added})$",
                f"${ratio_a * new_ratio_b}k = {new_ratio_a * ratio_b}k + {new_ratio_a * amount_added}$",
                f"${ratio_a * new_ratio_b - new_ratio_a * ratio_b}k = {new_ratio_a * amount_added}$",
                f"$k = {k}$",
                f"Original amount of $B$ = ${ratio_b} \\cdot {k} = {ans}$"
            )
        )
    
    elif problem_type == 4:
        # Compound ratio problem
        ratio1_a = randint(2, 5)
        ratio1_b = randint(2, 5)
        ratio2_b = randint(2, 5)
        ratio2_c = randint(2, 5)
        
        # A:B = ratio1_a:ratio1_b and B:C = ratio2_b:ratio2_c
        # Need to find A:B:C
        
        # Make B the same in both ratios
        lcm_b = (ratio1_b * ratio2_b) // gcd(ratio1_b, ratio2_b)
        mult1 = lcm_b // ratio1_b
        mult2 = lcm_b // ratio2_b
        
        final_a = ratio1_a * mult1
        final_b = lcm_b
        final_c = ratio2_c * mult2
        
        total = randint(150, 500)
        while total % (final_a + final_b + final_c) != 0:
            total = randint(150, 500)
        
        k = total // (final_a + final_b + final_c)
        ans = final_c * k
        
        return problem(
            question=f"If $A:B = {ratio1_a}:{ratio1_b}$ and $B:C = {ratio2_b}:{ratio2_c}$, and the sum $A + B + C = {total}$, find the value of $C$.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"From $A:B = {ratio1_a}:{ratio1_b}$, we have $A = {ratio1_a}k_1$ and $B = {ratio1_b}k_1$",
                f"From $B:C = {ratio2_b}:{ratio2_c}$, we have $B = {ratio2_b}k_2$ and $C = {ratio2_c}k_2$",
                f"To combine, make $B$ equal in both: multiply first by ${mult1}$ and second by ${mult2}$",
                f"$A:B:C = {final_a}:{final_b}:{final_c}$",
                f"Sum of parts: ${final_a} + {final_b} + {final_c} = {final_a + final_b + final_c}$",
                f"Each part = $\\frac{{{total}}}{{{final_a + final_b + final_c}}} = {k}$",
                f"$C = {final_c} \\times {k} = {ans}$"
            )
        )
    
    else:
        # Ratio with algebraic constraint
        ratio_x = randint(2, 6)
        ratio_y = randint(2, 6)
        while ratio_x == ratio_y:
            ratio_y = randint(2, 6)
        
        coeff_x = randint(2, 5)
        coeff_y = randint(2, 5)
        constant = randint(20, 100)
        
        # x:y = ratio_x:ratio_y, so y = (ratio_y/ratio_x) * x
        # coeff_x * x + coeff_y * y = constant
        # coeff_x * x + coeff_y * (ratio_y/ratio_x) * x = constant
        # x * (coeff_x + coeff_y * ratio_y / ratio_x) = constant
        
        numerator = constant * ratio_x
        denominator = coeff_x * ratio_x + coeff_y * ratio_y
        
        if numerator % denominator == 0:
            x_val = numerator // denominator
            y_val = (ratio_y * x_val) // ratio_x
            if ratio_y * x_val % ratio_x == 0:
                ans = x_val + y_val
            else:
                x_val = ratio_x * randint(2, 8)
                y_val = ratio_y * (x_val // ratio_x)
                ans = x_val + y_val
        else:
            k = randint(2, 8)
            x_val = ratio_x * k
            y_val = ratio_y * k
            ans = x_val + y_val
        
        return problem(
            question=f"Two numbers $x$ and $y$ are in the ratio ${ratio_x}:{ratio_y}$. If ${coeff_x}x + {coeff_y}y = {constant}$, find $x + y$.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="arithmetic/ratios_proportions",
            solution=steps(
                f"From the ratio $x:y = {ratio_x}:{ratio_y}$, let $x = {ratio_x}k$ and $y = {ratio_y}k$",
                f"Substitute into ${coeff_x}x + {coeff_y}y = {constant}$:",
                f"${coeff_x}({ratio_x}k) + {coeff_y}({ratio_y}k) = {constant}$",
                f"${coeff_x * ratio_x}k + {coeff_y * ratio_y}k = {constant}$",
                f"${coeff_x * ratio_x + coeff_y * ratio_y}k = {constant}$",
                f"$k = {constant // gcd(constant, coeff_x * ratio_x + coeff_y * ratio_y)}$" if constant % (coeff_x * ratio_x + coeff_y * ratio_y) == 0 else f"$k = \\frac{{{constant}}}{{{coeff_x * ratio_x + coeff_y * ratio_y}}}$",
                f"$x + y = {ratio_x}k + {ratio_y}k = {ratio_x + ratio_y}k = {ans}$"
            )
        )

emit(generate())