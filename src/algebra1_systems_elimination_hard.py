"""
algebra1 - systems_elimination (hard)
Generated: 2026-02-22T03:57:33.067010
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # Type 1: System with fractions/decimals (1600-1700)
        # Build from clean solution
        x_sol = randint(-5, 5)
        y_sol = randint(-5, 5)
        
        # Create coefficients that will need careful elimination
        a1 = choice([2, 3, 4, 5])
        b1 = choice([3, 4, 5, 6])
        c1 = a1 * x_sol + b1 * y_sol
        
        # Second equation with coefficients designed for elimination
        multiplier = choice([2, 3])
        a2 = a1 * multiplier + choice([-1, 1])
        b2 = -b1 * choice([2, 3])  # Make elimination require LCM work
        c2 = a2 * x_sol + b2 * y_sol
        
        ans = fmt_tuple(x_sol, y_sol)
        
        return problem(
            question=f"Solve the system using elimination:\n\\begin{{align*}}{a1}x + {b1}y &= {c1}\\\\{a2}x + {b2}y &= {c2}\\end{{align*}}",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/systems_elimination",
            answer_type="tuple",
            solution=steps(
                f"Multiply first equation by ${abs(b2)}$ and second by ${abs(b1)}$ to eliminate $y$:",
                f"${abs(b2)}({a1}x + {b1}y) = {abs(b2)}({c1}) \\Rightarrow {a1*abs(b2)}x + {b1*abs(b2)}y = {c1*abs(b2)}$",
                f"${abs(b1)}({a2}x + {b2}y) = {abs(b1)}({c2}) \\Rightarrow {a2*abs(b1)}x + {b2*abs(b1)}y = {c2*abs(b1)}$",
                f"Subtract to eliminate $y$: $({a1*abs(b2)} - {a2*abs(b1)})x = {c1*abs(b2) - c2*abs(b1)}$",
                f"Solve for $x$: $x = {x_sol}$",
                f"Substitute back: ${a1}({x_sol}) + {b1}y = {c1}$",
                f"Solve for $y$: $y = {y_sol}$",
                f"Solution: $(x, y) = ({x_sol}, {y_sol})$"
            )
        )
    
    elif difficulty_choice == 2:
        # Type 2: Three-variable system (1700-1800)
        x_sol = randint(-3, 3)
        y_sol = randint(-3, 3)
        z_sol = randint(-3, 3)
        
        # Create three equations
        a1, b1, c1_coef = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        d1 = a1 * x_sol + b1 * y_sol + c1_coef * z_sol
        
        a2, b2, c2_coef = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        d2 = a2 * x_sol + b2 * y_sol + c2_coef * z_sol
        
        a3, b3, c3_coef = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        d3 = a3 * x_sol + b3 * y_sol + c3_coef * z_sol
        
        ans = fmt_tuple(x_sol, y_sol, z_sol)
        
        return problem(
            question=f"Solve the system using elimination:\n\\begin{{align*}}{a1}x + {b1}y + {c1_coef}z &= {d1}\\\\{a2}x + {b2}y + {c2_coef}z &= {d2}\\\\{a3}x + {b3}y + {c3_coef}z &= {d3}\\end{{align*}}",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/systems_elimination",
            answer_type="tuple",
            solution=steps(
                f"Eliminate $z$ from equations 1 and 2 by multiplying appropriately",
                f"Eliminate $z$ from equations 2 and 3 by multiplying appropriately",
                f"Solve the resulting two-variable system for $x$ and $y$",
                f"Substitute back to find $z$",
                f"Solution: $(x, y, z) = ({x_sol}, {y_sol}, {z_sol})$"
            )
        )
    
    else:
        # Type 3: System requiring strategic elimination with large coefficients (1800-1900)
        x_sol = Rational(randint(-10, 10), choice([2, 3, 4]))
        y_sol = Rational(randint(-10, 10), choice([2, 3, 4]))
        
        # Build coefficients that create fractional answers
        a1 = choice([3, 5, 7])
        b1 = choice([4, 6, 8])
        c1 = a1 * x_sol + b1 * y_sol
        
        a2 = choice([2, 4, 6])
        b2 = choice([5, 7, 9])
        c2 = a2 * x_sol + b2 * y_sol
        
        ans = fmt_tuple(x_sol, y_sol)
        
        return problem(
            question=f"Solve the system using elimination:\n\\begin{{align*}}{a1}x + {b1}y &= {latex(c1)}\\\\{a2}x + {b2}y &= {latex(c2)}\\end{{align*}}",
            answer=ans,
            difficulty=(1800, 1900),
            topic="algebra1/systems_elimination",
            answer_type="tuple",
            calculator="scientific",
            solution=steps(
                f"To eliminate $x$, multiply equation 1 by ${a2}$ and equation 2 by ${a1}$:",
                f"${a2 * a1}x + {a2 * b1}y = {latex(a2 * c1)}$",
                f"${a1 * a2}x + {a1 * b2}y = {latex(a1 * c2)}$",
                f"Subtract: $({a2 * b1} - {a1 * b2})y = {latex(a2 * c1 - a1 * c2)}$",
                f"Solve for $y$: $y = {latex(y_sol)}$",
                f"Substitute into first equation and solve for $x$: $x = {latex(x_sol)}$",
                f"Solution: $(x, y) = ({latex(x_sol)}, {latex(y_sol)})$"
            )
        )

emit(generate())