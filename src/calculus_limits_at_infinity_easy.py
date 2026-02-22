"""
calculus - limits_at_infinity (easy)
Generated: 2026-02-22T04:59:42.220823
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Polynomial with highest degree term (1000-1200)
        # lim_{x->infinity} (ax^n + lower terms) / (bx^n + lower terms) = a/b
        coeff_num = nonzero(-5, 5)
        coeff_den = nonzero(-5, 5)
        power = randint(1, 3)
        
        # Simple case: just highest degree terms, easy to see
        numerator = coeff_num * x**power
        denominator = coeff_den * x**power
        
        ans = Rational(coeff_num, coeff_den)
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1000, 1200),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Both numerator and denominator have degree {power}",
                f"The limit is the ratio of leading coefficients: $\\frac{{{coeff_num}}}{{{coeff_den}}}$",
                f"Answer: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Constant over x^n -> 0 (1100-1250)
        const = nonzero(-10, 10)
        power = randint(1, 3)
        
        ans = 0
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{const}}}{{x^{{{power}}}}}",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"As $x \\to \\infty$, the denominator $x^{{{power}}} \\to \\infty$",
                f"A constant divided by an increasingly large number approaches 0",
                f"Answer: $0$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Polynomial divided by higher degree -> 0 (1150-1300)
        coeff_num = nonzero(-5, 5)
        coeff_den = nonzero(-5, 5)
        power_num = randint(1, 2)
        power_den = power_num + 1
        
        numerator = coeff_num * x**power_num
        denominator = coeff_den * x**power_den
        
        ans = 0
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1150, 1300),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Numerator has degree {power_num}, denominator has degree {power_den}",
                f"Since denominator degree > numerator degree, the limit is 0",
                f"Answer: $0$"
            ),
        )
    
    else:
        # Type 4: Simple polynomial with two terms, same degree (1100-1250)
        coeff_num1 = nonzero(-5, 5)
        coeff_num2 = nonzero(-5, 5)
        coeff_den1 = nonzero(-5, 5)
        coeff_den2 = nonzero(-5, 5)
        power = randint(1, 2)
        
        numerator = coeff_num1 * x**power + coeff_num2
        denominator = coeff_den1 * x**power + coeff_den2
        
        ans = Rational(coeff_num1, coeff_den1)
        
        return problem(
            question=f"\\lim_{{x \\to \\infty}} \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/limits_at_infinity",
            solution=steps(
                f"Both numerator and denominator have highest degree {power}",
                f"Leading coefficient of numerator: ${coeff_num1}$",
                f"Leading coefficient of denominator: ${coeff_den1}$",
                f"The limit is $\\frac{{{coeff_num1}}}{{{coeff_den1}}} = {latex(ans)}$"
            ),
        )

emit(generate())