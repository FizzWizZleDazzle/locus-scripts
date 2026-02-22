"""
calculus - related_rates (hard)
Generated: 2026-02-22T05:07:07.955984
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Ladder sliding down wall problem
        ladder_length = randint(10, 25)
        base_rate = randint(1, 4)
        base_distance = randint(int(ladder_length * 0.3), int(ladder_length * 0.7))
        
        # At this moment, height h satisfies: base^2 + h^2 = ladder^2
        height = sqrt(ladder_length**2 - base_distance**2)
        
        # dh/dt = -(x/y) * dx/dt
        height_rate = -(base_distance / height) * base_rate
        
        return problem(
            question=f"A {ladder_length}-foot ladder is leaning against a wall. The base of the ladder is sliding away from the wall at a rate of {base_rate} ft/s. At the moment when the base of the ladder is {base_distance} feet from the wall, how fast is the top of the ladder sliding down the wall? Give your answer in ft/s.",
            answer=float(height_rate),
            difficulty=(1600, 1750),
            topic="calculus/related_rates",
            solution=steps(
                f"Let $x$ be the distance from the wall to the base, and $y$ be the height of the top of the ladder.",
                f"By the Pythagorean theorem: $x^2 + y^2 = {ladder_length}^2$",
                f"When $x = {base_distance}$, we have $y = \\sqrt{{{ladder_length}^2 - {base_distance}^2}} = {latex(height)}$",
                f"Differentiating with respect to time: $2x\\frac{{dx}}{{dt}} + 2y\\frac{{dy}}{{dt}} = 0$",
                f"Solving for $\\frac{{dy}}{{dt}}$: $\\frac{{dy}}{{dt}} = -\\frac{{x}}{{y}}\\frac{{dx}}{{dt}}$",
                f"Substituting: $\\frac{{dy}}{{dt}} = -\\frac{{{base_distance}}}{{{latex(height)}}} \\cdot {base_rate} = {latex(height_rate)}$ ft/s"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Conical water tank problem
        tank_radius = randint(4, 10)
        tank_height = randint(8, 20)
        fill_rate = randint(2, 8)
        water_height = randint(int(tank_height * 0.4), int(tank_height * 0.8))
        
        # For a cone: r/h = R/H (similar triangles), so r = (R/H)*h
        # Volume V = (1/3)πr²h = (1/3)π(R/H)²h³
        # dV/dt = π(R/H)²h² dh/dt
        
        water_radius = (tank_radius / tank_height) * water_height
        height_rate = fill_rate / (pi * (tank_radius / tank_height)**2 * water_height**2)
        
        return problem(
            question=f"Water is being pumped into an inverted conical tank at a rate of {fill_rate} cubic meters per minute. The tank has a height of {tank_height} meters and a radius of {tank_radius} meters at the top. At what rate is the water level rising when the water is {water_height} meters deep? Give your answer in m/min.",
            answer=float(height_rate),
            difficulty=(1650, 1800),
            topic="calculus/related_rates",
            solution=steps(
                f"Let $h$ be the water depth and $r$ be the radius of the water surface.",
                f"By similar triangles: $\\frac{{r}}{{h}} = \\frac{{{tank_radius}}}{{{tank_height}}}$, so $r = \\frac{{{tank_radius}}}{{{tank_height}}}h$",
                f"Volume of water: $V = \\frac{{1}}{{3}}\\pi r^2 h = \\frac{{1}}{{3}}\\pi \\left(\\frac{{{tank_radius}}}{{{tank_height}}}h\\right)^2 h = \\frac{{\\pi {tank_radius}^2}}{{3 \\cdot {tank_height}^2}}h^3$",
                f"Differentiating: $\\frac{{dV}}{{dt}} = \\frac{{\\pi {tank_radius}^2}}{{{tank_height}^2}}h^2 \\frac{{dh}}{{dt}}$",
                f"When $h = {water_height}$ and $\\frac{{dV}}{{dt}} = {fill_rate}$:",
                f"$\\frac{{dh}}{{dt}} = \\frac{{{fill_rate} \\cdot {tank_height}^2}}{{\\pi \\cdot {tank_radius}^2 \\cdot {water_height}^2}} = {latex(height_rate)}$ m/min"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Two cars approaching intersection
        car1_distance = randint(30, 80)
        car2_distance = randint(30, 80)
        car1_speed = randint(40, 80)
        car2_speed = randint(40, 80)
        
        # Distance between cars: D = sqrt(x^2 + y^2)
        # dD/dt = (1/D)(x*dx/dt + y*dy/dt)
        current_distance = sqrt(car1_distance**2 + car2_distance**2)
        approach_rate = (car1_distance * (-car1_speed) + car2_distance * (-car2_speed)) / current_distance
        
        return problem(
            question=f"Two cars are traveling on perpendicular roads toward an intersection. Car A is {car1_distance} km from the intersection traveling at {car1_speed} km/h, and Car B is {car2_distance} km from the intersection traveling at {car2_speed} km/h. At what rate is the distance between the cars changing? Give your answer in km/h.",
            answer=float(approach_rate),
            difficulty=(1600, 1750),
            topic="calculus/related_rates",
            solution=steps(
                f"Let $x$ be Car A's distance from intersection and $y$ be Car B's distance from intersection.",
                f"Distance between cars: $D = \\sqrt{{x^2 + y^2}}$",
                f"Currently: $D = \\sqrt{{{car1_distance}^2 + {car2_distance}^2}} = {latex(current_distance)}$ km",
                f"Since cars approach intersection: $\\frac{{dx}}{{dt}} = -{car1_speed}$ km/h and $\\frac{{dy}}{{dt}} = -{car2_speed}$ km/h",
                f"Differentiating: $\\frac{{dD}}{{dt}} = \\frac{{1}}{{D}}\\left(x\\frac{{dx}}{{dt}} + y\\frac{{dy}}{{dt}}\\right)$",
                f"$\\frac{{dD}}{{dt}} = \\frac{{1}}{{{latex(current_distance)}}}\\left({car1_distance}(-{car1_speed}) + {car2_distance}(-{car2_speed})\\right) = {latex(approach_rate)}$ km/h"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Expanding circle area problem
        radius_rate = randint(2, 6)
        current_radius = randint(5, 15)
        
        # A = πr², dA/dt = 2πr dr/dt
        area_rate = 2 * pi * current_radius * radius_rate
        
        return problem(
            question=f"A circular oil slick is expanding at a rate such that its radius is increasing at {radius_rate} meters per minute. At what rate is the area of the oil slick increasing when the radius is {current_radius} meters? Give your answer in square meters per minute.",
            answer=float(area_rate),
            difficulty=(1600, 1700),
            topic="calculus/related_rates",
            solution=steps(
                f"Let $r$ be the radius and $A$ be the area of the circle.",
                f"Area formula: $A = \\pi r^2$",
                f"Given: $\\frac{{dr}}{{dt}} = {radius_rate}$ m/min",
                f"Differentiating with respect to time: $\\frac{{dA}}{{dt}} = 2\\pi r \\frac{{dr}}{{dt}}$",
                f"When $r = {current_radius}$ m:",
                f"$\\frac{{dA}}{{dt}} = 2\\pi ({current_radius})({radius_rate}) = {latex(area_rate)}$ m²/min"
            ),
            calculator="scientific"
        )
    
    else:
        # Spherical balloon volume problem
        radius_rate = Rational(randint(1, 4), randint(2, 5))
        current_radius = randint(6, 15)
        
        # V = (4/3)πr³, dV/dt = 4πr² dr/dt
        volume_rate = 4 * pi * current_radius**2 * radius_rate
        
        return problem(
            question=f"A spherical balloon is being inflated so that its radius is increasing at a rate of {latex(radius_rate)} cm/s. At what rate is the volume of the balloon increasing when the radius is {current_radius} cm? Give your answer in cubic cm per second.",
            answer=float(volume_rate),
            difficulty=(1650, 1800),
            topic="calculus/related_rates",
            solution=steps(
                f"Let $r$ be the radius and $V$ be the volume of the sphere.",
                f"Volume formula: $V = \\frac{{4}}{{3}}\\pi r^3$",
                f"Given: $\\frac{{dr}}{{dt}} = {latex(radius_rate)}$ cm/s",
                f"Differentiating with respect to time: $\\frac{{dV}}{{dt}} = 4\\pi r^2 \\frac{{dr}}{{dt}}$",
                f"When $r = {current_radius}$ cm:",
                f"$\\frac{{dV}}{{dt}} = 4\\pi ({current_radius})^2 \\left({latex(radius_rate)}\\right) = {latex(volume_rate)}$ cm³/s"
            ),
            calculator="scientific"
        )

emit(generate())