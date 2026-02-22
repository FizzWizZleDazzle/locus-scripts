"""
calculus - continuity (medium)
Generated: 2026-02-22T05:01:32.697834
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Piecewise function continuity (1300-1500)
        # Check if continuous at x = a
        a_val = randint(-3, 3)
        m = nonzero(-3, 3)
        b = nonzero(-5, 5)
        
        # Make it continuous by choosing k to match
        # For x < a: mx + b, so at x=a: m*a + b
        # For x >= a: k, must equal m*a + b
        k_correct = m * a_val + b
        
        # Create the piecewise function for display
        question_text = f"Is the function $f(x) = \\begin{{cases}} {latex(m*x + b)} & x < {a_val} \\\\ {k_correct} & x \\geq {a_val} \\end{{cases}}$ continuous at $x = {a_val}$?"
        
        # Check left limit, right limit, and f(a)
        left_limit = m * a_val + b
        right_limit = k_correct
        f_a = k_correct
        
        is_continuous = (left_limit == right_limit == f_a)
        
        return problem(
            question=question_text,
            answer=is_continuous,
            difficulty=(1300, 1400),
            topic="calculus/continuity",
            solution=steps(
                f"Check if $\\lim_{{x \\to {a_val}^-}} f(x) = \\lim_{{x \\to {a_val}^+}} f(x) = f({a_val})$",
                f"Left limit: $\\lim_{{x \\to {a_val}^-}} ({latex(m*x + b)}) = {left_limit}$",
                f"Right limit: $\\lim_{{x \\to {a_val}^+}} {k_correct} = {right_limit}$",
                f"$f({a_val}) = {f_a}$",
                f"Since all three values equal ${left_limit}$, the function is continuous at $x = {a_val}$" if is_continuous else "The limits or function value do not match, so not continuous"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Find k to make piecewise function continuous (1400-1600)
        a_val = randint(-2, 3)
        m1 = nonzero(-4, 4)
        b1 = nonzero(-6, 6)
        m2 = nonzero(-4, 4)
        
        # For continuity: m1*a + b1 = m2*a^2 + k
        # Solve for k
        k_ans = m1 * a_val + b1 - m2 * a_val**2
        
        question_text = f"Find the value of $k$ that makes $f(x) = \\begin{{cases}} {latex(m1*x + b1)} & x \\leq {a_val} \\\\ {latex(m2*x**2)} + k & x > {a_val} \\end{{cases}}$ continuous at $x = {a_val}$"
        
        return problem(
            question=question_text,
            answer=k_ans,
            difficulty=(1400, 1600),
            topic="calculus/continuity",
            solution=steps(
                f"For continuity at $x = {a_val}$, we need $\\lim_{{x \\to {a_val}^-}} f(x) = \\lim_{{x \\to {a_val}^+}} f(x)$",
                f"Left limit: $\\lim_{{x \\to {a_val}^-}} ({latex(m1*x + b1)}) = {m1 * a_val + b1}$",
                f"Right limit: $\\lim_{{x \\to {a_val}^+}} ({latex(m2*x**2)} + k) = {m2 * a_val**2} + k$",
                f"Set equal: ${m1 * a_val + b1} = {m2 * a_val**2} + k$",
                f"Solve for $k$: $k = {m1 * a_val + b1} - {m2 * a_val**2} = {k_ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Removable discontinuity - simplify rational function (1400-1600)
        # Create (x-r)/(x-r) form that can be simplified
        r = nonzero(-4, 4)
        a_coeff = nonzero(-3, 3)
        b_const = nonzero(-5, 5)
        
        numerator = expand((x - r) * (a_coeff * x + b_const))
        denominator = x - r
        
        # After simplification, limit as x->r is a_coeff*r + b_const
        limit_val = a_coeff * r + b_const
        
        question_text = f"Find $\\lim_{{x \\to {r}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"
        
        return problem(
            question=question_text,
            answer=limit_val,
            difficulty=(1300, 1500),
            topic="calculus/continuity",
            solution=steps(
                f"Factor the numerator: ${latex(numerator)} = {latex(factor(numerator))}$",
                f"Cancel common factor $(x - {r})$: $\\frac{{{latex(factor(numerator))}}}{{{latex(denominator)}}} = {latex(a_coeff*x + b_const)}$ for $x \\neq {r}$",
                f"Evaluate limit: $\\lim_{{x \\to {r}}} ({latex(a_coeff*x + b_const)}) = {limit_val}$"
            ),
        )
    
    else:
        # Type 4: Check continuity of a simple rational function at a point (1300-1500)
        r = nonzero(-3, 3)
        test_point = choice([p for p in range(-4, 5) if p != r])
        
        a_coeff = nonzero(-3, 3)
        b_const = nonzero(-5, 5)
        
        numerator = a_coeff * x + b_const
        denominator = x - r
        
        # Function is continuous everywhere except x = r
        is_continuous = True
        
        f_val = (a_coeff * test_point + b_const) / (test_point - r)
        
        question_text = f"Is $f(x) = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$ continuous at $x = {test_point}$?"
        
        return problem(
            question=question_text,
            answer=is_continuous,
            difficulty=(1300, 1400),
            topic="calculus/continuity",
            solution=steps(
                f"A rational function is continuous wherever it is defined",
                f"Check if denominator is zero at $x = {test_point}$: ${test_point} - {r} = {test_point - r} \\neq 0$",
                f"Since the denominator is not zero, $f({test_point})$ is defined",
                f"Therefore, $f(x)$ is continuous at $x = {test_point}$"
            ),
        )

emit(generate())