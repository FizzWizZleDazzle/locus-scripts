"""
calculus - volumes_of_revolution (medium)
Generated: 2026-02-22T05:17:35.758971
"""

from problem_utils import *

def generate():
    # Pick a random problem type
    problem_type = choice(['disk_x', 'disk_y', 'washer_x', 'washer_y'])
    
    if problem_type == 'disk_x':
        # Disk method rotating around x-axis
        # Use simple functions that integrate cleanly
        func_type = choice(['linear', 'quadratic', 'sqrt'])
        
        if func_type == 'linear':
            m = randint(1, 4)
            a_val = randint(0, 2)
            b_val = a_val + randint(2, 4)
            f = m * x
            
            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)
            
            q = f"Find the volume of the solid obtained by rotating the region bounded by $y = {latex(f)}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis."
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{latex(f)}]^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(expand(f**2))} \\, dx$",
                f"$V = \\pi \\left[{latex(integrate(f**2, x))}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )
            
        elif func_type == 'quadratic':
            a_val = randint(1, 2)
            b_val = a_val + randint(1, 2)
            f = x**2
            
            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)
            
            q = f"Find the volume of the solid obtained by rotating the region bounded by $y = x^2$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis."
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} (x^2)^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} x^4 \\, dx$",
                f"$V = \\pi \\left[\\frac{{x^5}}{{5}}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )
            
        else:  # sqrt
            a_val = randint(1, 3)
            b_val = randint(4, 9)
            f = sqrt(x)
            
            integral_expr = pi * integrate(f**2, (x, a_val, b_val))
            ans = simplify(integral_expr)
            
            q = f"Find the volume of the solid obtained by rotating the region bounded by $y = \\sqrt{{x}}$, $y = 0$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis."
            sol = steps(
                f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} (\\sqrt{{x}})^2 \\, dx$",
                f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} x \\, dx$",
                f"$V = \\pi \\left[\\frac{{x^2}}{{2}}\\right]_{{{a_val}}}^{{{b_val}}}$",
                f"$V = {latex(ans)}$"
            )
        
        difficulty = (1300, 1450)
        
    elif problem_type == 'disk_y':
        # Disk method rotating around y-axis
        c = randint(1, 3)
        a_val = randint(1, 3)
        b_val = a_val + randint(2, 4)
        f = c * y
        
        integral_expr = pi * integrate(f**2, (y, a_val, b_val))
        ans = simplify(integral_expr)
        
        q = f"Find the volume of the solid obtained by rotating the region bounded by $x = {latex(f)}$, $x = 0$, $y = {a_val}$, and $y = {b_val}$ about the $y$-axis."
        sol = steps(
            f"Using the disk method: $V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{latex(f)}]^2 \\, dy$",
            f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} {latex(expand(f**2))} \\, dy$",
            f"$V = \\pi \\left[{latex(integrate(f**2, y))}\\right]_{{{a_val}}}^{{{b_val}}}$",
            f"$V = {latex(ans)}$"
        )
        difficulty = (1350, 1500)
        
    elif problem_type == 'washer_x':
        # Washer method rotating around x-axis
        outer_val = randint(2, 4)
        a_val = randint(0, 1)
        b_val = randint(2, 4)
        
        outer = outer_val
        inner = x
        
        integral_expr = pi * integrate(outer**2 - inner**2, (x, a_val, b_val))
        ans = simplify(integral_expr)
        
        q = f"Find the volume of the solid obtained by rotating the region bounded by $y = {outer_val}$, $y = x$, $x = {a_val}$, and $x = {b_val}$ about the $x$-axis."
        sol = steps(
            f"Using the washer method with outer radius $R = {outer_val}$ and inner radius $r = x$:",
            f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} \\left[{outer_val}^2 - x^2\\right] \\, dx$",
            f"$V = \\pi \\int_{{{a_val}}}^{{{b_val}}} [{outer_val**2} - x^2] \\, dx$",
            f"$V = \\pi \\left[{outer_val**2}x - \\frac{{x^3}}{{3}}\\right]_{{{a_val}}}^{{{b_val}}}$",
            f"$V = {latex(ans)}$"
        )
        difficulty = (1450, 1600)
        
    else:  # washer_y
        # Washer method rotating around y-axis
        a_val = randint(1, 2)
        b_val = randint(3, 5)
        
        outer = b_val
        inner = y**2
        
        integral_expr = pi * integrate(outer**2 - inner**2, (y, 0, a_val))
        ans = simplify(integral_expr)
        
        q = f"Find the volume of the solid obtained by rotating the region bounded by $x = y^2$, $x = 0$, $y = 0$, $y = {a_val}$, and $x = {b_val}$ about the $y$-axis."
        sol = steps(
            f"Using the washer method with outer radius $R = {b_val}$ and inner radius $r = y^2$:",
            f"$V = \\pi \\int_{{0}}^{{{a_val}}} \\left[{b_val}^2 - (y^2)^2\\right] \\, dy$",
            f"$V = \\pi \\int_{{0}}^{{{a_val}}} [{b_val**2} - y^4] \\, dy$",
            f"$V = \\pi \\left[{b_val**2}y - \\frac{{y^5}}{{5}}\\right]_{{0}}^{{{a_val}}}$",
            f"$V = {latex(ans)}$"
        )
        difficulty = (1500, 1600)
    
    return problem(
        question=q,
        answer=ans,
        difficulty=difficulty,
        topic="calculus/volumes_of_revolution",
        solution=sol,
        calculator="scientific"
    )

emit(generate())