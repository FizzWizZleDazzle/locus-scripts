"""
geometry - right_triangle_trig (medium)
Generated: 2026-02-22T04:19:29.946948
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['find_side', 'find_angle', 'find_side_angle', 'word_problem'])
    
    if problem_type == 'find_side':
        # Given angle and one side, find another side
        angle = choice([30, 45, 60])
        side_given = choice(['opposite', 'adjacent', 'hypotenuse'])
        side_find = choice([s for s in ['opposite', 'adjacent', 'hypotenuse'] if s != side_given])
        
        # Pick clean values that work out nicely
        if angle == 30:
            ratios = {'opposite': 1, 'adjacent': sqrt(3), 'hypotenuse': 2}
        elif angle == 45:
            ratios = {'opposite': 1, 'adjacent': 1, 'hypotenuse': sqrt(2)}
        else:  # 60
            ratios = {'opposite': sqrt(3), 'adjacent': 1, 'hypotenuse': 2}
        
        scale = randint(2, 8)
        given_value = ratios[side_given] * scale
        answer_value = ratios[side_find] * scale
        
        # Create diagram
        d = Diagram(width=300, height=250, padding=40)
        if angle == 30 or angle == 60:
            base = float(ratios['adjacent'] * scale * 50)
            height = float(ratios['opposite'] * scale * 50)
        else:
            base = height = float(scale * 50)
        
        A, B, C = (0, 0), (base, 0), (base, height)
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.right_angle(B, A, C)
        d.angle_arc(A, B, C, f"{angle}°")
        
        if side_given == 'opposite':
            d.segment_label(B, C, f"{latex(given_value)}")
        elif side_given == 'adjacent':
            d.segment_label(A, B, f"{latex(given_value)}")
        else:
            d.segment_label(A, C, f"{latex(given_value)}")
        
        side_names = {'opposite': 'BC', 'adjacent': 'AB', 'hypotenuse': 'AC'}
        
        question = f"In right triangle $ABC$ with right angle at $B$, $\\angle A = {angle}°$ and ${side_names[side_given]} = {latex(given_value)}$. Find ${side_names[side_find]}$."
        
        # Determine which trig function to use
        if side_given == 'opposite' and side_find == 'adjacent':
            trig_func = 'tan'
            solution_text = steps(
                f"We know the opposite side and need the adjacent side",
                f"Use $\\tan({angle}°) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}}$",
                f"$\\tan({angle}°) = \\frac{{{latex(given_value)}}}{{{side_names[side_find]}}}$",
                f"${side_names[side_find]} = \\frac{{{latex(given_value)}}}{{\\tan({angle}°)}} = {latex(answer_value)}$"
            )
        elif side_given == 'adjacent' and side_find == 'opposite':
            trig_func = 'tan'
            solution_text = steps(
                f"We know the adjacent side and need the opposite side",
                f"Use $\\tan({angle}°) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}}$",
                f"$\\tan({angle}°) = \\frac{{{side_names[side_find]}}}{{{latex(given_value)}}}$",
                f"${side_names[side_find]} = {latex(given_value)} \\cdot \\tan({angle}°) = {latex(answer_value)}$"
            )
        elif side_given == 'opposite' and side_find == 'hypotenuse':
            trig_func = 'sin'
            solution_text = steps(
                f"We know the opposite side and need the hypotenuse",
                f"Use $\\sin({angle}°) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\sin({angle}°) = \\frac{{{latex(given_value)}}}{{{side_names[side_find]}}}$",
                f"${side_names[side_find]} = \\frac{{{latex(given_value)}}}{{\\sin({angle}°)}} = {latex(answer_value)}$"
            )
        elif side_given == 'hypotenuse' and side_find == 'opposite':
            trig_func = 'sin'
            solution_text = steps(
                f"We know the hypotenuse and need the opposite side",
                f"Use $\\sin({angle}°) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\sin({angle}°) = \\frac{{{side_names[side_find]}}}{{{latex(given_value)}}}$",
                f"${side_names[side_find]} = {latex(given_value)} \\cdot \\sin({angle}°) = {latex(answer_value)}$"
            )
        elif side_given == 'adjacent' and side_find == 'hypotenuse':
            trig_func = 'cos'
            solution_text = steps(
                f"We know the adjacent side and need the hypotenuse",
                f"Use $\\cos({angle}°) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\cos({angle}°) = \\frac{{{latex(given_value)}}}{{{side_names[side_find]}}}$",
                f"${side_names[side_find]} = \\frac{{{latex(given_value)}}}{{\\cos({angle}°)}} = {latex(answer_value)}$"
            )
        else:  # hypotenuse to adjacent
            trig_func = 'cos'
            solution_text = steps(
                f"We know the hypotenuse and need the adjacent side",
                f"Use $\\cos({angle}°) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\cos({angle}°) = \\frac{{{side_names[side_find]}}}{{{latex(given_value)}}}$",
                f"${side_names[side_find]} = {latex(given_value)} \\cdot \\cos({angle}°) = {latex(answer_value)}$"
            )
        
        return problem(
            question=question,
            answer=simplify(answer_value),
            difficulty=(1300, 1500),
            topic="geometry/right_triangle_trig",
            solution=solution_text,
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'find_angle':
        # Given two sides, find an angle
        sides = choice([
            (3, 4, 5),
            (5, 12, 13),
            (8, 15, 17),
            (7, 24, 25)
        ])
        opp, adj, hyp = sides
        
        # Find angle using inverse trig
        angle_choice = choice(['sin', 'cos', 'tan'])
        
        d = Diagram(width=300, height=250, padding=40)
        A, B, C = (0, 0), (adj*8, 0), (adj*8, opp*8)
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.right_angle(B, A, C)
        d.segment_label(A, B, str(adj))
        d.segment_label(B, C, str(opp))
        d.segment_label(A, C, str(hyp))
        
        if angle_choice == 'sin':
            question = f"In right triangle $ABC$ with right angle at $B$, $BC = {opp}$ and $AC = {hyp}$. Find $\\angle A$ to the nearest degree."
            ans_rad = asin(Rational(opp, hyp))
            solution_text = steps(
                f"Use $\\sin(A) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}} = \\frac{{{opp}}}{{{hyp}}}$",
                f"$A = \\sin^{{-1}}\\left(\\frac{{{opp}}}{{{hyp}}}\\right)$",
                f"$A \\approx {round(float(ans_rad * 180 / pi))}°$"
            )
        elif angle_choice == 'cos':
            question = f"In right triangle $ABC$ with right angle at $B$, $AB = {adj}$ and $AC = {hyp}$. Find $\\angle A$ to the nearest degree."
            ans_rad = acos(Rational(adj, hyp))
            solution_text = steps(
                f"Use $\\cos(A) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}} = \\frac{{{adj}}}{{{hyp}}}$",
                f"$A = \\cos^{{-1}}\\left(\\frac{{{adj}}}{{{hyp}}}\\right)$",
                f"$A \\approx {round(float(ans_rad * 180 / pi))}°$"
            )
        else:  # tan
            question = f"In right triangle $ABC$ with right angle at $B$, $BC = {opp}$ and $AB = {adj}$. Find $\\angle A$ to the nearest degree."
            ans_rad = atan(Rational(opp, adj))
            solution_text = steps(
                f"Use $\\tan(A) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}} = \\frac{{{opp}}}{{{adj}}}$",
                f"$A = \\tan^{{-1}}\\left(\\frac{{{opp}}}{{{adj}}}\\right)$",
                f"$A \\approx {round(float(ans_rad * 180 / pi))}°$"
            )
        
        answer = round(float(ans_rad * 180 / pi))
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1400, 1600),
            topic="geometry/right_triangle_trig",
            solution=solution_text,
            image=d.render(),
            calculator="scientific"
        )
    
    else:  # word_problem
        # Simple word problem with right triangle
        scenarios = [
            ("ladder", "wall", "ground"),
            ("ramp", "platform", "ground"),
            ("wire", "pole", "ground")
        ]
        obj, vertical, horizontal = choice(scenarios)
        
        angle = choice([30, 45, 60])
        length = randint(10, 25)
        
        if angle == 30:
            height = length / 2
        elif angle == 45:
            height = length / sqrt(2)
        else:  # 60
            height = length * sqrt(3) / 2
        
        question = f"A {length}-foot {obj} leans against a {vertical}, making a ${angle}°$ angle with the {horizontal}. How high up the {vertical} does the {obj} reach? Round to the nearest tenth of a foot."
        
        solution_text = steps(
            f"The {obj} forms the hypotenuse of a right triangle",
            f"The height is the opposite side to the ${angle}°$ angle",
            f"Use $\\sin({angle}°) = \\frac{{\\text{{height}}}}{{{length}}}$",
            f"$\\text{{height}} = {length} \\cdot \\sin({angle}°) = {latex(height)}$",
            f"$\\text{{height}} \\approx {round(float(height), 1)}$ feet"
        )
        
        return problem(
            question=question,
            answer=round(float(height), 1),
            difficulty=(1400, 1600),
            topic="geometry/right_triangle_trig",
            solution=solution_text,
            calculator="scientific"
        )

emit(generate())