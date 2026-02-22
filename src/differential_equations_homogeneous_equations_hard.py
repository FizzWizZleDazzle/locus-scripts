"""
differential_equations - homogeneous_equations (hard)
Generated: 2026-02-22T05:24:05.527732
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Homogeneous DE of form dy/dx = f(y/x) with substitution
        # Target: harder problems (1600-1900)
        
        # Pick coefficients for a rational homogeneous function
        a1, a2 = nonzero(-3, 3), nonzero(-3, 3)
        b1, b2 = nonzero(-3, 3), nonzero(-3, 3)
        
        # Ensure it's properly homogeneous and solvable
        # dy/dx = (a1*x + a2*y) / (b1*x + b2*y)
        
        numerator = a1*x + a2*y
        denominator = b1*x + b2*y
        
        # Use substitution v = y/x, so y = v*x, dy/dx = v + x*dv/dx
        v = symbols('v')
        rhs_in_v = (a1 + a2*v) / (b1 + b2*v)
        
        # v + x*dv/dx = rhs_in_v
        # x*dv/dx = rhs_in_v - v
        # dv/(rhs_in_v - v) = dx/x
        
        separable_lhs = simplify(rhs_in_v - v)
        
        if separable_lhs != 0:
            # Integrate both sides
            try:
                left_integral = integrate(1/separable_lhs, v)
                # Right side integrates to ln|x| + C
                
                # The general solution is: left_integral = ln|x| + C
                # Substitute back v = y/x
                solution_implicit = Eq(left_integral.subs(v, y/x), log(abs(x)) + c)
                
                question_text = f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"
                
                solution_steps = steps(
                    f"This is a homogeneous equation. Let $v = \\frac{{y}}{{x}}$, so $y = vx$",
                    f"Then $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
                    f"Substituting: $v + x\\frac{{dv}}{{dx}} = {latex(rhs_in_v)}$",
                    f"Separating variables: $x\\frac{{dv}}{{dx}} = {latex(separable_lhs)}$",
                    f"$\\frac{{dv}}{{{latex(separable_lhs)}}} = \\frac{{dx}}{{x}}$",
                    f"Integrating both sides: ${latex(left_integral)} = \\ln|x| + C$",
                    f"Substituting back $v = \\frac{{y}}{{x}}$: ${latex(solution_implicit)}$"
                )
                
                return problem(
                    question=question_text,
                    answer=solution_implicit,
                    difficulty=(1650, 1800),
                    topic="differential_equations/homogeneous_equations",
                    solution=solution_steps,
                    answer_type="equation"
                )
            except:
                pass
    
    if problem_type == 2:
        # Type 2: Homogeneous DE with trigonometric substitution
        # dy/dx = (x + y) / (x - y)
        
        sign1 = choice([1, -1])
        sign2 = choice([1, -1])
        
        numerator = x + sign1*y
        denominator = x + sign2*y
        
        # With v = y/x
        v = symbols('v')
        rhs_in_v = (1 + sign1*v) / (1 + sign2*v)
        separable_lhs = simplify(rhs_in_v - v)
        
        if separable_lhs != 0 and sign1 != sign2:
            try:
                left_integral = integrate(1/separable_lhs, v)
                solution_implicit = Eq(left_integral.subs(v, y/x), log(abs(x)) + c)
                
                question_text = f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"
                
                solution_steps = steps(
                    f"Recognize this as a homogeneous equation (both numerator and denominator are degree 1)",
                    f"Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
                    f"Substituting: $v + x\\frac{{dv}}{{dx}} = {latex(rhs_in_v)}$",
                    f"Rearranging: $x\\frac{{dv}}{{dx}} = {latex(separable_lhs)}$",
                    f"Separating: $\\frac{{dv}}{{{latex(separable_lhs)}}} = \\frac{{dx}}{{x}}$",
                    f"Integrating: ${latex(left_integral)} = \\ln|x| + C$",
                    f"Back-substituting $v = \\frac{{y}}{{x}}$: ${latex(solution_implicit)}$"
                )
                
                return problem(
                    question=question_text,
                    answer=solution_implicit,
                    difficulty=(1700, 1850),
                    topic="differential_equations/homogeneous_equations",
                    solution=solution_steps,
                    answer_type="equation"
                )
            except:
                pass
    
    # Default: Type 3 - Quadratic homogeneous
    # dy/dx = (x^2 + y^2) / (x*y) or similar
    
    coeff = choice([1, 2])
    
    # dy/dx = (x^2 + coeff*y^2)/(x*y)
    numerator = x**2 + coeff*y**2
    denominator = x*y
    
    v = symbols('v')
    # dy/dx = (x^2 + coeff*y^2)/(xy) = x/y + coeff*y/x = 1/v + coeff*v
    rhs_in_v = 1/v + coeff*v
    separable_lhs = simplify(rhs_in_v - v)
    
    left_integral = integrate(1/separable_lhs, v)
    solution_implicit = Eq(left_integral.subs(v, y/x), log(abs(x)) + c)
    
    question_text = f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$"
    
    solution_steps = steps(
        f"This is homogeneous since both numerator and denominator are degree 2",
        f"Let $v = \\frac{{y}}{{x}}$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
        f"Rewrite right side: $\\frac{{{latex(numerator)}}}{{{latex(denominator)}}} = {latex(rhs_in_v)}$",
        f"Substituting: $v + x\\frac{{dv}}{{dx}} = {latex(rhs_in_v)}$",
        f"Therefore: $x\\frac{{dv}}{{dx}} = {latex(separable_lhs)}$",
        f"Separating variables: $\\frac{{dv}}{{{latex(separable_lhs)}}} = \\frac{{dx}}{{x}}$",
        f"Integrating both sides: ${latex(left_integral)} = \\ln|x| + C$",
        f"Substituting $v = \\frac{{y}}{{x}}$ back: ${latex(solution_implicit)}$"
    )
    
    return problem(
        question=question_text,
        answer=solution_implicit,
        difficulty=(1750, 1900),
        topic="differential_equations/homogeneous_equations",
        solution=solution_steps,
        answer_type="equation"
    )

emit(generate())