"""
algebra2 - geometric_sequences (medium)
Generated: 2026-02-22T04:35:14.509855
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find nth term given first term and ratio (ELO ~1300)
        a1 = nonzero(-10, 10)
        r = choice([2, 3, -2, -3, Rational(1, 2), Rational(1, 3), Rational(2, 3)])
        n_val = randint(4, 7)
        
        ans = a1 * r**(n_val - 1)
        
        return problem(
            question=f"Find the {n_val}th term of the geometric sequence with first term $a_1 = {latex(a1)}$ and common ratio $r = {latex(r)}$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 \\cdot r^{{n-1}}$",
                f"$a_{{{n_val}}} = {latex(a1)} \\cdot ({latex(r)})^{{{n_val}-1}}$",
                f"$a_{{{n_val}}} = {latex(a1)} \\cdot ({latex(r)})^{{{n_val - 1}}}$",
                f"$a_{{{n_val}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Find common ratio given two terms (ELO ~1400)
        r = choice([2, 3, -2, Rational(1, 2), Rational(1, 3)])
        n1 = randint(2, 4)
        n2 = n1 + randint(1, 3)
        a1 = nonzero(-8, 8)
        
        term1 = a1 * r**(n1 - 1)
        term2 = a1 * r**(n2 - 1)
        
        ans = r
        
        return problem(
            question=f"In a geometric sequence, $a_{{{n1}}} = {latex(term1)}$ and $a_{{{n2}}} = {latex(term2)}$. Find the common ratio $r$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the relationship $a_{{{n2}}} = a_{{{n1}}} \\cdot r^{{{n2 - n1}}}$",
                f"${latex(term2)} = {latex(term1)} \\cdot r^{{{n2 - n1}}}$",
                f"$r^{{{n2 - n1}}} = \\frac{{{latex(term2)}}}{{{latex(term1)}}} = {latex(term2/term1)}$",
                f"$r = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Find sum of first n terms (ELO ~1500)
        a1 = nonzero(-8, 8)
        r = choice([2, 3, Rational(1, 2), Rational(1, 3), Rational(2, 3)])
        n_val = randint(4, 6)
        
        if r != 1:
            ans = a1 * (1 - r**n_val) / (1 - r)
        else:
            ans = a1 * n_val
        
        return problem(
            question=f"Find the sum of the first {n_val} terms of the geometric sequence with first term $a_1 = {latex(a1)}$ and common ratio $r = {latex(r)}$.",
            answer=ans,
            difficulty=(1400, 1600),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $S_n = a_1 \\cdot \\frac{{1 - r^n}}{{1 - r}}$",
                f"$S_{{{n_val}}} = {latex(a1)} \\cdot \\frac{{1 - ({latex(r)})^{{{n_val}}}}}{{1 - {latex(r)}}}$",
                f"$S_{{{n_val}}} = {latex(a1)} \\cdot \\frac{{{latex(1 - r**n_val)}}}{{{latex(1 - r)}}}$",
                f"$S_{{{n_val}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Find the first term given nth term and ratio (ELO ~1400)
        r = choice([2, 3, -2, Rational(1, 2), Rational(1, 3)])
        n_val = randint(4, 6)
        a1 = nonzero(-6, 6)
        
        an = a1 * r**(n_val - 1)
        ans = a1
        
        return problem(
            question=f"The {n_val}th term of a geometric sequence is ${latex(an)}$ and the common ratio is $r = {latex(r)}$. Find the first term $a_1$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 \\cdot r^{{n-1}}$",
                f"${latex(an)} = a_1 \\cdot ({latex(r)})^{{{n_val - 1}}}$",
                f"$a_1 = \\frac{{{latex(an)}}}{{({latex(r)})^{{{n_val - 1}}}}}$",
                f"$a_1 = \\frac{{{latex(an)}}}{{{latex(r**(n_val - 1))}}}$",
                f"$a_1 = {latex(ans)}$"
            ),
        )
    
    else:
        # Geometric mean / find missing term (ELO ~1500)
        r = choice([2, 3, Rational(1, 2), Rational(1, 4)])
        a1 = nonzero(-8, 8)
        
        # Three consecutive terms: a, ar, ar^2
        term1 = a1
        term2 = a1 * r
        term3 = a1 * r**2
        
        ans = term2
        
        return problem(
            question=f"Three consecutive terms of a geometric sequence are ${latex(term1)}$, $x$, and ${latex(term3)}$. Find $x$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"In a geometric sequence, the middle term is the geometric mean",
                f"$x^2 = ({latex(term1)}) \\cdot ({latex(term3)})$",
                f"$x^2 = {latex(term1 * term3)}$",
                f"$x = \\pm {latex(sqrt(abs(term1 * term3)))}$",
                f"Since the terms follow a pattern, $x = {latex(ans)}$"
            ),
        )

emit(generate())