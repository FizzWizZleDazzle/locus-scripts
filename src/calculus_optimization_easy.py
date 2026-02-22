"""
calculus - optimization (easy)
Generated: 2026-02-22T05:08:37.011165
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Find critical points of a simple quadratic (1000-1200)
        a_val = choice([-2, -1, 1, 2])
        h = nonzero(-5, 5)
        k = randint(-10, 10)
        # f(x) = a(x - h)^2 + k, critical point at x = h
        expr = a_val * (x - h)**2 + k
        expr_expanded = expand(expr)
        
        derivative = diff(expr_expanded, x)
        critical_pt = h
        
        return problem(
            question=f"Find the critical point of $f(x) = {latex(expr_expanded)}$",
            answer=critical_pt,
            difficulty=(1000, 1200),
            topic="calculus/optimization",
            solution=steps(
                f"Find the derivative: $f'(x) = {latex(derivative)}$",
                f"Set $f'(x) = 0$ and solve:",
                f"${latex(Eq(derivative, 0))}$",
                f"$x = {critical_pt}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Determine if a critical point is a max or min using second derivative (1100-1300)
        a_val = choice([-2, -1, 1, 2])
        h = nonzero(-5, 5)
        k = randint(-10, 10)
        expr = a_val * (x - h)**2 + k
        expr_expanded = expand(expr)
        
        second_deriv = diff(expr_expanded, x, 2)
        
        if a_val > 0:
            ans_text = "minimum"
        else:
            ans_text = "maximum"
        
        return problem(
            question=f"Does $f(x) = {latex(expr_expanded)}$ have a maximum or minimum at its critical point?",
            answer=ans_text,
            difficulty=(1100, 1300),
            topic="calculus/optimization",
            solution=steps(
                f"Find the second derivative: $f''(x) = {latex(second_deriv)}$",
                f"Since $f''(x) = {second_deriv}$ {'> 0' if a_val > 0 else '< 0'}$, the critical point is a {ans_text}"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Find maximum/minimum value of a simple quadratic (1100-1300)
        a_val = choice([-2, -1, 1, 2])
        h = nonzero(-5, 5)
        k = randint(-10, 10)
        expr = a_val * (x - h)**2 + k
        expr_expanded = expand(expr)
        
        if a_val > 0:
            question_text = "minimum"
        else:
            question_text = "maximum"
        
        ans = k
        
        return problem(
            question=f"Find the {question_text} value of $f(x) = {latex(expr_expanded)}$",
            answer=ans,
            difficulty=(1100, 1300),
            topic="calculus/optimization",
            solution=steps(
                f"Find the derivative: $f'(x) = {latex(diff(expr_expanded, x))}$",
                f"Set $f'(x) = 0$: $x = {h}$",
                f"Evaluate $f({h}) = {latex(expr_expanded.subs(x, h))} = {k}$",
                f"The {question_text} value is ${k}$"
            ),
        )
    
    else:
        # Type 4: Find where a linear function has its maximum on an interval (1200-1300)
        m = nonzero(-5, 5)
        b_val = randint(-10, 10)
        expr = m * x + b_val
        
        left = randint(0, 5)
        right = left + randint(3, 6)
        
        if m > 0:
            ans = right
            explanation = "increasing"
        else:
            ans = left
            explanation = "decreasing"
        
        return problem(
            question=f"At what value of $x$ in the interval $[{left}, {right}]$ does $f(x) = {latex(expr)}$ achieve its maximum?",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/optimization",
            solution=steps(
                f"Find the derivative: $f'(x) = {m}$",
                f"Since $f'(x) = {m}$ {'> 0' if m > 0 else '< 0'}$, the function is {explanation}",
                f"The maximum occurs at $x = {ans}$"
            ),
        )

emit(generate())