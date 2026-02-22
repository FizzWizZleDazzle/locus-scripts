"""
geometry - pythagorean_theorem (medium)
Generated: 2026-02-22T04:17:38.809654
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['find_hypotenuse', 'find_leg', 'find_leg_word', 'find_hypotenuse_word'])
    
    if problem_type == 'find_hypotenuse':
        # Generate a Pythagorean triple or near-triple
        use_triple = choice([True, False])
        if use_triple:
            triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25)]
            base_triple = choice(triples)
            multiplier = randint(1, 3)
            leg1 = base_triple[0] * multiplier
            leg2 = base_triple[1] * multiplier
            hyp = base_triple[2] * multiplier
        else:
            leg1 = randint(3, 12)
            leg2 = randint(3, 12)
            hyp = sqrt(leg1**2 + leg2**2)
        
        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0, 0), (leg1, 0), (leg1, leg2)], labels=['C', 'B', 'A'])
        d.right_angle((leg1, 0), (0, 0), (leg1, leg2))
        d.segment_label((0, 0), (leg1, 0), str(leg1))
        d.segment_label((leg1, 0), (leg1, leg2), str(leg2))
        d.segment_label((0, 0), (leg1, leg2), 'c')
        
        return problem(
            question=f"Find the length of the hypotenuse $c$ in the right triangle with legs of length ${leg1}$ and ${leg2}$.",
            answer=hyp,
            difficulty=(1300, 1400),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + {leg2}^2 = c^2$",
                f"${leg1**2} + {leg2**2} = c^2$",
                f"${leg1**2 + leg2**2} = c^2$",
                f"$c = \\sqrt{{{leg1**2 + leg2**2}}} = {latex(hyp)}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'find_leg':
        # Find a leg given hypotenuse and other leg
        use_triple = choice([True, False])
        if use_triple:
            triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25)]
            base_triple = choice(triples)
            multiplier = randint(1, 3)
            leg1 = base_triple[0] * multiplier
            leg2 = base_triple[1] * multiplier
            hyp = base_triple[2] * multiplier
        else:
            leg1 = randint(3, 10)
            hyp = randint(leg1 + 1, leg1 + 8)
            leg2 = sqrt(hyp**2 - leg1**2)
        
        d = Diagram(width=300, height=250, padding=40)
        # Estimate leg2 for diagram purposes
        leg2_approx = float(leg2) if not leg2.is_Integer else leg2
        d.polygon([(0, 0), (leg1, 0), (leg1, leg2_approx)], labels=['C', 'B', 'A'])
        d.right_angle((leg1, 0), (0, 0), (leg1, leg2_approx))
        d.segment_label((0, 0), (leg1, 0), str(leg1))
        d.segment_label((leg1, 0), (leg1, leg2_approx), 'b')
        d.segment_label((0, 0), (leg1, leg2_approx), str(hyp))
        
        return problem(
            question=f"Find the length of leg $b$ in a right triangle with hypotenuse ${hyp}$ and one leg of length ${leg1}$.",
            answer=leg2,
            difficulty=(1400, 1500),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + b^2 = {hyp}^2$",
                f"${leg1**2} + b^2 = {hyp**2}$",
                f"$b^2 = {hyp**2} - {leg1**2} = {hyp**2 - leg1**2}$",
                f"$b = \\sqrt{{{hyp**2 - leg1**2}}} = {latex(leg2)}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'find_leg_word':
        # Word problem: ladder against wall
        triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17)]
        base_triple = choice(triples)
        multiplier = randint(1, 2)
        ground = base_triple[0] * multiplier
        ladder = base_triple[2] * multiplier
        height = base_triple[1] * multiplier
        
        return problem(
            question=f"A ${ladder}$-foot ladder is leaning against a wall. The base of the ladder is ${ground}$ feet from the wall. How high up the wall does the ladder reach?",
            answer=height,
            difficulty=(1500, 1600),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"This forms a right triangle with hypotenuse ${ladder}$ ft (ladder) and one leg ${ground}$ ft (ground distance)",
                f"Let $h$ be the height on the wall",
                f"${ground}^2 + h^2 = {ladder}^2$",
                f"${ground**2} + h^2 = {ladder**2}$",
                f"$h^2 = {ladder**2} - {ground**2} = {ladder**2 - ground**2}$",
                f"$h = {height}$ feet"
            ),
            calculator="scientific"
        )
    
    else:  # find_hypotenuse_word
        # Word problem: diagonal distance
        triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17)]
        base_triple = choice(triples)
        multiplier = randint(1, 2)
        width = base_triple[0] * multiplier
        length = base_triple[1] * multiplier
        diagonal = base_triple[2] * multiplier
        
        context = choice([
            ('rectangular field', 'corner', 'opposite corner'),
            ('rectangular room', 'corner', 'opposite corner'),
            ('city block', 'corner', 'opposite corner')
        ])
        
        return problem(
            question=f"A {context[0]} measures ${width}$ meters by ${length}$ meters. What is the straight-line distance from one {context[1]} to the {context[2]}?",
            answer=diagonal,
            difficulty=(1400, 1500),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"The diagonal forms the hypotenuse of a right triangle with legs ${width}$ m and ${length}$ m",
                f"Use the Pythagorean theorem: $d^2 = {width}^2 + {length}^2$",
                f"$d^2 = {width**2} + {length**2}$",
                f"$d^2 = {width**2 + length**2}$",
                f"$d = {diagonal}$ meters"
            ),
            calculator="scientific"
        )

emit(generate())