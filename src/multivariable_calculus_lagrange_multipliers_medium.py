"""
multivariable_calculus - lagrange_multipliers (medium)
Generated: 2026-02-22T05:37:50.028875
"""

from problem_utils import *

def generate():
    prob_type = randint(1, 4)
    
    if prob_type == 1:
        # Optimize f(x,y) subject to g(x,y) = c (basic constraint)
        # Build a clean problem: maximize/minimize f subject to circle or line
        constraint_type = choice(['circle', 'line'])
        
        if constraint_type == 'circle':
            # f(x,y) = x + y subject to x^2 + y^2 = r^2
            a_coeff = nonzero(-3, 3)
            b_coeff = nonzero(-3, 3)
            r_sq = choice([4, 9, 16, 25])
            
            # Lagrange: grad f = lambda * grad g
            # (a, b) = lambda * (2x, 2y)
            # x^2 + y^2 = r_sq
            # a = 2*lambda*x, b = 2*lambda*y
            # x = a/(2*lambda), y = b/(2*lambda)
            # (a/(2*lambda))^2 + (b/(2*lambda))^2 = r_sq
            # (a^2 + b^2)/(4*lambda^2) = r_sq
            # lambda = ±sqrt((a^2 + b^2)/(4*r_sq))
            
            from sympy import symbols
            lam = symbols('lambda')
            
            # For max, use positive lambda (direction of gradient)
            lambda_val = sqrt((a_coeff**2 + b_coeff**2)/(4*r_sq))
            x_crit = a_coeff / (2*lambda_val)
            y_crit = b_coeff / (2*lambda_val)
            x_crit = simplify(x_crit)
            y_crit = simplify(y_crit)
            
            f_val = simplify(a_coeff * x_crit + b_coeff * y_crit)
            
            question = f"Find the maximum value of $f(x,y) = {latex(a_coeff*x + b_coeff*y)}$ subject to the constraint $x^2 + y^2 = {r_sq}$."
            
            solution = steps(
                f"Use Lagrange multipliers: $\\nabla f = \\lambda \\nabla g$ where $g(x,y) = x^2 + y^2 - {r_sq}$",
                f"$\\nabla f = ({a_coeff}, {b_coeff})$ and $\\nabla g = (2x, 2y)$",
                f"This gives ${a_coeff} = 2\\lambda x$ and ${b_coeff} = 2\\lambda y$",
                f"From the constraint and solving the system, the critical point for maximum is $(x,y) = ({latex(x_crit)}, {latex(y_crit)})$",
                f"The maximum value is $f = {latex(f_val)}$"
            )
            
            return problem(
                question=question,
                answer=f_val,
                difficulty=(1300, 1500),
                topic="multivariable_calculus/lagrange_multipliers",
                solution=solution
            )
        
        else:  # line constraint
            # f(x,y) = x^2 + y^2 subject to ax + by = c (minimize distance)
            a_coeff = nonzero(-3, 3)
            b_coeff = nonzero(-3, 3)
            c_val = nonzero(-5, 5)
            
            # grad f = (2x, 2y), grad g = (a, b)
            # 2x = lambda*a, 2y = lambda*b
            # x = lambda*a/2, y = lambda*b/2
            # a*(lambda*a/2) + b*(lambda*b/2) = c
            # lambda*(a^2 + b^2)/2 = c
            # lambda = 2c/(a^2 + b^2)
            
            lambda_val = Rational(2*c_val, a_coeff**2 + b_coeff**2)
            x_crit = simplify(lambda_val * a_coeff / 2)
            y_crit = simplify(lambda_val * b_coeff / 2)
            
            min_val = simplify(x_crit**2 + y_crit**2)
            
            question = f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to the constraint ${latex(a_coeff*x + b_coeff*y)} = {c_val}$."
            
            solution = steps(
                f"Use Lagrange multipliers: $\\nabla f = \\lambda \\nabla g$ where $g(x,y) = {latex(a_coeff*x + b_coeff*y - c_val)}$",
                f"$\\nabla f = (2x, 2y)$ and $\\nabla g = ({a_coeff}, {b_coeff})$",
                f"This gives $2x = {a_coeff}\\lambda$ and $2y = {b_coeff}\\lambda$",
                f"Substituting into the constraint: ${latex(a_coeff*(a_coeff*lam/2) + b_coeff*(b_coeff*lam/2))} = {c_val}$",
                f"Solving gives $\\lambda = {latex(lambda_val)}$, so $(x,y) = ({latex(x_crit)}, {latex(y_crit)})$",
                f"The minimum value is $f = {latex(min_val)}$"
            )
            
            return problem(
                question=question,
                answer=min_val,
                difficulty=(1300, 1500),
                topic="multivariable_calculus/lagrange_multipliers",
                solution=solution
            )
    
    elif prob_type == 2:
        # Product constraint: maximize xy subject to x + y = k
        k_val = randint(4, 12)
        
        # grad(xy) = lambda * grad(x+y)
        # (y, x) = lambda(1, 1)
        # y = lambda, x = lambda, so x = y
        # x + y = k => 2x = k => x = y = k/2
        
        x_crit = Rational(k_val, 2)
        y_crit = Rational(k_val, 2)
        max_val = x_crit * y_crit
        
        question = f"Find the maximum value of $f(x,y) = xy$ subject to the constraint $x + y = {k_val}$."
        
        solution = steps(
            f"Use Lagrange multipliers: $\\nabla f = \\lambda \\nabla g$ where $g(x,y) = x + y - {k_val}$",
            f"$\\nabla f = (y, x)$ and $\\nabla g = (1, 1)$",
            f"This gives $y = \\lambda$ and $x = \\lambda$, so $x = y$",
            f"From $x + y = {k_val}$ with $x = y$: $2x = {k_val}$, so $x = y = {latex(x_crit)}$",
            f"The maximum value is $f = {latex(x_crit)} \\cdot {latex(y_crit)} = {latex(max_val)}$"
        )
        
        return problem(
            question=question,
            answer=max_val,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=solution
        )
    
    elif prob_type == 3:
        # Three variables: maximize xyz subject to x + y + z = k
        k_val = randint(6, 15)
        
        # By symmetry, x = y = z = k/3
        val = Rational(k_val, 3)
        max_val = val**3
        
        question = f"Find the maximum value of $f(x,y,z) = xyz$ subject to the constraint $x + y + z = {k_val}$ where $x, y, z > 0$."
        
        solution = steps(
            f"Use Lagrange multipliers: $\\nabla f = \\lambda \\nabla g$ where $g(x,y,z) = x + y + z - {k_val}$",
            f"$\\nabla f = (yz, xz, xy)$ and $\\nabla g = (1, 1, 1)$",
            f"This gives $yz = \\lambda$, $xz = \\lambda$, and $xy = \\lambda$",
            f"From the first two: $yz = xz \\Rightarrow y = x$",
            f"From the first and third: $yz = xy \\Rightarrow z = x$",
            f"So $x = y = z$. From $x + y + z = {k_val}$: $3x = {k_val}$, giving $x = y = z = {latex(val)}$",
            f"The maximum value is $f = {latex(val)}^3 = {latex(max_val)}$"
        )
        
        return problem(
            question=question,
            answer=max_val,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=solution
        )
    
    else:  # prob_type == 4
        # Minimize x^2 + y^2 + z^2 subject to ax + by + cz = d
        a_coeff = nonzero(-2, 2)
        b_coeff = nonzero(-2, 2)
        c_coeff = nonzero(-2, 2)
        d_val = nonzero(-6, 6)
        
        # grad(x^2+y^2+z^2) = (2x, 2y, 2z)
        # grad(ax+by+cz) = (a, b, c)
        # 2x = lambda*a, 2y = lambda*b, 2z = lambda*c
        # x = lambda*a/2, y = lambda*b/2, z = lambda*c/2
        # a*(lambda*a/2) + b*(lambda*b/2) + c*(lambda*c/2) = d
        # lambda*(a^2+b^2+c^2)/2 = d
        
        denom = a_coeff**2 + b_coeff**2 + c_coeff**2
        lambda_val = Rational(2*d_val, denom)
        
        x_crit = simplify(lambda_val * a_coeff / 2)
        y_crit = simplify(lambda_val * b_coeff / 2)
        z_crit = simplify(lambda_val * c_coeff / 2)
        
        min_val = simplify(x_crit**2 + y_crit**2 + z_crit**2)
        
        question = f"Find the minimum value of $f(x,y,z) = x^2 + y^2 + z^2$ subject to the constraint ${latex(a_coeff*x + b_coeff*y + c_coeff*z)} = {d_val}$."
        
        solution = steps(
            f"Use Lagrange multipliers: $\\nabla f = \\lambda \\nabla g$ where $g(x,y,z) = {latex(a_coeff*x + b_coeff*y + c_coeff*z - d_val)}$",
            f"$\\nabla f = (2x, 2y, 2z)$ and $\\nabla g = ({a_coeff}, {b_coeff}, {c_coeff})$",
            f"This gives $2x = {a_coeff}\\lambda$, $2y = {b_coeff}\\lambda$, $2z = {c_coeff}\\lambda$",
            f"Substituting into the constraint and solving for $\\lambda$: $\\lambda = {latex(lambda_val)}$",
            f"The critical point is $(x,y,z) = ({latex(x_crit)}, {latex(y_crit)}, {latex(z_crit)})$",
            f"The minimum value is $f = {latex(min_val)}$"
        )
        
        return problem(
            question=question,
            answer=min_val,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=solution
        )

emit(generate())