"""
calculus - area_between_curves (medium)
Generated: 2026-02-22T05:16:14.607216
"""

from problem_utils import *

def generate():
    problem_type = choice(['vertical', 'horizontal', 'mixed'])
    difficulty_level = randint(1300, 1600)
    
    if problem_type == 'vertical':
        # Two curves where one is always above the other in the interval
        # f(x) - g(x) type problems
        
        if difficulty_level < 1400:
            # Simple polynomial difference, given bounds
            a1 = randint(1, 4)
            b1 = randint(-3, 3)
            c1 = randint(-5, 5)
            
            a2 = randint(1, 3)
            if a2 == a1:
                a2 += 1
            b2 = randint(-3, 3)
            c2 = c1 - randint(2, 5)  # Ensure f above g
            
            f = a1*x**2 + b1*x + c1
            g = a2*x**2 + b2*x + c2
            
            x_left = randint(0, 2)
            x_right = x_left + randint(2, 4)
            
            integrand = simplify(f - g)
            ans = integrate(integrand, (x, x_left, x_right))
            
            question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$ from $x = {x_left}$ to $x = {x_right}$."
            
            solution = steps(
                f"The area is given by $\\int_{{{x_left}}}^{{{x_right}}} [f(x) - g(x)] \\, dx$",
                f"$= \\int_{{{x_left}}}^{{{x_right}}} [{latex(integrand)}] \\, dx$",
                f"$= {latex(integrate(integrand, x))} \\Big|_{{{x_left}}}^{{{x_right}}}$",
                f"$= {latex(ans)}$"
            )
            
        else:
            # Need to find intersection points first
            a = randint(1, 3)
            b = randint(1, 4)
            
            # Use f(x) = -x^2 + a and g(x) = x^2 - b type
            # or f(x) = sqrt-like and g(x) = linear
            
            subtype = choice(['parabolas', 'sqrt_linear'])
            
            if subtype == 'parabolas':
                f = -x**2 + a**2
                g = x**2 - b
                
                intersections = solve(Eq(f, g), x)
                intersections_sorted = sorted([float(pt.evalf()) for pt in intersections])
                x_left = intersections_sorted[0]
                x_right = intersections_sorted[1]
                
                integrand = simplify(f - g)
                ans = integrate(integrand, (x, x_left, x_right))
                
                question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$."
                
                solution = steps(
                    f"First find intersection points: ${latex(f)} = {latex(g)}$",
                    f"${latex(simplify(f - g))} = 0$",
                    f"Intersection points: $x = {latex(intersections[0])}, x = {latex(intersections[1])}$",
                    f"Area $= \\int_{{{latex(intersections[0])}}}^{{{latex(intersections[1])}}} [{latex(integrand)}] \\, dx$",
                    f"$= {latex(integrate(integrand, x))} \\Big|_{{{latex(intersections[0])}}}^{{{latex(intersections[1])}}}$",
                    f"$= {latex(ans)}$"
                )
                
            else:
                # sqrt(x) and linear
                m = randint(1, 3)
                c = randint(-2, 0)
                
                f = sqrt(x)
                g = Rational(1, m) * x + c
                
                intersections = solve(Eq(f, g), x)
                real_intersections = [pt for pt in intersections if pt.is_real and pt >= 0]
                
                if len(real_intersections) >= 2:
                    intersections_sorted = sorted([float(pt.evalf()) for pt in real_intersections[:2]])
                    x_left = real_intersections[0]
                    x_right = real_intersections[1]
                    
                    integrand = simplify(f - g)
                    ans = integrate(integrand, (x, x_left, x_right))
                    
                    question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$."
                    
                    solution = steps(
                        f"Find intersection points: ${latex(f)} = {latex(g)}$",
                        f"Solving gives $x = {latex(x_left)}$ and $x = {latex(x_right)}$",
                        f"Area $= \\int_{{{latex(x_left)}}}^{{{latex(x_right)}}} [{latex(integrand)}] \\, dx$",
                        f"$= {latex(ans)}$"
                    )
                else:
                    # Fallback to simple case
                    f = -x**2 + 4
                    g = x**2 - 4
                    integrand = simplify(f - g)
                    ans = integrate(integrand, (x, -2, 2))
                    question = f"Find the area between $f(x) = {latex(f)}$ and $g(x) = {latex(g)}$."
                    solution = steps(
                        f"Intersection points: $x = -2, x = 2$",
                        f"Area $= \\int_{{-2}}^{{2}} [{latex(integrand)}] \\, dx = {latex(ans)}$"
                    )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1600),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    else:
        # Simpler: just two basic curves with clear bounds
        a = randint(2, 5)
        b = randint(1, 4)
        
        f = a - x**2
        g = x**2 - b
        
        intersections = solve(Eq(f, g), x)
        x_left = min(intersections)
        x_right = max(intersections)
        
        integrand = simplify(f - g)
        ans = integrate(integrand, (x, x_left, x_right))
        
        question = f"Find the area of the region bounded by $y = {latex(f)}$ and $y = {latex(g)}$."
        
        solution = steps(
            f"Find intersection points: ${latex(f)} = {latex(g)}$",
            f"${latex(simplify(f - g))} = 0$",
            f"$x = {latex(x_left)}, x = {latex(x_right)}$",
            f"Area $= \\int_{{{latex(x_left)}}}^{{{latex(x_right)}}} [{latex(integrand)}] \\, dx$",
            f"$= {latex(integrate(integrand, x))} \\Big|_{{{latex(x_left)}}}^{{{latex(x_right)}}}$",
            f"$= {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1600),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

emit(generate())