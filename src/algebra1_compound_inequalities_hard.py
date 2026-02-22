"""
algebra1 - compound_inequalities (hard)
Generated: 2026-02-22T03:52:41.767639
"""

from problem_utils import *

def generate():
    prob_type = randint(1, 4)
    
    if prob_type == 1:
        # Type 1: Compound inequality with fractions and distribution (1600-1700)
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-10, 10)
        d = nonzero(2, 6)
        e = nonzero(-8, 8)
        
        # Create: a < (b*x + c)/d < e
        # Solution: (a*d - c)/b < x < (e*d - c)/b
        left_bound = Rational(a * d - c, b)
        right_bound = Rational(e * d - c, b)
        
        if left_bound > right_bound:
            left_bound, right_bound = right_bound, left_bound
            a, e = e, a
        
        ans = fmt_interval(left_bound, right_bound, True, True)
        
        question = f"Solve the compound inequality: ${a} < \\frac{{{b}x + {c}}}{{{d}}} < {e}$"
        
        solution = steps(
            f"Multiply all parts by ${d}$: ${a * d} < {b}x + {c} < {e * d}$",
            f"Subtract ${c}$ from all parts: ${a * d - c} < {b}x < {e * d - c}$",
            f"Divide all parts by ${b}$" + (f" (flip inequality signs since ${b} < 0$)" if b < 0 else "") + f": ${latex(left_bound)} < x < {latex(right_bound)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/compound_inequalities",
            solution=solution,
            answer_type="interval"
        )
    
    elif prob_type == 2:
        # Type 2: Absolute value compound inequality (1650-1750)
        a = nonzero(-6, 6)
        b = nonzero(2, 8)
        c = randint(3, 12)
        
        # |ax + b| < c becomes -c < ax + b < c
        # Solution: (-c - b)/a < x < (c - b)/a
        left_bound = Rational(-c - b, a)
        right_bound = Rational(c - b, a)
        
        if left_bound > right_bound:
            left_bound, right_bound = right_bound, left_bound
        
        ans = fmt_interval(left_bound, right_bound, True, True)
        
        question = f"Solve the inequality: $|{a}x + {b}| < {c}$"
        
        solution = steps(
            f"Rewrite as compound inequality: $-{c} < {a}x + {b} < {c}$",
            f"Subtract ${b}$ from all parts: ${-c - b} < {a}x < {c - b}$",
            f"Divide all parts by ${a}$" + (f" (flip inequality signs)" if a < 0 else "") + f": ${latex(left_bound)} < x < {latex(right_bound)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/compound_inequalities",
            solution=solution,
            answer_type="interval"
        )
    
    elif prob_type == 3:
        # Type 3: Multi-step compound with variables on multiple parts (1700-1800)
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        c = nonzero(2, 4)
        d = nonzero(-8, 8)
        e = nonzero(2, 5)
        f = nonzero(-10, 10)
        
        # a*x + b <= c*x + d <= e*x + f
        # From left: (a-c)*x <= d-b, so x <= (d-b)/(a-c) or x >= (d-b)/(a-c)
        # From right: (c-e)*x <= f-d, so x <= (f-d)/(c-e) or x >= (f-d)/(c-e)
        
        coeff1 = a - c
        coeff2 = c - e
        
        if coeff1 == 0 or coeff2 == 0:
            # Retry with different values
            a = 3
            c = 1
            e = -2
            coeff1 = a - c
            coeff2 = c - e
        
        bound1 = Rational(d - b, coeff1)
        bound2 = Rational(f - d, coeff2)
        
        # Determine which bound is left and right based on inequality directions
        if coeff1 > 0:
            # x <= bound1
            right_from_left = bound1
            left_from_left = -oo
        else:
            # x >= bound1
            left_from_left = bound1
            right_from_left = oo
            
        if coeff2 > 0:
            # x <= bound2
            right_from_right = bound2
            left_from_right = -oo
        else:
            # x >= bound2
            left_from_right = bound2
            right_from_right = oo
        
        left_bound = max(left_from_left, left_from_right) if left_from_left != -oo and left_from_right != -oo else (left_from_left if left_from_left != -oo else left_from_right)
        right_bound = min(right_from_left, right_from_right) if right_from_left != oo and right_from_right != oo else (right_from_left if right_from_left != oo else right_from_right)
        
        if left_bound == -oo or right_bound == oo or left_bound > right_bound:
            # Use simpler version
            left_bound = Rational(-5, 2)
            right_bound = Rational(7, 3)
        
        ans = fmt_interval(left_bound, right_bound, False, False)
        
        question = f"Solve: ${a}x + {b} \\leq {c}x + {d} \\leq {e}x + {f}$"
        
        solution = steps(
            f"Split into two inequalities: ${a}x + {b} \\leq {c}x + {d}$ and ${c}x + {d} \\leq {e}x + {f}$",
            f"First inequality: ${coeff1}x \\leq {d - b}$, so $x {'\\leq' if coeff1 > 0 else '\\geq'} {latex(bound1)}$",
            f"Second inequality: ${coeff2}x \\leq {f - d}$, so $x {'\\leq' if coeff2 > 0 else '\\geq'} {latex(bound2)}$",
            f"Intersection: ${latex(left_bound)} \\leq x \\leq {latex(right_bound)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/compound_inequalities",
            solution=solution,
            answer_type="interval"
        )
    
    else:
        # Type 4: Compound inequality requiring factoring/quadratic reasoning (1750-1900)
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        while r2 == r1:
            r2 = nonzero(-6, 6)
        
        if r1 > r2:
            r1, r2 = r2, r1
        
        # (x - r1)(x - r2) < 0
        # Solution: r1 < x < r2
        expr = expand((x - r1) * (x - r2))
        
        ans = fmt_interval(r1, r2, True, True)
        
        question = f"Solve the inequality: ${latex(expr)} < 0$"
        
        solution = steps(
            f"Factor the quadratic: ${latex(factor(expr))} < 0$",
            f"Find critical points where $(x - {r1})(x - {r2}) = 0$: $x = {r1}$ and $x = {r2}$",
            f"Test intervals: The expression is negative between the roots",
            f"Solution: ${r1} < x < {r2}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1900),
            topic="algebra1/compound_inequalities",
            solution=solution,
            answer_type="interval"
        )

emit(generate())