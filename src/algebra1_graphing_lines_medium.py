"""
algebra1 - graphing_lines (medium)
Generated: 2026-02-22T03:54:34.595772
"""

from problem_utils import *
from svg_utils import Graph

def generate():
    problem_type = choice([
        'slope_intercept_to_graph',
        'point_slope_form',
        'two_points_equation',
        'standard_to_slope_intercept',
        'parallel_line',
        'perpendicular_line',
        'find_intercepts',
        'graph_interpretation'
    ])
    
    if problem_type == 'slope_intercept_to_graph':
        # Given slope-intercept form, identify slope and y-intercept
        m = nonzero(-4, 4)
        b = randint(-5, 5)
        equation = m*x + b
        
        q = f"What is the slope of the line $y = {latex(equation)}$?"
        ans = m
        sol = steps(
            f"The equation is in slope-intercept form $y = mx + b$",
            f"The slope $m = {m}$"
        )
        diff = (1200, 1300)
        
    elif problem_type == 'point_slope_form':
        # Convert point-slope to slope-intercept
        m = nonzero(-3, 3)
        x1 = nonzero(-4, 4)
        y1 = nonzero(-4, 4)
        b = y1 - m*x1
        ans = m*x + b
        
        q = f"Convert to slope-intercept form: $y - {y1} = {m}(x - {x1})$"
        sol = steps(
            f"Start with $y - {y1} = {m}(x - {x1})$",
            f"Distribute: $y - {y1} = {latex(m*x - m*x1)}$",
            f"Add ${y1}$ to both sides: $y = {latex(ans)}$"
        )
        diff = (1400, 1500)
        
    elif problem_type == 'two_points_equation':
        # Find equation from two points
        x1, y1 = nonzero(-5, 5), nonzero(-5, 5)
        x2, y2 = nonzero(-5, 5), nonzero(-5, 5)
        while x2 == x1:
            x2 = nonzero(-5, 5)
        
        m = Rational(y2 - y1, x2 - x1)
        b = y1 - m*x1
        ans = m*x + b
        
        q = f"Find the equation of the line passing through $({x1}, {y1})$ and $({x2}, {y2})$ in slope-intercept form."
        sol = steps(
            f"Find slope: $m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = \\frac{{{y2-y1}}}{{{x2-x1}}} = {latex(m)}$",
            f"Use point-slope form with $({x1}, {y1})$: $y - {y1} = {latex(m)}(x - {x1})$",
            f"Simplify: $y = {latex(ans)}$"
        )
        diff = (1500, 1600)
        
    elif problem_type == 'standard_to_slope_intercept':
        # Convert Ax + By = C to y = mx + b
        A = nonzero(-6, 6)
        B = nonzero(-6, 6)
        C = randint(-8, 8)
        
        m = Rational(-A, B)
        b = Rational(C, B)
        ans = m*x + b
        
        q = f"Convert to slope-intercept form: ${A}x + {B}y = {C}$"
        sol = steps(
            f"Subtract ${A}x$ from both sides: ${B}y = {latex(-A*x + C)}$",
            f"Divide by ${B}$: $y = {latex(ans)}$"
        )
        diff = (1300, 1400)
        
    elif problem_type == 'parallel_line':
        # Find equation parallel to given line through a point
        m = nonzero(-3, 3)
        b_orig = randint(-5, 5)
        x1 = nonzero(-4, 4)
        y1 = nonzero(-4, 4)
        b_new = y1 - m*x1
        ans = m*x + b_new
        
        q = f"Find the equation of the line parallel to $y = {latex(m*x + b_orig)}$ passing through $({x1}, {y1})$."
        sol = steps(
            f"Parallel lines have the same slope: $m = {m}$",
            f"Use point-slope form: $y - {y1} = {m}(x - {x1})$",
            f"Simplify: $y = {latex(ans)}$"
        )
        diff = (1400, 1550)
        
    elif problem_type == 'perpendicular_line':
        # Find equation perpendicular to given line through a point
        m_orig = nonzero(-4, 4)
        while abs(m_orig) == 1:  # Avoid m = ±1 for cleaner perpendicular slopes
            m_orig = nonzero(-4, 4)
        b_orig = randint(-5, 5)
        x1 = nonzero(-3, 3)
        y1 = nonzero(-3, 3)
        
        m_perp = Rational(-1, m_orig)
        b_new = y1 - m_perp*x1
        ans = m_perp*x + b_new
        
        q = f"Find the equation of the line perpendicular to $y = {latex(m_orig*x + b_orig)}$ passing through $({x1}, {y1})$."
        sol = steps(
            f"Perpendicular slope is negative reciprocal: $m = -\\frac{{1}}{{{m_orig}}} = {latex(m_perp)}$",
            f"Use point-slope form: $y - {y1} = {latex(m_perp)}(x - {x1})$",
            f"Simplify: $y = {latex(ans)}$"
        )
        diff = (1500, 1600)
        
    elif problem_type == 'find_intercepts':
        # Find x and y intercepts
        m = nonzero(-3, 3)
        b = nonzero(-5, 5)
        x_int = Rational(-b, m)
        
        which = choice(['x', 'y'])
        if which == 'x':
            q = f"Find the $x$-intercept of the line $y = {latex(m*x + b)}$."
            ans = x_int
            sol = steps(
                f"Set $y = 0$: $0 = {latex(m*x + b)}$",
                f"Solve for $x$: $x = {latex(x_int)}$"
            )
        else:
            q = f"Find the $y$-intercept of the line $y = {latex(m*x + b)}$."
            ans = b
            sol = steps(
                f"Set $x = 0$: $y = {latex(m*0 + b)}$",
                f"$y = {b}$"
            )
        diff = (1300, 1400)
        
    else:  # graph_interpretation
        # Given a graph description, find equation
        m = choice([-2, -1, 1, 2])
        b = randint(-3, 3)
        ans = m*x + b
        
        q = f"A line has slope ${m}$ and passes through the point $(0, {b})$. Write its equation in slope-intercept form."
        sol = steps(
            f"The point $(0, {b})$ is the $y$-intercept, so $b = {b}$",
            f"The slope is $m = {m}$",
            f"Therefore $y = {latex(ans)}$"
        )
        diff = (1300, 1400)
    
    return problem(
        question=q,
        answer=ans,
        difficulty=diff,
        topic="algebra1/graphing_lines",
        solution=sol
    )

emit(generate())