"""
calculus - volumes_of_revolution (hard)
Generated: 2026-02-22T05:18:18.113839
"""

from problem_utils import *

def generate():
    problem_type = choice(['disk', 'washer', 'shell', 'mixed_region', 'parametric'])
    
    if problem_type == 'disk':
        # Disk method with more complex functions
        func_type = choice(['trig', 'exp', 'rational'])
        
        if func_type == 'trig':
            # sin or cos with transformations
            amp = randint(1, 3)
            freq = choice([1, 2, Rational(1, 2)])
            shift = choice([0, randint(1, 2)])
            
            func = amp * sin(freq * x) + shift
            a_val = 0
            b_val = pi / freq if freq != Rational(1, 2) else 2 * pi
            
            volume_expr = pi * integrate(func**2, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(func)}$, $y = 0$, $x = {latex(a_val)}$, and $x = {latex(b_val)}$ about the $x$-axis using the disk method.",
                answer=ans,
                difficulty=(1600, 1750),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the disk method: $V = \\pi \\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} [f(x)]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} [{latex(func)}]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} {latex(expand(func**2))} \\, dx$",
                    f"Evaluating the integral: $V = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        
        elif func_type == 'exp':
            # Exponential function
            coeff = randint(1, 3)
            func = exp(coeff * x)
            a_val = 0
            b_val = randint(1, 2)
            
            volume_expr = pi * integrate(func**2, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(func)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [f(x)]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{latex(func)}]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(func**2)} \\, dx$",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        
        else:  # rational
            # sqrt function
            coeff = randint(2, 4)
            func = sqrt(coeff * x)
            a_val = 0
            b_val = randint(2, 4)
            
            volume_expr = pi * integrate(func**2, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(func)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [f(x)]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({latex(func)})^2 \\, dx$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(coeff * x)} \\, dx$",
                    f"$V = {latex(ans)}$"
                )
            )
    
    elif problem_type == 'washer':
        # Washer method with two functions
        outer_type = choice(['quadratic', 'sqrt'])
        
        if outer_type == 'quadratic':
            # Region between parabola and line
            h = randint(1, 3)
            outer = -x**2 + 2*h*x
            inner_const = randint(1, h-1) if h > 1 else 0
            inner = inner_const
            
            a_val = 0
            b_val = 2*h
            
            volume_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(outer)}$, $y = {inner_const}$, and the $y$-axis about the $x$-axis using the washer method.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"The outer radius is $R(x) = {latex(outer)}$ and inner radius is $r(x) = {inner_const}$",
                    f"Using washer method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [R(x)]^2 - [r(x)]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({latex(outer)})^2 - ({inner_const})^2 \\, dx$",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        
        else:  # sqrt
            # Region between sqrt and line
            coeff = randint(2, 4)
            outer = sqrt(coeff * x)
            inner_slope = Rational(1, 2)
            inner = inner_slope * x
            
            # Find intersection
            intersection_eq = Eq(outer**2, inner**2)
            b_val = solve(intersection_eq, x)[1]  # Take positive solution
            a_val = 0
            
            volume_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(outer)}$ and $y = {latex(inner)}$ about the $x$-axis.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"First find intersection: ${latex(outer)} = {latex(inner)}$ gives $x = {latex(b_val)}$",
                    f"Using washer method: $V = \\pi \\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} [({latex(outer)})]^2 - [({latex(inner)})]^2 \\, dx$",
                    f"$V = \\pi \\int_{{{latex(a_val)}}}^{{{latex(b_val)}}} {latex(coeff*x)} - {latex(inner**2)} \\, dx$",
                    f"$V = {latex(ans)}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 'shell':
        # Shell method (rotating about y-axis)
        func_choice = choice(['parabola', 'cubic'])
        
        if func_choice == 'parabola':
            # x^2 rotated about y-axis
            a_val = 0
            b_val = randint(2, 4)
            func = x**2
            
            volume_expr = 2 * pi * integrate(x * func, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(func)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $y$-axis using the shell method.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the shell method: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot f(x) \\, dx$",
                    f"$V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot {latex(func)} \\, dx$",
                    f"$V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(x * func)} \\, dx$",
                    f"$V = {latex(ans)}$"
                )
            )
        
        else:  # cubic
            # x^3 or similar
            coeff = randint(1, 2)
            func = coeff * x**3
            a_val = 0
            b_val = randint(1, 2)
            
            volume_expr = 2 * pi * integrate(x * func, (x, a_val, b_val))
            ans = simplify(volume_expr)
            
            return problem(
                question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(func)}$, $y = 0$, and $x = {b_val}$ about the $y$-axis using the shell method.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="calculus/volumes_of_revolution",
                solution=steps(
                    f"Using the shell method: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot f(x) \\, dx$",
                    f"$V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} x \\cdot ({latex(func)}) \\, dx$",
                    f"$V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(x * func)} \\, dx$",
                    f"$V = {latex(ans)}$"
                )
            )
    
    elif problem_type == 'mixed_region':
        # Rotation about a horizontal line other than x-axis
        offset = randint(1, 3)
        func = x**2
        a_val = 0
        b_val = randint(2, 3)
        
        # Rotating about y = -offset
        outer = func + offset
        inner = offset
        
        volume_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
        ans = simplify(volume_expr)
        
        return problem(
            question=f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(func)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the line $y = {-offset}$.",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/volumes_of_revolution",
            solution=steps(
                f"Shifting to the axis of rotation $y = {-offset}$:",
                f"Outer radius: $R(x) = {latex(func)} - ({-offset}) = {latex(outer)}$",
                f"Inner radius: $r(x) = 0 - ({-offset}) = {latex(inner)}$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [R(x)]^2 - [r(x)]^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} ({latex(outer)})^2 - ({offset})^2 \\, dx$",
                f"$V = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    else:  # parametric
        # Shell method with x = f(y)
        coeff = randint(1, 3)
        func = coeff * y**2  # x as function of y
        a_val = 0
        b_val = randint(2, 3)
        
        volume_expr = 2 * pi * integrate(y * func, (y, a_val, b_val))
        ans = simplify(volume_expr)
        
        return problem(
            question=f"Find the volume of the solid obtained by rotating the region bounded by $x = {latex(func)}$, $x = 0$, $y = {a_val}$, and $y = {b_val}$ about the $x$-axis using the shell method.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/volumes_of_revolution",
            solution=steps(
                f"Using shell method with horizontal shells: $V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} y \\cdot x(y) \\, dy$",
                f"$V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} y \\cdot ({latex(func)}) \\, dy$",
                f"$V = 2\\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(y * func)} \\, dy$",
                f"$V = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())