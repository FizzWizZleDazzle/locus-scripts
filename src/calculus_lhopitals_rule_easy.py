"""
calculus - lhopitals_rule (easy)
Generated: 2026-02-22T05:10:08.721512
"""

from problem_utils import *

def generate():
    # For easier L'Hopital problems (1000-1300), we want indeterminate forms 0/0 or ∞/∞
    # that resolve with a single application of L'Hopital's rule
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple polynomial 0/0 form
        # lim (x->a) (x-a)/(x-a) or variations
        a_val = nonzero(-5, 5)
        k = nonzero(-3, 3)
        
        # numerator: k(x - a)
        # denominator: (x - a)
        numerator = k * (x - a_val)
        denominator = x - a_val
        
        # After L'Hopital: k/1 = k
        ans = k
        
        return problem(
            question=f"\\lim_{{x \\to {a_val}}} \\frac{{{latex(expand(numerator))}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{{k*(a_val-a_val)}}}{{{a_val-a_val}}} = \\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: differentiate numerator and denominator",
                f"$\\lim_{{x \\to {a_val}}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$",
                f"$= \\frac{{{k}}}{{1}} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Polynomial with (x-a)^2 factors
        # lim (x->a) (x-a)^2 / (x-a)
        a_val = nonzero(-4, 4)
        
        numerator = (x - a_val)**2
        denominator = x - a_val
        
        # After L'Hopital: 2(x-a)/1, then substitute x=a gives 0
        ans = 0
        
        return problem(
            question=f"\\lim_{{x \\to {a_val}}} \\frac{{{latex(expand(numerator))}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to {a_val}}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$",
                f"$= \\lim_{{x \\to {a_val}}} \\frac{{{latex(simplify(diff(numerator, x)))}}}{{{latex(diff(denominator, x))}}}$",
                f"$= \\frac{{{2*(a_val - a_val)}}}{{1}} = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Type 3: sin(x)/x type at x->0
        k = nonzero(-3, 3)
        
        # lim (x->0) k*sin(x) / x = k
        numerator = k * sin(x)
        denominator = x
        
        ans = k
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1150, 1250),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to 0}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$",
                f"$= \\lim_{{x \\to 0}} \\frac{{{latex(diff(numerator, x))}}}{{1}}$",
                f"$= {k} \\cdot \\cos(0) = {k} \\cdot 1 = {ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Type 4: (e^x - 1)/x type at x->0
        k = nonzero(-3, 3)
        
        # lim (x->0) (e^(kx) - 1) / x = k
        numerator = exp(k*x) - 1
        denominator = x
        
        ans = k
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{e^0 - 1}}{{0}} = \\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule",
                f"$\\lim_{{x \\to 0}} \\frac{{{latex(diff(numerator, x))}}}{{{latex(diff(denominator, x))}}}$",
                f"$= \\lim_{{x \\to 0}} \\frac{{{latex(diff(numerator, x))}}}{{1}}$",
                f"$= {k} e^0 = {ans}$"
            ),
            calculator="scientific"
        )

emit(generate())