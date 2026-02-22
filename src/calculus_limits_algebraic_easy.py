"""
calculus - limits_algebraic (easy)
Generated: 2026-02-22T04:58:20.543585
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Direct substitution - polynomial
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        x_val = nonzero(-3, 3)
        
        expr = a*x**2 + b*x + c
        ans = expr.subs(x, x_val)
        
        return problem(
            question=f"Find $\\lim_{{x \\to {x_val}}} {latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Since ${latex(expr)}$ is a polynomial, we can use direct substitution",
                f"Substitute $x = {x_val}$:",
                f"${latex(a)}({x_val})^2 + {latex(b)}({x_val}) + {latex(c)} = {ans}$"
            )
        )
    
    elif problem_type == 2:
        # Direct substitution - rational function (no division by zero)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        x_val = nonzero(-3, 3)
        
        # Make sure denominator is non-zero at x_val
        denom_const = x_val + nonzero(1, 3)
        
        numerator = a*x + b
        denominator = x + denom_const
        
        ans = (a*x_val + b) / (x_val + denom_const)
        ans = Rational(a*x_val + b, x_val + denom_const)
        
        return problem(
            question=f"Find $\\lim_{{x \\to {x_val}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"The denominator at $x = {x_val}$ is ${latex(x_val + denom_const)} \\neq 0$",
                f"We can use direct substitution:",
                f"$\\frac{{{latex(a*x_val + b)}}}{{{latex(x_val + denom_const)}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Factoring to remove 0/0 form - simple (x-a) cancellation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # Limit as x -> a, where numerator is (x-a)(x+b)
        numerator = expand((x - a) * (x + b))
        denominator = x - a
        
        ans = a + b
        
        return problem(
            question=f"Find $\\lim_{{x \\to {a}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Factor the numerator: ${latex(numerator)} = {latex(factor(numerator))}$",
                f"Cancel common factor $(x - {a})$:",
                f"$\\lim_{{x \\to {a}}} (x + {b}) = {a} + {b} = {ans}$"
            )
        )
    
    elif problem_type == 4:
        # Difference of squares cancellation
        a = randint(1, 5)
        
        # (x^2 - a^2) / (x - a) as x -> a
        numerator = x**2 - a**2
        denominator = x - a
        
        ans = 2*a
        
        return problem(
            question=f"Find $\\lim_{{x \\to {a}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Factor using difference of squares: $x^2 - {a**2} = (x - {a})(x + {a})$",
                f"$\\lim_{{x \\to {a}}} \\frac{{(x - {a})(x + {a})}}{{x - {a}}}$",
                f"Cancel $(x - {a})$:",
                f"$\\lim_{{x \\to {a}}} (x + {a}) = {a} + {a} = {ans}$"
            )
        )
    
    else:
        # Simple polynomial with coefficient
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        x_val = nonzero(-2, 2)
        
        expr = a*x + b
        ans = a*x_val + b
        
        return problem(
            question=f"Find $\\lim_{{x \\to {x_val}}} ({latex(expr)})$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/limits_algebraic",
            solution=steps(
                f"Since ${latex(expr)}$ is continuous everywhere, use direct substitution:",
                f"${latex(a)} \\cdot {x_val} + {latex(b)} = {ans}$"
            )
        )

emit(generate())