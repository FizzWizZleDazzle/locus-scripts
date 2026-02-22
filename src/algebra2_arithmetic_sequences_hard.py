"""
algebra2 - arithmetic_sequences (hard)
Generated: 2026-02-22T04:34:25.608215
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find the nth term given non-consecutive terms (1600-1700)
        # Example: a_5 = 17, a_12 = 38, find a_20
        pos1 = randint(3, 8)
        pos2 = pos1 + randint(5, 9)
        target_pos = pos2 + randint(6, 12)
        
        d = choice([2, 3, 4, 5, -2, -3, -4])
        a1 = randint(-10, 10)
        
        val1 = a1 + (pos1 - 1) * d
        val2 = a1 + (pos2 - 1) * d
        ans = a1 + (target_pos - 1) * d
        
        return problem(
            question=f"In an arithmetic sequence, $a_{{{pos1}}} = {val1}$ and $a_{{{pos2}}} = {val2}$. Find $a_{{{target_pos}}}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 + (n-1)d$ to set up two equations:",
                f"$a_{{{pos1}}} = a_1 + {pos1-1}d = {val1}$",
                f"$a_{{{pos2}}} = a_1 + {pos2-1}d = {val2}$",
                f"Subtract the first from the second: ${pos2-pos1}d = {val2 - val1}$",
                f"So $d = {d}$",
                f"Substitute back: $a_1 + {pos1-1}({d}) = {val1}$, giving $a_1 = {a1}$",
                f"Now find $a_{{{target_pos}}} = {a1} + {target_pos-1}({d}) = {ans}$"
            )
        )
    
    elif problem_type == 2:
        # Sum of arithmetic sequence with constraint (1650-1750)
        # Example: First term is 5, last term is 89, sum is 705. How many terms?
        num_terms = randint(12, 20)
        a1 = randint(-8, 15)
        d = nonzero(-5, 6)
        
        an = a1 + (num_terms - 1) * d
        sum_val = num_terms * (a1 + an) // 2
        
        return problem(
            question=f"An arithmetic sequence has first term $a_1 = {a1}$ and last term $a_n = {an}$. If the sum of all terms is ${sum_val}$, how many terms are in the sequence?",
            answer=num_terms,
            difficulty=(1650, 1750),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use the sum formula: $S_n = \\frac{{n(a_1 + a_n)}}{2}$",
                f"Substitute: ${sum_val} = \\frac{{n({a1} + {an})}}{2}$",
                f"${sum_val} = \\frac{{n \\cdot {a1 + an}}}{2}$",
                f"${2 * sum_val} = {a1 + an}n$",
                f"$n = \\frac{{{2 * sum_val}}}{{{a1 + an}}} = {num_terms}$"
            )
        )
    
    elif problem_type == 3:
        # Finding which term equals a specific value (1600-1700)
        # Example: a_1 = 7, d = 4, for what n does a_n = 83?
        a1 = randint(-10, 15)
        d = nonzero(-6, 7)
        term_num = randint(15, 30)
        
        target_val = a1 + (term_num - 1) * d
        
        return problem(
            question=f"In an arithmetic sequence with $a_1 = {a1}$ and common difference $d = {d}$, which term has value ${target_val}$?",
            answer=term_num,
            difficulty=(1600, 1700),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use $a_n = a_1 + (n-1)d$",
                f"${target_val} = {a1} + (n-1)({d})$",
                f"${target_val - a1} = (n-1)({d})$",
                f"$n - 1 = {(target_val - a1) // d}$",
                f"$n = {term_num}$"
            )
        )
    
    elif problem_type == 4:
        # Sum of terms from position p to position q (1700-1800)
        start_pos = randint(8, 15)
        end_pos = start_pos + randint(10, 18)
        
        a1 = randint(-8, 12)
        d = nonzero(-4, 5)
        
        a_start = a1 + (start_pos - 1) * d
        a_end = a1 + (end_pos - 1) * d
        num_terms = end_pos - start_pos + 1
        ans = num_terms * (a_start + a_end) // 2
        
        return problem(
            question=f"An arithmetic sequence has first term $a_1 = {a1}$ and common difference $d = {d}$. Find the sum of the terms from $a_{{{start_pos}}}$ to $a_{{{end_pos}}}$ (inclusive).",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"First find $a_{{{start_pos}}} = {a1} + {start_pos-1}({d}) = {a_start}$",
                f"Then find $a_{{{end_pos}}} = {a1} + {end_pos-1}({d}) = {a_end}$",
                f"Number of terms from position {start_pos} to {end_pos}: ${end_pos} - {start_pos} + 1 = {num_terms}$",
                f"Sum = $\\frac{{{num_terms}({a_start} + {a_end})}}{2} = {ans}$"
            )
        )
    
    else:
        # System problem: sum and product constraints (1750-1900)
        # Given sum of first n terms and a specific term, find other parameters
        num_terms = randint(10, 16)
        d = nonzero(-5, 5)
        a1 = randint(5, 20)
        
        specific_pos = randint(5, 8)
        specific_val = a1 + (specific_pos - 1) * d
        
        sum_n = num_terms * (2 * a1 + (num_terms - 1) * d) // 2
        
        return problem(
            question=f"An arithmetic sequence satisfies $a_{{{specific_pos}}} = {specific_val}$ and the sum of the first ${num_terms}$ terms is ${sum_n}$. Find the common difference $d$.",
            answer=d,
            difficulty=(1750, 1850),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"From $a_{{{specific_pos}}} = {specific_val}$: $a_1 + {specific_pos - 1}d = {specific_val}$ ... (1)",
                f"From $S_{{{num_terms}}} = {sum_n}$: $\\frac{{{num_terms}(2a_1 + {num_terms-1}d)}}{2} = {sum_n}$",
                f"Simplify: ${num_terms}a_1 + {num_terms*(num_terms-1)//2}d = {sum_n}$ ... (2)",
                f"From equation (1): $a_1 = {specific_val} - {specific_pos - 1}d$",
                f"Substitute into (2): ${num_terms}({specific_val} - {specific_pos - 1}d) + {num_terms*(num_terms-1)//2}d = {sum_n}$",
                f"${num_terms * specific_val} - {num_terms * (specific_pos - 1)}d + {num_terms*(num_terms-1)//2}d = {sum_n}$",
                f"${num_terms*(num_terms-1)//2 - num_terms*(specific_pos-1)}d = {sum_n - num_terms * specific_val}$",
                f"$d = {d}$"
            )
        )

emit(generate())