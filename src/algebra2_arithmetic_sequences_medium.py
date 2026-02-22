"""
algebra2 - arithmetic_sequences (medium)
Generated: 2026-02-22T04:33:55.233786
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find the nth term given first term and common difference
        a1 = nonzero(-10, 10)
        d = nonzero(-5, 5)
        n_val = randint(8, 15)
        ans = a1 + (n_val - 1) * d
        
        return problem(
            question=f"Find the {n_val}th term of the arithmetic sequence with first term $a_1 = {a1}$ and common difference $d = {d}$.",
            answer=ans,
            difficulty=(1300, 1400),
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
        n1 = randint(3, 7)
        n2 = n1 + randint(3, 6)
        d = nonzero(-4, 4)
        a_n1 = nonzero(-15, 15)
        a_n2 = a_n1 + (n2 - n1) * d
        
        return problem(
            question=f"In an arithmetic sequence, $a_{{{n1}}} = {a_n1}$ and $a_{{{n2}}} = {a_n2}$. Find the common difference $d$.",
            answer=d,
            difficulty=(1400, 1500),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use $a_{{{n2}}} = a_{{{n1}}} + ({n2}-{n1})d$",
                f"${a_n2} = {a_n1} + {n2-n1}d$",
                f"${a_n2 - a_n1} = {n2-n1}d$",
                f"$d = \\frac{{{a_n2 - a_n1}}}{{{n2-n1}}} = {d}$"
            ),
        )
    
    elif problem_type == 3:
        # Find sum of first n terms
        a1 = nonzero(-8, 8)
        d = nonzero(-4, 4)
        n_val = randint(10, 20)
        an = a1 + (n_val - 1) * d
        ans = n_val * (a1 + an) // 2
        
        return problem(
            question=f"Find the sum of the first {n_val} terms of the arithmetic sequence with $a_1 = {a1}$ and common difference $d = {d}$.",
            answer=ans,
            difficulty=(1450, 1550),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"First find the last term: $a_{{{n_val}}} = {a1} + ({n_val}-1)({d}) = {an}$",
                f"Use the sum formula: $S_n = \\frac{{n(a_1 + a_n)}}{2}$",
                f"$S_{{{n_val}}} = \\frac{{{n_val}({a1} + {an})}}{2}$",
                f"$S_{{{n_val}}} = \\frac{{{n_val}({a1 + an})}}{2} = {ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Find first term given nth term and common difference
        d = nonzero(-5, 5)
        n_val = randint(6, 12)
        a1 = nonzero(-10, 10)
        an = a1 + (n_val - 1) * d
        
        return problem(
            question=f"In an arithmetic sequence with common difference $d = {d}$, the {n_val}th term is $a_{{{n_val}}} = {an}$. Find the first term $a_1$.",
            answer=a1,
            difficulty=(1400, 1500),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 + (n-1)d$",
                f"${an} = a_1 + ({n_val}-1)({d})$",
                f"${an} = a_1 + {(n_val-1)*d}$",
                f"$a_1 = {an} - {(n_val-1)*d} = {a1}$"
            ),
        )
    
    else:
        # Find which term equals a given value
        a1 = nonzero(-15, 15)
        d = nonzero(2, 5) * choice([-1, 1])
        n_val = randint(8, 15)
        target = a1 + (n_val - 1) * d
        
        return problem(
            question=f"In the arithmetic sequence with first term $a_1 = {a1}$ and common difference $d = {d}$, which term equals ${target}$?",
            answer=n_val,
            difficulty=(1500, 1600),
            topic="algebra2/arithmetic_sequences",
            solution=steps(
                f"Use $a_n = a_1 + (n-1)d$ and solve for $n$",
                f"${target} = {a1} + (n-1)({d})$",
                f"${target - a1} = {d}(n-1)$",
                f"$n-1 = \\frac{{{target - a1}}}{{{d}}} = {(target - a1)//d}$",
                f"$n = {n_val}$"
            ),
        )

emit(generate())