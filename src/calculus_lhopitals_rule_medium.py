"""
calculus - lhopitals_rule (medium)
Generated: 2026-02-22T05:10:30.832647
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # 0/0 form with polynomials
        # Target difficulty: 1300-1500
        root = nonzero(-5, 5)
        
        # Numerator has (x - root) as a factor
        other_root_num = nonzero(-4, 4)
        while other_root_num == root:
            other_root_num = nonzero(-4, 4)
        
        numerator = expand((x - root) * (x - other_root_num))
        
        # Denominator has (x - root) as a factor
        other_root_den = nonzero(-4, 4)
        while other_root_den == root or other_root_den == other_root_num:
            other_root_den = nonzero(-4, 4)
        
        denominator = expand((x - root) * (x - other_root_den))
        
        # L'Hopital's rule: take derivatives
        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)
        
        # Evaluate at the limit point
        ans = simplify(num_prime.subs(x, root) / den_prime.subs(x, root))
        
        return problem(
            question=f"\\lim_{{x \\to {root}}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{{numerator.subs(x, root)}}}{{{denominator.subs(x, root)}}} = \\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to {root}}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"Substitute $x = {root}$: $\\frac{{{num_prime.subs(x, root)}}}{{{den_prime.subs(x, root)}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # 0/0 form with trig functions
        # Target difficulty: 1400-1600
        coeff = nonzero(-3, 3)
        
        # lim x->0 of sin(ax)/x or sin(ax)/(bx)
        if randint(0, 1) == 0:
            numerator = sin(coeff * x)
            denominator = x
            ans = coeff
            
            num_prime = diff(numerator, x)
            den_prime = diff(denominator, x)
            
            return problem(
                question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
                answer=ans,
                difficulty=(1400, 1600),
                topic="calculus/lhopitals_rule",
                solution=steps(
                    f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                    f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                    f"Substitute $x = 0$: $\\frac{{{num_prime.subs(x, 0)}}}{{{den_prime.subs(x, 0)}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        else:
            b = nonzero(-3, 3)
            while b == coeff:
                b = nonzero(-3, 3)
            
            numerator = sin(coeff * x)
            denominator = b * x
            ans = Rational(coeff, b)
            
            num_prime = diff(numerator, x)
            den_prime = diff(denominator, x)
            
            return problem(
                question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
                answer=ans,
                difficulty=(1400, 1600),
                topic="calculus/lhopitals_rule",
                solution=steps(
                    f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                    f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                    f"Substitute $x = 0$: $\\frac{{{latex(num_prime.subs(x, 0))}}}{{{latex(den_prime.subs(x, 0))}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 3:
        # Exponential 0/0 form
        # Target difficulty: 1500-1600
        a = nonzero(-3, 3)
        
        # lim x->0 (e^(ax) - 1)/x
        numerator = exp(a * x) - 1
        denominator = x
        ans = a
        
        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"Substitute $x = 0$: $\\frac{{{latex(num_prime.subs(x, 0))}}}{{{latex(den_prime.subs(x, 0))}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Logarithmic 0/0 form
        # Target difficulty: 1400-1600
        a = randint(2, 5)
        
        # lim x->0 ln(1 + ax)/x
        numerator = log(1 + a * x)
        denominator = x
        ans = a
        
        num_prime = diff(numerator, x)
        den_prime = diff(denominator, x)
        
        return problem(
            question=f"\\lim_{{x \\to 0}} \\frac{{\\ln(1 + {a}x)}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1400, 1600),
            topic="calculus/lhopitals_rule",
            solution=steps(
                f"Direct substitution gives $\\frac{{0}}{{0}}$ (indeterminate)",
                f"Apply L'Hôpital's rule: $\\lim_{{x \\to 0}} \\frac{{{latex(num_prime)}}}{{{latex(den_prime)}}}$",
                f"Substitute $x = 0$: $\\frac{{{latex(simplify(num_prime.subs(x, 0)))}}}{{{latex(den_prime.subs(x, 0))}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())