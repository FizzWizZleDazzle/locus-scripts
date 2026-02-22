"""
arithmetic - long_division (easy)
Generated: 2026-02-22T03:39:30.102867
"""

from problem_utils import *

def generate():
    # For easier long division (1000-1300 ELO), we want:
    # - Simple divisors (single digit, maybe 2-digit for higher end)
    # - Clean or near-clean division
    # - Small quotients
    
    difficulty_roll = randint(1000, 1300)
    
    if difficulty_roll < 1150:
        # 1000-1150: Very simple, single-digit divisor, clean division, 2-digit dividend
        divisor = randint(2, 9)
        quotient = randint(2, 9)
        dividend = divisor * quotient
        remainder = 0
    elif difficulty_roll < 1250:
        # 1150-1250: Single-digit divisor, 2-3 digit dividend, small or no remainder
        divisor = randint(2, 9)
        quotient = randint(10, 20)
        remainder = choice([0, 0, 0, randint(1, divisor-1)])  # favor clean division
        dividend = divisor * quotient + remainder
    else:
        # 1250-1300: Single-digit divisor or easy 2-digit, 3-digit dividend, may have remainder
        if randint(0, 1) == 0:
            divisor = randint(2, 9)
            quotient = randint(20, 50)
        else:
            divisor = choice([10, 11, 12, 15, 20, 25])
            quotient = randint(5, 20)
        remainder = randint(0, divisor-1)
        dividend = divisor * quotient + remainder
    
    # Construct the answer
    if remainder == 0:
        ans = quotient
        answer_text = f"{quotient}"
        solution_text = steps(
            f"Divide ${dividend}$ by ${divisor}$",
            f"${divisor} \\times {quotient} = {dividend}$",
            f"Quotient: ${quotient}$, Remainder: $0$",
            f"Answer: ${quotient}$"
        )
    else:
        ans = quotient
        answer_text = f"{quotient} R{remainder}"
        solution_text = steps(
            f"Divide ${dividend}$ by ${divisor}$",
            f"${divisor} \\times {quotient} = {divisor * quotient}$",
            f"${dividend} - {divisor * quotient} = {remainder}$",
            f"Quotient: ${quotient}$, Remainder: ${remainder}$",
            f"Answer: ${quotient}$ R${remainder}$"
        )
    
    # Format the question
    question_text = f"Divide ${dividend} \\div {divisor}$. Express your answer as quotient R remainder (or just the quotient if there is no remainder)."
    
    return problem(
        question=question_text,
        answer=answer_text,
        difficulty=difficulty_roll,
        topic="arithmetic/long_division",
        solution=solution_text,
        answer_type="text"
    )

emit(generate())