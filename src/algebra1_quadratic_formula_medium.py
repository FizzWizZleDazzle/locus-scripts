"""
algebra1 - quadratic_formula (medium)
Generated: 2026-02-22T04:02:09.307734
"""

from problem_utils import *

def generate():
    # Pick target difficulty within standard range
    target_elo = randint(1300, 1600)
    
    # For quadratic formula problems, we'll reverse engineer from clean roots
    # Difficulty levels:
    # 1300-1400: a=1, integer roots, discriminant is perfect square
    # 1400-1500: a≠1, or irrational roots (simple surds)
    # 1500-1600: a≠1 with irrational roots, or complex roots
    
    if target_elo < 1400:
        # Simple case: a=1, integer roots
        a_val = 1
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        # Build quadratic from roots
        b_val = -(r1 + r2)
        c_val = r1 * r2
        roots = sorted([r1, r2])
        difficulty = (1300, 1400)
        
    elif target_elo < 1500:
        # Medium: a≠1 or irrational roots
        if choice([True, False]):
            # a≠1 with integer roots
            a_val = choice([2, 3, 4])
            r1 = randint(-5, 5)
            r2 = randint(-5, 5)
            # a(x - r1)(x - r2) = ax^2 - a(r1+r2)x + a*r1*r2
            b_val = -a_val * (r1 + r2)
            c_val = a_val * r1 * r2
            roots = sorted([r1, r2])
        else:
            # a=1 with simple irrational roots
            a_val = 1
            b_val = choice([2, 4, 6])
            c_val = choice([-1, -2, -3])
            # Use quadratic formula to find roots
            disc = b_val**2 - 4*a_val*c_val
            roots = [(-b_val + sqrt(disc))/(2*a_val), (-b_val - sqrt(disc))/(2*a_val)]
            roots = sorted(roots, key=lambda r: float(r.evalf()))
        difficulty = (1400, 1500)
        
    else:
        # Hard: complex roots or a≠1 with irrational
        if choice([True, False]):
            # Complex roots
            a_val = 1
            b_val = choice([2, 4, 6])
            c_val = choice([5, 10, 13, 17])
            disc = b_val**2 - 4*a_val*c_val
            if disc >= 0:
                c_val = c_val + abs(disc) + 1  # Force negative discriminant
            disc = b_val**2 - 4*a_val*c_val
            roots = [(-b_val + sqrt(disc))/(2*a_val), (-b_val - sqrt(disc))/(2*a_val)]
            roots = sorted(roots, key=lambda r: str(r))
        else:
            # a≠1 with irrational roots
            a_val = choice([2, 3])
            b_val = choice([3, 5, 7])
            c_val = choice([-2, -3, -5])
            disc = b_val**2 - 4*a_val*c_val
            roots = [(-b_val + sqrt(disc))/(2*a_val), (-b_val - sqrt(disc))/(2*a_val)]
            roots = sorted(roots, key=lambda r: float(r.evalf()))
        difficulty = (1500, 1600)
    
    # Build the equation
    if a_val == 1:
        if b_val >= 0:
            eq_str = f"x^2 + {b_val}x + {c_val} = 0"
        else:
            eq_str = f"x^2 {b_val}x + {c_val} = 0"
    else:
        if b_val >= 0:
            eq_str = f"{a_val}x^2 + {b_val}x + {c_val} = 0"
        else:
            eq_str = f"{a_val}x^2 {b_val}x + {c_val} = 0"
    
    # Clean up equation display
    eq_str = eq_str.replace("+ -", "- ").replace("+ 1x", "+ x").replace("^2 1x", "^2 + x")
    if "- -" in eq_str:
        eq_str = eq_str.replace("- -", "+ ")
    
    # Answer is a set of roots
    ans = FiniteSet(*roots)
    
    # Solution steps
    disc_val = b_val**2 - 4*a_val*c_val
    
    solution_steps = [
        f"Use the quadratic formula: $x = \\frac{{-b \\pm \\sqrt{{b^2 - 4ac}}}}{{2a}}$",
        f"Here $a = {a_val}$, $b = {b_val}$, $c = {c_val}$",
        f"Calculate discriminant: $b^2 - 4ac = ({b_val})^2 - 4({a_val})({c_val}) = {disc_val}$",
    ]
    
    if disc_val < 0:
        solution_steps.append(f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc_val}}}}}{{{2*a_val}}} = \\frac{{{-b_val} \\pm {latex(sqrt(disc_val))}}}{{{2*a_val}}}$")
    else:
        solution_steps.append(f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc_val}}}}}{{{2*a_val}}}$")
    
    solution_steps.append(f"Solutions: $x = {latex(roots[0])}$ and $x = {latex(roots[1])}$")
    
    return problem(
        question=f"Solve using the quadratic formula: ${eq_str}$",
        answer=ans,
        difficulty=difficulty,
        topic="algebra1/quadratic_formula",
        solution=steps(*solution_steps),
    )

emit(generate())