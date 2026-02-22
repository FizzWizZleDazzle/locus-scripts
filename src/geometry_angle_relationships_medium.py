"""
geometry - angle_relationships (medium)
Generated: 2026-02-22T04:03:42.217565
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['vertical_angles', 'linear_pair', 'complementary', 'supplementary', 'angle_sum'])
    
    if problem_type == 'vertical_angles':
        # Vertical angles problem with algebraic expressions
        coeff1 = randint(2, 5)
        const1 = randint(5, 25)
        coeff2 = randint(2, 5)
        const2 = randint(5, 25)
        
        # Ensure different coefficients
        while coeff1 == coeff2:
            coeff2 = randint(2, 5)
        
        # Solve for x: coeff1*x + const1 = coeff2*x + const2
        x_val = (const2 - const1) / (coeff1 - coeff2)
        
        # Make sure x is a positive integer
        if x_val <= 0 or x_val != int(x_val):
            # Adjust to get clean solution
            const2 = const1 + (coeff1 - coeff2) * randint(2, 8)
            x_val = (const2 - const1) // (coeff1 - coeff2)
        
        angle_measure = coeff1 * x_val + const1
        
        expr1 = f"{coeff1}x + {const1}" if const1 > 0 else f"{coeff1}x - {-const1}"
        expr2 = f"{coeff2}x + {const2}" if const2 > 0 else f"{coeff2}x - {-const2}"
        
        d = Diagram(width=300, height=250)
        # Draw two intersecting lines
        d.line((-3, -2), (3, 2))
        d.line((-2, 2), (2, -2))
        # Label angles
        d.text(1.5, 0.8, f"${expr1}°$")
        d.text(-1.5, -0.8, f"${expr2}°$")
        
        question = f"Two lines intersect forming vertical angles. One angle measures $({expr1})°$ and its vertical angle measures $({expr2})°$. Find the value of $x$."
        
        return problem(
            question=question,
            answer=int(x_val),
            difficulty=(1300, 1450),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Vertical angles are congruent, so we set the expressions equal:",
                f"${expr1} = {expr2}$",
                f"${coeff1}x - {coeff2}x = {const2} - {const1}$",
                f"${coeff1 - coeff2}x = {const2 - const1}$",
                f"$x = {int(x_val)}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'linear_pair':
        # Linear pair (supplementary adjacent angles)
        coeff = randint(2, 4)
        const = randint(10, 30)
        
        # Solve: (coeff*x + const) + (90 - x) = 180
        # coeff*x - x = 180 - 90 - const
        x_val = (90 - const) // (coeff - 1)
        
        # Ensure positive integer
        if x_val <= 0:
            const = randint(5, 20)
            x_val = (90 - const) // (coeff - 1)
        
        angle1 = coeff * x_val + const
        angle2 = 180 - angle1
        
        expr1 = f"{coeff}x + {const}" if const > 0 else f"{coeff}x - {-const}"
        
        d = Diagram(width=300, height=200)
        # Draw a line with two adjacent angles
        d.line((-3, 0), (3, 0))
        d.line((0, 0), (1.5, 2))
        d.angle_arc((0, 0), (3, 0), (1.5, 2), label=f"${expr1}°$")
        d.angle_arc((0, 0), (1.5, 2), (-3, 0), label=f"${angle2}°$")
        
        question = f"Two angles form a linear pair. One angle measures $({expr1})°$ and the other measures ${angle2}°$. Find the value of $x$."
        
        return problem(
            question=question,
            answer=int(x_val),
            difficulty=(1350, 1500),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Linear pairs are supplementary (sum to $180°$):",
                f"$({expr1}) + {angle2} = 180$",
                f"${coeff}x + {const + angle2} = 180$",
                f"${coeff}x = {180 - const - angle2}$",
                f"$x = {int(x_val)}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'complementary':
        # Complementary angles
        coeff = randint(2, 5)
        const = randint(5, 15)
        
        # Solve: (coeff*x + const) + 2x = 90
        x_val = (90 - const) // (coeff + 2)
        
        # Ensure clean solution
        if x_val <= 0:
            const = randint(3, 10)
            x_val = (90 - const) // (coeff + 2)
        
        angle1 = coeff * x_val + const
        angle2 = 90 - angle1
        
        expr1 = f"{coeff}x + {const}"
        
        question = f"Two complementary angles are given. One angle measures $({expr1})°$ and the other measures $2x°$. Find the value of $x$."
        
        return problem(
            question=question,
            answer=int(x_val),
            difficulty=(1300, 1450),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Complementary angles sum to $90°$:",
                f"$({expr1}) + 2x = 90$",
                f"${coeff + 2}x + {const} = 90$",
                f"${coeff + 2}x = {90 - const}$",
                f"$x = {int(x_val)}$"
            )
        )
    
    elif problem_type == 'supplementary':
        # Supplementary angles
        coeff1 = randint(3, 6)
        coeff2 = randint(2, 4)
        const = randint(8, 20)
        
        # Solve: (coeff1*x - const) + (coeff2*x + const) = 180
        x_val = 180 // (coeff1 + coeff2)
        
        angle1 = coeff1 * x_val - const
        angle2 = coeff2 * x_val + const
        
        expr1 = f"{coeff1}x - {const}"
        expr2 = f"{coeff2}x + {const}"
        
        question = f"Two supplementary angles measure $({expr1})°$ and $({expr2})°$. Find the value of $x$."
        
        return problem(
            question=question,
            answer=int(x_val),
            difficulty=(1400, 1550),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Supplementary angles sum to $180°$:",
                f"$({expr1}) + ({expr2}) = 180$",
                f"${coeff1}x - {const} + {coeff2}x + {const} = 180$",
                f"${coeff1 + coeff2}x = 180$",
                f"$x = {int(x_val)}$"
            )
        )
    
    else:  # angle_sum
        # Angles around a point or in a triangle
        if choice([True, False]):
            # Triangle angle sum
            coeff = randint(2, 4)
            angle1 = randint(40, 60)
            angle2 = randint(30, 50)
            
            # Third angle: coeff*x
            x_val = (180 - angle1 - angle2) // coeff
            
            question = f"In a triangle, two angles measure ${angle1}°$ and ${angle2}°$. The third angle measures ${coeff}x°$. Find the value of $x$."
            
            return problem(
                question=question,
                answer=int(x_val),
                difficulty=(1300, 1450),
                topic="geometry/angle_relationships",
                solution=steps(
                    f"The sum of angles in a triangle is $180°$:",
                    f"${angle1} + {angle2} + {coeff}x = 180$",
                    f"${angle1 + angle2} + {coeff}x = 180$",
                    f"${coeff}x = {180 - angle1 - angle2}$",
                    f"$x = {int(x_val)}$"
                )
            )
        else:
            # Angles around a point
            coeff1 = randint(2, 4)
            coeff2 = randint(2, 4)
            const1 = randint(10, 30)
            const2 = randint(10, 30)
            
            # Three angles: (coeff1*x + const1), (coeff2*x + const2), and remaining
            # Sum = 360
            x_val = (360 - const1 - const2 - 90) // (coeff1 + coeff2)
            
            expr1 = f"{coeff1}x + {const1}"
            expr2 = f"{coeff2}x + {const2}"
            
            question = f"Three angles around a point measure $({expr1})°$, $({expr2})°$, and $90°$. Find the value of $x$."
            
            return problem(
                question=question,
                answer=int(x_val),
                difficulty=(1450, 1600),
                topic="geometry/angle_relationships",
                solution=steps(
                    f"Angles around a point sum to $360°$:",
                    f"$({expr1}) + ({expr2}) + 90 = 360$",
                    f"${coeff1 + coeff2}x + {const1 + const2 + 90} = 360$",
                    f"${coeff1 + coeff2}x = {360 - const1 - const2 - 90}$",
                    f"$x = {int(x_val)}$"
                )
            )

emit(generate())