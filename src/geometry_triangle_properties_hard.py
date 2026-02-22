"""
geometry - triangle_properties (hard)
Generated: 2026-02-22T04:05:51.510080
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Triangle with angle bisector theorem
        # Pick clean ratios
        ratio1 = randint(2, 5)
        ratio2 = randint(2, 5)
        while ratio2 == ratio1:
            ratio2 = randint(2, 5)
        
        multiplier = randint(2, 4)
        side1 = ratio1 * multiplier
        side2 = ratio2 * multiplier
        
        # Angle bisector divides opposite side in ratio of adjacent sides
        total_base = randint(12, 24)
        segment1 = Rational(total_base * ratio1, ratio1 + ratio2)
        segment2 = total_base - segment1
        
        d = Diagram(width=350, height=250)
        A = (0, 0)
        B = (total_base, 0)
        C = (float(segment1), 8)
        D = (float(segment1), 0)
        
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.line(C, D, dashed=True)
        d.segment_label(A, C, f"{side1}")
        d.segment_label(B, C, f"{side2}")
        d.segment_label(A, D, "x")
        d.segment_label(D, B, "y")
        d.angle_arc(C, A, D, label="")
        d.angle_arc(C, D, B, label="")
        
        question = f"In triangle $ABC$, $AC = {side1}$ and $BC = {side2}$. The angle bisector from $C$ meets side $AB$ at point $D$, dividing it into segments $AD = x$ and $DB = y$ where $x + y = {total_base}$. Find $x$."
        
        ans = segment1
        
        solution = steps(
            f"By the Angle Bisector Theorem, the angle bisector divides the opposite side in the ratio of the adjacent sides",
            f"Therefore, $\\frac{{AD}}{{DB}} = \\frac{{AC}}{{BC}} = \\frac{{{side1}}}{{{side2}}}$",
            f"Let $AD = x$ and $DB = y$, so $\\frac{{x}}{{y}} = \\frac{{{side1}}}{{{side2}}}$",
            f"We also know $x + y = {total_base}$",
            f"From the ratio: ${side2}x = {side1}y$, so $y = \\frac{{{side2}x}}{{{side1}}}$",
            f"Substituting: $x + \\frac{{{side2}x}}{{{side1}}} = {total_base}$",
            f"$\\frac{{{side1}x + {side2}x}}{{{side1}}} = {total_base}$",
            f"${side1 + side2}x = {total_base * side1}$",
            f"$x = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/triangle_properties",
            solution=solution,
            image=d.render()
        )
    
    elif problem_type == 2:
        # Stewart's Theorem application
        base = randint(10, 16)
        cevian_point = randint(4, base - 4)
        other_point = base - cevian_point
        
        side_b = randint(8, 14)
        side_c = randint(8, 14)
        
        # Using Stewart's Theorem: b²·m + c²·n - d²·a = m·n·a
        # where d is cevian, a is base, m and n are segments
        # Solve for d
        m = cevian_point
        n = other_point
        a = base
        
        d_squared = (side_b**2 * m + side_c**2 * n - m * n * a) / a
        
        if d_squared > 0 and d_squared == int(d_squared):
            d_val = int(sqrt(d_squared))
            
            question = f"In triangle $ABC$, side $AB = {base}$. Point $D$ lies on $AB$ such that $AD = {m}$ and $DB = {n}$. If $AC = {side_b}$ and $BC = {side_c}$, find the length of cevian $CD$ using Stewart's Theorem."
            
            ans = d_val
            
            solution = steps(
                f"Stewart's Theorem states: $b^2 \\cdot m + c^2 \\cdot n = a(d^2 + mn)$",
                f"where $b = AC = {side_b}$, $c = BC = {side_c}$, $a = AB = {base}$, $m = AD = {m}$, $n = DB = {n}$, and $d = CD$",
                f"Substituting: ${side_b}^2 \\cdot {m} + {side_c}^2 \\cdot {n} = {base}(d^2 + {m} \\cdot {n})$",
                f"${side_b**2 * m} + {side_c**2 * n} = {base}d^2 + {base * m * n}$",
                f"${side_b**2 * m + side_c**2 * n} = {base}d^2 + {base * m * n}$",
                f"${base}d^2 = {side_b**2 * m + side_c**2 * n - base * m * n}$",
                f"$d^2 = {int(d_squared)}$",
                f"$d = {ans}$"
            )
            
            return problem(
                question=question,
                answer=ans,
                difficulty=(1700, 1800),
                topic="geometry/triangle_properties",
                solution=solution
            )
    
    elif problem_type == 3:
        # Median length formula
        a_side = randint(8, 14)
        b_side = randint(8, 14)
        c_side = randint(8, 14)
        
        # Check triangle inequality
        if a_side + b_side > c_side and a_side + c_side > b_side and b_side + c_side > a_side:
            # Median to side a: m_a = (1/2)sqrt(2b² + 2c² - a²)
            median_squared = (2 * b_side**2 + 2 * c_side**2 - a_side**2) / 4
            
            if median_squared > 0:
                median_val = sqrt(median_squared)
                
                question = f"In triangle $ABC$, $AB = {c_side}$, $AC = {b_side}$, and $BC = {a_side}$. Find the length of the median from vertex $A$ to the midpoint of side $BC$."
                
                ans = median_val
                
                solution = steps(
                    f"The median length formula from vertex $A$ to side $a$ is: $m_a = \\frac{{1}}{{2}}\\sqrt{{2b^2 + 2c^2 - a^2}}$",
                    f"where $a = BC = {a_side}$, $b = AC = {b_side}$, $c = AB = {c_side}$",
                    f"$m_a = \\frac{{1}}{{2}}\\sqrt{{2({b_side})^2 + 2({c_side})^2 - ({a_side})^2}}$",
                    f"$m_a = \\frac{{1}}{{2}}\\sqrt{{{2 * b_side**2} + {2 * c_side**2} - {a_side**2}}}$",
                    f"$m_a = \\frac{{1}}{{2}}\\sqrt{{{2 * b_side**2 + 2 * c_side**2 - a_side**2}}}$",
                    f"$m_a = {latex(ans)}$"
                )
                
                return problem(
                    question=question,
                    answer=ans,
                    difficulty=(1650, 1750),
                    topic="geometry/triangle_properties",
                    solution=solution
                )
    
    elif problem_type == 4:
        # Triangle with altitude and area relationship
        base = randint(10, 20)
        height = randint(6, 12)
        area = Rational(base * height, 2)
        
        # Find another side length
        side_b = randint(12, 18)
        # Area = (1/2) * side_b * h_b, so h_b = 2*area/side_b
        height_b = Rational(2 * area, side_b)
        
        question = f"Triangle $ABC$ has base $BC = {base}$ and the altitude from $A$ to $BC$ has length ${height}$. If side $AC = {side_b}$, find the length of the altitude from vertex $B$ to side $AC$."
        
        ans = height_b
        
        solution = steps(
            f"First, find the area of triangle $ABC$ using base $BC$ and its altitude",
            f"Area $= \\frac{{1}}{{2}} \\cdot {base} \\cdot {height} = {latex(area)}$",
            f"The area can also be calculated using side $AC = {side_b}$ as the base",
            f"If $h$ is the altitude from $B$ to $AC$, then Area $= \\frac{{1}}{{2}} \\cdot {side_b} \\cdot h$",
            f"${latex(area)} = \\frac{{{side_b}h}}{{2}}$",
            f"${2 * area} = {side_b}h$",
            f"$h = {latex(height_b)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/triangle_properties",
            solution=solution
        )
    
    else:
        # Heron's formula with specific sides
        a_val = randint(10, 15)
        b_val = randint(10, 15)
        c_val = randint(10, 15)
        
        # Check triangle inequality
        if a_val + b_val > c_val and a_val + c_val > b_val and b_val + c_val > a_val:
            s = Rational(a_val + b_val + c_val, 2)
            area_squared = s * (s - a_val) * (s - b_val) * (s - c_val)
            
            if area_squared > 0:
                area_val = sqrt(area_squared)
                
                question = f"Find the area of a triangle with sides of length ${a_val}$, ${b_val}$, and ${c_val}$ using Heron's formula."
                
                ans = area_val
                
                solution = steps(
                    f"Heron's formula: Area $= \\sqrt{{s(s-a)(s-b)(s-c)}}$ where $s$ is the semi-perimeter",
                    f"Calculate semi-perimeter: $s = \\frac{{{a_val} + {b_val} + {c_val}}}{{2}} = {latex(s)}$",
                    f"$s - a = {latex(s)} - {a_val} = {latex(s - a_val)}$",
                    f"$s - b = {latex(s)} - {b_val} = {latex(s - b_val)}$",
                    f"$s - c = {latex(s)} - {c_val} = {latex(s - c_val)}$",
                    f"Area $= \\sqrt{{{latex(s)} \\cdot {latex(s - a_val)} \\cdot {latex(s - b_val)} \\cdot {latex(s - c_val)}}}$",
                    f"Area $= \\sqrt{{{latex(area_squared)}}}$",
                    f"Area $= {latex(area_val)}$"
                )
                
                return problem(
                    question=question,
                    answer=ans,
                    difficulty=(1700, 1800),
                    topic="geometry/triangle_properties",
                    solution=solution
                )
    
    # Fallback to angle bisector problem
    ratio1 = 3
    ratio2 = 4
    multiplier = 2
    side1 = ratio1 * multiplier
    side2 = ratio2 * multiplier
    total_base = 14
    segment1 = Rational(total_base * ratio1, ratio1 + ratio2)
    
    question = f"In triangle $ABC$, $AC = {side1}$ and $BC = {side2}$. The angle bisector from $C$ meets side $AB$ at point $D$, dividing it into segments $AD$ and $DB$ where $AD + DB = {total_base}$. Find $AD$."
    
    ans = segment1
    
    solution = steps(
        f"By the Angle Bisector Theorem: $\\frac{{AD}}{{DB}} = \\frac{{AC}}{{BC}} = \\frac{{{side1}}}{{{side2}}}$",
        f"Let $AD = x$ and $DB = y$, so $x + y = {total_base}$",
        f"From the ratio: $\\frac{{x}}{{y}} = \\frac{{{side1}}}{{{side2}}}$, so $y = \\frac{{{side2}x}}{{{side1}}}$",
        f"Substituting: $x + \\frac{{{side2}x}}{{{side1}}} = {total_base}$",
        f"$x = {latex(ans)}$"
    )
    
    return problem(
        question=question,
        answer=ans,
        difficulty=(1650, 1750),
        topic="geometry/triangle_properties",
        solution=solution
    )

emit(generate())