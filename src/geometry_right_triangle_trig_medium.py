"""
geometry - right_triangle_trig (medium)
Generated: 2026-02-22T04:19:29.946948
"""

from problem_utils import *
from svg_utils import Diagram

SPECIAL_ANGLES = {
    30: {'sin': Rational(1,2), 'cos': sqrt(3)/2, 'tan': 1/sqrt(3)},
    45: {'sin': sqrt(2)/2, 'cos': sqrt(2)/2, 'tan': Integer(1)},
    60: {'sin': sqrt(3)/2, 'cos': Rational(1,2), 'tan': sqrt(3)},
}

def generate():
    problem_type = choice(['find_side', 'find_angle', 'word_problem', 'six_trig_fns', 'inverse'])

    if problem_type == 'find_side':
        # Given angle (30/45/60) and one side, find another side
        angle = choice([30, 45, 60])
        side_given = choice(['opposite', 'adjacent', 'hypotenuse'])
        side_find = choice([s for s in ['opposite', 'adjacent', 'hypotenuse'] if s != side_given])
        ratios = SPECIAL_ANGLES[angle]

        if angle == 30:
            ratio_map = {'opposite': Rational(1,2), 'adjacent': sqrt(3)/2, 'hypotenuse': Integer(1)}
        elif angle == 45:
            ratio_map = {'opposite': sqrt(2)/2, 'adjacent': sqrt(2)/2, 'hypotenuse': Integer(1)}
        else:
            ratio_map = {'opposite': sqrt(3)/2, 'adjacent': Rational(1,2), 'hypotenuse': Integer(1)}

        scale = randint(2, 12)
        given_value = simplify(ratio_map[side_given] * scale)
        answer_value = simplify(ratio_map[side_find] * scale)

        d = Diagram(width=300, height=250, padding=40)
        opp_r = float(ratio_map['opposite'])
        adj_r = float(ratio_map['adjacent'])
        base = adj_r * scale * 20
        height = opp_r * scale * 20
        A, B, C = (0,0), (base,0), (base,height)
        d.polygon([A,B,C], labels=['A','B','C'])
        d.right_angle(B, A, C)
        d.angle_arc(A, B, C, f"{angle}°")

        side_names = {'opposite': 'BC', 'adjacent': 'AB', 'hypotenuse': 'AC'}
        q = f"In right triangle $ABC$ with right angle at $B$, $\\angle A = {angle}°$ and ${side_names[side_given]} = {latex(given_value)}$. Find ${side_names[side_find]}$."

        # Determine trig function
        pairs = {('opposite','hypotenuse'): 'sin', ('hypotenuse','opposite'): 'sin',
                 ('adjacent','hypotenuse'): 'cos', ('hypotenuse','adjacent'): 'cos',
                 ('opposite','adjacent'): 'tan', ('adjacent','opposite'): 'tan'}
        fn = pairs.get((side_given, side_find), 'sin')

        if side_find == 'hypotenuse':
            sol = steps(
                f"Use $\\{fn}({angle}°) = \\frac{{{side_given}}}{{{side_find}}}$",
                f"${side_names[side_find]} = \\frac{{{latex(given_value)}}}{{\\{fn}({angle}°)}} = {latex(answer_value)}$"
            )
        elif side_given == 'hypotenuse':
            sol = steps(
                f"Use $\\{fn}({angle}°) = \\frac{{{side_find}}}{{{side_given}}}$",
                f"${side_names[side_find]} = {latex(given_value)} \\cdot \\{fn}({angle}°) = {latex(answer_value)}$"
            )
        else:
            sol = steps(
                f"Use $\\{fn}({angle}°) = \\frac{{{side_given}}}{{{side_find}}}$ (rearranged as needed)",
                f"${side_names[side_find]} = {latex(answer_value)}$"
            )

        return problem(
            question=q,
            answer=simplify(answer_value),
            difficulty=(1300, 1500),
            topic="geometry/right_triangle_trig",
            solution=sol,
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 'find_angle':
        # Given two sides from a variety of Pythagorean triples, find angle
        # Use a broad pool of triples including scaled ones
        all_triples = [
            (3,4,5),(5,12,13),(8,15,17),(7,24,25),(20,21,29),
            (9,40,41),(6,8,10),(9,12,15),(12,16,20),(15,20,25),
            (10,24,26),(5,12,13),(7,24,25),(28,45,53)
        ]
        opp, adj, hyp = choice(all_triples)
        angle_choice = choice(['sin', 'cos', 'tan'])

        d = Diagram(width=300, height=250, padding=40)
        scale_f = min(180/max(opp,adj,hyp), 8)
        A, B, C = (0,0), (adj*scale_f,0), (adj*scale_f, opp*scale_f)
        d.polygon([A,B,C], labels=['A','B','C'])
        d.right_angle(B,A,C)
        d.segment_label(A,B,str(adj))
        d.segment_label(B,C,str(opp))
        d.segment_label(A,C,str(hyp))

        if angle_choice == 'sin':
            q = f"In right triangle $ABC$ with right angle at $B$, $BC = {opp}$ and $AC = {hyp}$. Find $\\angle A$ to the nearest degree."
            ans_rad = asin(Rational(opp, hyp))
            sol = steps(
                f"$\\sin(A) = \\frac{{{opp}}}{{{hyp}}}$",
                f"$A = \\sin^{{-1}}\\!\\left(\\frac{{{opp}}}{{{hyp}}}\\right) \\approx {round(float(ans_rad*180/pi))}°$"
            )
        elif angle_choice == 'cos':
            q = f"In right triangle $ABC$ with right angle at $B$, $AB = {adj}$ and $AC = {hyp}$. Find $\\angle A$ to the nearest degree."
            ans_rad = acos(Rational(adj, hyp))
            sol = steps(
                f"$\\cos(A) = \\frac{{{adj}}}{{{hyp}}}$",
                f"$A = \\cos^{{-1}}\\!\\left(\\frac{{{adj}}}{{{hyp}}}\\right) \\approx {round(float(ans_rad*180/pi))}°$"
            )
        else:
            q = f"In right triangle $ABC$ with right angle at $B$, $BC = {opp}$ and $AB = {adj}$. Find $\\angle A$ to the nearest degree."
            ans_rad = atan(Rational(opp, adj))
            sol = steps(
                f"$\\tan(A) = \\frac{{{opp}}}{{{adj}}}$",
                f"$A = \\tan^{{-1}}\\!\\left(\\frac{{{opp}}}{{{adj}}}\\right) \\approx {round(float(ans_rad*180/pi))}°$"
            )

        answer = round(float(ans_rad * 180 / pi))
        return problem(
            question=q,
            answer=answer,
            difficulty=(1400, 1600),
            topic="geometry/right_triangle_trig",
            solution=sol,
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 'word_problem':
        # Practical angle-of-elevation/depression or distance problems
        angle = choice([20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70])
        length = randint(8, 50)
        angle_rad_float = angle * 3.14159265 / 180

        scenarios = [
            (f"A ${length}$-foot ladder leans against a wall making a ${angle}°$ angle with the ground. How high up the wall does the ladder reach? Round to the nearest tenth.",
             round(length * float(sin(angle * pi / 180)), 1), "feet"),
            (f"From a point ${length}$ meters from the base of a building, the angle of elevation to the top is ${angle}°$. Find the height of the building. Round to the nearest tenth.",
             round(length * float(tan(angle * pi / 180)), 1), "meters"),
            (f"A ramp rises at a ${angle}°$ angle. If the horizontal distance covered is ${length}$ feet, what is the length of the ramp? Round to the nearest tenth.",
             round(length / float(cos(angle * pi / 180)), 1), "feet"),
        ]
        q_text, ans, unit = choice(scenarios)

        return problem(
            question=q_text,
            answer=ans,
            difficulty=(1400, 1600),
            topic="geometry/right_triangle_trig",
            solution=steps(
                f"Identify the relevant trig ratio based on the known and unknown sides",
                f"Set up equation and solve",
                f"Result $\\approx {ans}$ {unit}"
            ),
            calculator="scientific"
        )

    elif problem_type == 'six_trig_fns':
        # Given a right triangle with integer sides, find all 6 trig functions of an angle
        triples = [(3,4,5),(5,12,13),(8,15,17),(7,24,25),(20,21,29),(9,40,41)]
        opp, adj, hyp = choice(triples)
        fn = choice(['csc', 'sec', 'cot'])

        if fn == 'csc':
            ans = Rational(hyp, opp)
            q = f"In a right triangle, the side opposite angle $\\theta$ is ${opp}$ and the hypotenuse is ${hyp}$. Find $\\csc(\\theta)$."
            sol = steps(
                f"$\\csc(\\theta) = \\frac{{\\text{{hypotenuse}}}}{{\\text{{opposite}}}} = \\frac{{{hyp}}}{{{opp}}} = {latex(ans)}$"
            )
        elif fn == 'sec':
            ans = Rational(hyp, adj)
            q = f"In a right triangle, the side adjacent to angle $\\theta$ is ${adj}$ and the hypotenuse is ${hyp}$. Find $\\sec(\\theta)$."
            sol = steps(
                f"$\\sec(\\theta) = \\frac{{\\text{{hypotenuse}}}}{{\\text{{adjacent}}}} = \\frac{{{hyp}}}{{{adj}}} = {latex(ans)}$"
            )
        else:
            ans = Rational(adj, opp)
            q = f"In a right triangle, the side opposite angle $\\theta$ is ${opp}$ and the side adjacent is ${adj}$. Find $\\cot(\\theta)$."
            sol = steps(
                f"$\\cot(\\theta) = \\frac{{\\text{{adjacent}}}}{{\\text{{opposite}}}} = \\frac{{{adj}}}{{{opp}}} = {latex(ans)}$"
            )

        return problem(
            question=q,
            answer=ans,
            difficulty=(1350, 1500),
            topic="geometry/right_triangle_trig",
            solution=sol
        )

    else:  # inverse
        # Given a decimal ratio, find angle approximately
        angle_true = randint(15, 75)
        fn = choice(['sin', 'cos', 'tan'])
        angle_rad = angle_true * pi / 180
        ratio_val = round(float(eval(f"{fn}(angle_rad)")), 3)

        q = f"Use an inverse trig function to find angle $\\theta$ (in degrees) if $\\{fn}(\\theta) \\approx {ratio_val}$. Round to the nearest degree."
        sol = steps(
            f"$\\theta = \\{fn}^{{-1}}({ratio_val})$",
            f"$\\theta \\approx {angle_true}°$"
        )

        return problem(
            question=q,
            answer=angle_true,
            difficulty=(1400, 1550),
            topic="geometry/right_triangle_trig",
            solution=sol,
            calculator="scientific"
        )

emit(generate())
