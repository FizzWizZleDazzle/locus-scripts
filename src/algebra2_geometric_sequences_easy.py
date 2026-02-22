"""
algebra2 - geometric_sequences (easy)
Generated: 2026-02-22T04:34:51.560084
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find the nth term given first term and common ratio
        # Difficulty: 1000-1150
        a1 = nonzero(-10, 10)
        r = choice([2, 3, -2, -3, Rational(1,2), Rational(1,3)])
        term_num = randint(3, 6)
        
        ans = a1 * r**(term_num - 1)
        
        if isinstance(r, Rational):
            r_str = f"\\frac{{{r.p}}}{{{r.q}}}"
        else:
            r_str = str(r)
        
        return problem(
            question=f"Find the {term_num}th term of a geometric sequence with first term $a_1 = {a1}$ and common ratio $r = {r_str}$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 \\cdot r^{{n-1}}$",
                f"$a_{{{term_num}}} = {a1} \\cdot ({r_str})^{{{term_num}-1}}$",
                f"$a_{{{term_num}}} = {a1} \\cdot ({r_str})^{{{term_num-1}}}$",
                f"$a_{{{term_num}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Find common ratio given two consecutive terms
        # Difficulty: 1100-1250
        r = choice([2, 3, 4, -2, -3, Rational(1,2), Rational(1,3), Rational(1,4)])
        a_n = nonzero(-20, 20)
        a_n_plus_1 = a_n * r
        
        if isinstance(r, Rational):
            ans = r
        else:
            ans = Integer(r)
        
        return problem(
            question=f"In a geometric sequence, consecutive terms are ${latex(a_n)}$ and ${latex(a_n_plus_1)}$. Find the common ratio $r$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"The common ratio is found by dividing consecutive terms: $r = \\frac{{a_{{n+1}}}}{{a_n}}$",
                f"$r = \\frac{{{latex(a_n_plus_1)}}}{{{latex(a_n)}}}$",
                f"$r = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Find first term given nth term, n, and r
        # Difficulty: 1150-1300
        r = choice([2, 3, -2, Rational(1,2), Rational(1,3)])
        term_num = randint(3, 5)
        a1 = nonzero(-8, 8)
        a_n = a1 * r**(term_num - 1)
        
        if isinstance(r, Rational):
            r_str = f"\\frac{{{r.p}}}{{{r.q}}}"
        else:
            r_str = str(r)
        
        return problem(
            question=f"A geometric sequence has common ratio $r = {r_str}$ and the {term_num}th term is ${latex(a_n)}$. Find the first term $a_1$.",
            answer=a1,
            difficulty=(1150, 1300),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"Use the formula $a_n = a_1 \\cdot r^{{n-1}}$",
                f"${latex(a_n)} = a_1 \\cdot ({r_str})^{{{term_num-1}}}$",
                f"$a_1 = \\frac{{{latex(a_n)}}}{{({r_str})^{{{term_num-1}}}}}$",
                f"$a_1 = {latex(a1)}$"
            )
        )
    
    elif problem_type == 4:
        # Write out the first n terms of a geometric sequence
        # Difficulty: 1000-1100
        a1 = nonzero(-6, 6)
        r = choice([2, 3, -2, Rational(1,2)])
        num_terms = 4
        
        terms = [a1 * r**i for i in range(num_terms)]
        ans = fmt_list([latex(t) for t in terms])
        
        if isinstance(r, Rational):
            r_str = f"\\frac{{{r.p}}}{{{r.q}}}"
        else:
            r_str = str(r)
        
        term_list = ", ".join([f"${latex(t)}$" for t in terms])
        
        return problem(
            question=f"Write the first {num_terms} terms of the geometric sequence with $a_1 = {a1}$ and $r = {r_str}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/geometric_sequences",
            solution=steps(
                f"$a_1 = {a1}$",
                f"$a_2 = a_1 \\cdot r = {a1} \\cdot ({r_str}) = {latex(terms[1])}$",
                f"$a_3 = a_2 \\cdot r = {latex(terms[1])} \\cdot ({r_str}) = {latex(terms[2])}$",
                f"$a_4 = a_3 \\cdot r = {latex(terms[2])} \\cdot ({r_str}) = {latex(terms[3])}$",
                f"The sequence is: {term_list}"
            )
        )
    
    else:
        # Is this a geometric sequence? (Yes/No)
        # Difficulty: 1050-1200
        is_geometric = choice([True, False])
        
        if is_geometric:
            a1 = nonzero(-10, 10)
            r = choice([2, 3, -2, Rational(1,2), Rational(1,3)])
            terms = [a1 * r**i for i in range(4)]
            ans = True
        else:
            # Create a non-geometric sequence
            terms = [randint(1, 5), randint(6, 10), randint(11, 15), randint(16, 20)]
            ans = False
        
        term_str = ", ".join([f"{latex(t)}" for t in terms])
        
        if ans:
            ratio = simplify(terms[1] / terms[0])
            return problem(
                question=f"Is the sequence ${term_str}, \\ldots$ a geometric sequence?",
                answer=ans,
                difficulty=(1050, 1200),
                topic="algebra2/geometric_sequences",
                solution=steps(
                    f"Check if consecutive terms have the same ratio",
                    f"$\\frac{{a_2}}{{a_1}} = \\frac{{{latex(terms[1])}}}{{{latex(terms[0])}}} = {latex(ratio)}$",
                    f"$\\frac{{a_3}}{{a_2}} = \\frac{{{latex(terms[2])}}}{{{latex(terms[1])}}} = {latex(simplify(terms[2]/terms[1]))}$",
                    f"The ratios are constant, so this is a geometric sequence."
                )
            )
        else:
            return problem(
                question=f"Is the sequence ${term_str}, \\ldots$ a geometric sequence?",
                answer=ans,
                difficulty=(1050, 1200),
                topic="algebra2/geometric_sequences",
                solution=steps(
                    f"Check if consecutive terms have the same ratio",
                    f"$\\frac{{a_2}}{{a_1}} = \\frac{{{latex(terms[1])}}}{{{latex(terms[0])}}} = {latex(simplify(terms[1]/terms[0]))}$",
                    f"$\\frac{{a_3}}{{a_2}} = \\frac{{{latex(terms[2])}}}{{{latex(terms[1])}}} = {latex(simplify(terms[2]/terms[1]))}$",
                    f"The ratios are not constant, so this is not a geometric sequence."
                )
            )

emit(generate())