"""
geometry - pythagorean_theorem (medium)
Generated: 2026-02-22T04:17:38.809654
"""

from problem_utils import *
from svg_utils import Diagram

PRIMITIVE_TRIPLES = [
    (3,4,5),(5,12,13),(8,15,17),(7,24,25),(20,21,29),
    (9,40,41),(12,35,37),(11,60,61),(28,45,53),(36,77,85),
]

def random_triple(scale_min=1, scale_max=5):
    base = choice(PRIMITIVE_TRIPLES)
    k = randint(scale_min, scale_max)
    return base[0]*k, base[1]*k, base[2]*k

def generate():
    problem_type = choice(['find_hypotenuse', 'find_leg', 'find_leg_word', 'find_hyp_word', 'multi_step'])

    if problem_type == 'find_hypotenuse':
        # Scaled triple or non-triple irrational
        if randint(0,1):
            leg1, leg2, hyp = random_triple(scale_max=5)
            hyp_expr = hyp
        else:
            leg1 = randint(4, 15)
            leg2 = randint(4, 15)
            hyp_expr = sqrt(leg1**2 + leg2**2)
            hyp = hyp_expr

        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0,0),(leg1,0),(leg1,leg2)], labels=['C','B','A'])
        d.right_angle((leg1,0),(0,0),(leg1,leg2))
        d.segment_label((0,0),(leg1,0),str(leg1))
        d.segment_label((leg1,0),(leg1,leg2),str(leg2))
        d.segment_label((0,0),(leg1,leg2),'c')

        return problem(
            question=f"Find the length of the hypotenuse $c$ in the right triangle with legs of length ${leg1}$ and ${leg2}$.",
            answer=hyp_expr,
            difficulty=(1300, 1400),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + {leg2}^2 = c^2$",
                f"${leg1**2} + {leg2**2} = c^2$",
                f"${leg1**2 + leg2**2} = c^2$",
                f"$c = \\sqrt{{{leg1**2 + leg2**2}}} = {latex(hyp_expr)}$"
            ),
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 'find_leg':
        # Find a leg given hypotenuse and one leg
        if randint(0,1):
            leg1, leg2, hyp = random_triple(scale_max=5)
            given_leg, missing_leg = choice([(leg1, leg2), (leg2, leg1)])
            missing_expr = missing_leg
        else:
            given_leg = randint(4, 15)
            hyp = randint(given_leg + 2, given_leg + 15)
            missing_expr = sqrt(hyp**2 - given_leg**2)

        d = Diagram(width=300, height=250, padding=40)
        leg2_approx = float(missing_expr) if hasattr(missing_expr, 'evalf') else missing_expr
        d.polygon([(0,0),(given_leg,0),(given_leg,leg2_approx)], labels=['C','B','A'])
        d.right_angle((given_leg,0),(0,0),(given_leg,leg2_approx))
        d.segment_label((0,0),(given_leg,0),str(given_leg))
        d.segment_label((given_leg,0),(given_leg,leg2_approx),'b')
        d.segment_label((0,0),(given_leg,leg2_approx),str(hyp))

        return problem(
            question=f"Find the length of leg $b$ in a right triangle with hypotenuse ${hyp}$ and one leg of length ${given_leg}$.",
            answer=missing_expr,
            difficulty=(1400, 1500),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${given_leg}^2 + b^2 = {hyp}^2$",
                f"${given_leg**2} + b^2 = {hyp**2}$",
                f"$b^2 = {hyp**2} - {given_leg**2} = {hyp**2 - given_leg**2}$",
                f"$b = \\sqrt{{{hyp**2 - given_leg**2}}} = {latex(missing_expr)}$"
            ),
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 'find_leg_word':
        # Ladder word problem - find height
        leg1, leg2, hyp = random_triple(scale_max=4)
        # ground, height, ladder
        scenarios = [
            (leg1, leg2, hyp,
             f"A ${hyp}$-foot ladder leans against a wall. The base is ${leg1}$ feet from the wall. How high up the wall does the ladder reach?",
             "feet"),
            (leg2, leg1, hyp,
             f"A ${hyp}$-meter rope is stretched from the top of a pole to the ground. The rope is anchored ${leg2}$ meters from the base of the pole. How tall is the pole?",
             "meters"),
        ]
        ground, height, ladder, question_text, unit = choice(scenarios)

        return problem(
            question=question_text,
            answer=height,
            difficulty=(1500, 1600),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"This forms a right triangle with hypotenuse ${ladder}$ {unit} and one leg ${ground}$ {unit}",
                f"Let $h$ be the unknown leg",
                f"${ground}^2 + h^2 = {ladder}^2$",
                f"${ground**2} + h^2 = {ladder**2}$",
                f"$h^2 = {ladder**2} - {ground**2} = {ladder**2 - ground**2}$",
                f"$h = {height}$ {unit}"
            ),
            calculator="scientific"
        )

    elif problem_type == 'find_hyp_word':
        # Diagonal / distance word problem
        leg1, leg2, hyp = random_triple(scale_max=3)
        contexts = [
            ('rectangular field', leg1, leg2, hyp, 'meters', 'corner', 'opposite corner'),
            ('rectangular room', leg1, leg2, hyp, 'feet', 'corner', 'opposite corner'),
            ('city block', leg1, leg2, hyp, 'meters', 'one corner', 'the diagonally opposite corner'),
            ('rectangular swimming pool', leg1, leg2, hyp, 'meters', 'one end', 'the opposite corner'),
        ]
        ctx, w, l, d_ans, unit, p1, p2 = choice(contexts)

        return problem(
            question=f"A {ctx} measures ${w}$ {unit} by ${l}$ {unit}. What is the straight-line distance from {p1} to {p2}?",
            answer=d_ans,
            difficulty=(1400, 1500),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"The diagonal forms the hypotenuse of a right triangle with legs ${w}$ {unit} and ${l}$ {unit}",
                f"$d^2 = {w}^2 + {l}^2 = {w**2} + {l**2} = {w**2 + l**2}$",
                f"$d = \\sqrt{{{w**2 + l**2}}} = {d_ans}$ {unit}"
            ),
            calculator="scientific"
        )

    else:  # multi_step
        # Two-step: find diagonal of face, then use it as leg for space diagonal
        a_val = randint(2, 8)
        b_val = randint(2, 8)
        face_diag_sq = a_val**2 + b_val**2
        face_diag = sqrt(face_diag_sq)
        # Answer is just the face diagonal (simpler medium problem)
        return problem(
            question=f"A rectangle has sides ${a_val}$ and ${b_val}$. Find the length of the diagonal. Simplify your answer.",
            answer=face_diag,
            difficulty=(1350, 1450),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"The diagonal of a rectangle is the hypotenuse of a right triangle with legs ${a_val}$ and ${b_val}$",
                f"$d^2 = {a_val}^2 + {b_val}^2 = {a_val**2} + {b_val**2} = {face_diag_sq}$",
                f"$d = \\sqrt{{{face_diag_sq}}} = {latex(face_diag)}$"
            ),
            calculator="scientific"
        )

emit(generate())
