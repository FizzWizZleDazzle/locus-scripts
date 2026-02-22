"""
algebra1 - compound_inequalities (easy)
Generated: 2026-02-22T03:51:43.857103
"""

from problem_utils import *

def generate():
    # For compound inequalities at 1000-1300 ELO, we want simple problems
    # Types: "and" conjunctions or "or" disjunctions with single-step inequalities
    
    problem_type = choice(['and_basic', 'or_basic', 'and_solve', 'or_solve'])
    
    if problem_type == 'and_basic':
        # Simple "and" with x already isolated: a < x < b
        a_val = randint(-10, 5)
        b_val = randint(a_val + 2, a_val + 10)
        
        question = f"Solve: ${a_val} < x < {b_val}$"
        answer = fmt_interval(a_val, b_val, True, True)
        difficulty = (1000, 1100)
        solution = steps(
            f"This is already in standard form.",
            f"$x$ is between ${a_val}$ and ${b_val}$ (not including endpoints).",
            f"Interval notation: $({a_val}, {b_val})$"
        )
    
    elif problem_type == 'or_basic':
        # Simple "or" with x already isolated: x < a or x > b
        a_val = randint(-5, 5)
        b_val = randint(a_val + 3, a_val + 10)
        
        question = f"Solve: $x < {a_val}$ or $x > {b_val}$"
        answer = f"(-inf,{a_val}) U ({b_val},inf)"
        difficulty = (1050, 1150)
        solution = steps(
            f"This is a disjunction (or statement).",
            f"$x$ is less than ${a_val}$ OR greater than ${b_val}$.",
            f"Interval notation: $(-\\infty, {a_val}) \\cup ({b_val}, \\infty)$"
        )
    
    elif problem_type == 'and_solve':
        # Two-step "and": a < x + b < c, need to subtract b
        b_val = nonzero(-5, 5)
        a_val = randint(-10, 5)
        c_val = randint(a_val + 3, a_val + 12)
        
        left_bound = a_val - b_val
        right_bound = c_val - b_val
        
        question = f"Solve: ${a_val} < x + {b_val} < {c_val}$"
        answer = fmt_interval(left_bound, right_bound, True, True)
        difficulty = (1150, 1300)
        solution = steps(
            f"Subtract ${b_val}$ from all parts:",
            f"${a_val} - {b_val} < x + {b_val} - {b_val} < {c_val} - {b_val}$",
            f"${left_bound} < x < {right_bound}$",
            f"Interval notation: $({left_bound}, {right_bound})$"
        )
    
    else:  # or_solve
        # Simple "or" requiring one-step solving: x + a < b or x + a > c
        a_val = nonzero(-5, 5)
        b_val = randint(-8, 3)
        c_val = randint(b_val + 4, b_val + 12)
        
        left_bound = b_val - a_val
        right_bound = c_val - a_val
        
        question = f"Solve: $x + {a_val} < {b_val}$ or $x + {a_val} > {c_val}$"
        answer = f"(-inf,{left_bound}) U ({right_bound},inf)"
        difficulty = (1200, 1300)
        solution = steps(
            f"Solve each inequality separately by subtracting ${a_val}$:",
            f"$x + {a_val} < {b_val}$ gives $x < {left_bound}$",
            f"$x + {a_val} > {c_val}$ gives $x > {right_bound}$",
            f"Interval notation: $(-\\infty, {left_bound}) \\cup ({right_bound}, \\infty)$"
        )
    
    return problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        topic="algebra1/compound_inequalities",
        solution=solution,
        answer_type="interval"
    )

emit(generate())