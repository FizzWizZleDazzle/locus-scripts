"""
multivariable_calculus - partial_derivatives (medium)
Generated: 2026-02-22T05:33:55.748810
"""

from problem_utils import *

def generate():
    problem_type = choice(['first_order', 'second_order', 'mixed', 'evaluate'])
    
    if problem_type == 'first_order':
        # Simple first-order partial derivatives
        base_func = choice([
            x**2 + y**2,
            x**3 + y**2,
            x*y**2,
            x**2 * y,
            x**3 + x*y + y**2,
            x**2 - y**2,
        ])
        coeff = nonzero(-5, 5)
        func = coeff * base_func
        
        var_choice = choice([x, y])
        
        ans = diff(func, var_choice)
        
        return problem(
            question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right)$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Treat all variables except ${latex(var_choice)}$ as constants",
                f"Differentiate with respect to ${latex(var_choice)}$",
                f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'second_order':
        # Second-order partial derivatives
        base_func = choice([
            x**3 * y,
            x**2 * y**2,
            x**3 + y**3,
            x**2 * y + x * y**2,
        ])
        coeff = nonzero(-3, 3)
        func = coeff * base_func
        
        var1 = choice([x, y])
        var2 = choice([x, y])
        
        ans = diff(diff(func, var1), var2)
        
        if var1 == var2:
            notation = f"\\frac{{\\partial^2}}{{\\partial {latex(var1)}^2}}"
        else:
            notation = f"\\frac{{\\partial^2}}{{\\partial {latex(var2)} \\partial {latex(var1)}}}"
        
        first_deriv = diff(func, var1)
        
        return problem(
            question=f"Find ${notation}\\left({latex(func)}\\right)$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"First find $\\frac{{\\partial}}{{\\partial {latex(var1)}}}\\left({latex(func)}\\right) = {latex(first_deriv)}$",
                f"Then differentiate with respect to ${latex(var2)}$",
                f"${notation}\\left({latex(func)}\\right) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'mixed':
        # Mixed partial derivatives with exponentials or trig
        func_type = choice(['exp', 'trig', 'product'])
        
        if func_type == 'exp':
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            func = exp(a_val*x + b_val*y)
            
            var_choice = choice([x, y])
            ans = diff(func, var_choice)
            
            return problem(
                question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right)$",
                answer=ans,
                difficulty=(1350, 1500),
                topic="multivariable_calculus/partial_derivatives",
                solution=steps(
                    f"Use the chain rule for exponential functions",
                    f"Treat variables other than ${latex(var_choice)}$ as constants",
                    f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right) = {latex(ans)}$"
                )
            )
        
        elif func_type == 'trig':
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            trig_func = choice([sin, cos])
            func = trig_func(a_val*x + b_val*y)
            
            var_choice = choice([x, y])
            ans = diff(func, var_choice)
            
            return problem(
                question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right)$",
                answer=ans,
                difficulty=(1400, 1550),
                topic="multivariable_calculus/partial_derivatives",
                solution=steps(
                    f"Use the chain rule for trigonometric functions",
                    f"Treat variables other than ${latex(var_choice)}$ as constants",
                    f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right) = {latex(ans)}$"
                )
            )
        
        else:  # product
            func = x**2 * sin(y)
            var_choice = choice([x, y])
            ans = diff(func, var_choice)
            
            return problem(
                question=f"Find $\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right)$",
                answer=ans,
                difficulty=(1450, 1600),
                topic="multivariable_calculus/partial_derivatives",
                solution=steps(
                    f"Treat variables other than ${latex(var_choice)}$ as constants",
                    f"Apply differentiation rules",
                    f"$\\frac{{\\partial}}{{\\partial {latex(var_choice)}}}\\left({latex(func)}\\right) = {latex(ans)}$"
                )
            )
    
    else:  # evaluate
        # Evaluate partial derivative at a point
        func = x**2 * y + x * y**2
        var_choice = choice([x, y])
        
        x_val = nonzero(-3, 3)
        y_val = nonzero(-3, 3)
        
        partial_deriv = diff(func, var_choice)
        ans = partial_deriv.subs([(x, x_val), (y, y_val)])
        
        return problem(
            question=f"Evaluate $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}$ at $({x_val}, {y_val})$ where $f(x,y) = {latex(func)}$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"First find $\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}} = {latex(partial_deriv)}$",
                f"Substitute $x = {x_val}$ and $y = {y_val}$",
                f"$\\frac{{\\partial f}}{{\\partial {latex(var_choice)}}}({x_val}, {y_val}) = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())