"""
algebra1 - multi_step_equations (hard)
Generated: 2026-02-22T03:49:47.535855
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Equations with variables on both sides and nested parentheses
        # e.g., 2(3x - 4) - 5(x + 1) = 3(2x - 1) + 7
        a1 = nonzero(-4, 4)
        b1 = nonzero(-6, 6)
        a2 = nonzero(-4, 4)
        b2 = nonzero(-6, 6)
        a3 = nonzero(-4, 4)
        b3 = nonzero(-6, 6)
        c = nonzero(-8, 8)
        
        left_side = a1*(a2*x + b1) + a3*(b2*x + b3)
        right_side = c
        
        left_expanded = expand(left_side)
        solutions = solve(Eq(left_expanded, right_side), x)
        
        if solutions and len(solutions) == 1:
            ans = solutions[0]
            if ans.is_rational and abs(ans) < 100:
                left_latex = f"{a1}({a2}x {'+' if b1 >= 0 else ''}{b1}) {'+' if a3 >= 0 else ''}{a3}({b2}x {'+' if b3 >= 0 else ''}{b3})"
                
                return problem(
                    question=f"Solve for $x$: ${left_latex} = {c}$",
                    answer=ans,
                    difficulty=(1600, 1750),
                    topic="algebra1/multi_step_equations",
                    solution=steps(
                        f"Distribute: ${latex(left_expanded)} = {c}$",
                        f"Combine like terms and solve",
                        f"$x = {latex(ans)}$"
                    )
                )
    
    if problem_type == 2:
        # Type 2: Equations with fractions on both sides
        # e.g., (2x + 3)/4 - (x - 1)/3 = (x + 5)/6
        a1 = nonzero(-5, 5)
        b1 = nonzero(-8, 8)
        d1 = choice([2, 3, 4, 5, 6])
        
        a2 = nonzero(-5, 5)
        b2 = nonzero(-8, 8)
        d2 = choice([2, 3, 4, 5, 6])
        if d2 == d1:
            d2 = choice([d for d in [2, 3, 4, 5, 6] if d != d1])
        
        a3 = nonzero(-5, 5)
        b3 = nonzero(-8, 8)
        d3 = choice([2, 3, 4, 5, 6])
        
        equation = Eq((a1*x + b1)/d1 - (a2*x + b2)/d2, (a3*x + b3)/d3)
        solutions = solve(equation, x)
        
        if solutions and len(solutions) == 1:
            ans = solutions[0]
            if ans.is_rational and abs(ans) < 100:
                return problem(
                    question=f"Solve for $x$: $\\frac{{{a1}x {'+' if b1 >= 0 else ''}{b1}}}{{{d1}}} - \\frac{{{a2}x {'+' if b2 >= 0 else ''}{b2}}}{{{d3}}} = \\frac{{{a3}x {'+' if b3 >= 0 else ''}{b3}}}{{{d3}}}$",
                    answer=ans,
                    difficulty=(1650, 1800),
                    topic="algebra1/multi_step_equations",
                    solution=steps(
                        f"Multiply through by LCD to clear fractions",
                        f"Simplify and combine like terms",
                        f"$x = {latex(ans)}$"
                    )
                )
    
    if problem_type == 3:
        # Type 3: Complex distribution with collection of like terms
        # e.g., 3(2x - 1) - 4(x + 2) + 2(3x - 5) = 7x + 1
        a1 = nonzero(-5, 5)
        b1 = nonzero(-7, 7)
        c1 = nonzero(-5, 5)
        
        a2 = nonzero(-5, 5)
        b2 = nonzero(-7, 7)
        c2 = nonzero(-5, 5)
        
        a3 = nonzero(-5, 5)
        b3 = nonzero(-7, 7)
        c3 = nonzero(-5, 5)
        
        right_a = nonzero(-7, 7)
        right_b = nonzero(-10, 10)
        
        left_side = a1*(c1*x + b1) + a2*(c2*x + b2) + a3*(c3*x + b3)
        right_side = right_a*x + right_b
        
        left_expanded = expand(left_side)
        solutions = solve(Eq(left_expanded, right_side), x)
        
        if solutions and len(solutions) == 1:
            ans = solutions[0]
            if ans.is_rational and abs(ans) < 100:
                left_latex = f"{a1}({c1}x {'+' if b1 >= 0 else ''}{b1}) {'+' if a2 >= 0 else ''}{a2}({c2}x {'+' if b2 >= 0 else ''}{b2}) {'+' if a3 >= 0 else ''}{a3}({c3}x {'+' if b3 >= 0 else ''}{b3})"
                
                return problem(
                    question=f"Solve for $x$: ${left_latex} = {right_a}x {'+' if right_b >= 0 else ''}{right_b}$",
                    answer=ans,
                    difficulty=(1600, 1750),
                    topic="algebra1/multi_step_equations",
                    solution=steps(
                        f"Distribute all terms: ${latex(left_expanded)} = {right_a}x {'+' if right_b >= 0 else ''}{right_b}$",
                        f"Move all $x$ terms to one side",
                        f"$x = {latex(ans)}$"
                    )
                )
    
    if problem_type == 4:
        # Type 4: Nested parentheses with distribution
        # e.g., 2[3(x - 1) + 4] - 5[2(x + 3) - 1] = 8
        outer1 = nonzero(-4, 4)
        inner1_a = nonzero(-3, 3)
        inner1_b = nonzero(-6, 6)
        add1 = nonzero(-5, 5)
        
        outer2 = nonzero(-4, 4)
        inner2_a = nonzero(-3, 3)
        inner2_b = nonzero(-6, 6)
        add2 = nonzero(-5, 5)
        
        rhs = nonzero(-15, 15)
        
        left_side = outer1*(inner1_a*(x + inner1_b) + add1) + outer2*(inner2_a*(x + inner2_b) + add2)
        left_expanded = expand(left_side)
        
        solutions = solve(Eq(left_expanded, rhs), x)
        
        if solutions and len(solutions) == 1:
            ans = solutions[0]
            if ans.is_rational and abs(ans) < 100:
                return problem(
                    question=f"Solve for $x$: ${outer1}[{inner1_a}(x {'+' if inner1_b >= 0 else ''}{inner1_b}) {'+' if add1 >= 0 else ''}{add1}] {'+' if outer2 >= 0 else ''}{outer2}[{inner2_a}(x {'+' if inner2_b >= 0 else ''}{inner2_b}) {'+' if add2 >= 0 else ''}{add2}] = {rhs}$",
                    answer=ans,
                    difficulty=(1700, 1850),
                    topic="algebra1/multi_step_equations",
                    solution=steps(
                        f"Distribute inner parentheses first",
                        f"Then distribute outer brackets",
                        f"Simplify: ${latex(left_expanded)} = {rhs}$",
                        f"$x = {latex(ans)}$"
                    )
                )
    
    # Type 5: Equations with multiple fractions and parentheses
    # e.g., (3x - 2)/4 + (2x + 1)/3 = (x - 5)/2 + 1
    a1 = nonzero(-4, 4)
    b1 = nonzero(-8, 8)
    d1 = choice([2, 3, 4, 6])
    
    a2 = nonzero(-4, 4)
    b2 = nonzero(-8, 8)
    d2 = choice([2, 3, 4, 6])
    
    a3 = nonzero(-4, 4)
    b3 = nonzero(-8, 8)
    d3 = choice([2, 3, 4, 6])
    
    constant = nonzero(-5, 5)
    
    equation = Eq((a1*x + b1)/d1 + (a2*x + b2)/d2, (a3*x + b3)/d3 + constant)
    solutions = solve(equation, x)
    
    if solutions and len(solutions) == 1:
        ans = solutions[0]
        if ans.is_rational and abs(ans) < 100:
            return problem(
                question=f"Solve for $x$: $\\frac{{{a1}x {'+' if b1 >= 0 else ''}{b1}}}{{{d1}}} + \\frac{{{a2}x {'+' if b2 >= 0 else ''}{b2}}}{{{d2}}} = \\frac{{{a3}x {'+' if b3 >= 0 else ''}{b3}}}{{{d3}}} {'+' if constant >= 0 else ''}{constant}$",
                answer=ans,
                difficulty=(1700, 1900),
                topic="algebra1/multi_step_equations",
                solution=steps(
                    f"Find LCD and multiply through to clear fractions",
                    f"Distribute and combine like terms",
                    f"$x = {latex(ans)}$"
                )
            )
    
    # Fallback to simple harder problem
    a = nonzero(-5, 5)
    b = nonzero(-8, 8)
    c = nonzero(-5, 5)
    d = nonzero(-8, 8)
    e = nonzero(-10, 10)
    
    left = a*(b*x + c) + d*x
    left_expanded = expand(left)
    solutions = solve(Eq(left_expanded, e), x)
    ans = solutions[0]
    
    return problem(
        question=f"Solve for $x$: ${a}({b}x {'+' if c >= 0 else ''}{c}) {'+' if d >= 0 else ''}{d}x = {e}$",
        answer=ans,
        difficulty=(1600, 1700),
        topic="algebra1/multi_step_equations",
        solution=steps(
            f"Distribute: ${latex(left_expanded)} = {e}$",
            f"$x = {latex(ans)}$"
        )
    )

emit(generate())