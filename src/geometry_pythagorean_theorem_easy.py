"""
geometry - pythagorean_theorem (easy)
Generated: 2026-02-22T04:17:13.145456
"""

from problem_utils import *
from svg_utils import Diagram

# Comprehensive list of primitive Pythagorean triples
PRIMITIVE_TRIPLES = [
    (3,4,5),(5,12,13),(8,15,17),(7,24,25),(20,21,29),
    (9,40,41),(12,35,37),(11,60,61),(13,84,85),(28,45,53),
    (36,77,85),(20,99,101),(60,11,61),(5,12,13),(8,15,17),
]

def random_triple(scale_max=5):
    base = choice(PRIMITIVE_TRIPLES)
    k = randint(1, scale_max)
    return base[0]*k, base[1]*k, base[2]*k

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # Given both legs, find hypotenuse - Pythagorean triple
        leg1, leg2, hyp = random_triple(scale_max=4)

        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0,0),(leg1,0),(leg1,leg2)], labels=['A','B','C'])
        d.right_angle((leg1,0),(0,0),(leg1,leg2))
        d.segment_label((0,0),(leg1,0),str(leg1))
        d.segment_label((leg1,0),(leg1,leg2),str(leg2))
        d.segment_label((leg1,leg2),(0,0),'c')

        return problem(
            question=f"A right triangle has legs of length ${leg1}$ and ${leg2}$. Find the length of the hypotenuse $c$.",
            answer=hyp,
            difficulty=(1000, 1100),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + {leg2}^2 = c^2$",
                f"${leg1**2} + {leg2**2} = c^2$",
                f"${leg1**2 + leg2**2} = c^2$",
                f"$c = \\sqrt{{{leg1**2 + leg2**2}}} = {hyp}$"
            ),
            image=d.render()
        )

    elif problem_type == 2:
        # Given hypotenuse and one leg, find other leg - Pythagorean triple
        leg1, leg2, hyp = random_triple(scale_max=4)
        # Randomly swap which leg is given
        if randint(0,1) == 0:
            given_leg, missing_leg = leg1, leg2
        else:
            given_leg, missing_leg = leg2, leg1

        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0,0),(given_leg,0),(given_leg,missing_leg)], labels=['A','B','C'])
        d.right_angle((given_leg,0),(0,0),(given_leg,missing_leg))
        d.segment_label((0,0),(given_leg,0),str(given_leg))
        d.segment_label((given_leg,0),(given_leg,missing_leg),'b')
        d.segment_label((given_leg,missing_leg),(0,0),str(hyp))

        return problem(
            question=f"A right triangle has one leg of length ${given_leg}$ and hypotenuse of length ${hyp}$. Find the length of the other leg $b$.",
            answer=missing_leg,
            difficulty=(1100, 1200),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${given_leg}^2 + b^2 = {hyp}^2$",
                f"${given_leg**2} + b^2 = {hyp**2}$",
                f"$b^2 = {hyp**2} - {given_leg**2} = {hyp**2 - given_leg**2}$",
                f"$b = \\sqrt{{{hyp**2 - given_leg**2}}} = {missing_leg}$"
            ),
            image=d.render()
        )

    elif problem_type == 3:
        # Given both legs (non-triple), find hypotenuse as simplified radical
        leg1 = randint(1, 9)
        leg2 = randint(1, 9)
        hyp_sq = leg1**2 + leg2**2
        ans = sqrt(hyp_sq)

        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0,0),(leg1,0),(leg1,leg2)], labels=['A','B','C'])
        d.right_angle((leg1,0),(0,0),(leg1,leg2))
        d.segment_label((0,0),(leg1,0),str(leg1))
        d.segment_label((leg1,0),(leg1,leg2),str(leg2))
        d.segment_label((leg1,leg2),(0,0),'c')

        return problem(
            question=f"A right triangle has legs of length ${leg1}$ and ${leg2}$. Find the length of the hypotenuse $c$. Simplify your answer.",
            answer=ans,
            difficulty=(1200, 1250),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + {leg2}^2 = c^2$",
                f"${leg1**2} + {leg2**2} = c^2$",
                f"${hyp_sq} = c^2$",
                f"$c = \\sqrt{{{hyp_sq}}} = {latex(ans)}$"
            ),
            image=d.render(),
            calculator="scientific"
        )

    else:
        # Word problem with scaled Pythagorean triple
        leg1, leg2, hyp = random_triple(scale_max=3)
        contexts = [
            (
                f"A ladder is leaning against a wall. The base of the ladder is ${leg1}$ feet from the wall, and the top of the ladder reaches ${leg2}$ feet up the wall. How long is the ladder?",
                hyp,
                "feet"
            ),
            (
                f"A rectangular TV screen is ${leg1}$ inches wide and ${leg2}$ inches tall. What is the length of the diagonal of the screen?",
                hyp,
                "inches"
            ),
            (
                f"A park has a rectangular field ${leg1}$ meters wide and ${leg2}$ meters long. What is the length of the diagonal path across the field?",
                hyp,
                "meters"
            ),
            (
                f"A boat travels ${leg1}$ km east then ${leg2}$ km north. How far is it from its starting point?",
                hyp,
                "km"
            ),
        ]
        question_text, ans, unit = choice(contexts)

        return problem(
            question=question_text,
            answer=ans,
            difficulty=(1250, 1300),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"This is a right triangle problem. Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + {leg2}^2 = c^2$",
                f"${leg1**2} + {leg2**2} = c^2$",
                f"${leg1**2 + leg2**2} = c^2$",
                f"$c = \\sqrt{{{leg1**2 + leg2**2}}} = {ans}$ {unit}"
            )
        )

emit(generate())
