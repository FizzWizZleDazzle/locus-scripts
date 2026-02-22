"""
algebra2 - geometric_sequences (hard)
Generated: 2026-02-22T04:35:43.780515
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find the sum of a geometric series with complex expressions
        r_num = nonzero(-3, 3)
        r_den = choice([2, 3, 4, 5])
        r = Rational(r_num, r_den)
        
        # Ensure |r| < 1 for convergence
        while abs(r) >= 1:
            r_num = nonzero(-3, 3)
            r = Rational(r_num, r_den)
        
        a1 = nonzero(-10, 10)
        n_terms = randint(8, 15)
        
        # Sum formula: S_n = a1 * (1 - r^n) / (1 - r)
        ans = a1 * (1 - r**n_terms) / (1 - r)
        ans = simplify(ans)
        
        return problem(
            question=f"Find the sum of the first ${n_terms}$ terms of the geometric sequence with first term $a_1 = {a1}$ and common ratio $r = {latex(r)}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $S_n = a_1 \\cdot \\frac{{1 - r^n}}{{1 - r}}$",
                f"$S_{{{n_terms}}} = {a1} \\cdot \\frac{{1 - \\left({latex(r)}\\right)^{{{n_terms}}}}}{{1 - {latex(r)}}}$",
                f"$S_{{{n_terms}}} = {a1} \\cdot \\frac{{1 - {latex(r**n_terms)}}}{{1 - {latex(r)}}}$",
                f"$S_{{{n_terms}}} = {a1} \\cdot \\frac{{{latex(1 - r**n_terms)}}}{{{latex(1 - r)}}}$",
                f"$S_{{{n_terms}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Find which term equals a specific value in a geometric sequence
        a1 = nonzero(-5, 5)
        r = choice([2, 3, -2, -3, Rational(1,2), Rational(1,3)])
        n_val = randint(5, 9)
        
        target = a1 * r**(n_val - 1)
        
        return problem(
            question=f"In a geometric sequence with first term $a_1 = {a1}$ and common ratio $r = {latex(r)}$, which term equals ${latex(target)}$?",
            answer=n_val,
            difficulty=(1650, 1750),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 \\cdot r^{{n-1}}$",
                f"Set up the equation: ${latex(target)} = {a1} \\cdot {latex(r)}^{{n-1}}$",
                f"${latex(target/a1)} = {latex(r)}^{{n-1}}$",
                f"${latex(r**(n_val-1))} = {latex(r)}^{{n-1}}$",
                f"Therefore $n - 1 = {n_val - 1}$, so $n = {n_val}$"
            )
        )
    
    elif problem_type == 3:
        # Three consecutive terms of geometric sequence, find the middle term
        r_vals = [Rational(1,2), Rational(2,1), Rational(1,3), Rational(3,1), Rational(3,2), Rational(2,3)]
        r = choice(r_vals)
        
        middle = nonzero(-8, 8)
        first = middle / r
        third = middle * r
        
        # Make sure first is an integer or simple fraction
        if first.is_integer:
            first = int(first)
        if third.is_integer:
            third = int(third)
            
        return problem(
            question=f"Three consecutive terms of a geometric sequence are ${latex(first)}$, $x$, and ${latex(third)}$. Find $x$.",
            answer=middle,
            difficulty=(1600, 1700),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"In a geometric sequence, the ratio between consecutive terms is constant",
                f"So $\\frac{{x}}{{{latex(first)}}} = \\frac{{{latex(third)}}}{{x}}$",
                f"Cross multiply: $x^2 = {latex(first)} \\cdot {latex(third)}$",
                f"$x^2 = {latex(first * third)}$",
                f"$x = \\pm {latex(abs(middle))}$",
                f"Since the sequence has ratio $r = {latex(r)}$, we have $x = {latex(middle)}$"
            )
        )
    
    elif problem_type == 4:
        # Infinite geometric series sum
        a1 = nonzero(-12, 12)
        r_vals = [Rational(1,2), Rational(1,3), Rational(1,4), Rational(2,3), Rational(3,4), 
                  Rational(-1,2), Rational(-1,3), Rational(-2,3)]
        r = choice(r_vals)
        
        # Sum of infinite series: S = a1 / (1 - r)
        ans = a1 / (1 - r)
        ans = simplify(ans)
        
        return problem(
            question=f"Find the sum of the infinite geometric series with first term $a_1 = {a1}$ and common ratio $r = {latex(r)}$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"For an infinite geometric series with $|r| < 1$, the sum is $S = \\frac{{a_1}}{{1 - r}}$",
                f"Here $|r| = {latex(abs(r))} < 1$, so the series converges",
                f"$S = \\frac{{{a1}}}{{1 - {latex(r)}}}$",
                f"$S = \\frac{{{a1}}}{{{latex(1 - r)}}}$",
                f"$S = {latex(ans)}$"
            )
        )
    
    else:  # problem_type == 5
        # Find the common ratio given two non-consecutive terms
        n1 = randint(2, 4)
        n2 = randint(6, 10)
        gap = n2 - n1
        
        r_base = choice([2, 3, Rational(1,2), Rational(1,3)])
        a1 = nonzero(-6, 6)
        
        term1_val = a1 * r_base**(n1 - 1)
        term2_val = a1 * r_base**(n2 - 1)
        
        return problem(
            question=f"In a geometric sequence, the ${n1}$-th term is ${latex(term1_val)}$ and the ${n2}$-th term is ${latex(term2_val)}$. Find the common ratio $r$.",
            answer=r_base,
            difficulty=(1700, 1800),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use $a_n = a_1 \\cdot r^{{n-1}}$ for both terms",
                f"$a_{{{n1}}} = a_1 \\cdot r^{{{n1-1}}} = {latex(term1_val)}$",
                f"$a_{{{n2}}} = a_1 \\cdot r^{{{n2-1}}} = {latex(term2_val)}$",
                f"Divide the second equation by the first:",
                f"$\\frac{{a_{{{n2}}}}}{{a_{{{n1}}}}} = \\frac{{a_1 \\cdot r^{{{n2-1}}}}}{{a_1 \\cdot r^{{{n1-1}}}}} = r^{{{gap}}}$",
                f"$\\frac{{{latex(term2_val)}}}{{{latex(term1_val)}}} = r^{{{gap}}}$",
                f"${latex(term2_val / term1_val)} = r^{{{gap}}}$",
                f"$r = {latex(r_base)}$"
            )
        )

emit(generate())