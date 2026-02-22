"""
arithmetic - long_division (hard)
Generated: 2026-02-22T03:39:56.060604
"""

from problem_utils import *

def generate():
    # For long division at 1600-1900 ELO, we want:
    # - Large dividends (4-5 digits)
    # - 2-3 digit divisors
    # - Remainders that require careful tracking
    # - Non-obvious quotients
    
    difficulty_choice = randint(1, 4)
    
    if difficulty_choice == 1:
        # 1600-1700: 4-digit ÷ 2-digit with remainder
        quotient = randint(35, 95)
        divisor = randint(23, 87)
        remainder = randint(1, divisor - 1)
        dividend = quotient * divisor + remainder
        
        ans = quotient
        elo = randint(1600, 1700)
        
    elif difficulty_choice == 2:
        # 1700-1800: 5-digit ÷ 2-digit with remainder
        quotient = randint(145, 425)
        divisor = randint(34, 89)
        remainder = randint(1, divisor - 1)
        dividend = quotient * divisor + remainder
        
        ans = quotient
        elo = randint(1700, 1800)
        
    elif difficulty_choice == 3:
        # 1800-1900: 5-digit ÷ 3-digit with remainder
        quotient = randint(25, 85)
        divisor = randint(123, 456)
        remainder = randint(1, divisor - 1)
        dividend = quotient * divisor + remainder
        
        ans = quotient
        elo = randint(1800, 1900)
        
    else:
        # 1750-1900: 6-digit ÷ 3-digit with tricky quotient
        quotient = randint(105, 325)
        divisor = randint(178, 398)
        remainder = randint(1, divisor - 1)
        dividend = quotient * divisor + remainder
        
        ans = quotient
        elo = randint(1750, 1900)
    
    # Build solution steps
    solution_text = steps(
        f"Divide ${{{dividend}}}$ by ${{{divisor}}}$ using long division",
        f"The quotient is ${{{quotient}}}$ with remainder ${{{remainder}}}$",
        f"Check: ${{{divisor}}} \\times {{{quotient}}} + {{{remainder}}} = {{{divisor * quotient}}} + {{{remainder}}} = {{{dividend}}}$"
    )
    
    return problem(
        question=f"What is the quotient when ${{{dividend}}}$ is divided by ${{{divisor}}}$? (Do not include the remainder in your answer.)",
        answer=ans,
        difficulty=elo,
        topic="arithmetic/long_division",
        solution=solution_text,
        answer_type="numeric"
    )

emit(generate())