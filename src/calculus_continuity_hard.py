"""
calculus - continuity (hard)
Generated: 2026-02-22T05:02:06.038894
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Piecewise function continuity - find parameter value
        a_coeff = nonzero(-3, 3)
        b_val = nonzero(-5, 5)
        c_point = randint(1, 4)
        
        # For continuity at x=c, we need ax + b = c^2
        # So a*c + b = c^2, which gives b = c^2 - a*c
        b_val = c_point**2 - a_coeff * c_point
        
        ans = a_coeff
        
        question = f"For what value of $a$ is the function $$f(x) = \\begin{{cases}} ax + {b_val} & \\text{{if }} x \\leq {c_point} \\\\ x^2 & \\text{{if }} x > {c_point} \\end{{cases}}$$ continuous at $x = {c_point}$?"
        
        left_limit = a_coeff * c_point + b_val
        right_limit = c_point**2
        
        solution = steps(
            f"For continuity at $x = {c_point}$, we need $\\lim_{{x \\to {c_point}^-}} f(x) = \\lim_{{x \\to {c_point}^+}} f(x) = f({c_point})$",
            f"Left-hand limit: $\\lim_{{x \\to {c_point}^-}} (ax + {b_val}) = a({c_point}) + {b_val}$",
            f"Right-hand limit: $\\lim_{{x \\to {c_point}^+}} x^2 = {c_point}^2 = {c_point**2}$",
            f"Set them equal: $a({c_point}) + {b_val} = {c_point**2}$",
            f"Solve for $a$: $a = \\frac{{{c_point**2} - {b_val}}}{{{c_point}}} = {ans}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/continuity",
            solution=solution
        )
    
    elif problem_type == 2:
        # Removable discontinuity - find limit
        r = nonzero(-4, 4)
        coeff = nonzero(-2, 3)
        
        # (x-r)(x+coeff) / (x-r) has removable discontinuity at x=r
        numerator = expand((x - r) * (x + coeff))
        denominator = x - r
        
        ans = r + coeff
        
        question = f"Find the value of $\\lim_{{x \\to {r}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"
        
        solution = steps(
            f"Factor the numerator: ${latex(numerator)} = (x - {r})(x + {coeff})$",
            f"Cancel common factor: $\\frac{{(x - {r})(x + {coeff})}}{{x - {r}}} = x + {coeff}$ for $x \\neq {r}$",
            f"Evaluate the limit: $\\lim_{{x \\to {r}}} (x + {coeff}) = {r} + {coeff} = {ans}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/continuity",
            solution=solution
        )
    
    elif problem_type == 3:
        # Continuity with absolute value
        c_point = randint(2, 5)
        m = nonzero(-3, 3)
        
        # For |x - c| + b to be continuous with mx at x=c
        # We need b = m*c since |c - c| = 0
        b_val = m * c_point
        
        ans = b_val
        
        question = f"Find the value of $b$ such that $$f(x) = \\begin{{cases}} {m}x & \\text{{if }} x \\leq {c_point} \\\\ |x - {c_point}| + b & \\text{{if }} x > {c_point} \\end{{cases}}$$ is continuous everywhere."
        
        solution = steps(
            f"For continuity at $x = {c_point}$, we need $\\lim_{{x \\to {c_point}^-}} f(x) = \\lim_{{x \\to {c_point}^+}} f(x)$",
            f"Left-hand limit: $\\lim_{{x \\to {c_point}^-}} {m}x = {m * c_point}$",
            f"Right-hand limit: $\\lim_{{x \\to {c_point}^+}} (|x - {c_point}| + b) = 0 + b = b$",
            f"Set them equal: $b = {m * c_point}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/continuity",
            solution=solution
        )
    
    elif problem_type == 4:
        # Two-parameter piecewise continuity
        c_point = randint(1, 3)
        
        # f(x) = { ax^2 + b, x <= c ; 2ax + 3b, x > c }
        # Continuity requires: ac^2 + b = 2ac + 3b
        # This gives: ac^2 - 2ac = 2b, or a*c(c-2) = 2b
        
        # Choose specific values
        a_val = nonzero(-2, 2)
        b_val = a_val * c_point * (c_point - 2) // 2
        
        ans = (a_val, b_val)
        
        question = f"Find values of $a$ and $b$ such that $$f(x) = \\begin{{cases}} ax^2 + b & \\text{{if }} x \\leq {c_point} \\\\ 2ax + 3b & \\text{{if }} x > {c_point} \\end{{cases}}$$ is continuous at $x = {c_point}$. Enter your answer as an ordered pair $(a, b)$ where $a = {a_val}$."
        
        left_val = a_val * c_point**2 + b_val
        right_val = 2 * a_val * c_point + 3 * b_val
        
        solution = steps(
            f"For continuity: $a({c_point})^2 + b = 2a({c_point}) + 3b$",
            f"Simplify: ${a_val * c_point**2}a + b = {2 * a_val * c_point}a + 3b$",
            f"Given $a = {a_val}$: ${a_val * c_point**2} + b = {2 * a_val * c_point} + 3b$",
            f"Solve for $b$: $2b = {a_val * c_point**2 - 2 * a_val * c_point}$, so $b = {b_val}$",
            f"Answer: $(a, b) = ({a_val}, {b_val})$"
        )
        
        return problem(
            question=question,
            answer=fmt_tuple(ans),
            answer_type="tuple",
            difficulty=(1700, 1850),
            topic="calculus/continuity",
            solution=solution
        )
    
    else:
        # Rational function continuity with limit
        p = nonzero(-3, 3)
        q = nonzero(-3, 3)
        while q == p:
            q = nonzero(-3, 3)
        
        c_point = randint(1, 4)
        
        # Define k such that (x^2 + px + q)/(x - c) → k as x → c
        # This requires x^2 + px + q = (x - c)(x - m) for some m
        # So we need c^2 + pc + q = 0, which gives q = -c^2 - pc
        q = -c_point**2 - p * c_point
        
        # The other root m = -p - c (from Vieta's formulas)
        m = -p - c_point
        
        ans = m
        
        numerator = expand(x**2 + p*x + q)
        
        question = f"The function $$f(x) = \\begin{{cases}} \\frac{{{latex(numerator)}}}{{x - {c_point}}} & \\text{{if }} x \\neq {c_point} \\\\ k & \\text{{if }} x = {c_point} \\end{{cases}}$$ is continuous at $x = {c_point}$. Find $k$."
        
        solution = steps(
            f"For continuity, $k = \\lim_{{x \\to {c_point}}} \\frac{{{latex(numerator)}}}{{x - {c_point}}}$",
            f"Factor the numerator: ${latex(numerator)} = (x - {c_point})(x - {m})$",
            f"Cancel: $\\frac{{(x - {c_point})(x - {m})}}{{x - {c_point}}} = x - {m}$ for $x \\neq {c_point}$",
            f"Therefore: $k = \\lim_{{x \\to {c_point}}} (x - {m}) = {c_point} - ({m}) = {ans}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/continuity",
            solution=solution
        )

emit(generate())