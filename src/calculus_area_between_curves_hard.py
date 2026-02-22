"""
calculus - area_between_curves (hard)
Generated: 2026-02-22T05:16:53.762015
"""

from problem_utils import *

def generate():
    # Choose problem type for area between curves (1600-1900 range)
    problem_type = choice([
        'polynomial_intersection',
        'trig_polynomial',
        'exponential_polynomial',
        'multiple_intersections',
        'vertical_line_bounds'
    ])
    
    if problem_type == 'polynomial_intersection':
        # Two polynomials that intersect at nice points
        # Work backward: choose intersection points
        root1 = randint(-3, -1)
        root2 = randint(1, 3)
        
        # f(x) is a parabola, g(x) is a line or parabola
        a1 = choice([-2, -1, 1, 2])
        # f(x) = a1(x - root1)(x - root2) + baseline
        baseline = randint(-2, 2)
        f = expand(a1 * (x - root1) * (x - root2)) + baseline
        
        # g(x) should pass through the same roots when subtracted
        # Let g(x) be linear or quadratic
        if choice([True, False]):
            # Linear g(x) = mx + b
            # At roots: f(root) = g(root)
            y1 = f.subs(x, root1)
            y2 = f.subs(x, root2)
            m = (y2 - y1) / (root2 - root1)
            b = y1 - m * root1
            g = m * x + b
        else:
            # Use same formula but different coefficient
            a2 = a1 + choice([-1, 1]) * randint(1, 2)
            g = expand(a2 * (x - root1) * (x - root2)) + baseline
        
        # Calculate area
        integrand = simplify(f - g)
        integral = integrate(integrand, (x, root1, root2))
        area = abs(integral)
        
        question = f"Find the area between the curves $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$."
        
        solution = steps(
            f"Find intersection points by solving ${latex(f)} = {latex(g)}$",
            f"${latex(Eq(f, g))}$",
            f"${latex(Eq(simplify(f - g), 0))}$",
            f"Intersection points: $x = {root1}$ and $x = {root2}$",
            f"Set up integral: $A = \\int_{{{root1}}}^{{{root2}}} \\left|{latex(f)} - ({latex(g)})\\right| dx$",
            f"$= \\int_{{{root1}}}^{{{root2}}} \\left|{latex(integrand)}\\right| dx$",
            f"$= \\left|{latex(integral)}\\right| = {latex(area)}$"
        )
        
        return problem(
            question=question,
            answer=area,
            difficulty=randint(1600, 1750),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 'trig_polynomial':
        # sin or cos with a polynomial
        amp = choice([1, 2])
        freq = choice([1, 2])
        shift = choice([0, 1, -1])
        
        # Let f(x) = sin(freq*x) and g(x) = polynomial
        # Choose bounds where they intersect
        # For simplicity, use 0 to pi or -pi/2 to pi/2
        if freq == 1:
            lower = 0
            upper = pi
            trig_func = sin(x)
        else:
            lower = 0
            upper = pi / 2
            trig_func = sin(2*x)
        
        f = amp * trig_func
        
        # Simple polynomial that crosses
        poly_coef = choice([Rational(1, 2), Rational(2, 3), Rational(3, 4)])
        g = poly_coef * x + shift
        
        # Calculate area (upper - lower)
        integrand = f - g
        integral = integrate(integrand, (x, lower, upper))
        area = abs(integral)
        
        question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$ from $x = {latex(lower)}$ to $x = {latex(upper)}$."
        
        solution = steps(
            f"Set up integral: $A = \\left|\\int_{{{latex(lower)}}}^{{{latex(upper)}}} \\left({latex(f)} - ({latex(g)})\\right) dx\\right|$",
            f"$= \\left|\\int_{{{latex(lower)}}}^{{{latex(upper)}}} {latex(integrand)} dx\\right|$",
            f"Integrate term by term",
            f"$= \\left|{latex(integral)}\\right|$",
            f"$= {latex(area)}$"
        )
        
        return problem(
            question=question,
            answer=area,
            difficulty=randint(1650, 1800),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 'exponential_polynomial':
        # e^x vs polynomial
        k = choice([1, -1])
        shift = randint(0, 2)
        
        f = exp(k * x)
        
        # Polynomial
        a = choice([1, 2])
        b = randint(-2, 2)
        g = a * x + b
        
        # Use specific bounds
        lower = 0
        upper = choice([1, 2])
        
        integrand = f - g
        integral = integrate(integrand, (x, lower, upper))
        area = abs(integral)
        
        question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$ from $x = {lower}$ to $x = {upper}$."
        
        solution = steps(
            f"Set up integral: $A = \\left|\\int_{{{lower}}}^{{{upper}}} \\left({latex(f)} - ({latex(g)})\\right) dx\\right|$",
            f"$= \\left|\\int_{{{lower}}}^{{{upper}}} {latex(integrand)} dx\\right|$",
            f"Integrate: $\\int e^{{{latex(k*x)}}} dx = {latex(integrate(f, x))}$ and $\\int ({latex(g)}) dx = {latex(integrate(g, x))}$",
            f"$= \\left|{latex(integral)}\\right| = {latex(area)}$"
        )
        
        return problem(
            question=question,
            answer=area,
            difficulty=randint(1700, 1850),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 'multiple_intersections':
        # Two functions that cross multiple times - need to split integral
        # Use f(x) = x^3 - ax and g(x) = 0 or similar
        a = randint(2, 4)
        f = x**3 - a * x
        g = 0
        
        # Roots are at x = 0, ±sqrt(a)
        root = sqrt(a)
        
        # Area needs to be split: from -sqrt(a) to 0 and 0 to sqrt(a)
        int1 = integrate(f - g, (x, -root, 0))
        int2 = integrate(f - g, (x, 0, root))
        area = abs(int1) + abs(int2)
        
        question = f"Find the total area enclosed between $f(x) = {latex(f)}$ and the $x$-axis."
        
        solution = steps(
            f"Find roots: ${latex(f)} = 0$ gives $x({latex(x**2 - a)}) = 0$",
            f"Roots: $x = 0, x = \\pm{latex(root)}$",
            f"Function changes sign at roots, so split integral:",
            f"$A = \\left|\\int_{{{latex(-root)}}}^{{0}} {latex(f)} dx\\right| + \\left|\\int_{{0}}^{{{latex(root)}}} {latex(f)} dx\\right|$",
            f"$= \\left|{latex(int1)}\\right| + \\left|{latex(int2)}\\right|$",
            f"$= {latex(abs(int1))} + {latex(abs(int2))} = {latex(area)}$"
        )
        
        return problem(
            question=question,
            answer=area,
            difficulty=randint(1750, 1900),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    else:  # vertical_line_bounds
        # Area bounded by curve, vertical lines, and x-axis
        # Use y = x^2 or similar between x = a and x = b, and another curve
        a_val = randint(1, 3)
        f = x**2
        g = a_val * x
        
        # Find intersection
        intersections = solve(f - g, x)
        # Get positive intersection
        pos_int = [pt for pt in intersections if pt > 0][0]
        
        lower = 0
        upper = pos_int
        
        integrand = g - f  # g is above f in this region
        integral = integrate(integrand, (x, lower, upper))
        area = abs(integral)
        
        question = f"Find the area of the region bounded by $y = {latex(f)}$, $y = {latex(g)}$, and the $y$-axis."
        
        solution = steps(
            f"Find intersection: ${latex(f)} = {latex(g)}$",
            f"${latex(Eq(f, g))}$ gives $x = 0$ or $x = {latex(pos_int)}$",
            f"For $0 \\leq x \\leq {latex(pos_int)}$, ${latex(g)} \\geq {latex(f)}$",
            f"$A = \\int_{{0}}^{{{latex(pos_int)}}} \\left({latex(g)} - {latex(f)}\\right) dx$",
            f"$= \\int_{{0}}^{{{latex(pos_int)}}} {latex(integrand)} dx$",
            f"$= {latex(integral)} = {latex(area)}$"
        )
        
        return problem(
            question=question,
            answer=area,
            difficulty=randint(1650, 1850),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

emit(generate())