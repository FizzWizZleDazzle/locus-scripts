"""
arithmetic - addition (hard)
Generated: 2026-02-22T03:37:50.528975
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Multi-digit addition with carrying in multiple places
        num1 = randint(4567, 9876)
        num2 = randint(3456, 8765)
        ans = num1 + num2
        
        return problem(
            question=f"Calculate: ${num1} + {num2}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/addition",
            solution=steps(
                f"Add the numbers column by column from right to left:",
                f"${num1} + {num2} = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Sum of arithmetic sequence
        first = randint(15, 45)
        diff = randint(3, 12)
        n_terms = randint(8, 15)
        last = first + (n_terms - 1) * diff
        ans = n_terms * (first + last) // 2
        
        return problem(
            question=f"Find the sum: ${first} + {first + diff} + {first + 2*diff} + \\ldots + {last}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="arithmetic/addition",
            solution=steps(
                f"This is an arithmetic sequence with first term $a = {first}$, common difference $d = {diff}$, and ${n_terms}$ terms",
                f"Last term: ${last}$",
                f"Sum formula: $S = \\frac{{n(a_1 + a_n)}}{2} = \\frac{{{n_terms}({first} + {last})}}{2}$",
                f"$S = \\frac{{{n_terms} \\cdot {first + last}}}{2} = \\frac{{{n_terms * (first + last)}}}{2} = {ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Addition with multiple large numbers
        nums = [randint(1234, 8765) for _ in range(randint(4, 6))]
        ans = sum(nums)
        terms_str = " + ".join(str(n) for n in nums)
        
        return problem(
            question=f"Calculate: ${terms_str}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="arithmetic/addition",
            solution=steps(
                f"Add all numbers:",
                f"${terms_str} = {ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Word problem with multiple additions
        items = randint(4, 6)
        prices = [randint(125, 875) for _ in range(items)]
        total = sum(prices)
        
        prices_str = ", ".join(f"\\${p}" for p in prices[:-1]) + f", and \\${prices[-1]}"
        
        return problem(
            question=f"A customer purchases {items} items priced at {prices_str}. What is the total cost in cents?",
            answer=total,
            difficulty=(1600, 1700),
            topic="arithmetic/addition",
            solution=steps(
                f"Add all prices: ${' + '.join(str(p) for p in prices)}$",
                f"Total: ${total}$ cents"
            ),
        )
    
    else:
        # Sum of numbers following a pattern
        start = randint(100, 300)
        multiplier = randint(2, 4)
        terms = randint(6, 9)
        
        sequence = [start * (multiplier ** i) for i in range(terms)]
        ans = sum(sequence)
        
        seq_str = " + ".join(str(s) for s in sequence)
        
        return problem(
            question=f"Calculate: ${seq_str}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="arithmetic/addition",
            solution=steps(
                f"This is a geometric sequence with first term ${start}$ and ratio ${multiplier}$",
                f"Add all terms: ${seq_str}$",
                f"Sum: ${ans}$"
            ),
        )

emit(generate())