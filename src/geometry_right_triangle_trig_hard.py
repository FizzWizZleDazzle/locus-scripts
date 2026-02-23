"""
geometry - right_triangle_trig (hard)
Generated: 2026-02-22T04:20:15.107979
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['angle_elevation', 'two_observers', 'inverse_complement',
                           'multi_step', 'bearing_problem', 'isosceles_altitude'])

    if problem_type == 'angle_elevation':
        # Angle of elevation / depression with varied numbers
        height = randint(20, 150)
        distance = randint(30, 200)
        angle_rad = atan(Rational(height, distance))
        ans = round(float(angle_rad * 180 / pi), 1)

        extra = randint(10, 50)
        d = Diagram(width=350, height=250, padding=40)
        d.line((0,0),(distance+extra,0))
        d.line((distance,0),(distance,height))
        d.line((0,0),(distance,height),dashed=True)
        d.right_angle((distance,0),(distance+extra,0),(distance,height))
        d.segment_label((distance,0),(distance,height),f"{height} ft")
        d.segment_label((0,0),(distance,0),f"{distance} ft")
        d.angle_arc((0,0),(distance,0),(distance,height),r"\theta")

        return problem(
            question=f"A building is ${height}$ feet tall. From a point on the ground ${distance}$ feet from the base of the building, find the angle of elevation $\\theta$ to the top. Round to one decimal place.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"$\\tan(\\theta) = \\frac{{{height}}}{{{distance}}}$",
                f"$\\theta = \\arctan\\!\\left(\\frac{{{height}}}{{{distance}}}\\right) \\approx {ans}°$"
            ),
            calculator="scientific",
            image=d.render()
        )

    elif problem_type == 'two_observers':
        # Two observers on the same line, tower in between
        base = randint(40, 120)
        angle_A = randint(20, 50)
        angle_B = randint(40, 70)
        while angle_A + angle_B >= 90:
            angle_B = randint(30, 60)

        angle_A_rad = angle_A * pi / 180
        angle_B_rad = angle_B * pi / 180
        h = base * tan(angle_A_rad) * tan(angle_B_rad) / (tan(angle_A_rad) + tan(angle_B_rad))
        ans = round(float(h), 2)

        return problem(
            question=f"Two observers stand ${base}$ meters apart. The angle of elevation of a tower from the first observer is ${angle_A}°$ and from the second is ${angle_B}°$. The tower stands between them. Find the height of the tower. Round to two decimal places.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"Let $h$ = height, $x$ = distance from observer 1 to tower base",
                f"$\\tan({angle_A}°) = h/x \\Rightarrow x = h/\\tan({angle_A}°)$",
                f"$\\tan({angle_B}°) = h/({base}-x) \\Rightarrow {base}-x = h/\\tan({angle_B}°)$",
                f"Adding: ${base} = h(\\cot({angle_A}°) + \\cot({angle_B}°))$",
                f"$h \\approx {ans}$ meters"
            ),
            calculator="scientific"
        )

    elif problem_type == 'inverse_complement':
        # Find the complement angle using inverse trig
        opposite = randint(5, 20)
        hypotenuse = randint(opposite + 3, opposite + 15)
        angle1_rad = asin(Rational(opposite, hypotenuse))
        angle1_deg = float(angle1_rad * 180 / pi)
        angle2_deg = 90 - angle1_deg
        ans = round(angle2_deg, 2)

        d = Diagram(width=300, height=250, padding=40)
        adj_len = float(sqrt(hypotenuse**2 - opposite**2))
        d.polygon([(0,0),(adj_len,0),(adj_len,opposite)], labels=["B","C","A"])
        d.right_angle((adj_len,0),(0,0),(adj_len,opposite))
        d.segment_label((adj_len,0),(adj_len,opposite),f"{opposite}")
        d.segment_label((0,0),(adj_len,opposite),f"{hypotenuse}")

        return problem(
            question=f"In right triangle $ABC$ with right angle at $C$, side $AC = {opposite}$ and hypotenuse $AB = {hypotenuse}$. Find angle $\\angle B$ to two decimal places.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"$\\sin(A) = \\frac{{{opposite}}}{{{hypotenuse}}}$, so $A \\approx {round(angle1_deg,2)}°$",
                f"$\\angle B = 90° - A \\approx 90° - {round(angle1_deg,2)}° = {ans}°$"
            ),
            calculator="scientific",
            image=d.render()
        )

    elif problem_type == 'multi_step':
        # Find height of object using two angles from same point via different trig
        angle1 = randint(25, 55)
        base_dist = randint(30, 100)
        h = round(base_dist * float(tan(angle1 * pi / 180)), 2)
        angle2_deg = round(float(atan(h / base_dist) * 180 / pi), 1)

        # Second part: from a different distance
        new_dist = base_dist + randint(15, 40)
        new_angle = round(float(atan(h / new_dist) * 180 / pi), 1)

        return problem(
            question=f"A person stands ${base_dist}$ meters from a building. The angle of elevation to the top is ${angle1}°$. What is the angle of elevation from a point ${new_dist}$ meters from the building? Round to one decimal place.",
            answer=new_angle,
            difficulty=(1650, 1800),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"First find height: $h = {base_dist} \\cdot \\tan({angle1}°) \\approx {h}$ m",
                f"From new distance ${new_dist}$ m: $\\theta = \\arctan\\!\\left(\\frac{{{h}}}{{{new_dist}}}\\right) \\approx {new_angle}°$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'bearing_problem':
        # Navigation / bearing problem
        dist1 = randint(20, 80)
        dist2 = randint(20, 80)
        # Ship travels east then north
        diagonal = round(float(sqrt(dist1**2 + dist2**2)), 2)
        bearing_angle = round(float(atan(dist1 / dist2) * 180 / pi), 1)

        return problem(
            question=f"A ship travels ${dist1}$ km due east, then ${dist2}$ km due north. Find the straight-line distance from the starting point. Also find the bearing (angle east of north) of the ship from its start. Round distance to 2 decimal places and angle to 1 decimal place.",
            answer=diagonal,
            difficulty=(1650, 1750),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"The path forms a right triangle with legs ${dist1}$ km and ${dist2}$ km",
                f"Distance $= \\sqrt{{{dist1}^2 + {dist2}^2}} = \\sqrt{{{dist1**2 + dist2**2}}} \\approx {diagonal}$ km",
                f"Bearing (east of north) $= \\arctan\\!\\left(\\frac{{{dist1}}}{{{dist2}}}\\right) \\approx {bearing_angle}°$"
            ),
            calculator="scientific"
        )

    else:  # isosceles_altitude
        # Find altitude / area of isosceles triangle
        base = randint(4, 20) * 2  # even for symmetry
        leg = randint(base//2 + 2, base + 10)
        half_base = base // 2
        if leg**2 - half_base**2 <= 0:
            leg = half_base + randint(3, 8)
        altitude_sq = leg**2 - half_base**2
        altitude = round(float(sqrt(altitude_sq)), 2)
        area = round(0.5 * base * altitude, 2)
        angle_apex = round(2 * float(asin(Rational(half_base, leg)) * 180 / pi), 1)

        variant = randint(0, 1)
        if variant == 0:
            return problem(
                question=f"An isosceles triangle has two equal sides of length ${leg}$ and a base of ${base}$. Find the altitude to the base. Round to two decimal places.",
                answer=altitude,
                difficulty=(1650, 1800),
                topic="geometry/right_triangle_trig",
                solution=steps(
                    f"The altitude bisects the base, forming a right triangle with hypotenuse ${leg}$ and leg ${half_base}$",
                    f"$h^2 = {leg}^2 - {half_base}^2 = {leg**2} - {half_base**2} = {altitude_sq}$",
                    f"$h = \\sqrt{{{altitude_sq}}} \\approx {altitude}$"
                ),
                calculator="scientific"
            )
        else:
            return problem(
                question=f"An isosceles triangle has two equal sides of length ${leg}$ and a base of ${base}$. Find the area of the triangle. Round to two decimal places.",
                answer=area,
                difficulty=(1650, 1800),
                topic="geometry/right_triangle_trig",
                solution=steps(
                    f"The altitude bisects the base: $h^2 = {leg}^2 - {half_base}^2 = {altitude_sq}$, so $h \\approx {altitude}$",
                    f"Area $= \\frac{{1}}{{2}} \\cdot \\text{{base}} \\cdot h = \\frac{{1}}{{2}} \\cdot {base} \\cdot {altitude} \\approx {area}$"
                ),
                calculator="scientific"
            )

emit(generate())
