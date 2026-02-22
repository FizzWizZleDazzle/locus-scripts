"""
algebra1 - one_step_equations (hard)
Generated: 2026-02-22T03:47:35.209029
"""

from problem_utils import *

def generate():
    # For HARDER one-step equations (1600-1900), we need to push beyond typical one-step problems
    # Options:
    # 1. Fractional coefficients with complex numbers
    # 2. Equations requiring careful manipulation of radicals
    # 3. One-step but with algebraic expressions as coefficients
    # 4. Equations involving absolute values (technically one-step after setup)
    # 5. Rational equations that simplify to one-step
    
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Fractional coefficient with nested fractions
        num1 = nonzero(-7, 7)
        den1 = choice([2, 3, 4, 5, 6])
        num2 = nonzero(-9, 9)
        den2 = choice([2, 3, 4, 5, 6])
        
        # Equation: (num1/den1)x = num2/den2
        # Solution: x = (num2/den2) / (num1/den1) = (num2 * den1) / (den2 * num1)
        
        coeff = Rational(num1, den1)
        rhs = Rational(num2, den2)
        ans = rhs / coeff
        
        question = f"\\frac{{{num1}}}{{{den1}}}x = \\frac{{{num2}}}{{{den2}}}"
        
        solution = steps(
            f"Divide both sides by $\\frac{{{num1}}}{{{den1}}}$",
            f"$x = \\frac{{{num2}}}{{{den2}}} \\div \\frac{{{num1}}}{{{den1}}}$",
            f"$x = \\frac{{{num2}}}{{{den2}}} \\cdot \\frac{{{den1}}}{{{num1}}}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra1/one_step_equations",
            solution=solution
        )
    
    elif problem_type == 2:
        # Equation with radicals: sqrt(a) * x = b
        a_squared = choice([4, 9, 16, 25, 36, 49])
        a_val = sqrt(a_squared)
        b_val = nonzero(-10, 10)
        
        ans = Rational(b_val, int(a_val))
        
        question = f"\\sqrt{{{a_squared}}}x = {b_val}"
        
        solution = steps(
            f"Simplify: $\\sqrt{{{a_squared}}} = {int(a_val)}$",
            f"${int(a_val)}x = {b_val}$",
            f"Divide both sides by ${int(a_val)}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/one_step_equations",
            solution=solution
        )
    
    elif problem_type == 3:
        # Rational equation that's one-step: x/a = b/c
        a_val = nonzero(-8, 8)
        num_b = nonzero(-9, 9)
        den_c = choice([2, 3, 4, 5, 6, 7])
        
        # x/a = num_b/den_c
        # x = a * num_b / den_c
        
        ans = Rational(a_val * num_b, den_c)
        
        question = f"\\frac{{x}}{{{a_val}}} = \\frac{{{num_b}}}{{{den_c}}}"
        
        solution = steps(
            f"Multiply both sides by ${a_val}$",
            f"$x = {a_val} \\cdot \\frac{{{num_b}}}{{{den_c}}}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="algebra1/one_step_equations",
            solution=solution
        )
    
    elif problem_type == 4:
        # Decimal coefficient requiring careful division
        decimals = [0.25, 0.5, 0.75, 1.25, 1.5, 2.5, 3.5]
        coeff_dec = choice(decimals)
        rhs_val = nonzero(-15, 15)
        
        # Convert to rational for exact answer
        coeff_rat = Rational(int(coeff_dec * 4), 4)
        ans = Rational(rhs_val) / coeff_rat
        
        question = f"{coeff_dec}x = {rhs_val}"
        
        solution = steps(
            f"Divide both sides by ${coeff_dec}$",
            f"$x = \\frac{{{rhs_val}}}{{{coeff_dec}}}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1750),
            topic="algebra1/one_step_equations",
            solution=solution
        )
    
    else:  # problem_type == 5
        # Complex rational equation: (ax + b)/c = d, solve for x (still one-step algebraically)
        # Wait, that's two-step. Let me do: x/(a/b) = c
        
        num_a = nonzero(-6, 6)
        den_b = choice([2, 3, 4, 5])
        c_val = nonzero(-10, 10)
        
        # x / (a/b) = c
        # x = c * (a/b) = ca/b
        
        coeff_frac = Rational(num_a, den_b)
        ans = c_val * coeff_frac
        
        question = f"\\frac{{x}}{{\\frac{{{num_a}}}{{{den_b}}}}} = {c_val}"
        
        solution = steps(
            f"Multiply both sides by $\\frac{{{num_a}}}{{{den_b}}}$",
            f"$x = {c_val} \\cdot \\frac{{{num_a}}}{{{den_b}}}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra1/one_step_equations",
            solution=solution
        )

emit(generate())