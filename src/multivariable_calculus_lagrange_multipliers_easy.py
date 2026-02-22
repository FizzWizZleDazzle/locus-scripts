"""
multivariable_calculus - lagrange_multipliers (easy)
Generated: 2026-02-22T05:37:14.650899
"""

from problem_utils import *

def generate():
    # For Lagrange multipliers at the EASIER level (1000-1300), we want:
    # - Simple objective functions (quadratic or linear)
    # - Simple constraints (linear or circular)
    # - Problems that can be solved with basic setup
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Type 1: Minimize/maximize f(x,y) = x^2 + y^2 subject to ax + by = c
        # This is finding distance from origin to a line
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-5, 5)
        
        objective = x**2 + y**2
        constraint = a_val*x + b_val*y - c_val
        
        # Set up Lagrange equations
        L = objective - m * constraint
        dL_dx = diff(L, x)
        dL_dy = diff(L, y)
        dL_dm = diff(L, m)
        
        # Solve the system
        solutions = solve([dL_dx, dL_dy, dL_dm], [x, y, m], dict=True)
        
        if solutions:
            sol = solutions[0]
            x_val = sol[x]
            y_val = sol[y]
            ans_value = objective.subs([(x, x_val), (y, y_val)])
            ans = simplify(ans_value)
        else:
            # Fallback
            ans = c_val**2 / (a_val**2 + b_val**2)
        
        question = f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to the constraint ${latex(a_val*x + b_val*y)} = {c_val}$."
        
        solution = steps(
            f"Set up the Lagrangian: $L(x,y,\\lambda) = x^2 + y^2 - \\lambda({latex(a_val*x + b_val*y - c_val)})$",
            f"Take partial derivatives and set equal to zero:",
            f"$\\frac{{\\partial L}}{{\\partial x}} = 2x - {a_val}\\lambda = 0$",
            f"$\\frac{{\\partial L}}{{\\partial y}} = 2y - {b_val}\\lambda = 0$",
            f"$\\frac{{\\partial L}}{{\\partial \\lambda}} = {latex(-(a_val*x + b_val*y - c_val))} = 0$",
            f"Solving this system gives the minimum value: ${latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1300),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Maximize/minimize f(x,y) = xy subject to x + y = c
        # Classic problem with simple setup
        c_val = randint(4, 10)
        
        objective = x * y
        constraint = x + y - c_val
        
        # Set up Lagrange
        L = objective - m * constraint
        dL_dx = diff(L, x)
        dL_dy = diff(L, y)
        
        # From symmetry, x = y = c_val/2
        ans = (c_val/2) * (c_val/2)
        ans = simplify(ans)
        
        question = f"Find the maximum value of $f(x,y) = xy$ subject to the constraint $x + y = {c_val}$."
        
        solution = steps(
            f"Set up the Lagrangian: $L(x,y,\\lambda) = xy - \\lambda(x + y - {c_val})$",
            f"Take partial derivatives:",
            f"$\\frac{{\\partial L}}{{\\partial x}} = y - \\lambda = 0$",
            f"$\\frac{{\\partial L}}{{\\partial y}} = x - \\lambda = 0$",
            f"$\\frac{{\\partial L}}{{\\partial \\lambda}} = -(x + y - {c_val}) = 0$",
            f"From the first two equations: $x = y = \\lambda$",
            f"Substituting into the constraint: $2x = {c_val}$, so $x = y = {c_val/2}$",
            f"Maximum value: $xy = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1200),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=solution,
            calculator="scientific"
        )
    
    else:
        # Type 3: Find critical points using Lagrange multipliers
        # f(x,y) = x + y subject to x^2 + y^2 = r^2
        r_val = randint(2, 5)
        r_sq = r_val**2
        
        objective = x + y
        constraint = x**2 + y**2 - r_sq
        
        # Set up Lagrange
        L = objective - m * constraint
        dL_dx = diff(L, x)
        dL_dy = diff(L, y)
        
        # Solution: x = y = r/sqrt(2) for maximum
        max_val = r_val * sqrt(2)
        ans = simplify(max_val)
        
        question = f"Find the maximum value of $f(x,y) = x + y$ subject to the constraint $x^2 + y^2 = {r_sq}$."
        
        solution = steps(
            f"Set up the Lagrangian: $L(x,y,\\lambda) = x + y - \\lambda(x^2 + y^2 - {r_sq})$",
            f"Take partial derivatives:",
            f"$\\frac{{\\partial L}}{{\\partial x}} = 1 - 2\\lambda x = 0$",
            f"$\\frac{{\\partial L}}{{\\partial y}} = 1 - 2\\lambda y = 0$",
            f"$\\frac{{\\partial L}}{{\\partial \\lambda}} = -(x^2 + y^2 - {r_sq}) = 0$",
            f"From the first two equations: $x = y = \\frac{{1}}{{2\\lambda}}$",
            f"Substituting into constraint: $2x^2 = {r_sq}$",
            f"Solving: $x = y = \\frac{{{r_val}}}{{\\sqrt{{2}}}}$",
            f"Maximum value: $x + y = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=solution,
            calculator="scientific"
        )

emit(generate())