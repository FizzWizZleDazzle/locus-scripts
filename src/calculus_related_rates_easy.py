"""
calculus - related_rates (easy)
Generated: 2026-02-22T05:05:57.992678
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Ladder sliding down a wall - given rate, find other rate
        # 1000-1200 ELO: direct substitution, one differentiation
        height = choice([3, 4, 5, 6])
        base = choice([4, 5, 6, 8])
        ladder = sqrt(height**2 + base**2)
        
        # Make ladder length nice if possible
        if ladder == int(ladder):
            ladder = int(ladder)
        else:
            # Pick Pythagorean triple
            height, base, ladder = choice([(3, 4, 5), (5, 12, 13), (8, 15, 17), (6, 8, 10)])
        
        dh_dt = choice([1, 2, 3])  # ft/s, positive means moving up (but we'll make it negative)
        
        # x^2 + y^2 = L^2
        # 2x(dx/dt) + 2y(dy/dt) = 0
        # dx/dt = -(y/x)(dy/dt)
        
        dx_dt_val = (height * dh_dt) / base
        
        return problem(
            question=f"A {ladder}-ft ladder is leaning against a wall. The bottom is {base} ft from the wall and is sliding away at {dx_dt_val} ft/s. How fast is the top of the ladder sliding down the wall? (Answer in ft/s, positive = down)",
            answer=dh_dt,
            difficulty=(1000, 1200),
            topic="calculus/related_rates",
            solution=steps(
                f"Let $x$ = distance from wall (base), $y$ = height on wall",
                f"Given: $x = {base}$ ft, $\\frac{{dx}}{{dt}} = {latex(dx_dt_val)}$ ft/s",
                f"Pythagorean theorem: $x^2 + y^2 = {ladder}^2$",
                f"Find $y$: ${base}^2 + y^2 = {ladder**2}$, so $y = {height}$ ft",
                f"Differentiate: $2x\\frac{{dx}}{{dt}} + 2y\\frac{{dy}}{{dt}} = 0$",
                f"Solve: $\\frac{{dy}}{{dt}} = -\\frac{{x}}{{y}}\\frac{{dx}}{{dt}} = -\\frac{{{base}}}{{{height}}} \\cdot {latex(dx_dt_val)} = {-dh_dt}$ ft/s",
                f"The top is sliding down at ${dh_dt}$ ft/s"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Expanding circle - given dr/dt, find dA/dt at specific radius
        # 1100-1250 ELO
        radius_val = choice([2, 3, 4, 5])
        dr_dt = choice([1, 2, 3])
        
        # A = pi*r^2
        # dA/dt = 2*pi*r * dr/dt
        dA_dt = 2 * radius_val * dr_dt
        
        return problem(
            question=f"A circular oil slick is expanding. Its radius is increasing at {dr_dt} ft/s. How fast is the area increasing when the radius is {radius_val} ft? (Answer as a coefficient of $\\pi$, in ft²/s)",
            answer=dA_dt,
            difficulty=(1100, 1250),
            topic="calculus/related_rates",
            solution=steps(
                f"Area formula: $A = \\pi r^2$",
                f"Given: $\\frac{{dr}}{{dt}} = {dr_dt}$ ft/s, $r = {radius_val}$ ft",
                f"Differentiate both sides with respect to $t$:",
                f"$\\frac{{dA}}{{dt}} = 2\\pi r \\frac{{dr}}{{dt}}$",
                f"Substitute: $\\frac{{dA}}{{dt}} = 2\\pi({radius_val})({dr_dt}) = {dA_dt}\\pi$ ft²/s"
            ),
            calculator="none"
        )
    
    elif problem_type == 3:
        # Water filling cone - given dV/dt, find dh/dt
        # 1200-1300 ELO: requires knowing cone volume and chain rule
        radius_cone = choice([3, 4, 6])
        height_cone = choice([6, 8, 9, 12])
        
        # Make sure r/h ratio is simple
        if radius_cone == 3 and height_cone == 6:
            r_h_ratio = Rational(1, 2)
        elif radius_cone == 4 and height_cone == 8:
            r_h_ratio = Rational(1, 2)
        elif radius_cone == 6 and height_cone == 12:
            r_h_ratio = Rational(1, 2)
        else:
            r_h_ratio = Rational(radius_cone, height_cone)
        
        dV_dt = choice([2, 3, 4, 5])
        h_val = choice([3, 4, 6])
        
        # V = (1/3)*pi*r^2*h, but r = (R/H)*h
        # V = (1/3)*pi*(R/H)^2*h^3
        # dV/dt = pi*(R/H)^2*h^2 * dh/dt
        
        dh_dt_num = dV_dt
        dh_dt_denom = r_h_ratio**2 * h_val**2
        dh_dt = Rational(dh_dt_num, dh_dt_denom)
        
        return problem(
            question=f"Water is being poured into a conical tank (vertex down) at {dV_dt} ft³/min. The tank has radius {radius_cone} ft and height {height_cone} ft. How fast is the water level rising when the water is {h_val} ft deep? (Answer in ft/min)",
            answer=dh_dt,
            difficulty=(1200, 1300),
            topic="calculus/related_rates",
            solution=steps(
                f"Volume of cone: $V = \\frac{{1}}{{3}}\\pi r^2 h$",
                f"Similar triangles: $\\frac{{r}}{{h}} = \\frac{{{radius_cone}}}{{{height_cone}}}$, so $r = {latex(r_h_ratio)}h$",
                f"Substitute: $V = \\frac{{1}}{{3}}\\pi({latex(r_h_ratio)}h)^2 h = \\frac{{\\pi}}{{3}} \\cdot {latex(r_h_ratio**2)} h^3$",
                f"Differentiate: $\\frac{{dV}}{{dt}} = \\pi \\cdot {latex(r_h_ratio**2)} h^2 \\frac{{dh}}{{dt}}$",
                f"Given: $h = {h_val}$ ft, $\\frac{{dV}}{{dt}} = {dV_dt}$ ft³/min",
                f"Solve: ${dV_dt} = \\pi \\cdot {latex(r_h_ratio**2)} \\cdot {h_val**2} \\frac{{dh}}{{dt}}$",
                f"$\\frac{{dh}}{{dt}} = \\frac{{{dV_dt}}}{{\\pi \\cdot {latex(r_h_ratio**2 * h_val**2)}}} = {latex(dh_dt)}$ ft/min"
            ),
            calculator="scientific"
        )
    
    else:
        # Expanding sphere - given dr/dt, find dV/dt
        # 1150-1250 ELO
        radius_val = choice([2, 3, 4, 5])
        dr_dt = choice([1, 2])
        
        # V = (4/3)*pi*r^3
        # dV/dt = 4*pi*r^2 * dr/dt
        dV_dt_coeff = 4 * radius_val**2 * dr_dt
        
        return problem(
            question=f"A spherical balloon is being inflated. Its radius is increasing at {dr_dt} cm/s. How fast is the volume increasing when the radius is {radius_val} cm? (Answer as a coefficient of $\\pi$, in cm³/s)",
            answer=dV_dt_coeff,
            difficulty=(1150, 1250),
            topic="calculus/related_rates",
            solution=steps(
                f"Volume of sphere: $V = \\frac{{4}}{{3}}\\pi r^3$",
                f"Given: $\\frac{{dr}}{{dt}} = {dr_dt}$ cm/s, $r = {radius_val}$ cm",
                f"Differentiate: $\\frac{{dV}}{{dt}} = 4\\pi r^2 \\frac{{dr}}{{dt}}$",
                f"Substitute: $\\frac{{dV}}{{dt}} = 4\\pi({radius_val})^2({dr_dt}) = {dV_dt_coeff}\\pi$ cm³/s"
            ),
            calculator="none"
        )

emit(generate())