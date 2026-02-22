"""
geometry - right_triangle_trig (hard)
Generated: 2026-02-22T04:20:15.107979
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['angle_elevation_depression', 'word_problem_application', 
                          'inverse_trig', 'law_of_sines_setup', 'multi_step_diagram'])
    
    if problem_type == 'angle_elevation_depression':
        # Angle of elevation/depression with multiple steps
        height = randint(40, 120)
        distance = randint(50, 150)
        extra_distance = randint(20, 60)
        
        # Create diagram
        d = Diagram(width=350, height=250, padding=40)
        d.line((0, 0), (distance + extra_distance, 0))
        d.line((distance, 0), (distance, height))
        d.line((0, 0), (distance, height), dashed=True)
        d.right_angle((distance, 0), (distance + extra_distance, 0), (distance, height))
        d.point(0, 0, "A")
        d.point(distance, 0, "B")
        d.point(distance, height, "C")
        d.point(distance + extra_distance, 0, "D")
        d.segment_label((distance, 0), (distance, height), f"{height} ft")
        d.segment_label((0, 0), (distance, 0), f"{distance} ft")
        d.segment_label((distance, 0), (distance + extra_distance, 0), f"{extra_distance} ft")
        d.angle_arc((0, 0), (distance, 0), (distance, height), r"\theta")
        
        angle_rad = atan(Rational(height, distance))
        angle_deg = float(angle_rad * 180 / pi)
        ans = round(angle_deg, 1)
        
        return problem(
            question=f"A building is {height} feet tall. From point A on the ground, the horizontal distance to the base of the building (point B) is {distance} feet. Point D is {extra_distance} feet beyond B on the same line. Find the angle of elevation $\\theta$ from point A to the top of the building (point C), in degrees. Round to one decimal place.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"The angle of elevation is formed by the line AC and the horizontal line AB",
                f"We have opposite side = {height} ft and adjacent side = {distance} ft",
                f"$\\tan(\\theta) = \\frac{{{height}}}{{{distance}}}$",
                f"$\\theta = \\arctan\\left(\\frac{{{height}}}{{{distance}}}\\right)$",
                f"$\\theta \\approx {ans}^\\circ$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    elif problem_type == 'word_problem_application':
        # Complex ladder/shadow problem with constraint
        ladder_length = randint(15, 30)
        initial_height = randint(8, ladder_length - 3)
        rate = choice([1, 2, 3])
        time = randint(1, 4)
        
        new_height = initial_height - rate * time
        if new_height <= 3 or new_height >= ladder_length - 2:
            new_height = initial_height - 2
        
        base_distance = sqrt(ladder_length**2 - new_height**2)
        ans = round(float(base_distance), 2)
        
        return problem(
            question=f"A {ladder_length}-foot ladder is leaning against a wall. Initially, the top of the ladder is {initial_height} feet above the ground. The top of the ladder slides down the wall at a rate of {rate} foot per second. After {time} seconds, how far is the base of the ladder from the wall (in feet)? Round to two decimal places.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"After {time} seconds, the top of the ladder is at height: ${initial_height} - {rate} \\cdot {time} = {new_height}$ feet",
                f"The ladder length remains constant at {ladder_length} feet",
                f"Using the Pythagorean theorem: $x^2 + {new_height}^2 = {ladder_length}^2$",
                f"$x^2 = {ladder_length**2} - {new_height**2} = {ladder_length**2 - new_height**2}$",
                f"$x = \\sqrt{{{ladder_length**2 - new_height**2}}} \\approx {ans}$ feet"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'inverse_trig':
        # Inverse trig with algebraic setup
        opposite = randint(5, 15)
        hypotenuse = randint(opposite + 3, opposite + 10)
        
        # Find the other angle using complementary property
        angle1_rad = asin(Rational(opposite, hypotenuse))
        angle1_deg = float(angle1_rad * 180 / pi)
        angle2_deg = 90 - angle1_deg
        ans = round(angle2_deg, 2)
        
        d = Diagram(width=300, height=250, padding=40)
        adjacent_len = float(sqrt(hypotenuse**2 - opposite**2))
        d.polygon([(0, 0), (adjacent_len, 0), (adjacent_len, opposite)], 
                  labels=["B", "C", "A"])
        d.right_angle((adjacent_len, 0), (0, 0), (adjacent_len, opposite))
        d.segment_label((adjacent_len, 0), (adjacent_len, opposite), f"{opposite}")
        d.segment_label((0, 0), (adjacent_len, opposite), f"{hypotenuse}")
        d.angle_arc((0, 0), (adjacent_len, 0), (adjacent_len, opposite), r"\alpha")
        d.angle_arc((adjacent_len, opposite), (adjacent_len, 0), (0, 0), r"\beta")
        
        return problem(
            question=f"In right triangle ABC with right angle at C, side AC = {opposite} and hypotenuse AB = {hypotenuse}. If $\\alpha$ is the angle at B, find the measure of angle $\\beta$ at A in degrees. Round to two decimal places.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"First find $\\alpha$ using $\\sin(\\alpha) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}} = \\frac{{{opposite}}}{{{hypotenuse}}}$",
                f"$\\alpha = \\arcsin\\left(\\frac{{{opposite}}}{{{hypotenuse}}}\\right) \\approx {round(angle1_deg, 2)}^\\circ$",
                f"Since the angles in a triangle sum to $180^\\circ$ and we have a right angle:",
                f"$\\beta = 90^\\circ - \\alpha \\approx {ans}^\\circ$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    elif problem_type == 'law_of_sines_setup':
        # Problem requiring multiple trig ratios
        base = randint(30, 60)
        angle_A_deg = randint(25, 50)
        angle_B_deg = randint(40, 65)
        
        if angle_A_deg + angle_B_deg >= 90:
            angle_A_deg = 35
            angle_B_deg = 45
        
        # Convert to radians
        angle_A_rad = angle_A_deg * pi / 180
        angle_B_rad = angle_B_deg * pi / 180
        
        # Height of triangle
        height = base * tan(angle_A_rad) * tan(angle_B_rad) / (tan(angle_A_rad) + tan(angle_B_rad))
        ans = round(float(height), 2)
        
        return problem(
            question=f"Two observers stand {base} meters apart on level ground, both looking at the top of a tower. The angle of elevation from the first observer is {angle_A_deg}° and from the second observer is {angle_B_deg}°. The tower is located between them on the line connecting the two observers. Find the height of the tower in meters. Round to two decimal places.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"Let $h$ be the height of the tower, $x$ be the distance from observer 1 to the tower",
                f"Then the distance from observer 2 to the tower is ${base} - x$",
                f"From observer 1: $\\tan({angle_A_deg}^\\circ) = \\frac{{h}}{{x}}$, so $x = \\frac{{h}}{{\\tan({angle_A_deg}^\\circ)}}$",
                f"From observer 2: $\\tan({angle_B_deg}^\\circ) = \\frac{{h}}{{{base} - x}}$, so ${base} - x = \\frac{{h}}{{\\tan({angle_B_deg}^\\circ)}}$",
                f"Adding: ${base} = \\frac{{h}}{{\\tan({angle_A_deg}^\\circ)}} + \\frac{{h}}{{\\tan({angle_B_deg}^\\circ)}} = h\\left(\\frac{{1}}{{\\tan({angle_A_deg}^\\circ)}} + \\frac{{1}}{{\\tan({angle_B_deg}^\\circ)}}\\right)$",
                f"$h = \\frac{{{base}}}{{\\frac{{1}}{{\\tan({angle_A_deg}^\\circ)}} + \\frac{{1}}{{\\tan({angle_B_deg}^\\circ)}}}} \\approx {ans}$ meters"
            ),
            calculator="scientific"
        )
    
    else:  # multi_step_diagram
        # Complex geometric setup requiring trig identities
        side_a = randint(8, 15)
        angle_deg = choice([30, 45, 60])
        
        if angle_deg == 30:
            height = side_a / 2
            ans = round(float(height), 2)
        elif angle_deg == 45:
            height = side_a * sqrt(2) / 2
            ans = round(float(height), 2)
        else:  # 60 degrees
            height = side_a * sqrt(3) / 2
            ans = round(float(height), 2)
        
        d = Diagram(width=300, height=280, padding=40)
        h_numeric = float(height)
        half_a = side_a / 2.0
        
        d.polygon([(0, 0), (side_a, 0), (half_a, h_numeric)], labels=["A", "B", "C"])
        d.line((half_a, 0), (half_a, h_numeric), dashed=True)
        d.right_angle((half_a, 0), (0, 0), (half_a, h_numeric))
        d.segment_label((0, 0), (side_a, 0), f"{side_a}")
        d.segment_label((0, 0), (half_a, h_numeric), f"{side_a}")
        d.segment_label((half_a, 0), (half_a, h_numeric), "h")
        d.angle_arc((0, 0), (side_a, 0), (half_a, h_numeric), f"{angle_deg}°")
        d.point(half_a, 0, "D")
        
        return problem(
            question=f"In isosceles triangle ABC, sides AC = AB = {side_a} units and angle CAB = {angle_deg}°. A perpendicular is drawn from C to side AB, meeting it at point D. Find the length of CD. Round to two decimal places.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"In isosceles triangle ABC with AC = AB = {side_a}, the altitude from C to AB creates two congruent right triangles",
                f"In right triangle ACD, angle CAD = {angle_deg}°, hypotenuse AC = {side_a}",
                f"The altitude CD is opposite to the {angle_deg}° angle",
                f"$\\sin({angle_deg}^\\circ) = \\frac{{CD}}{{AC}} = \\frac{{h}}{{{side_a}}}$",
                f"$h = {side_a} \\cdot \\sin({angle_deg}^\\circ) = {ans}$ units"
            ),
            calculator="scientific",
            image=d.render()
        )

emit(generate())