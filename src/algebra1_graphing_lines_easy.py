"""
algebra1 - graphing_lines (easy)
Generated: 2026-02-22T03:54:07.817087
"""

from problem_utils import *
from svg_utils import Graph

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find slope from two points (easiest)
        x1, y1 = randint(-5, 5), randint(-5, 5)
        x2, y2 = x1 + randint(1, 4), y1 + randint(-4, 4)
        while y2 == y1:
            y2 = y1 + randint(-4, 4)
        
        slope = Rational(y2 - y1, x2 - x1)
        
        g = Graph(x_range=(-8, 8), y_range=(-8, 8), width=300, height=300)
        g.point(x1, y1, f"({x1},{y1})")
        g.point(x2, y2, f"({x2},{y2})")
        line_expr = slope * (x - x1) + y1
        g.plot(line_expr)
        
        return problem(
            question=f"Find the slope of the line passing through the points $({x1}, {y1})$ and $({x2}, {y2})$.",
            answer=slope,
            difficulty=(1000, 1100),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"Use the slope formula: $m = \\frac{{y_2 - y_1}}{{x_2 - x_1}}$",
                f"$m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = \\frac{{{y2 - y1}}}{{{x2 - x1}}}$",
                f"$m = {latex(slope)}$"
            ),
            image=g.render()
        )
    
    elif problem_type == 2:
        # Find y-intercept from graph or equation in slope-intercept form
        m = nonzero(-3, 3)
        b_val = randint(-6, 6)
        
        equation = Eq(y, m*x + b_val)
        
        return problem(
            question=f"What is the $y$-intercept of the line ${latex(equation)}$?",
            answer=b_val,
            difficulty=(1050, 1150),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"The equation is in slope-intercept form: $y = mx + b$",
                f"The $y$-intercept is the constant term $b$",
                f"$b = {b_val}$"
            )
        )
    
    elif problem_type == 3:
        # Identify slope from slope-intercept form
        m = Rational(nonzero(-4, 4), choice([1, 2, 3, 4]))
        b_val = randint(-5, 5)
        
        equation = Eq(y, m*x + b_val)
        
        return problem(
            question=f"What is the slope of the line ${latex(equation)}$?",
            answer=m,
            difficulty=(1000, 1100),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"The equation is in slope-intercept form: $y = mx + b$",
                f"The slope is the coefficient of $x$",
                f"$m = {latex(m)}$"
            )
        )
    
    elif problem_type == 4:
        # Find x-intercept (where y=0)
        m = nonzero(-3, 3)
        b_val = nonzero(-6, 6)
        
        # x-intercept when y=0: 0 = mx + b, so x = -b/m
        x_intercept = Rational(-b_val, m)
        
        equation = Eq(y, m*x + b_val)
        
        return problem(
            question=f"Find the $x$-intercept of the line ${latex(equation)}$.",
            answer=x_intercept,
            difficulty=(1150, 1250),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"The $x$-intercept occurs when $y = 0$",
                f"$0 = {m}x + {b_val}$",
                f"${-b_val} = {m}x$",
                f"$x = {latex(x_intercept)}$"
            )
        )
    
    else:
        # Graph a simple line (identify slope and y-intercept, then plot)
        m = choice([-2, -1, 1, 2])
        b_val = randint(-3, 3)
        
        g = Graph(x_range=(-5, 5), y_range=(-5, 5), width=300, height=300)
        g.plot(m*x + b_val)
        g.point(0, b_val, f"(0,{b_val})")
        
        equation = Eq(y, m*x + b_val)
        
        return problem(
            question=f"The graph shows the line ${latex(equation)}$. What point does the line cross the $y$-axis?",
            answer=fmt_tuple(0, b_val),
            difficulty=(1100, 1200),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"The $y$-intercept is where the line crosses the $y$-axis (where $x = 0$)",
                f"From the equation $y = {m}x + {b_val}$, when $x = 0$:",
                f"$y = {m}(0) + {b_val} = {b_val}$",
                f"The point is $(0, {b_val})$"
            ),
            image=g.render()
        )

emit(generate())