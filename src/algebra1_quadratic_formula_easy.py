"""
algebra1 - quadratic_formula (easy)
Generated: 2026-02-22T04:01:47.330615
"""

from problem_utils import *

def generate():
    # For EASIER quadratic formula problems (1000-1300 ELO range)
    # We want problems where:
    # - Coefficients are small
    # - Solutions are integers or simple numbers
    # - Discriminant is a perfect square (for easier computation)
    
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # Easiest: a=1, integer solutions, small numbers (1000-1100)
        # Reverse engineer from two integer roots
        r1 = randint(-5, 5)
        r2 = randint(-5, 5)
        
        # Expand (x - r1)(x - r2) = x^2 - (r1+r2)x + r1*r2
        a_val = 1
        b_val = -(r1 + r2)
        c_val = r1 * r2
        
        # Build equation
        equation = Eq(x**2 + b_val*x + c_val, 0)
        
        # Calculate discriminant
        disc = b_val**2 - 4*a_val*c_val
        
        # Solutions
        sol1 = (-b_val + sqrt(disc)) / (2*a_val)
        sol2 = (-b_val - sqrt(disc)) / (2*a_val)
        
        # Format answer as a set
        ans = FiniteSet(sol1, sol2)
        
        question = f"Solve using the quadratic formula: ${latex(equation)}$"
        
        solution = steps(
            f"For ${latex(equation)}$, identify $a = {a_val}$, $b = {b_val}$, $c = {c_val}$",
            f"Apply the quadratic formula: $x = \\frac{{-b \\pm \\sqrt{{b^2 - 4ac}}}}{{2a}}$",
            f"$x = \\frac{{-({b_val}) \\pm \\sqrt{{({b_val})^2 - 4({a_val})({c_val})}}}}{{2({a_val})}}$",
            f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc}}}}}{{2}}$",
            f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc))}}}{{2}}$",
            f"$x = {latex(sol1)}$ or $x = {latex(sol2)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/quadratic_formula",
            solution=solution,
            calculator="scientific"
        )
    
    elif difficulty_choice == 2:
        # Medium-easy: a=1, perfect square discriminant (1100-1200)
        r1 = randint(-6, 6)
        r2 = randint(-6, 6)
        
        a_val = 1
        b_val = -(r1 + r2)
        c_val = r1 * r2
        
        equation = Eq(x**2 + b_val*x + c_val, 0)
        disc = b_val**2 - 4*a_val*c_val
        
        sol1 = (-b_val + sqrt(disc)) / 2
        sol2 = (-b_val - sqrt(disc)) / 2
        
        ans = FiniteSet(sol1, sol2)
        
        question = f"Use the quadratic formula to solve: ${latex(equation)}$"
        
        solution = steps(
            f"Identify coefficients: $a = {a_val}$, $b = {b_val}$, $c = {c_val}$",
            f"Quadratic formula: $x = \\frac{{-b \\pm \\sqrt{{b^2 - 4ac}}}}{{2a}}$",
            f"Calculate discriminant: $b^2 - 4ac = ({b_val})^2 - 4({a_val})({c_val}) = {disc}$",
            f"$x = \\frac{{{-b_val} \\pm \\sqrt{{{disc}}}}}{{2}}$",
            f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc))}}}{{2}}$",
            f"Solutions: $x = {latex(sol1)}$ and $x = {latex(sol2)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/quadratic_formula",
            solution=solution,
            calculator="scientific"
        )
    
    else:
        # Harder in this range: a≠1 but still perfect square discriminant (1200-1300)
        r1 = randint(-4, 4)
        r2 = randint(-4, 4)
        a_val = choice([2, 3])
        
        # a(x - r1)(x - r2) = ax^2 - a(r1+r2)x + a*r1*r2
        b_val = -a_val * (r1 + r2)
        c_val = a_val * r1 * r2
        
        equation = Eq(a_val*x**2 + b_val*x + c_val, 0)
        disc = b_val**2 - 4*a_val*c_val
        
        sol1 = (-b_val + sqrt(disc)) / (2*a_val)
        sol2 = (-b_val - sqrt(disc)) / (2*a_val)
        
        ans = FiniteSet(sol1, sol2)
        
        question = f"Solve using the quadratic formula: ${latex(equation)}$"
        
        solution = steps(
            f"Identify coefficients: $a = {a_val}$, $b = {b_val}$, $c = {c_val}$",
            f"Quadratic formula: $x = \\frac{{-b \\pm \\sqrt{{b^2 - 4ac}}}}{{2a}}$",
            f"Calculate discriminant: $({b_val})^2 - 4({a_val})({c_val}) = {disc}$",
            f"$x = \\frac{{-({b_val}) \\pm \\sqrt{{{disc}}}}}{{2({a_val})}}$",
            f"$x = \\frac{{{-b_val} \\pm {latex(sqrt(disc))}}}}{{{2*a_val}}}$",
            f"Solutions: $x = {latex(sol1)}$ and $x = {latex(sol2)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/quadratic_formula",
            solution=solution,
            calculator="scientific"
        )

emit(generate())