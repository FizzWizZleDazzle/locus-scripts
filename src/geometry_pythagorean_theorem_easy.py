"""
geometry - pythagorean_theorem (easy)
Generated: 2026-02-22T04:17:13.145456
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    # For ELO 1000-1300, we want simple Pythagorean theorem problems
    # We'll vary the difficulty within this range
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # ELO ~1000-1100: Given both legs, find hypotenuse with Pythagorean triple
        triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (6, 8, 10)]
        leg1, leg2, hyp = choice(triples)
        
        # Create diagram
        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0, 0), (leg1, 0), (leg1, leg2)], labels=['A', 'B', 'C'])
        d.right_angle((leg1, 0), (0, 0), (leg1, leg2))
        d.segment_label((0, 0), (leg1, 0), str(leg1))
        d.segment_label((leg1, 0), (leg1, leg2), str(leg2))
        d.segment_label((leg1, leg2), (0, 0), 'c')
        
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
        # ELO ~1100-1200: Given hypotenuse and one leg, find other leg with Pythagorean triple
        triples = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (6, 8, 10)]
        leg1, leg2, hyp = choice(triples)
        
        # Create diagram
        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0, 0), (leg1, 0), (leg1, leg2)], labels=['A', 'B', 'C'])
        d.right_angle((leg1, 0), (0, 0), (leg1, leg2))
        d.segment_label((0, 0), (leg1, 0), str(leg1))
        d.segment_label((leg1, 0), (leg1, leg2), 'b')
        d.segment_label((leg1, leg2), (0, 0), str(hyp))
        
        return problem(
            question=f"A right triangle has one leg of length ${leg1}$ and hypotenuse of length ${hyp}$. Find the length of the other leg $b$.",
            answer=leg2,
            difficulty=(1100, 1200),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + b^2 = {hyp}^2$",
                f"${leg1**2} + b^2 = {hyp**2}$",
                f"$b^2 = {hyp**2} - {leg1**2}$",
                f"$b^2 = {hyp**2 - leg1**2}$",
                f"$b = \\sqrt{{{hyp**2 - leg1**2}}} = {leg2}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # ELO ~1200-1250: Given both legs, find hypotenuse (non-triple, requires simplification)
        leg1 = randint(1, 4)
        leg2 = randint(1, 4)
        hyp_squared = leg1**2 + leg2**2
        ans = sqrt(hyp_squared)
        
        # Create diagram
        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0, 0), (leg1, 0), (leg1, leg2)], labels=['A', 'B', 'C'])
        d.right_angle((leg1, 0), (0, 0), (leg1, leg2))
        d.segment_label((0, 0), (leg1, 0), str(leg1))
        d.segment_label((leg1, 0), (leg1, leg2), str(leg2))
        d.segment_label((leg1, leg2), (0, 0), 'c')
        
        return problem(
            question=f"A right triangle has legs of length ${leg1}$ and ${leg2}$. Find the length of the hypotenuse $c$. Simplify your answer.",
            answer=ans,
            difficulty=(1200, 1250),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the Pythagorean theorem: $a^2 + b^2 = c^2$",
                f"${leg1}^2 + {leg2}^2 = c^2$",
                f"${leg1**2} + {leg2**2} = c^2$",
                f"${hyp_squared} = c^2$",
                f"$c = \\sqrt{{{hyp_squared}}} = {latex(ans)}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    else:
        # ELO ~1250-1300: Word problem with Pythagorean triple
        triples = [(3, 4, 5), (5, 12, 13), (6, 8, 10)]
        leg1, leg2, hyp = choice(triples)
        
        contexts = [
            (f"A ladder is leaning against a wall. The base of the ladder is ${leg1}$ feet from the wall, and the top of the ladder reaches ${leg2}$ feet up the wall. How long is the ladder?", hyp),
            (f"A rectangular TV screen is ${leg1}$ feet wide and ${leg2}$ feet tall. What is the diagonal length of the screen?", hyp),
        ]
        
        question_text, ans = choice(contexts)
        
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
                f"$c = \\sqrt{{{leg1**2 + leg2**2}}} = {ans}$ feet"
            )
        )

emit(generate())