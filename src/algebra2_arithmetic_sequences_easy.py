"""
algebra2 - arithmetic_sequences (easy)
Generated: 2026-02-22T04:33:36.248992
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find the nth term given first term and common difference
        a1 = randint(-10, 10)
        d = nonzero(-5, 5)
        n_val = randint(5, 15)
        ans = a1 + (n_val - 1) * d
        
        return problem(
            question=f"Find the {n_val}th term of the arithmetic sequence with first term $a_1 = {a1}$ and common difference $d = {d}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 + (n-1)d$",
                f"$a_{{{n_val}}} = {a1} + ({n_val}-1)({d})$",
                f"$a_{{{n_val}}} = {a1} + {(n_val-1)*d}$",
                f"$a_{{{n_val}}} = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Find common difference given two terms
        a1 = randint(-10, 10)
        d = nonzero(-5, 5)
        n1 = randint(1, 5)
        n2 = randint(n1 + 2, n1 + 6)
        term1 = a1 + (n1 - 1) * d
        term2 = a1 + (n2 - 1) * d
        ans = d
        
        return problem(
            question=f"In an arithmetic sequence, the {n1}th term is ${term1}$ and the {n2}th term is ${term2}$. Find the common difference.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"The common difference is the change divided by the number of steps",
                f"$d = \\frac{{a_{{{n2}}} - a_{{{n1}}}}}{{{n2} - {n1}}}$",
                f"$d = \\frac{{{term2} - ({term1})}}{{{n2 - n1}}}$",
                f"$d = \\frac{{{term2 - term1}}}{{{n2 - n1}}}$",
                f"$d = {ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Find first term given nth term and common difference
        d = nonzero(-5, 5)
        n_val = randint(4, 10)
        a1 = randint(-10, 10)
        an = a1 + (n_val - 1) * d
        ans = a1
        
        return problem(
            question=f"An arithmetic sequence has common difference $d = {d}$ and the {n_val}th term is ${an}$. Find the first term.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 + (n-1)d$ and solve for $a_1$",
                f"${an} = a_1 + ({n_val}-1)({d})$",
                f"${an} = a_1 + {(n_val-1)*d}$",
                f"$a_1 = {an} - {(n_val-1)*d}$",
                f"$a_1 = {ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Find which term equals a given value
        a1 = randint(-10, 10)
        d = nonzero(-4, 4)
        n_val = randint(5, 12)
        target = a1 + (n_val - 1) * d
        ans = n_val
        
        return problem(
            question=f"In the arithmetic sequence ${a1}, {a1+d}, {a1+2*d}, \\ldots$, which term equals ${target}$?",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"The first term is $a_1 = {a1}$ and common difference is $d = {d}$",
                f"Use $a_n = a_1 + (n-1)d$ and solve for $n$",
                f"${target} = {a1} + (n-1)({d})$",
                f"${target - a1} = (n-1)({d})$",
                f"$n-1 = {(target - a1)//d}$",
                f"$n = {ans}$"
            ),
        )
    
    else:
        # Simple: Find the next term in sequence
        a1 = randint(-10, 10)
        d = nonzero(-6, 6)
        a2 = a1 + d
        a3 = a2 + d
        a4 = a3 + d
        ans = a4
        
        return problem(
            question=f"Find the next term in the arithmetic sequence: ${a1}, {a2}, {a3}, \\ldots$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Find the common difference: $d = {a2} - {a1} = {d}$",
                f"Add the common difference to the last term",
                f"${a3} + {d} = {ans}$"
            ),
        )

emit(generate())