"""
algebra1 - slope_and_intercept (hard)
Generated: 2026-02-22T03:53:48.688533
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Perpendicular/parallel lines word problem with constraints
        m1 = Rational(nonzero(-5, 5), nonzero(2, 4))
        b1 = nonzero(-8, 8)
        x0 = nonzero(-6, 6)
        y0 = nonzero(-6, 6)
        
        # Perpendicular slope
        m2 = -1/m1
        # Find b such that line passes through (x0, y0)
        b2 = y0 - m2*x0
        
        ans = simplify(m2*x + b2)
        
        return problem(
            question=f"Find the equation of the line perpendicular to $y = {latex(m1*x + b1)}$ that passes through the point $({x0}, {y0})$. Express in slope-intercept form.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"The original line has slope $m_1 = {latex(m1)}$",
                f"Perpendicular lines have slopes that multiply to $-1$, so $m_2 = -\\frac{{1}}{{m_1}} = {latex(m2)}$",
                f"Using point-slope form with $({x0}, {y0})$: $y - {y0} = {latex(m2)}(x - {x0})$",
                f"Simplify: $y = {latex(m2)}x + {latex(simplify(y0 - m2*x0))}$",
                f"Final answer: $y = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Finding slope/intercept from two word-problem constraints
        x1, y1 = nonzero(-5, 5), nonzero(-8, 8)
        x2, y2 = nonzero(-5, 5), nonzero(-8, 8)
        while x2 == x1:
            x2 = nonzero(-5, 5)
        
        m = Rational(y2 - y1, x2 - x1)
        b = y1 - m*x1
        
        # Ask for a specific x-intercept
        if b != 0:
            x_intercept = solve(m*x + b, x)[0]
            ans = x_intercept
            
            return problem(
                question=f"A line passes through the points $({x1}, {y1})$ and $({x2}, {y2})$. At what $x$-value does this line cross the $x$-axis?",
                answer=ans,
                difficulty=(1650, 1750),
                topic="algebra1/slope_and_intercept",
                solution=steps(
                    f"First find the slope: $m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = {latex(m)}$",
                    f"Using point-slope form with $({x1}, {y1})$: $y - {y1} = {latex(m)}(x - {x1})$",
                    f"Simplify to slope-intercept form: $y = {latex(m*x + b)}$",
                    f"The line crosses the $x$-axis when $y = 0$: ${latex(m)}x + {latex(b)} = 0$",
                    f"Solving for $x$: $x = {latex(ans)}$"
                ),
            )
        else:
            # Ask for y-intercept instead
            ans = b
            return problem(
                question=f"A line passes through the points $({x1}, {y1})$ and $({x2}, {y2})$. What is the $y$-intercept of this line?",
                answer=ans,
                difficulty=(1650, 1750),
                topic="algebra1/slope_and_intercept",
                solution=steps(
                    f"Find the slope: $m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = {latex(m)}$",
                    f"Using point-slope form: $y - {y1} = {latex(m)}(x - {x1})$",
                    f"Simplify: $y = {latex(m*x + b)}$",
                    f"The $y$-intercept is $b = {latex(ans)}$"
                ),
            )
    
    elif problem_type == 3:
        # System where lines intersect - find intersection and one unknown parameter
        m1 = Rational(nonzero(-4, 4), nonzero(2, 3))
        b1 = nonzero(-6, 6)
        m2 = Rational(nonzero(-4, 4), nonzero(2, 3))
        while m2 == m1:
            m2 = Rational(nonzero(-4, 4), nonzero(2, 3))
        
        # Find intersection point
        x_int = solve(m1*x + b1 - (m2*x + c), x)[0]
        y_int = m1*x_int + b1
        
        # Give the intersection point and ask for c
        ans = y_int - m2*x_int
        
        return problem(
            question=f"The lines $y = {latex(m1*x + b1)}$ and $y = {latex(m2*x)} + c$ intersect at the point $({latex(x_int)}, {latex(y_int)})$. Find the value of $c$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Since the point $({latex(x_int)}, {latex(y_int)})$ lies on the second line, it must satisfy the equation",
                f"Substitute: ${latex(y_int)} = {latex(m2)} \\cdot {latex(x_int)} + c$",
                f"${latex(y_int)} = {latex(m2*x_int)} + c$",
                f"$c = {latex(y_int)} - {latex(m2*x_int)} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Parallel line through point with fractional slopes
        m = Rational(nonzero(-7, 7), nonzero(2, 5))
        b_orig = nonzero(-9, 9)
        x0 = Rational(nonzero(-10, 10), nonzero(2, 4))
        y0 = nonzero(-8, 8)
        
        b_new = y0 - m*x0
        ans = simplify(m*x + b_new)
        
        return problem(
            question=f"Find the equation of the line parallel to $y = {latex(m*x + b_orig)}$ that passes through $\\left({latex(x0)}, {y0}\\right)$. Express in slope-intercept form.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Parallel lines have the same slope, so $m = {latex(m)}$",
                f"Using point-slope form with $\\left({latex(x0)}, {y0}\\right)$: $y - {y0} = {latex(m)}\\left(x - {latex(x0)}\\right)$",
                f"Expand: $y = {latex(m)}x - {latex(m*x0)} + {y0}$",
                f"Simplify: $y = {latex(ans)}$"
            ),
        )
    
    else:
        # Midpoint lies on a line - find unknown coordinate
        x1 = nonzero(-8, 8)
        y1 = nonzero(-8, 8)
        m = Rational(nonzero(-5, 5), nonzero(2, 4))
        b = nonzero(-7, 7)
        
        # Let second point be (x2, y2), midpoint is ((x1+x2)/2, (y1+y2)/2)
        # Midpoint lies on line: (y1+y2)/2 = m*(x1+x2)/2 + b
        # y1 + y2 = m*(x1+x2) + 2b
        # Choose x2, solve for y2
        x2 = nonzero(-8, 8)
        while x2 == x1:
            x2 = nonzero(-8, 8)
        
        # y2 = m*(x1+x2) + 2b - y1
        ans = m*(x1 + x2) + 2*b - y1
        
        mid_x = Rational(x1 + x2, 2)
        mid_y = Rational(y1 + ans, 2)
        
        return problem(
            question=f"Point $A$ is at $({x1}, {y1})$ and point $B$ is at $({x2}, y)$. If the midpoint of segment $AB$ lies on the line $y = {latex(m*x + b)}$, find the value of $y$.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"The midpoint of $AB$ is $\\left(\\frac{{{x1} + {x2}}}{{2}}, \\frac{{{y1} + y}}{{2}}\\right) = \\left({latex(mid_x)}, \\frac{{{y1} + y}}{{2}}\\right)$",
                f"This midpoint lies on $y = {latex(m*x + b)}$, so:",
                f"$\\frac{{{y1} + y}}{{2}} = {latex(m)} \\cdot {latex(mid_x)} + {latex(b)}$",
                f"$\\frac{{{y1} + y}}{{2}} = {latex(m*mid_x + b)}$",
                f"${y1} + y = {latex(2*(m*mid_x + b))}$",
                f"$y = {latex(ans)}$"
            ),
        )

emit(generate())