"""
calculus - limits_algebraic (medium)
Generated: 2026-02-22T04:58:42.983569
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Direct substitution limit (1300-1400)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-8, 8)
        c_val = nonzero(-10, 10)
        
        expr = a_val * x**2 + b_val * x + c_val
        limit_point = nonzero(-4, 4)
        ans = expr.subs(x, limit_point)
        
        return problem(
            question=f"\\lim_{{x \\to {limit_point}}} \\left({latex(expr)}\\right)",
            answer=ans,
            difficulty=(1300, 1400),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Since ${latex(expr)}$ is a polynomial, it is continuous everywhere",
                f"Substitute $x = {limit_point}$ directly",
                f"${latex(expr.subs(x, limit_point))} = {ans}$"
            )
        )
    
    elif problem_type == 2:
        # Factoring to remove indeterminate form (1400-1500)
        root = nonzero(-5, 5)
        other_val = nonzero(-6, 6)
        while other_val == root:
            other_val = nonzero(-6, 6)
        
        numerator = expand((x - root) * (x - other_val))
        denominator = x - root
        
        ans = other_val
        
        return problem(
            question=f"\\lim_{{x \\to {root}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Factor the numerator: ${latex(numerator)} = {latex(factor(numerator))}$",
                f"Cancel common factor $(x - {root})$",
                f"$\\lim_{{x \\to {root}}} (x - {other_val}) = {root} - {other_val} = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Rationalize conjugate (1500-1600)
        a_val = choice([1, 4, 9, 16, 25])
        b_val = nonzero(-3, 3)
        
        limit_point = a_val
        numerator = sqrt(x) - sqrt(a_val)
        denominator = x - a_val
        
        ans = Rational(1, 2 * sqrt(a_val))
        
        return problem(
            question=f"\\lim_{{x \\to {a_val}}} \\frac{{\\sqrt{{x}} - {latex(sqrt(a_val))}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Multiply by conjugate: $\\frac{{\\sqrt{{x}} + {latex(sqrt(a_val))}}}{{\\sqrt{{x}} + {latex(sqrt(a_val))}}}$",
                f"Numerator becomes: $(\\sqrt{{x}} - {latex(sqrt(a_val))})(\\sqrt{{x}} + {latex(sqrt(a_val))}) = x - {a_val}$",
                f"Cancel $(x - {a_val})$ factor",
                f"$\\lim_{{x \\to {a_val}}} \\frac{{1}}{{\\sqrt{{x}} + {latex(sqrt(a_val))}}} = \\frac{{1}}{{{latex(2*sqrt(a_val))}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Difference of squares or simple factoring (1400-1500)
        root = nonzero(-4, 4)
        k = nonzero(2, 5)
        
        numerator = expand(k * (x - root) * (x + root))
        denominator = x - root
        
        ans = 2 * k * root
        
        return problem(
            question=f"\\lim_{{x \\to {root}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Factor the numerator: ${latex(numerator)} = {latex(k)}(x - {root})(x + {root})$",
                f"Cancel $(x - {root})$",
                f"$\\lim_{{x \\to {root}}} {latex(k)}(x + {root}) = {latex(k)}({root} + {root}) = {ans}$"
            )
        )
    
    else:
        # Polynomial long division style (1300-1400)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-5, 5)
        
        expr = (a_val * x + b_val) / x
        ans = a_val
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{latex(a_val * x + b_val)}}}{{x}}",
            answer=ans,
            difficulty=(1300, 1400),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Divide each term by $x$",
                f"$\\lim_{{x \\to \\infty}} \\left({a_val} + \\frac{{{b_val}}}{{x}}\\right)$",
                f"As $x \\to \\infty$, $\\frac{{{b_val}}}{{x}} \\to 0$",
                f"The limit is ${a_val}$"
            )
        )

emit(generate())