"""
algebra1 - graphing_lines (hard)
Generated: 2026-02-22T03:55:13.901596
"""

from problem_utils import *
from svg_utils import Graph

def generate():
    problem_type = choice([
        'perpendicular_line',
        'parallel_line',
        'intercepts_from_standard',
        'line_from_two_points',
        'intersection_point',
        'distance_and_line',
        'equation_from_parallel_perpendicular'
    ])
    
    if problem_type == 'perpendicular_line':
        # Find equation of line perpendicular to given line through a point
        m1 = nonzero(-4, 4)
        b1 = randint(-5, 5)
        px = nonzero(-6, 6)
        py = randint(-6, 6)
        
        # Perpendicular slope
        m2 = Rational(-1, m1)
        
        # Find b using point-slope: y - py = m2(x - px)
        b2 = py - m2 * px
        
        ans = simplify(m2 * x + b2)
        
        g = Graph(x_range=(-8, 8), y_range=(-8, 8), width=300, height=300)
        g.plot(m1*x + b1, color="blue", dashed=True)
        g.plot(ans, color="red")
        g.point(px, py, label=f"({px},{py})")
        
        return problem(
            question=f"Find the equation of the line perpendicular to $y = {latex(m1*x + b1)}$ that passes through $({px}, {py})$. Write your answer in slope-intercept form.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"The given line has slope $m_1 = {m1}$",
                f"Perpendicular lines have slopes that are negative reciprocals: $m_2 = -\\frac{{1}}{{m_1}} = {latex(m2)}$",
                f"Use point-slope form: $y - {py} = {latex(m2)}(x - {px})$",
                f"Simplify: $y - {py} = {latex(m2*x - m2*px)}$",
                f"$y = {latex(ans)}$"
            ),
            image=g.render()
        )
    
    elif problem_type == 'parallel_line':
        # Find equation of line parallel to given line through a point
        m = nonzero(-4, 4)
        b1 = randint(-5, 5)
        px = nonzero(-6, 6)
        py = randint(-6, 6)
        
        # Parallel lines have same slope
        b2 = py - m * px
        
        ans = simplify(m * x + b2)
        
        return problem(
            question=f"Find the equation of the line parallel to $y = {latex(m*x + b1)}$ that passes through $({px}, {py})$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"Parallel lines have the same slope: $m = {m}$",
                f"Use point-slope form: $y - {py} = {m}(x - {px})$",
                f"Simplify: $y - {py} = {latex(m*x - m*px)}$",
                f"$y = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'intercepts_from_standard':
        # Given line in standard form, find both intercepts
        A = nonzero(-5, 5)
        B = nonzero(-5, 5)
        C = nonzero(-10, 10)
        
        # x-intercept when y=0: Ax = C, x = C/A
        x_int = Rational(C, A)
        # y-intercept when x=0: By = C, y = C/B
        y_int = Rational(C, B)
        
        ans = (x_int, y_int)
        
        return problem(
            question=f"Find the $x$-intercept and $y$-intercept of the line ${latex(A*x + B*y)} = {C}$. Give your answer as an ordered pair $(x\\text{{-int}}, y\\text{{-int}})$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"For $x$-intercept, set $y = 0$: ${latex(A*x)} = {C}$, so $x = {latex(x_int)}$",
                f"For $y$-intercept, set $x = 0$: ${latex(B*y)} = {C}$, so $y = {latex(y_int)}$",
                f"Answer: $({latex(x_int)}, {latex(y_int)})$"
            )
        )
    
    elif problem_type == 'line_from_two_points':
        # Find equation from two points with non-integer slope
        x1 = nonzero(-6, 6)
        y1 = randint(-6, 6)
        x2 = x1 + nonzero(-4, 4)
        y2 = y1 + nonzero(-5, 5)
        
        # Calculate slope
        m = Rational(y2 - y1, x2 - x1)
        
        # y - y1 = m(x - x1)
        b = y1 - m * x1
        
        ans = simplify(m * x + b)
        
        return problem(
            question=f"Find the equation of the line passing through $({x1}, {y1})$ and $({x2}, {y2})$. Write in slope-intercept form.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"Calculate slope: $m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = \\frac{{{y2-y1}}}{{{x2-x1}}} = {latex(m)}$",
                f"Use point-slope form with $({x1}, {y1})$: $y - {y1} = {latex(m)}(x - {x1})$",
                f"Expand: $y - {y1} = {latex(m*x - m*x1)}$",
                f"$y = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'intersection_point':
        # Find intersection of two lines
        m1 = nonzero(-4, 4)
        b1 = randint(-6, 6)
        m2 = nonzero(-4, 4)
        while m2 == m1:
            m2 = nonzero(-4, 4)
        b2 = randint(-6, 6)
        
        # Solve m1*x + b1 = m2*x + b2
        x_sol = solve(Eq(m1*x + b1, m2*x + b2), x)[0]
        y_sol = m1 * x_sol + b1
        
        ans = (x_sol, y_sol)
        
        return problem(
            question=f"Find the intersection point of the lines $y = {latex(m1*x + b1)}$ and $y = {latex(m2*x + b2)}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"Set the equations equal: ${latex(m1*x + b1)} = {latex(m2*x + b2)}$",
                f"Solve for $x$: ${latex((m1-m2)*x)} = {b2-b1}$",
                f"$x = {latex(x_sol)}$",
                f"Substitute back: $y = {latex(m1*x_sol + b1)} = {latex(y_sol)}$",
                f"Intersection point: $({latex(x_sol)}, {latex(y_sol)})$"
            )
        )
    
    elif problem_type == 'distance_and_line':
        # Find equation of line given slope and distance to origin
        m = Rational(nonzero(-3, 3), choice([1, 2]))
        distance = randint(2, 5)
        
        # Line y = mx + b has distance from origin: |b|/sqrt(1+m^2) = distance
        # So |b| = distance * sqrt(1 + m^2)
        b_val = distance * sqrt(1 + m**2)
        
        # Choose positive b for uniqueness
        ans = m*x + b_val
        
        return problem(
            question=f"Find the equation of the line with slope ${latex(m)}$ that is at a perpendicular distance of ${distance}$ units from the origin. (Choose the line with positive $y$-intercept.)",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"The distance from origin to line $y = mx + b$ is $\\frac{{|b|}}{{\\sqrt{{1+m^2}}}}$",
                f"With $m = {latex(m)}$ and distance $= {distance}$:",
                f"$\\frac{{|b|}}{{\\sqrt{{1+{latex(m**2)}}}}} = {distance}$",
                f"$|b| = {distance}\\sqrt{{{latex(1+m**2)}}} = {latex(b_val)}$",
                f"Taking positive value: $y = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    else:  # equation_from_parallel_perpendicular
        # More complex: find line perpendicular to one line and parallel to another (actually finds line through intersection)
        m1 = nonzero(-3, 3)
        b1 = randint(-5, 5)
        
        # Create perpendicular line to first
        m_perp = Rational(-1, m1)
        b_perp = randint(-5, 5)
        
        # Find intersection of these two
        x_int = solve(Eq(m1*x + b1, m_perp*x + b_perp), x)[0]
        y_int = m1*x_int + b1
        
        # Now create a different slope line through this point
        m3 = nonzero(-4, 4)
        while m3 == m1 or m3 == m_perp:
            m3 = nonzero(-4, 4)
        
        b3 = y_int - m3*x_int
        ans = simplify(m3*x + b3)
        
        return problem(
            question=f"Line $\\ell_1$ has equation $y = {latex(m1*x + b1)}$ and line $\\ell_2$ is perpendicular to $\\ell_1$ with equation $y = {latex(m_perp*x + b_perp)}$. Find the equation of the line with slope ${latex(m3)}$ that passes through the intersection of $\\ell_1$ and $\\ell_2$.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra1/graphing_lines",
            solution=steps(
                f"Find intersection of $\\ell_1$ and $\\ell_2$:",
                f"${latex(m1*x + b1)} = {latex(m_perp*x + b_perp)}$",
                f"$x = {latex(x_int)}$, $y = {latex(y_int)}$",
                f"Line with slope ${latex(m3)}$ through $({latex(x_int)}, {latex(y_int)})$:",
                f"$y - {latex(y_int)} = {latex(m3)}(x - {latex(x_int)})$",
                f"$y = {latex(ans)}$"
            )
        )

emit(generate())