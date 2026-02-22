"""
arithmetic - subtraction (medium)
Generated: 2026-02-22T03:38:20.945546
"""

from problem_utils import *

def generate():
    # Choose difficulty level and problem type
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # 1200-1400: Two or three digit subtraction, possibly with borrowing
        minuend = randint(50, 999)
        subtrahend = randint(20, min(minuend - 5, 500))
        ans = minuend - subtrahend
        
        return problem(
            question=f"${minuend} - {subtrahend} = ?$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="arithmetic/subtraction",
            solution=steps(
                f"Subtract: ${minuend} - {subtrahend}$",
                f"Answer: ${ans}$"
            )
        )
    
    elif difficulty_choice == 2:
        # 1300-1500: Multi-step subtraction with parentheses or multiple operations
        a = randint(100, 500)
        b = randint(20, 100)
        c = randint(10, 50)
        
        if randint(0, 1) == 0:
            # (a - b) - c
            ans = a - b - c
            return problem(
                question=f"$({a} - {b}) - {c} = ?$",
                answer=ans,
                difficulty=(1300, 1500),
                topic="arithmetic/subtraction",
                solution=steps(
                    f"First calculate: ${a} - {b} = {a - b}$",
                    f"Then subtract: ${a - b} - {c} = {ans}$"
                )
            )
        else:
            # a - (b - c)
            ans = a - (b - c)
            return problem(
                question=f"${a} - ({b} - {c}) = ?$",
                answer=ans,
                difficulty=(1300, 1500),
                topic="arithmetic/subtraction",
                solution=steps(
                    f"First calculate inside parentheses: ${b} - {c} = {b - c}$",
                    f"Then subtract: ${a} - {b - c} = {ans}$"
                )
            )
    
    else:
        # 1400-1600: Word problem or more complex multi-step
        initial = randint(500, 2000)
        first_expense = randint(100, initial // 3)
        second_expense = randint(50, (initial - first_expense) // 2)
        third_expense = randint(20, (initial - first_expense - second_expense) // 2)
        ans = initial - first_expense - second_expense - third_expense
        
        contexts = [
            ("dollars in a bank account", "withdrew", "dollars"),
            ("students in a school", "transferred out", "students"),
            ("books in a library", "checked out", "books"),
            ("gallons of water in a tank", "used", "gallons")
        ]
        
        context, action, unit = choice(contexts)
        
        return problem(
            question=f"There were ${initial}$ {context}. First, ${first_expense}$ {unit} were {action}, then ${second_expense}$ {unit} were {action}, and finally ${third_expense}$ {unit} were {action}. How many {unit} remain?",
            answer=ans,
            difficulty=(1400, 1600),
            topic="arithmetic/subtraction",
            solution=steps(
                f"Start with: ${initial}$ {unit}",
                f"After first: ${initial} - {first_expense} = {initial - first_expense}$ {unit}",
                f"After second: ${initial - first_expense} - {second_expense} = {initial - first_expense - second_expense}$ {unit}",
                f"After third: ${initial - first_expense - second_expense} - {third_expense} = {ans}$ {unit}"
            )
        )

emit(generate())