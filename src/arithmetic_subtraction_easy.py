"""
arithmetic - subtraction (easy)
Generated: 2026-02-22T03:38:05.848939
"""

from problem_utils import *

def generate():
    # For 1000-1300 ELO subtraction problems, we want:
    # - 1000-1100: simple single-digit or small two-digit subtraction
    # - 1100-1200: two-digit subtraction, may require borrowing
    # - 1200-1300: three-digit subtraction or word problems
    
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # 1000-1100: Simple subtraction, no borrowing needed
        minuend = randint(10, 50)
        subtrahend = randint(1, minuend - 1)
        ans = minuend - subtrahend
        
        return problem(
            question=f"${minuend} - {subtrahend} = ?$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/subtraction",
            solution=f"${minuend} - {subtrahend} = {ans}$"
        )
    
    elif difficulty_choice == 2:
        # 1100-1200: Two-digit subtraction, may require borrowing
        minuend = randint(20, 99)
        subtrahend = randint(10, minuend - 1)
        ans = minuend - subtrahend
        
        # Check if borrowing is needed (makes it slightly harder)
        needs_borrowing = (minuend % 10) < (subtrahend % 10)
        
        if needs_borrowing:
            solution_text = steps(
                f"Subtract ones place: borrow from tens since ${minuend % 10} < {subtrahend % 10}$",
                f"Subtract tens place after borrowing",
                f"${minuend} - {subtrahend} = {ans}$"
            )
        else:
            solution_text = steps(
                f"Subtract ones place: ${minuend % 10} - {subtrahend % 10} = {(minuend - subtrahend) % 10}$",
                f"Subtract tens place: ${minuend // 10} - {subtrahend // 10} = {(minuend - subtrahend) // 10}$",
                f"${minuend} - {subtrahend} = {ans}$"
            )
        
        return problem(
            question=f"${minuend} - {subtrahend} = ?$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/subtraction",
            solution=solution_text
        )
    
    else:
        # 1200-1300: Three-digit subtraction or simple word problem
        if randint(1, 2) == 1:
            # Three-digit subtraction
            minuend = randint(100, 999)
            subtrahend = randint(10, minuend - 1)
            ans = minuend - subtrahend
            
            return problem(
                question=f"${minuend} - {subtrahend} = ?$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="arithmetic/subtraction",
                solution=steps(
                    f"Line up the digits by place value",
                    f"Subtract each place value from right to left, borrowing if necessary",
                    f"${minuend} - {subtrahend} = {ans}$"
                )
            )
        else:
            # Simple word problem
            total = randint(20, 100)
            used = randint(5, total - 5)
            remaining = total - used
            
            items = choice(["apples", "pencils", "books", "marbles", "cookies"])
            
            return problem(
                question=f"Sarah had ${total}$ {items}. She gave away ${used}$ {items}. How many {items} does she have left?",
                answer=remaining,
                difficulty=(1200, 1300),
                topic="arithmetic/subtraction",
                solution=steps(
                    f"Sarah started with ${total}$ {items}",
                    f"She gave away ${used}$ {items}",
                    f"Subtract: ${total} - {used} = {remaining}$",
                    f"Sarah has ${remaining}$ {items} left"
                )
            )

emit(generate())