"""
arithmetic - multiplication (medium)
Generated: 2026-02-22T03:39:03.764866
"""

from problem_utils import *

def generate():
    # Choose problem type based on difficulty level
    problem_type = choice(['two_digit', 'three_digit', 'with_zero', 'multi_step'])
    
    if problem_type == 'two_digit':
        # Standard two-digit multiplication (1300-1400 ELO)
        a_val = randint(12, 99)
        b_val = randint(12, 99)
        ans = a_val * b_val
        
        return problem(
            question=f"${{{a_val}}} \\times {{{b_val}}} = ?$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Multiply ${{{a_val}}} \\times {{{b_val}}}$",
                f"${{{ans}}}$"
            ),
            calculator="none"
        )
    
    elif problem_type == 'three_digit':
        # Three-digit by two-digit multiplication (1400-1500 ELO)
        a_val = randint(100, 999)
        b_val = randint(12, 99)
        ans = a_val * b_val
        
        return problem(
            question=f"${{{a_val}}} \\times {{{b_val}}} = ?$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Multiply ${{{a_val}}} \\times {{{b_val}}}$",
                f"${{{ans}}}$"
            ),
            calculator="none"
        )
    
    elif problem_type == 'with_zero':
        # Multiplication with zeros requiring careful place value (1350-1450 ELO)
        a_val = randint(10, 99) * 10  # ensures ending in 0
        b_val = randint(12, 99)
        ans = a_val * b_val
        
        return problem(
            question=f"${{{a_val}}} \\times {{{b_val}}} = ?$",
            answer=ans,
            difficulty=(1350, 1450),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Multiply ${{{a_val}}} \\times {{{b_val}}}$",
                f"Note that ${{{a_val}}}$ ends in zero",
                f"${{{ans}}}$"
            ),
            calculator="none"
        )
    
    else:  # multi_step
        # Word problem requiring setup and multiplication (1500-1600 ELO)
        scenarios = [
            ("boxes", "items per box", "items"),
            ("hours", "miles per hour", "miles"),
            ("days", "pages per day", "pages"),
            ("weeks", "dollars per week", "dollars"),
            ("rows", "seats per row", "seats")
        ]
        
        unit1, rate_desc, unit2 = choice(scenarios)
        
        num_units = randint(12, 50)
        rate = randint(15, 99)
        ans = num_units * rate
        
        return problem(
            question=f"If there are ${{{num_units}}}$ {unit1} with ${{{rate}}}$ {rate_desc}, how many {unit2} are there in total?",
            answer=ans,
            difficulty=(1500, 1600),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Multiply the number of {unit1} by the {rate_desc}",
                f"${{{num_units}}} \\times {{{rate}}} = {{{ans}}}$",
                f"There are ${{{ans}}}$ {unit2}"
            ),
            calculator="none"
        )

emit(generate())