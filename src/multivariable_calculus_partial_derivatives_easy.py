"""
multivariable_calculus - partial_derivatives (easy)
Generated: 2026-02-22T05:33:32.789809
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple first-order partial derivative of polynomial (1000-1150)
        # f(x,y) = ax^m + by^n, find ∂f/∂x or ∂f/∂y
        a_coeff = nonzero(-5, 5)
        b_coeff = nonzero(-5, 5)
        x_power = randint(2, 4)
        y_power = randint(2, 4)
        
        f = a_coeff * x**x_power + b_coeff * y**y_power
        
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        
        return problem(
            question=f"Find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ where $f({latex(x)},{latex(y)}) = {latex(f)}$",
            answer=ans,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"To find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$, treat all other variables as constants",
                f"Differentiate ${latex(f)}$ with respect to ${latex(var_choice)}$",
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Partial derivative of sum of monomials (1100-1250)
        # f(x,y) = ax^m*y^n + bx^p, find ∂f/∂x or ∂f/∂y
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        x_power1 = randint(1, 3)
        y_power1 = randint(1, 3)
        x_power2 = randint(2, 3)
        
        f = a_coeff * x**x_power1 * y**y_power1 + b_coeff * x**x_power2
        
        var_choice = choice([x, y])
        ans = diff(f, var_choice)
        
        return problem(
            question=f"Compute $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left[{latex(f)}\\right]$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Differentiate ${latex(f)}$ with respect to ${latex(var_choice)}$, treating other variables as constants",
                f"Apply the power rule to each term",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left[{latex(f)}\\right] = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Evaluate partial derivative at a point (1150-1300)
        # f(x,y) = ax^2 + by^2, find ∂f/∂x at (x0, y0)
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        
        f = a_coeff * x**2 + b_coeff * y**2
        
        var_choice = choice([x, y])
        partial = diff(f, var_choice)
        
        x0 = randint(-3, 3)
        y0 = randint(-3, 3)
        
        ans = partial.subs([(x, x0), (y, y0)])
        
        return problem(
            question=f"Let $f({latex(x)},{latex(y)}) = {latex(f)}$. Evaluate $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ at the point $({x0}, {y0})$",
            answer=ans,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"First, find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(partial)}$",
                f"Substitute ${latex(var_choice)} = {x0 if var_choice == x else y0}$",
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}({x0}, {y0}) = {latex(ans)}$"
            )
        )
    
    else:
        # Type 4: Simple mixed partial with three variables (1200-1300)
        # f(x,y,z) = axy + byz, find ∂f/∂x or ∂f/∂y or ∂f/∂z
        a_coeff = nonzero(-5, 5)
        b_coeff = nonzero(-5, 5)
        
        f = a_coeff * x * y + b_coeff * y * z
        
        var_choice = choice([x, y, z])
        ans = diff(f, var_choice)
        
        return problem(
            question=f"Find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ where $f({latex(x)},{latex(y)},{latex(z)}) = {latex(f)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"To find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$, differentiate with respect to ${latex(var_choice)}$ and treat all other variables as constants",
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(ans)}$"
            )
        )

emit(generate())