"""
calculus - implicit_differentiation (easy)
Generated: 2026-02-22T05:04:36.786935
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple implicit differentiation of circle or ellipse
        # Example: x^2 + y^2 = r^2, find dy/dx
        r_sq = randint(4, 25)
        
        # The equation is x^2 + y^2 = r_sq
        # Differentiating: 2x + 2y(dy/dx) = 0
        # So dy/dx = -x/y
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for the equation $x^2 + y^2 = {r_sq}$ using implicit differentiation.",
            answer=-x/y,
            difficulty=(1000, 1150),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$:",
                f"$\\frac{{d}}{{dx}}[x^2 + y^2] = \\frac{{d}}{{dx}}[{r_sq}]$",
                f"$2x + 2y\\frac{{dy}}{{dx}} = 0$",
                f"Solve for $\\frac{{dy}}{{dx}}$:",
                f"$2y\\frac{{dy}}{{dx}} = -2x$",
                f"$\\frac{{dy}}{{dx}} = -\\frac{{x}}{{y}}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Linear implicit equation ax + by = c
        # Example: 2x + 3y = 5, find dy/dx
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        c_val = randint(1, 10)
        
        # Differentiating: a + b(dy/dx) = 0
        # So dy/dx = -a/b
        ans = Rational(-a_val, b_val)
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for the equation ${latex(a_val*x + b_val*y)} = {c_val}$ using implicit differentiation.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$:",
                f"$\\frac{{d}}{{dx}}[{latex(a_val*x + b_val*y)}] = \\frac{{d}}{{dx}}[{c_val}]$",
                f"${a_val} + {b_val}\\frac{{dy}}{{dx}} = 0$",
                f"Solve for $\\frac{{dy}}{{dx}}$:",
                f"${b_val}\\frac{{dy}}{{dx}} = {-a_val}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Simple product like xy = k
        # Example: xy = 6, find dy/dx
        k_val = randint(2, 20)
        
        # Differentiating: y + x(dy/dx) = 0
        # So dy/dx = -y/x
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for the equation $xy = {k_val}$ using implicit differentiation.",
            answer=-y/x,
            difficulty=(1100, 1200),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$:",
                f"$\\frac{{d}}{{dx}}[xy] = \\frac{{d}}{{dx}}[{k_val}]$",
                f"Using the product rule on the left side:",
                f"$y + x\\frac{{dy}}{{dx}} = 0$",
                f"Solve for $\\frac{{dy}}{{dx}}$:",
                f"$x\\frac{{dy}}{{dx}} = -y$",
                f"$\\frac{{dy}}{{dx}} = -\\frac{{y}}{{x}}$"
            ),
        )
    
    else:  # problem_type == 4
        # Type 4: ax^2 + by^2 = c (ellipse-like)
        # Example: 2x^2 + 3y^2 = 12, find dy/dx
        a_val = randint(1, 5)
        b_val = randint(1, 5)
        c_val = randint(5, 20)
        
        # Differentiating: 2ax + 2by(dy/dx) = 0
        # So dy/dx = -ax/(by)
        ans = simplify(-a_val*x/(b_val*y))
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ for the equation ${latex(a_val*x**2 + b_val*y**2)} = {c_val}$ using implicit differentiation.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$:",
                f"$\\frac{{d}}{{dx}}[{latex(a_val*x**2 + b_val*y**2)}] = \\frac{{d}}{{dx}}[{c_val}]$",
                f"${latex(2*a_val*x)} + {latex(2*b_val*y)}\\frac{{dy}}{{dx}} = 0$",
                f"Solve for $\\frac{{dy}}{{dx}}$:",
                f"${latex(2*b_val*y)}\\frac{{dy}}{{dx}} = {latex(-2*a_val*x)}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

emit(generate())