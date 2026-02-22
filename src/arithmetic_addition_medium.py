"""
arithmetic - addition (medium)
Generated: 2026-02-22T03:37:34.891966
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Two-digit addition without carrying (1200-1300)
        a = randint(10, 44)
        b = randint(10, 44)
        ans = a + b
        return problem(
            question=f"${a} + {b} = ?$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/addition",
            solution=f"${a} + {b} = {ans}$"
        )
    
    elif problem_type == 2:
        # Two-digit addition with carrying (1300-1400)
        a = randint(45, 99)
        b = randint(45, 99)
        ans = a + b
        tens_a = a // 10
        ones_a = a % 10
        tens_b = b // 10
        ones_b = b % 10
        ones_sum = ones_a + ones_b
        carry = ones_sum // 10
        return problem(
            question=f"${a} + {b} = ?$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="arithmetic/addition",
            solution=steps(
                f"Add the ones place: ${ones_a} + {ones_b} = {ones_sum}$ (carry {carry})",
                f"Add the tens place: ${tens_a} + {tens_b} + {carry} = {(tens_a + tens_b + carry)}$",
                f"${a} + {b} = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Three-digit addition (1400-1500)
        a = randint(100, 999)
        b = randint(100, 999)
        ans = a + b
        return problem(
            question=f"${a} + {b} = ?$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/addition",
            solution=steps(
                f"Line up the digits by place value",
                f"Add ones, tens, then hundreds (carrying as needed)",
                f"${a} + {b} = {ans}$"
            )
        )
    
    else:
        # Adding three or four two-digit numbers (1500-1600)
        num_count = randint(3, 4)
        numbers = [randint(10, 99) for _ in range(num_count)]
        ans = sum(numbers)
        question_str = " + ".join([str(n) for n in numbers])
        return problem(
            question=f"${question_str} = ?$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="arithmetic/addition",
            solution=steps(
                f"Add from left to right: ${' + '.join([str(n) for n in numbers])}$",
                f"$= {ans}$"
            )
        )

emit(generate())