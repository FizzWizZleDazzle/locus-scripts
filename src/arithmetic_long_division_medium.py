"""
arithmetic - long_division (medium)
Generated: 2026-02-22T03:39:44.867860
"""

from problem_utils import *

def generate():
    # For long division problems at 1300-1600 ELO:
    # 1300: 3-digit by 1-digit with no remainder
    # 1400: 3-digit by 1-digit with remainder or 3-digit by 2-digit no remainder
    # 1500: 3-digit by 2-digit with remainder
    # 1600: 4-digit by 2-digit with remainder
    
    difficulty_level = randint(1300, 1600)
    
    if difficulty_level < 1350:
        # 3-digit by 1-digit, no remainder
        divisor = randint(2, 9)
        quotient = randint(10, 99)
        dividend = divisor * quotient
        expected_remainder = 0
        elo = (1300, 1350)
        
    elif difficulty_level < 1450:
        # 3-digit by 1-digit with remainder
        divisor = randint(2, 9)
        quotient = randint(10, 99)
        remainder = randint(1, divisor - 1)
        dividend = divisor * quotient + remainder
        expected_remainder = remainder
        elo = (1350, 1450)
        
    elif difficulty_level < 1550:
        # 3-digit by 2-digit with possible remainder
        divisor = randint(11, 29)
        quotient = randint(10, 30)
        remainder = randint(0, divisor - 1)
        dividend = divisor * quotient + remainder
        expected_remainder = remainder
        elo = (1450, 1550)
        
    else:
        # 4-digit by 2-digit with remainder
        divisor = randint(12, 49)
        quotient = randint(30, 150)
        remainder = randint(1, divisor - 1)
        dividend = divisor * quotient + remainder
        expected_remainder = remainder
        elo = (1550, 1650)
    
    # Calculate the actual answer
    actual_quotient = dividend // divisor
    actual_remainder = dividend % divisor
    
    # Format the answer
    if actual_remainder == 0:
        ans = actual_quotient
        answer_str = f"{actual_quotient}"
        question_text = f"Divide ${dividend} \\div {divisor}$"
    else:
        ans = actual_quotient
        answer_str = f"{actual_quotient} R {actual_remainder}"
        question_text = f"Divide ${dividend} \\div {divisor}$. Express your answer as a quotient with remainder (e.g., 12 R 3)."
    
    # Build solution steps
    solution_steps = []
    solution_steps.append(f"Divide ${dividend}$ by ${divisor}$ using long division.")
    
    # Show the division process
    temp = dividend
    result_digits = []
    current_dividend = 0
    
    # Long division walkthrough
    dividend_str = str(dividend)
    position = 0
    
    solution_steps.append(f"${divisor}$ goes into ${dividend}$ exactly ${actual_quotient}$ times with remainder ${actual_remainder}$.")
    
    if actual_remainder == 0:
        solution_steps.append(f"Answer: ${actual_quotient}$")
        # For clean division, student should enter just the quotient
        final_answer = actual_quotient
    else:
        solution_steps.append(f"Answer: ${actual_quotient}$ R ${actual_remainder}$")
        # For remainder problems, format as "quotient R remainder"
        final_answer = f"{actual_quotient} R {actual_remainder}"
    
    return problem(
        question=question_text,
        answer=final_answer,
        difficulty=elo,
        topic="arithmetic/long_division",
        solution=steps(*solution_steps),
        answer_type="expression"
    )

emit(generate())