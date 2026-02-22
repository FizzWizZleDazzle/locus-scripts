"""
calculus - related_rates (medium)
Generated: 2026-02-22T05:06:32.746887
"""

from problem_utils import *

def generate():
    problem_type = choice(['ladder', 'cone', 'sphere', 'rectangle', 'cylinder'])
    
    if problem_type == 'ladder':
        # Ladder sliding down a wall
        length = randint(10, 25)
        x_val = randint(int(length * 0.4), int(length * 0.7))
        y_val = int(sqrt(length**2 - x_val**2))
        dx_dt = choice([2, 3, 4, 5])
        
        # At the moment, y^2 + x^2 = L^2
        # 2y(dy/dt) + 2x(dx/dt) = 0
        # dy/dt = -x(dx/dt)/y
        dy_dt = -x_val * dx_dt / y_val
        
        question = f"A {length}-foot ladder is leaning against a wall. The bottom of the ladder is sliding away from the wall at a rate of {dx_dt} ft/s. How fast is the top of the ladder sliding down the wall when the bottom is {x_val} feet from the wall?"
        
        solution = steps(
            f"Let $x$ = distance from wall to bottom, $y$ = height of top on wall",
            f"Given: $\\frac{{dx}}{{dt}} = {dx_dt}$ ft/s, $x = {x_val}$ ft, ladder length = {length} ft",
            f"By Pythagorean theorem: $x^2 + y^2 = {length}^2$",
            f"When $x = {x_val}$: $y = \\sqrt{{{length}^2 - {x_val}^2}} = {y_val}$ ft",
            f"Differentiate implicitly: $2x\\frac{{dx}}{{dt}} + 2y\\frac{{dy}}{{dt}} = 0$",
            f"Solve for $\\frac{{dy}}{{dt}}$: $\\frac{{dy}}{{dt}} = -\\frac{{x}}{{y}}\\frac{{dx}}{{dt}}$",
            f"Substitute: $\\frac{{dy}}{{dt}} = -\\frac{{{x_val}}}{{{y_val}}} \\cdot {dx_dt} = {latex(Rational(int(dy_dt * 100), 100))}$ ft/s"
        )
        
        return problem(
            question=question,
            answer=float(dy_dt),
            difficulty=(1400, 1500),
            topic="calculus/related_rates",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 'cone':
        # Water draining from/filling a cone
        radius = choice([3, 4, 5, 6])
        height = choice([8, 9, 10, 12])
        dV_dt = choice([2, 3, 4, 5])
        h_val = randint(int(height * 0.4), int(height * 0.7))
        
        # V = (1/3)πr^2h, r/h = R/H (similar triangles)
        # V = (1/3)π(R/H)^2 h^3
        # dV/dt = π(R/H)^2 h^2 (dh/dt)
        # dh/dt = dV/dt / [π(R/H)^2 h^2]
        
        dh_dt = dV_dt / (pi * (radius/height)**2 * h_val**2)
        
        question = f"Water is draining from a conical tank at a rate of {dV_dt} ft³/min. The tank has a radius of {radius} feet at the top and a height of {height} feet. How fast is the water level dropping when the water is {h_val} feet deep?"
        
        solution = steps(
            f"Let $h$ = water height, $r$ = radius at water surface",
            f"Given: $\\frac{{dV}}{{dt}} = -{dV_dt}$ ft³/min, $h = {h_val}$ ft",
            f"By similar triangles: $\\frac{{r}}{{h}} = \\frac{{{radius}}}{{{height}}}$, so $r = \\frac{{{radius}}}{{{height}}}h$",
            f"Volume of cone: $V = \\frac{{1}}{{3}}\\pi r^2 h = \\frac{{1}}{{3}}\\pi\\left(\\frac{{{radius}}}{{{height}}}h\\right)^2 h = \\frac{{\\pi \\cdot {radius**2}}}{{{3 * height**2}}}h^3$",
            f"Differentiate: $\\frac{{dV}}{{dt}} = \\frac{{\\pi \\cdot {radius**2}}}{{{height**2}}}h^2\\frac{{dh}}{{dt}}$",
            f"Solve: $\\frac{{dh}}{{dt}} = \\frac{{\\frac{{dV}}{{dt}}}}{{\\frac{{\\pi \\cdot {radius**2}}}{{{height**2}}}h^2}}$",
            f"Substitute: $\\frac{{dh}}{{dt}} = \\frac{{-{dV_dt}}}{{\\frac{{\\pi \\cdot {radius**2}}}{{{height**2}}} \\cdot {h_val}^2}} = {latex(dh_dt.evalf(4))}$ ft/min"
        )
        
        return problem(
            question=question,
            answer=float(dh_dt.evalf(6)),
            difficulty=(1500, 1600),
            topic="calculus/related_rates",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 'sphere':
        # Expanding sphere (balloon, etc.)
        dr_dt = choice([2, 3, 4, 5])
        r_val = choice([6, 8, 10, 12])
        
        # V = (4/3)πr^3
        # dV/dt = 4πr^2 (dr/dt)
        dV_dt = 4 * pi * r_val**2 * dr_dt
        
        question = f"A spherical balloon is being inflated so that its radius increases at a rate of {dr_dt} cm/s. How fast is the volume increasing when the radius is {r_val} cm?"
        
        solution = steps(
            f"Given: $\\frac{{dr}}{{dt}} = {dr_dt}$ cm/s, $r = {r_val}$ cm",
            f"Volume of sphere: $V = \\frac{{4}}{{3}}\\pi r^3$",
            f"Differentiate with respect to time: $\\frac{{dV}}{{dt}} = 4\\pi r^2 \\frac{{dr}}{{dt}}$",
            f"Substitute: $\\frac{{dV}}{{dt}} = 4\\pi ({r_val})^2 \\cdot {dr_dt} = {4 * r_val**2 * dr_dt}\\pi$ cm³/s"
        )
        
        return problem(
            question=question,
            answer=float(dV_dt.evalf(6)),
            difficulty=(1300, 1400),
            topic="calculus/related_rates",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 'rectangle':
        # Rectangle with changing dimensions
        dx_dt = choice([2, 3, 4, 5])
        dy_dt = choice([-1, -2, -3, 1, 2, 3])
        x_val = randint(8, 15)
        y_val = randint(6, 12)
        
        # A = xy
        # dA/dt = y(dx/dt) + x(dy/dt)
        dA_dt = y_val * dx_dt + x_val * dy_dt
        
        question = f"The length of a rectangle is increasing at a rate of {dx_dt} m/s and the width is {'increasing' if dy_dt > 0 else 'decreasing'} at a rate of {abs(dy_dt)} m/s. How fast is the area changing when the length is {x_val} m and the width is {y_val} m?"
        
        solution = steps(
            f"Let $l$ = length, $w$ = width, $A$ = area",
            f"Given: $\\frac{{dl}}{{dt}} = {dx_dt}$ m/s, $\\frac{{dw}}{{dt}} = {dy_dt}$ m/s",
            f"At the moment: $l = {x_val}$ m, $w = {y_val}$ m",
            f"Area: $A = lw$",
            f"Differentiate: $\\frac{{dA}}{{dt}} = w\\frac{{dl}}{{dt}} + l\\frac{{dw}}{{dt}}$",
            f"Substitute: $\\frac{{dA}}{{dt}} = {y_val} \\cdot {dx_dt} + {x_val} \\cdot ({dy_dt}) = {dA_dt}$ m²/s"
        )
        
        return problem(
            question=question,
            answer=dA_dt,
            difficulty=(1300, 1400),
            topic="calculus/related_rates",
            solution=solution
        )
    
    else:  # cylinder
        # Cylindrical tank filling
        r = choice([3, 4, 5])
        dV_dt = choice([8, 10, 12, 15])
        
        # V = πr²h
        # dV/dt = πr²(dh/dt)
        # dh/dt = dV/dt / (πr²)
        dh_dt = dV_dt / (pi * r**2)
        
        question = f"Water is being poured into a cylindrical tank with radius {r} feet at a rate of {dV_dt} ft³/min. How fast is the water level rising?"
        
        solution = steps(
            f"Given: radius $r = {r}$ ft, $\\frac{{dV}}{{dt}} = {dV_dt}$ ft³/min",
            f"Volume of cylinder: $V = \\pi r^2 h$",
            f"Since radius is constant: $\\frac{{dV}}{{dt}} = \\pi r^2 \\frac{{dh}}{{dt}}$",
            f"Solve for $\\frac{{dh}}{{dt}}$: $\\frac{{dh}}{{dt}} = \\frac{{\\frac{{dV}}{{dt}}}}{{\\pi r^2}}$",
            f"Substitute: $\\frac{{dh}}{{dt}} = \\frac{{{dV_dt}}}{{\\pi \\cdot {r}^2}} = \\frac{{{dV_dt}}}{{{r**2}\\pi}}$ ft/min"
        )
        
        return problem(
            question=question,
            answer=float(dh_dt.evalf(6)),
            difficulty=(1300, 1400),
            topic="calculus/related_rates",
            solution=solution,
            calculator="scientific"
        )

emit(generate())