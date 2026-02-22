"""
calculus - implicit_differentiation (medium)
Generated: 2026-02-22T05:04:55.640510
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Basic implicit differentiation: circle or simple curve
        # Difficulty: 1300-1400
        r_sq = randint(1, 9)
        eq = Eq(x**2 + y**2, r_sq)
        
        # dy/dx = -x/y
        ans = -x/y
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ using implicit differentiation: ${latex(eq)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$: ${latex(eq)}$",
                f"$\\frac{{d}}{{dx}}[x^2 + y^2] = \\frac{{d}}{{dx}}[{r_sq}]$",
                f"$2x + 2y\\frac{{dy}}{{dx}} = 0$",
                f"$2y\\frac{{dy}}{{dx}} = -2x$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Implicit differentiation with linear terms
        # Difficulty: 1400-1500
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(1, 20)
        
        eq = Eq(a*x**2 + b*y**2, c)
        
        # dy/dx = -ax/(by)
        ans = simplify(-a*x / (b*y))
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ using implicit differentiation: ${latex(eq)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$: ${latex(eq)}$",
                f"${latex(2*a*x)} + {latex(2*b*y)}\\frac{{dy}}{{dx}} = 0$",
                f"${latex(2*b*y)}\\frac{{dy}}{{dx}} = {latex(-2*a*x)}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Product of x and y terms
        # Difficulty: 1400-1500
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(1, 15)
        
        eq = Eq(a*x*y + b*x, c)
        
        # Differentiate: a(y + x*dy/dx) + b = 0
        # a*x*dy/dx = -a*y - b
        # dy/dx = -(a*y + b)/(a*x)
        ans = simplify(-(a*y + b)/(a*x))
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ using implicit differentiation: ${latex(eq)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$: ${latex(eq)}$",
                f"Apply product rule to ${latex(a*x*y)}$:",
                f"${latex(a)}\\left(y + x\\frac{{dy}}{{dx}}\\right) + {latex(b)} = 0$",
                f"${latex(a*y)} + {latex(a*x)}\\frac{{dy}}{{dx}} + {latex(b)} = 0$",
                f"${latex(a*x)}\\frac{{dy}}{{dx}} = {latex(-(a*y + b))}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )
    
    else:
        # Mixed terms with x, y, and xy
        # Difficulty: 1500-1600
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = randint(1, 12)
        
        eq = Eq(x**2 + a*x*y + y**2, c)
        
        # Differentiate: 2x + a(y + x*dy/dx) + 2y*dy/dx = 0
        # 2x + ay + ax*dy/dx + 2y*dy/dx = 0
        # (ax + 2y)*dy/dx = -2x - ay
        # dy/dx = -(2x + ay)/(ax + 2y)
        ans = simplify(-(2*x + a*y)/(a*x + 2*y))
        
        return problem(
            question=f"Find $\\frac{{dy}}{{dx}}$ using implicit differentiation: ${latex(eq)}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/implicit_differentiation",
            solution=steps(
                f"Differentiate both sides with respect to $x$: ${latex(eq)}$",
                f"$2x + {latex(a)}\\left(y + x\\frac{{dy}}{{dx}}\\right) + 2y\\frac{{dy}}{{dx}} = 0$",
                f"$2x + {latex(a*y)} + {latex(a*x)}\\frac{{dy}}{{dx}} + 2y\\frac{{dy}}{{dx}} = 0$",
                f"$\\left({latex(a*x)} + 2y\\right)\\frac{{dy}}{{dx}} = {latex(-(2*x + a*y))}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            ),
        )

emit(generate())