"""
algebra1 - linear_inequalities (easy)
Generated: 2026-02-22T03:50:09.465597
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # One-step inequality: ax > b or ax < b (1000-1150)
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        ineq_sign = choice(['>', '<', '>=', '<='])
        
        if a > 0:
            if ineq_sign == '>':
                solution_val = b / a
                solution_sign = '>'
            elif ineq_sign == '<':
                solution_val = b / a
                solution_sign = '<'
            elif ineq_sign == '>=':
                solution_val = b / a
                solution_sign = r'\geq'
            else:  # <=
                solution_val = b / a
                solution_sign = r'\leq'
        else:  # a < 0, flip the sign
            if ineq_sign == '>':
                solution_val = b / a
                solution_sign = '<'
            elif ineq_sign == '<':
                solution_val = b / a
                solution_sign = '>'
            elif ineq_sign == '>=':
                solution_val = b / a
                solution_sign = r'\leq'
            else:  # <=
                solution_val = b / a
                solution_sign = r'\geq'
        
        ans_str = f"x {solution_sign} {latex(Rational(b, a).limit_denominator())}"
        
        return problem(
            question=f"Solve for $x$: ${latex(a*x)} {ineq_sign} {b}$",
            answer=ans_str,
            difficulty=(1000, 1150),
            topic="algebra1/linear_inequalities",
            answer_type="expression",
            solution=steps(
                f"Divide both sides by ${a}$",
                f"$x {solution_sign} {latex(Rational(b, a).limit_denominator())}$" + 
                (f" (sign flips because we divided by a negative)" if a < 0 else "")
            )
        )
    
    elif problem_type == 2:
        # Two-step inequality: ax + b > c (1150-1300)
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        c = randint(-10, 10)
        ineq_sign = choice(['>', '<', '>=', '<='])
        
        # Solution: x ineq_sign (c - b) / a
        numerator = c - b
        
        if a > 0:
            if ineq_sign == '>':
                solution_sign = '>'
            elif ineq_sign == '<':
                solution_sign = '<'
            elif ineq_sign == '>=':
                solution_sign = r'\geq'
            else:  # <=
                solution_sign = r'\leq'
        else:  # a < 0, flip the sign
            if ineq_sign == '>':
                solution_sign = '<'
            elif ineq_sign == '<':
                solution_sign = '>'
            elif ineq_sign == '>=':
                solution_sign = r'\leq'
            else:  # <=
                solution_sign = r'\geq'
        
        ans_str = f"x {solution_sign} {latex(Rational(numerator, a).limit_denominator())}"
        
        # Format question nicely
        if b >= 0:
            question_str = f"${latex(a*x)} + {b} {ineq_sign} {c}$"
        else:
            question_str = f"${latex(a*x)} - {-b} {ineq_sign} {c}$"
        
        return problem(
            question=f"Solve for $x$: {question_str}",
            answer=ans_str,
            difficulty=(1150, 1300),
            topic="algebra1/linear_inequalities",
            answer_type="expression",
            solution=steps(
                f"Subtract ${b}$ from both sides: ${latex(a*x)} {ineq_sign} {c - b}$",
                f"Divide both sides by ${a}$",
                f"$x {solution_sign} {latex(Rational(numerator, a).limit_denominator())}$" +
                (f" (sign flips because we divided by a negative)" if a < 0 else "")
            )
        )
    
    elif problem_type == 3:
        # Simple compound inequality: a < x < b (1100-1200)
        a = randint(-10, 5)
        b = a + randint(2, 8)
        
        return problem(
            question=f"Is $x = {a + 1}$ a solution to ${a} < x < {b}$?",
            answer=True,
            difficulty=(1100, 1200),
            topic="algebra1/linear_inequalities",
            answer_type="boolean",
            solution=steps(
                f"Check if ${a} < {a + 1} < {b}$",
                f"Since ${a} < {a + 1}$ is true and ${a + 1} < {b}$ is true,",
                f"$x = {a + 1}$ is a solution"
            )
        )
    
    else:  # problem_type == 4
        # Graph interpretation: which values satisfy inequality (1200-1300)
        a = nonzero(-3, 3)
        b = randint(-5, 5)
        c = randint(-8, 8)
        
        # ax + b > c means x > (c-b)/a or x < (c-b)/a
        boundary = Rational(c - b, a).limit_denominator()
        
        if a > 0:
            ineq_sign = '>'
            ans_str = f"x > {latex(boundary)}"
        else:
            ineq_sign = '<'
            ans_str = f"x < {latex(boundary)}"
        
        if b >= 0:
            question_str = f"${latex(a*x)} + {b} > {c}$"
        else:
            question_str = f"${latex(a*x)} - {-b} > {c}$"
        
        return problem(
            question=f"Solve for $x$: {question_str}",
            answer=ans_str,
            difficulty=(1200, 1300),
            topic="algebra1/linear_inequalities",
            answer_type="expression",
            solution=steps(
                f"Subtract ${b}$ from both sides: ${latex(a*x)} > {c - b}$",
                f"Divide both sides by ${a}$",
                f"$x {ineq_sign} {latex(boundary)}$" +
                (f" (sign flips because we divided by a negative)" if a < 0 else "")
            )
        )

emit(generate())