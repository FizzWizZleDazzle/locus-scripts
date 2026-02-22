"""
calculus - continuity (easy)
Generated: 2026-02-22T05:01:06.594357
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Check if a simple polynomial is continuous at a point (1000-1100)
        # All polynomials are continuous everywhere
        coeff1 = nonzero(-5, 5)
        coeff2 = nonzero(-5, 5)
        power = randint(2, 3)
        func = coeff1 * x**power + coeff2 * x
        point = randint(-3, 3)
        
        return problem(
            question=f"Is $f(x) = {latex(func)}$ continuous at $x = {point}$?",
            answer=True,
            difficulty=(1000, 1100),
            topic="calculus/continuity",
            solution=steps(
                f"$f(x) = {latex(func)}$ is a polynomial function",
                "Polynomial functions are continuous everywhere",
                f"Therefore, $f$ is continuous at $x = {point}$"
            ),
            answer_type="boolean"
        )
    
    elif problem_type == 2:
        # Type 2: Evaluate limit to check continuity (simple direct substitution) (1100-1200)
        coeff = nonzero(-5, 5)
        const = randint(-8, 8)
        func = coeff * x + const
        point = randint(-3, 3)
        limit_val = coeff * point + const
        
        return problem(
            question=f"Find $\\lim_{{x \\to {point}}} ({latex(func)})$",
            answer=limit_val,
            difficulty=(1100, 1200),
            topic="calculus/continuity",
            solution=steps(
                f"Since $f(x) = {latex(func)}$ is a polynomial, we can use direct substitution",
                f"$\\lim_{{x \\to {point}}} ({latex(func)}) = {coeff}({point}) + {const}$",
                f"$= {limit_val}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Identify point of discontinuity in rational function (1200-1300)
        # f(x) = 1/(x - a) has discontinuity at x = a
        disc_point = nonzero(-5, 5)
        numerator = randint(1, 5)
        
        return problem(
            question=f"At what value of $x$ is $f(x) = \\frac{{{numerator}}}{{x - {disc_point}}}$ discontinuous?",
            answer=disc_point,
            difficulty=(1200, 1300),
            topic="calculus/continuity",
            solution=steps(
                f"A rational function is discontinuous where the denominator equals zero",
                f"Set $x - {disc_point} = 0$",
                f"$x = {disc_point}$",
                f"Therefore, $f$ is discontinuous at $x = {disc_point}$"
            )
        )
    
    elif problem_type == 4:
        # Type 4: Check continuity of piecewise function where it's obviously continuous (1100-1200)
        m = nonzero(-3, 3)
        b = randint(-5, 5)
        point = randint(-2, 2)
        val_at_point = m * point + b
        
        return problem(
            question=f"Is $f(x) = \\begin{{cases}} {latex(m*x + b)} & x \\leq {point} \\\\ {val_at_point} & x = {point} \\end{{cases}}$ continuous at $x = {point}$?",
            answer=True,
            difficulty=(1100, 1200),
            topic="calculus/continuity",
            solution=steps(
                f"For continuity at $x = {point}$, we need $\\lim_{{x \\to {point}}} f(x) = f({point})$",
                f"$\\lim_{{x \\to {point}^-}} f(x) = {m}({point}) + {b} = {val_at_point}$",
                f"$f({point}) = {val_at_point}$",
                f"Since the limit equals the function value, $f$ is continuous at $x = {point}$"
            ),
            answer_type="boolean"
        )
    
    else:
        # Type 5: Direct evaluation at a point for continuous function (1000-1100)
        a_val = nonzero(-4, 4)
        b_val = randint(-6, 6)
        point = randint(-2, 2)
        func = a_val * x**2 + b_val
        func_val = a_val * point**2 + b_val
        
        return problem(
            question=f"Evaluate $f({point})$ where $f(x) = {latex(func)}$",
            answer=func_val,
            difficulty=(1000, 1100),
            topic="calculus/continuity",
            solution=steps(
                f"Substitute $x = {point}$ into $f(x) = {latex(func)}$",
                f"$f({point}) = {a_val}({point})^2 + {b_val}$",
                f"$= {a_val * point**2} + {b_val}$",
                f"$= {func_val}$"
            )
        )

emit(generate())