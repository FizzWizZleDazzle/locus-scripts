"""
algebra1 - slope_and_intercept (easy)
Generated: 2026-02-22T03:52:57.391393
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Finding slope from two points (1100-1200)
        x1, y1 = randint(-5, 5), randint(-5, 5)
        x2, y2 = randint(-5, 5), randint(-5, 5)
        while x1 == x2:  # Avoid vertical line
            x2 = randint(-5, 5)
        
        slope = Rational(y2 - y1, x2 - x1)
        
        return problem(
            question=f"Find the slope of the line passing through the points $({x1}, {y1})$ and $({x2}, {y2})$.",
            answer=slope,
            difficulty=(1100, 1200),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Use the slope formula: $m = \\frac{{y_2 - y_1}}{{x_2 - x_1}}$",
                f"$m = \\frac{{{y2} - ({y1})}}{{{x2} - ({x1})}} = \\frac{{{y2 - y1}}}{{{x2 - x1}}}$",
                f"$m = {latex(slope)}$"
            )
        )
    
    elif problem_type == 2:
        # Finding y-intercept from equation in slope-intercept form (1000-1100)
        m = nonzero(-5, 5)
        b_val = randint(-8, 8)
        
        return problem(
            question=f"What is the $y$-intercept of the line $y = {m}x + {b_val}$?",
            answer=b_val,
            difficulty=(1000, 1100),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"The equation is in slope-intercept form $y = mx + b$",
                f"The $y$-intercept is $b = {b_val}$"
            )
        )
    
    elif problem_type == 3:
        # Finding slope from equation in slope-intercept form (1000-1100)
        m = nonzero(-5, 5)
        b_val = randint(-8, 8)
        
        return problem(
            question=f"What is the slope of the line $y = {m}x + {b_val}$?",
            answer=m,
            difficulty=(1000, 1100),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"The equation is in slope-intercept form $y = mx + b$",
                f"The slope is $m = {m}$"
            )
        )
    
    elif problem_type == 4:
        # Convert from standard form to find slope (1200-1300)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        c_val = randint(-10, 10)
        
        # Standard form: ax + by = c
        # Slope-intercept: y = (-a/b)x + (c/b)
        slope = Rational(-a_val, b_val)
        
        return problem(
            question=f"Find the slope of the line ${a_val}x + {b_val}y = {c_val}$.",
            answer=slope,
            difficulty=(1200, 1300),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Solve for $y$ to get slope-intercept form",
                f"${b_val}y = {-a_val}x + {c_val}$",
                f"$y = {latex(Rational(-a_val, b_val))}x + {latex(Rational(c_val, b_val))}$",
                f"The slope is $m = {latex(slope)}$"
            )
        )
    
    else:
        # Write equation given slope and y-intercept (1100-1200)
        m = nonzero(-5, 5)
        b_val = randint(-8, 8)
        
        ans = Eq(y, m*x + b_val)
        
        return problem(
            question=f"Write the equation of a line with slope ${m}$ and $y$-intercept ${b_val}$ in slope-intercept form.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/slope_and_intercept",
            solution=steps(
                f"Use slope-intercept form: $y = mx + b$",
                f"Substitute $m = {m}$ and $b = {b_val}$",
                f"${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

emit(generate())