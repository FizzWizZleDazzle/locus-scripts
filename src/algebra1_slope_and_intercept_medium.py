"""
algebra1 - slope_and_intercept (medium)
Generated: 2026-02-22T03:53:14.385120
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Find slope given two points (1300-1400)
        x1, y1 = randint(-8, 8), randint(-8, 8)
        x2, y2 = randint(-8, 8), randint(-8, 8)
        while x2 == x1:  # Ensure different x-coordinates
            x2 = randint(-8, 8)
        
        slope = Rational(y2 - y1, x2 - x1)
        
        return problem(
            question=f"Find the slope of the line passing through the points $({x1}, {y1})$ and $({x2}, {y2})$.",
            answer=slope,
            difficulty=(1300, 1400),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Use the slope formula: $m = \\frac{{y_2 - y_1}}{{x_2 - x_1}}$",
                f"$m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}}$",
                f"$m = \\frac{{{y2 - y1}}}{{{x2 - x1}}}$",
                f"$m = {latex(slope)}$"
            )
        )
    
    elif problem_type == 2:
        # Find y-intercept given slope and point (1400-1500)
        m = Rational(nonzero(-5, 5), choice([1, 2, 3]))
        x_pt, y_pt = randint(-6, 6), randint(-6, 6)
        
        # y = mx + b, so b = y - mx
        b = y_pt - m * x_pt
        
        return problem(
            question=f"A line has slope ${latex(m)}$ and passes through the point $({x_pt}, {y_pt})$. Find the $y$-intercept.",
            answer=b,
            difficulty=(1400, 1500),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Use point-slope form: $y - y_1 = m(x - x_1)$",
                f"$y - {y_pt} = {latex(m)}(x - {x_pt})$",
                f"$y - {y_pt} = {latex(m * x)} - {latex(m * x_pt)}$",
                f"$y = {latex(m * x)} + {latex(y_pt - m * x_pt)}$",
                f"The $y$-intercept is ${latex(b)}$"
            )
        )
    
    elif problem_type == 3:
        # Write equation in slope-intercept form given two points (1500-1600)
        x1, y1 = randint(-6, 6), randint(-6, 6)
        x2, y2 = randint(-6, 6), randint(-6, 6)
        while x2 == x1:
            x2 = randint(-6, 6)
        
        m = Rational(y2 - y1, x2 - x1)
        b = y1 - m * x1
        ans = Eq(y, m * x + b)
        
        return problem(
            question=f"Write the equation of the line passing through $({x1}, {y1})$ and $({x2}, {y2})$ in slope-intercept form.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"First find the slope: $m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = \\frac{{{y2 - y1}}}{{{x2 - x1}}} = {latex(m)}$",
                f"Use point-slope form with point $({x1}, {y1})$:",
                f"$y - {y1} = {latex(m)}(x - {x1})$",
                f"$y - {y1} = {latex(m * x)} - {latex(m * x1)}$",
                f"$y = {latex(m * x)} + {latex(b)}$"
            )
        )
    
    else:
        # Find x-intercept given equation in slope-intercept form (1300-1400)
        m = Rational(nonzero(-4, 4), choice([1, 2]))
        b = nonzero(-8, 8)
        
        # x-intercept when y = 0: 0 = mx + b, so x = -b/m
        x_int = Rational(-b, m)
        
        return problem(
            question=f"Find the $x$-intercept of the line $y = {latex(m * x + b)}$.",
            answer=x_int,
            difficulty=(1300, 1400),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"The $x$-intercept occurs when $y = 0$",
                f"$0 = {latex(m * x + b)}$",
                f"${latex(-b)} = {latex(m * x)}$",
                f"$x = {latex(x_int)}$"
            )
        )

emit(generate())