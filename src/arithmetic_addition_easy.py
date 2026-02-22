"""
arithmetic - addition (easy)
Generated: 2026-02-22T03:37:24.514793
"""

from problem_utils import *

def generate():
    # For ELO 1000-1300 (easier addition problems)
    # 1000-1100: Single digit addition
    # 1100-1200: Two-digit addition without carrying
    # 1200-1300: Two-digit addition with carrying or simple three numbers
    
    difficulty_level = randint(1000, 1300)
    
    if difficulty_level < 1100:
        # Single digit addition (simplest)
        a_val = randint(1, 9)
        b_val = randint(1, 9)
        ans = a_val + b_val
        
        return problem(
            question=f"${a_val} + {b_val} = ?$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/addition",
            solution=f"${a_val} + {b_val} = {ans}$"
        )
    
    elif difficulty_level < 1200:
        # Two-digit addition without carrying
        a_val = randint(10, 44)
        b_val = randint(10, 55 - a_val)  # Ensure no carrying by keeping sum under constraints
        
        # Make sure no carrying happens
        ones_a = a_val % 10
        ones_b = b_val % 10
        if ones_a + ones_b >= 10:
            b_val = b_val - ones_b + randint(0, 9 - ones_a)
        
        ans = a_val + b_val
        
        return problem(
            question=f"${a_val} + {b_val} = ?$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/addition",
            solution=steps(
                f"Add the ones place: ${a_val % 10} + {b_val % 10} = {(a_val % 10) + (b_val % 10)}$",
                f"Add the tens place: ${(a_val // 10) * 10} + {(b_val // 10) * 10} = {((a_val // 10) + (b_val // 10)) * 10}$",
                f"${a_val} + {b_val} = {ans}$"
            )
        )
    
    else:
        # Two-digit addition with carrying OR adding three single-digit numbers
        problem_type = choice(['carrying', 'three_numbers'])
        
        if problem_type == 'carrying':
            a_val = randint(15, 89)
            b_val = randint(15, 99 - a_val)
            
            # Force carrying by adjusting ones digits
            ones_a = a_val % 10
            ones_b = b_val % 10
            if ones_a + ones_b < 10:
                # Adjust to create carrying
                new_ones_b = randint(10 - ones_a, 9)
                b_val = (b_val // 10) * 10 + new_ones_b
            
            ans = a_val + b_val
            ones_sum = (a_val % 10) + (b_val % 10)
            
            return problem(
                question=f"${a_val} + {b_val} = ?$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="arithmetic/addition",
                solution=steps(
                    f"Add the ones place: ${a_val % 10} + {b_val % 10} = {ones_sum}$",
                    f"Write ${ones_sum % 10}$ and carry ${ones_sum // 10}$",
                    f"Add the tens place: ${a_val // 10} + {b_val // 10} + {ones_sum // 10} = {(a_val // 10) + (b_val // 10) + (ones_sum // 10)}$",
                    f"${a_val} + {b_val} = {ans}$"
                )
            )
        else:
            # Three single-digit numbers
            a_val = randint(2, 9)
            b_val = randint(2, 9)
            c_val = randint(2, 9)
            ans = a_val + b_val + c_val
            
            return problem(
                question=f"${a_val} + {b_val} + {c_val} = ?$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="arithmetic/addition",
                solution=steps(
                    f"First add ${a_val} + {b_val} = {a_val + b_val}$",
                    f"Then add ${a_val + b_val} + {c_val} = {ans}$"
                )
            )

emit(generate())