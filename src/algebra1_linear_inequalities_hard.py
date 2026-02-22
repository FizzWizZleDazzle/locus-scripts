"""
algebra1 - linear_inequalities (hard)
Generated: 2026-02-22T03:51:27.567854
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Compound inequality with distribution and fractions
        a = nonzero(-4, 4)
        b = nonzero(-8, 8)
        c = nonzero(-10, 10)
        d = nonzero(2, 5)
        e = nonzero(-12, 12)
        f = nonzero(-15, 15)
        
        # Ensure solution exists and is bounded
        left_val = (c - a * d) / b if b != 0 else (c - a * d)
        right_val = (f - a * d) / b if b != 0 else (f - a * d)
        
        if left_val > right_val:
            left_val, right_val = right_val, left_val
            c, f = f, c
        
        inequality = f"{c} < {a}({d}x + {b}) \\leq {f}"
        
        # Solve step by step
        step1 = f"{c} < {a * d}x + {a * b} \\leq {f}"
        step2 = f"{c - a * b} < {a * d}x \\leq {f - a * b}"
        
        if a * d > 0:
            ans_left = Rational(c - a * b, a * d)
            ans_right = Rational(f - a * b, a * d)
            inequality_final = "<"
            inequality_right = "\\leq"
        else:
            ans_left = Rational(f - a * b, a * d)
            ans_right = Rational(c - a * b, a * d)
            inequality_final = "\\geq"
            inequality_right = ">"
            step2 = f"{f - a * b} \\geq {a * d}x > {c - a * b}"
        
        answer = fmt_interval(ans_left, ans_right, True, False)
        
        return problem(
            question=f"Solve the compound inequality: ${inequality}$",
            answer=answer,
            difficulty=(1650, 1750),
            topic="algebra1/linear_inequalities",
            solution=steps(
                f"Distribute the ${a}$: ${step1}$",
                f"Subtract ${a * b}$ from all parts: ${step2}$",
                f"Divide by ${a * d}$ (flip inequality if negative): ${latex(ans_left)} {inequality_final} x {inequality_right} {latex(ans_right)}$",
                f"Interval notation: $({latex(ans_left)}, {latex(ans_right)}]$"
            ),
            answer_type="interval"
        )
    
    elif problem_type == 2:
        # Absolute value inequality (greater than type)
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = randint(3, 10)
        d = nonzero(2, 4)
        
        # |ax + b| > cd creates two cases
        left_bound = Rational(-c * d - b, a)
        right_bound = Rational(c * d - b, a)
        
        if a < 0:
            left_bound, right_bound = right_bound, left_bound
        
        if left_bound > right_bound:
            left_bound, right_bound = right_bound, left_bound
            answer = fmt_interval(left_bound, right_bound, True, True)
            interval_str = f"({latex(left_bound)}, {latex(right_bound)})"
        else:
            answer = f"union:open:-oo,open:{left_bound}|open:{right_bound},open:oo"
            interval_str = f"(-\\infty, {latex(left_bound)}) \\cup ({latex(right_bound)}, \\infty)"
        
        return problem(
            question=f"Solve the inequality: $|{a}x + {b}| > {c * d}$",
            answer=answer,
            difficulty=(1600, 1700),
            topic="algebra1/linear_inequalities",
            solution=steps(
                f"For $|{a}x + {b}| > {c * d}$, we have two cases:",
                f"Case 1: ${a}x + {b} > {c * d}$ gives $x > {latex(right_bound)}$" if a > 0 else f"Case 1: ${a}x + {b} > {c * d}$ gives $x < {latex(left_bound)}$",
                f"Case 2: ${a}x + {b} < {-c * d}$ gives $x < {latex(left_bound)}$" if a > 0 else f"Case 2: ${a}x + {b} < {-c * d}$ gives $x > {latex(right_bound)}$",
                f"Solution: ${interval_str}$"
            ),
            answer_type="interval"
        )
    
    elif problem_type == 3:
        # Absolute value inequality (less than type) with harder coefficients
        a = nonzero(2, 5)
        b = nonzero(-10, 10)
        c = randint(5, 15)
        
        # |ax + b| ≤ c
        left_bound = Rational(-c - b, a)
        right_bound = Rational(c - b, a)
        
        if left_bound > right_bound:
            left_bound, right_bound = right_bound, left_bound
        
        answer = fmt_interval(left_bound, right_bound, False, False)
        
        return problem(
            question=f"Solve the inequality: $|{a}x + {b}| \\leq {c}$",
            answer=answer,
            difficulty=(1650, 1750),
            topic="algebra1/linear_inequalities",
            solution=steps(
                f"Rewrite as: ${-c} \\leq {a}x + {b} \\leq {c}$",
                f"Subtract ${b}$ from all parts: ${-c - b} \\leq {a}x \\leq {c - b}$",
                f"Divide by ${a}$: ${latex(left_bound)} \\leq x \\leq {latex(right_bound)}$",
                f"Interval notation: $[{latex(left_bound)}, {latex(right_bound)}]$"
            ),
            answer_type="interval"
        )
    
    elif problem_type == 4:
        # Rational inequality
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        c = nonzero(-5, 5)
        d = nonzero(-8, 8)
        
        # (ax + b)/(x + c) ≥ d
        # Convert to (ax + b - dx - cd)/(x + c) ≥ 0
        # ((a-d)x + (b-cd))/(x + c) ≥ 0
        
        num_coeff = a - d
        num_const = b - c * d
        
        if num_coeff != 0:
            critical_num = Rational(-num_const, num_coeff)
        else:
            critical_num = 0
        
        critical_denom = -c
        
        # Determine signs based on coefficients
        if num_coeff > 0:
            if critical_num < critical_denom:
                answer = f"union:closed:{critical_num},open:{critical_denom}|open:{critical_denom},open:oo"
            else:
                answer = f"union:open:-oo,open:{critical_denom}|closed:{critical_num},open:oo"
        else:
            if critical_num > critical_denom:
                answer = f"union:open:-oo,open:{critical_denom}|open:{critical_denom},closed:{critical_num}"
            else:
                answer = fmt_interval(critical_num, critical_denom, False, True)
        
        return problem(
            question=f"Solve the inequality: $\\frac{{{a}x + {b}}}{{x + {c}}} \\geq {d}$",
            answer=answer,
            difficulty=(1750, 1850),
            topic="algebra1/linear_inequalities",
            solution=steps(
                f"Subtract ${d}$ from both sides: $\\frac{{{a}x + {b}}}{{x + {c}}} - {d} \\geq 0$",
                f"Combine: $\\frac{{{a}x + {b} - {d}(x + {c})}}{{x + {c}}} \\geq 0$",
                f"Simplify: $\\frac{{{num_coeff}x + {num_const}}}{{x + {c}}} \\geq 0$",
                f"Critical points: $x = {latex(critical_num)}$ (numerator zero), $x = {latex(critical_denom)}$ (denominator zero)",
                f"Test intervals to find where expression is non-negative"
            ),
            answer_type="interval",
            calculator="scientific"
        )
    
    else:
        # System of inequalities
        a = nonzero(-3, 3)
        b = nonzero(-10, 10)
        c = nonzero(-3, 3)
        d = nonzero(-10, 10)
        
        # ax < b and cx > d
        bound1 = Rational(b, a)
        bound2 = Rational(d, c)
        
        if a < 0:
            bound1_ineq = ">"
        else:
            bound1_ineq = "<"
            
        if c < 0:
            bound2_ineq = "<"
        else:
            bound2_ineq = ">"
        
        # Simplify to determine final interval
        left = min(bound1, bound2)
        right = max(bound1, bound2)
        
        if (a > 0 and c > 0 and bound2 < bound1) or (a < 0 and c < 0 and bound2 > bound1):
            answer = fmt_interval(bound2, bound1, True, True)
        else:
            answer = "empty"
        
        return problem(
            question=f"Solve the system of inequalities: ${a}x < {b}$ and ${c}x > {d}$",
            answer=answer,
            difficulty=(1600, 1700),
            topic="algebra1/linear_inequalities",
            solution=steps(
                f"From ${a}x < {b}$: $x {bound1_ineq} {latex(bound1)}$",
                f"From ${c}x > {d}$: $x {bound2_ineq} {latex(bound2)}$",
                f"Find intersection of both conditions",
                f"Solution: $({latex(min(bound2, bound1))}, {latex(max(bound2, bound1))})$" if answer != "empty" else "No solution (empty set)"
            ),
            answer_type="interval"
        )

emit(generate())