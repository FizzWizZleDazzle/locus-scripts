"""
calculus - implicit_differentiation (hard)
Generated: 2026-02-22T05:05:25.184470
"""

from problem_utils import *

def generate():
    problem_type = choice(['circle_line', 'ellipse', 'related_products', 'trig_implicit', 'nested_implicit'])
    
    if problem_type == 'circle_line':
        # Circle with a line through it, find dy/dx at a point
        r = randint(3, 7)
        x0 = randint(-r+1, r-1)
        # Make sure point is on circle
        y0_sq = r**2 - x0**2
        y0 = int(sqrt(y0_sq))
        if choice([True, False]) and y0 != 0:
            y0 = -y0
        
        question = f"Find $\\frac{{dy}}{{dx}}$ for the equation $x^2 + y^2 = {r**2}$ at the point $({x0}, {y0})$."
        
        # Implicit differentiation: 2x + 2y*dy/dx = 0
        # dy/dx = -x/y
        if y0 != 0:
            ans = Rational(-x0, y0)
        else:
            ans = oo
        
        solution = steps(
            f"Differentiate both sides with respect to $x$: $2x + 2y\\frac{{dy}}{{dx}} = 0$",
            f"Solve for $\\frac{{dy}}{{dx}}$: $\\frac{{dy}}{{dx}} = -\\frac{{x}}{{y}}$",
            f"Substitute $x = {x0}$ and $y = {y0}$: $\\frac{{dy}}{{dx}} = -\\frac{{{x0}}}{{{y0}}} = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/implicit_differentiation",
            solution=solution
        )
    
    elif problem_type == 'ellipse':
        # Ellipse equation, find dy/dx
        a_sq = randint(4, 16)
        b_sq = randint(4, 16)
        while a_sq == b_sq:
            b_sq = randint(4, 16)
        
        question = f"Find $\\frac{{dy}}{{dx}}$ for the equation $\\frac{{x^2}}{{{a_sq}}} + \\frac{{y^2}}{{{b_sq}}} = 1$."
        
        # Differentiate: (2x)/a_sq + (2y/b_sq)*dy/dx = 0
        # dy/dx = -b_sq*x/(a_sq*y)
        ans = simplify(-b_sq*x/(a_sq*y))
        
        solution = steps(
            f"Differentiate both sides with respect to $x$: $\\frac{{2x}}{{{a_sq}}} + \\frac{{2y}}{{{b_sq}}}\\frac{{dy}}{{dx}} = 0$",
            f"Solve for $\\frac{{dy}}{{dx}}$: $\\frac{{2y}}{{{b_sq}}}\\frac{{dy}}{{dx}} = -\\frac{{2x}}{{{a_sq}}}$",
            f"$\\frac{{dy}}{{dx}} = -\\frac{{{b_sq}x}}{{{a_sq}y}} = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/implicit_differentiation",
            solution=solution
        )
    
    elif problem_type == 'related_products':
        # Product of x and y terms
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = randint(1, 20)
        
        question = f"Find $\\frac{{dy}}{{dx}}$ for the equation ${latex(a*x**2*y + b*x*y**2)} = {c}$."
        
        # Differentiate: a(2xy + x^2*dy/dx) + b(y^2 + 2xy*dy/dx) = 0
        # a*x^2*dy/dx + b*2xy*dy/dx = -2axy - by^2
        # dy/dx(ax^2 + 2bxy) = -2axy - by^2
        numerator = -2*a*x*y - b*y**2
        denominator = a*x**2 + 2*b*x*y
        ans = simplify(numerator/denominator)
        
        solution = steps(
            f"Apply product rule to each term: ${latex(a)}(2xy + x^2\\frac{{dy}}{{dx}}) + {latex(b)}(y^2 + 2xy\\frac{{dy}}{{dx}}) = 0$",
            f"Expand: ${latex(2*a*x*y + a*x**2)} \\frac{{dy}}{{dx}} + {latex(b*y**2 + 2*b*x*y)} \\frac{{dy}}{{dx}} = 0$",
            f"Combine terms with $\\frac{{dy}}{{dx}}$: $({latex(a*x**2 + 2*b*x*y)})\\frac{{dy}}{{dx}} = {latex(-2*a*x*y - b*y**2)}$",
            f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/implicit_differentiation",
            solution=solution
        )
    
    elif problem_type == 'trig_implicit':
        # Trigonometric implicit equation
        a = nonzero(-3, 3)
        
        question = f"Find $\\frac{{dy}}{{dx}}$ for the equation $\\sin(xy) = {latex(a*x)}$."
        
        # Differentiate: cos(xy)*(y + x*dy/dx) = a
        # cos(xy)*y + cos(xy)*x*dy/dx = a
        # dy/dx = (a - y*cos(xy))/(x*cos(xy))
        numerator = a - y*cos(x*y)
        denominator = x*cos(x*y)
        ans = simplify(numerator/denominator)
        
        solution = steps(
            f"Differentiate both sides: $\\cos(xy) \\cdot (y + x\\frac{{dy}}{{dx}}) = {latex(a)}$",
            f"Expand: $y\\cos(xy) + x\\cos(xy)\\frac{{dy}}{{dx}} = {latex(a)}$",
            f"Solve for $\\frac{{dy}}{{dx}}$: $x\\cos(xy)\\frac{{dy}}{{dx}} = {latex(a)} - y\\cos(xy)$",
            f"$\\frac{{dy}}{{dx}} = \\frac{{{latex(a)} - y\\cos(xy)}}{{x\\cos(xy)}} = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/implicit_differentiation",
            solution=solution
        )
    
    else:  # nested_implicit
        # More complex nested function
        k = randint(2, 5)
        c = randint(1, 10)
        
        question = f"Find $\\frac{{dy}}{{dx}}$ for the equation $e^{{xy}} + y^{k} = {c}$."
        
        # Differentiate: e^(xy)*(y + x*dy/dx) + k*y^(k-1)*dy/dx = 0
        # e^(xy)*y + e^(xy)*x*dy/dx + k*y^(k-1)*dy/dx = 0
        # dy/dx*(e^(xy)*x + k*y^(k-1)) = -e^(xy)*y
        # dy/dx = -e^(xy)*y / (e^(xy)*x + k*y^(k-1))
        numerator = -exp(x*y)*y
        denominator = exp(x*y)*x + k*y**(k-1)
        ans = simplify(numerator/denominator)
        
        solution = steps(
            f"Differentiate both sides: $e^{{xy}}(y + x\\frac{{dy}}{{dx}}) + {k}y^{{{k-1}}}\\frac{{dy}}{{dx}} = 0$",
            f"Expand: $ye^{{xy}} + xe^{{xy}}\\frac{{dy}}{{dx}} + {k}y^{{{k-1}}}\\frac{{dy}}{{dx}} = 0$",
            f"Factor out $\\frac{{dy}}{{dx}}$: $(xe^{{xy}} + {k}y^{{{k-1}}})\\frac{{dy}}{{dx}} = -ye^{{xy}}$",
            f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1800, 1900),
            topic="calculus/implicit_differentiation",
            solution=solution
        )

emit(generate())