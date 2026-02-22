"""
calculus - optimization (hard)
Generated: 2026-02-22T05:09:48.741977
"""

from problem_utils import *

def generate():
    problem_type = choice(['box', 'fence', 'cylinder', 'distance', 'area_triangle', 'window'])
    
    if problem_type == 'box':
        # Open box from cutting corners of rectangular sheet
        length = randint(8, 20)
        width = randint(8, 20)
        
        # Volume function V(x) = x(L-2x)(W-2x)
        V = x * (length - 2*x) * (width - 2*x)
        V_expanded = expand(V)
        
        # Find critical points
        dV = diff(V, x)
        critical_pts = solve(dV, x)
        
        # Filter for valid dimensions (0 < x < min(L,W)/2)
        valid_crit = [pt for pt in critical_pts if pt.is_real and pt > 0 and pt < min(length, width)/2]
        
        if valid_crit:
            x_max = valid_crit[0]
            V_max = V.subs(x, x_max)
            
            return problem(
                question=f"A rectangular sheet of metal measuring ${length}$ cm by ${width}$ cm has squares of side length $x$ cut from each corner. The sides are then folded up to form an open box. Find the value of $x$ that maximizes the volume of the box.",
                answer=x_max,
                difficulty=(1650, 1750),
                topic="calculus/optimization",
                solution=steps(
                    f"The box has dimensions: length = ${length - 2}x$, width = ${width - 2}x$, height = $x$",
                    f"Volume: $V(x) = x({length} - 2x)({width} - 2x) = {latex(V_expanded)}$",
                    f"Take derivative: $V'(x) = {latex(dV)}$",
                    f"Set $V'(x) = 0$ and solve: ${latex(Eq(dV, 0))}$",
                    f"Critical point: $x = {latex(x_max)}$",
                    f"Verify this is a maximum by checking $V''(x)$ or endpoints.",
                    f"The value that maximizes volume is $x = {latex(x_max)}$ cm"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 'fence':
        # Rectangular enclosure with one side against building
        area = choice([800, 1200, 1600, 2000, 2400])
        
        # Area = xy = A, so y = A/x
        # Perimeter to minimize: P = x + 2y = x + 2A/x
        P = x + 2*area/x
        dP = diff(P, x)
        
        x_min = solve(dP, x)[0]
        y_min = area / x_min
        P_min = P.subs(x, x_min)
        
        return problem(
            question=f"A rectangular enclosure is to be built against an existing wall, requiring fencing on only three sides. If the enclosure must have an area of ${area}$ square meters, find the dimensions that minimize the amount of fencing needed. What is the length of the side parallel to the wall?",
            answer=x_min,
            difficulty=(1600, 1700),
            topic="calculus/optimization",
            solution=steps(
                f"Let $x$ = length parallel to wall, $y$ = width perpendicular to wall",
                f"Constraint: $xy = {area}$, so $y = \\frac{{{area}}}{{x}}$",
                f"Minimize perimeter: $P(x) = x + 2y = x + \\frac{{{2*area}}}{{x}}$",
                f"Take derivative: $P'(x) = {latex(dP)}$",
                f"Set $P'(x) = 0$: $1 - \\frac{{{2*area}}}{{x^2}} = 0$",
                f"Solve: $x^2 = {2*area}$, so $x = {latex(x_min)}$ meters",
                f"Then $y = \\frac{{{area}}}{{{latex(x_min)}}} = {latex(y_min)}$ meters",
                f"The side parallel to the wall is ${latex(x_min)}$ meters"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'cylinder':
        # Cylinder with fixed surface area, maximize volume
        surface_area = choice([100, 200, 300, 400]) * pi
        SA_coef = surface_area / pi
        
        # Surface area: 2πr² + 2πrh = SA
        # So h = (SA - 2πr²)/(2πr)
        # Volume V = πr²h = πr² · (SA - 2πr²)/(2πr) = r(SA - 2πr²)/2
        
        h_expr = (surface_area - 2*pi*x**2) / (2*pi*x)
        V = pi * x**2 * h_expr
        V_simplified = simplify(V)
        
        dV = diff(V_simplified, x)
        r_max = solve(dV, x)[0]
        h_max = h_expr.subs(x, r_max)
        
        return problem(
            question=f"A closed cylindrical can has a surface area of ${latex(surface_area)}$ square units. Find the radius that maximizes the volume of the can.",
            answer=r_max,
            difficulty=(1700, 1800),
            topic="calculus/optimization",
            solution=steps(
                f"Let $r$ = radius, $h$ = height",
                f"Surface area: $2\\pi r^2 + 2\\pi rh = {latex(surface_area)}$",
                f"Solve for $h$: $h = \\frac{{{latex(surface_area)} - 2\\pi r^2}}{{2\\pi r}}$",
                f"Volume: $V = \\pi r^2 h = {latex(V_simplified)}$",
                f"Take derivative: $V'(r) = {latex(dV)}$",
                f"Set $V'(r) = 0$ and solve",
                f"Optimal radius: $r = {latex(r_max)}$ units"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'distance':
        # Point on curve closest to given point
        px = randint(3, 8)
        py = 0
        
        # Use parabola y = x²
        # Distance squared: D² = (x - px)² + (x² - py)²
        D_squared = (x - px)**2 + (x**2 - py)**2
        
        dD = diff(D_squared, x)
        critical = solve(dD, x)
        
        # Find real critical point closest to px
        real_crit = [pt for pt in critical if pt.is_real]
        if real_crit:
            x_closest = min(real_crit, key=lambda pt: abs(float(pt - px)))
            y_closest = x_closest**2
            min_dist = sqrt(D_squared.subs(x, x_closest))
            
            return problem(
                question=f"Find the point on the parabola $y = x^2$ that is closest to the point $({px}, {py})$. What is the $x$-coordinate of this point?",
                answer=x_closest,
                difficulty=(1750, 1850),
                topic="calculus/optimization",
                solution=steps(
                    f"Point on parabola: $(x, x^2)$. Given point: $({px}, {py})$",
                    f"Distance squared: $D^2 = (x - {px})^2 + (x^2 - {py})^2 = {latex(expand(D_squared))}$",
                    f"Minimize by taking derivative: $\\frac{{dD^2}}{{dx}} = {latex(dD)}$",
                    f"Set equal to zero and solve: ${latex(Eq(dD, 0))}$",
                    f"Critical point: $x = {latex(x_closest)}$",
                    f"Verify this is a minimum using the second derivative test"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 'area_triangle':
        # Isosceles triangle with fixed perimeter, maximize area
        perimeter = randint(15, 30)
        
        # Let base = x, two equal sides = s each
        # Perimeter: x + 2s = P, so s = (P - x)/2
        # Height by Pythagorean: h² = s² - (x/2)²
        # Area = (1/2)xh
        
        s_expr = (perimeter - x) / 2
        h_squared = s_expr**2 - (x/2)**2
        h_squared_simplified = simplify(h_squared)
        
        # Area² = (x²/4)(s² - x²/4)
        A_squared = (x**2 / 4) * h_squared_simplified
        A_squared_expanded = expand(A_squared)
        
        dA = diff(A_squared_expanded, x)
        x_max = solve(dA, x)[0]
        
        return problem(
            question=f"An isosceles triangle has a perimeter of ${perimeter}$ units. Find the length of the base that maximizes the area of the triangle.",
            answer=x_max,
            difficulty=(1700, 1800),
            topic="calculus/optimization",
            solution=steps(
                f"Let base = $x$, equal sides = $s$ each",
                f"Perimeter constraint: $x + 2s = {perimeter}$, so $s = \\frac{{{perimeter} - x}}{{2}}$",
                f"Height: $h = \\sqrt{{s^2 - \\frac{{x^2}}{{4}}}}$",
                f"Area: $A = \\frac{{1}}{{2}}xh = \\frac{{x}}{{2}}\\sqrt{{s^2 - \\frac{{x^2}}{{4}}}}$",
                f"To maximize, consider $A^2 = \\frac{{x^2}}{{4}}\\left(s^2 - \\frac{{x^2}}{{4}}\\right) = {latex(A_squared_expanded)}$",
                f"Take derivative: $\\frac{{d(A^2)}}{{dx}} = {latex(dA)}$",
                f"Set equal to zero and solve: $x = {latex(x_max)}$ units"
            ),
            calculator="scientific"
        )
    
    else:  # window
        # Norman window (rectangle with semicircle on top), fixed perimeter
        perimeter = randint(12, 24)
        
        # Let width = 2r (diameter of semicircle), height of rectangle = h
        # Perimeter: 2h + 2r + πr = P
        # So h = (P - 2r - πr)/2
        # Area: 2rh + (1/2)πr²
        
        h_expr = (perimeter - 2*x - pi*x) / 2
        A = 2*x*h_expr + pi*x**2/2
        A_simplified = simplify(A)
        
        dA = diff(A_simplified, x)
        r_max = solve(dA, x)[0]
        
        return problem(
            question=f"A Norman window consists of a rectangle surmounted by a semicircle. If the perimeter of the window is ${perimeter}$ meters, find the radius of the semicircle that maximizes the area of the window.",
            answer=r_max,
            difficulty=(1800, 1900),
            topic="calculus/optimization",
            solution=steps(
                f"Let $r$ = radius of semicircle (so width = $2r$), $h$ = height of rectangle",
                f"Perimeter: $2h + 2r + \\pi r = {perimeter}$",
                f"Solve for $h$: $h = \\frac{{{perimeter} - 2r - \\pi r}}{{2}}$",
                f"Area: $A = 2rh + \\frac{{1}}{{2}}\\pi r^2 = {latex(A_simplified)}$",
                f"Take derivative: $A'(r) = {latex(dA)}$",
                f"Set $A'(r) = 0$ and solve",
                f"Optimal radius: $r = {latex(r_max)}$ meters"
            ),
            calculator="scientific"
        )

emit(generate())