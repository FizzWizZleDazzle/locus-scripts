"""
geometry - triangle_congruence (hard)
Generated: 2026-02-22T04:07:23.965949
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['cpctc', 'proof_step', 'corresponding_parts', 'multiple_triangles'])
    
    if problem_type == 'cpctc':
        # Given congruent triangles, find a missing measurement using CPCTC
        triangle1 = choice(['ABC', 'DEF', 'PQR', 'XYZ'])
        triangle2 = choice(['MNO', 'STU', 'JKL', 'UVW'])
        
        congruence_type = choice(['SSS', 'SAS', 'ASA', 'AAS'])
        
        # Set up corresponding vertices
        vertex_map = {
            triangle1[0]: triangle2[0],
            triangle1[1]: triangle2[1],
            triangle1[2]: triangle2[2]
        }
        
        # Choose what to find
        element_type = choice(['side', 'angle'])
        
        if element_type == 'side':
            side_idx = randint(0, 2)
            side1 = triangle1[side_idx] + triangle1[(side_idx+1)%3]
            side2 = triangle2[side_idx] + triangle2[(side_idx+1)%3]
            
            # Give value for one side, ask for corresponding
            known_value = randint(8, 20)
            
            # Add an algebraic expression for the unknown side
            coeff = randint(2, 4)
            const = randint(-5, 5)
            expr = coeff * x + const
            
            # The answer is solving the equation
            ans = solve(Eq(expr, known_value), x)[0]
            
            question = f"Given $\\triangle {triangle1} \\cong \\triangle {triangle2}$ by {congruence_type}. "
            question += f"If ${side1} = {known_value}$ and ${side2} = {latex(expr)}$, find the value of $x$."
            
            solution = steps(
                f"Since $\\triangle {triangle1} \\cong \\triangle {triangle2}$, corresponding parts are congruent (CPCTC)",
                f"${side1} \\cong {side2}$",
                f"${known_value} = {latex(expr)}$",
                f"${latex(expr)} = {known_value}$",
                f"${latex(coeff*x)} = {known_value - const}$",
                f"$x = {ans}$"
            )
            
            difficulty = (1600, 1750)
            
        else:  # angle
            angle_idx = randint(0, 2)
            angle1 = triangle1[angle_idx]
            angle2 = triangle2[angle_idx]
            
            # Create algebraic expressions for both angles that should be equal
            coeff1 = randint(2, 5)
            const1 = randint(10, 30)
            expr1 = coeff1 * x + const1
            
            coeff2 = randint(2, 5)
            const2 = randint(10, 30)
            while coeff2 == coeff1:
                coeff2 = randint(2, 5)
            expr2 = coeff2 * x + const2
            
            ans = solve(Eq(expr1, expr2), x)[0]
            
            question = f"Given $\\triangle {triangle1} \\cong \\triangle {triangle2}$ by {congruence_type}. "
            question += f"If $m\\angle {angle1} = {latex(expr1)}^\\circ$ and $m\\angle {angle2} = {latex(expr2)}^\\circ$, find the value of $x$."
            
            solution = steps(
                f"Since $\\triangle {triangle1} \\cong \\triangle {triangle2}$, corresponding angles are congruent (CPCTC)",
                f"$\\angle {angle1} \\cong \\angle {angle2}$",
                f"${latex(expr1)} = {latex(expr2)}$",
                f"${latex(expr1 - expr2)} = 0$",
                f"${latex(simplify(expr1 - expr2))} = 0$",
                f"$x = {ans}$"
            )
            
            difficulty = (1650, 1800)
    
    elif problem_type == 'proof_step':
        # Given information, determine which congruence theorem applies
        triangle1 = 'ABC'
        triangle2 = 'DEF'
        
        # Create a scenario with given information
        scenario = choice([
            ('SSS', ['AB \\cong DE', 'BC \\cong EF', 'AC \\cong DF']),
            ('SAS', ['AB \\cong DE', '\\angle B \\cong \\angle E', 'BC \\cong EF']),
            ('ASA', ['\\angle A \\cong \\angle D', 'AB \\cong DE', '\\angle B \\cong \\angle E']),
            ('AAS', ['\\angle A \\cong \\angle D', '\\angle B \\cong \\angle E', 'BC \\cong EF']),
            ('HL', ['\\angle C \\cong \\angle F \\text{ (both right angles)}', 'AC \\cong DF', 'AB \\cong DE'])
        ])
        
        ans_theorem = scenario[0]
        given_info = scenario[1]
        
        # Ask which theorem to use
        question = f"Given the following about $\\triangle ABC$ and $\\triangle DEF$:<br>"
        for info in given_info:
            question += f"$\\bullet$ ${info}$<br>"
        question += "Which congruence theorem proves $\\triangle ABC \\cong \\triangle DEF$?"
        
        solution = steps(
            f"Analyze the given information:",
            *[f"${info}$" for info in given_info],
            f"This matches the {ans_theorem} congruence theorem",
            f"Therefore, $\\triangle ABC \\cong \\triangle DEF$ by {ans_theorem}"
        )
        
        ans = ans_theorem
        difficulty = (1600, 1700)
        
    elif problem_type == 'corresponding_parts':
        # More complex: overlapping triangles or shared sides
        use_diagram = choice([True, False])
        
        if use_diagram:
            # Create a diagram with overlapping triangles
            d = Diagram(width=400, height=300, padding=50)
            
            # Points for two triangles sharing a side
            A = (0, 0)
            B = (8, 0)
            C = (4, 6)
            D = (4, -2)
            
            d.polygon([A, B, C], labels=['A', 'B', 'C'])
            d.polygon([A, B, D], labels=['A', 'B', 'D'])
            
            # Mark some equal sides
            d.tick_marks(A, C, 1)
            d.tick_marks(B, D, 1)
            
            given_angle = randint(45, 75)
            d.text(1, 0.5, f"{given_angle}°")
            
            question = f"In the diagram, $AC \\cong BD$, $AB$ is shared, and $\\angle CAB \\cong \\angle DBA = {given_angle}^\\circ$. "
            question += f"If $BC = {randint(10, 18)}$, what theorem proves $\\triangle ABC \\cong \\triangle BAD$, and what is $AD$?"
            
            bc_val = randint(10, 18)
            ans = f"SAS, {bc_val}"
            
            solution = steps(
                "Identify the given information:",
                f"$AC \\cong BD$ (given)",
                f"$AB \\cong AB$ (reflexive property - shared side)",
                f"$\\angle CAB \\cong \\angle DBA$ (given)",
                "This is Side-Angle-Side (SAS)",
                f"By CPCTC, $BC \\cong AD$",
                f"Therefore $AD = {bc_val}$"
            )
            
            difficulty = (1700, 1850)
            
            return problem(
                question=question,
                answer=ans,
                difficulty=difficulty,
                topic="geometry/triangle_congruence",
                solution=solution,
                image=d.render(),
                answer_type="text"
            )
        else:
            # Word problem about overlapping triangles
            A, B, C, D = 'A', 'B', 'C', 'D'
            
            side_val = randint(12, 25)
            angle_val = randint(40, 80)
            
            question = f"Quadrilateral $ABCD$ has diagonals $AC$ and $BD$ intersecting at point $E$. "
            question += f"Given that $AE \\cong CE$, $BE \\cong DE$, and $\\angle AEB \\cong \\angle CED$ (vertical angles). "
            question += f"If $AB = {side_val}$ and you need to prove $AB \\cong CD$, which triangles must be proven congruent "
            question += f"and by which theorem?"
            
            ans = "Triangle AEB and Triangle CED, SAS"
            
            solution = steps(
                "To prove $AB \\cong CD$, we need those as corresponding parts",
                "Consider $\\triangle AEB$ and $\\triangle CED$:",
                "$AE \\cong CE$ (given)",
                "$\\angle AEB \\cong \\angle CED$ (vertical angles)",
                "$BE \\cong DE$ (given)",
                "By SAS, $\\triangle AEB \\cong \\triangle CED$",
                "By CPCTC, $AB \\cong CD$"
            )
            
            difficulty = (1750, 1900)
            
            return problem(
                question=question,
                answer=ans,
                difficulty=difficulty,
                topic="geometry/triangle_congruence",
                solution=solution,
                answer_type="text"
            )
    
    else:  # multiple_triangles
        # Chain of congruent triangles
        val1 = randint(15, 30)
        val2 = randint(8, 15)
        
        question = f"Given: $\\triangle ABC \\cong \\triangle DEF$ and $\\triangle DEF \\cong \\triangle GHI$ by SAS. "
        question += f"If $AB = {val1}$, $BC = {val2}$, and $HI = 3x - 5$, find $x$."
        
        # HI corresponds to BC in the chain
        # BC = HI, so val2 = 3x - 5
        ans = solve(Eq(3*x - 5, val2), x)[0]
        
        solution = steps(
            "Use the transitive property of congruence:",
            "$\\triangle ABC \\cong \\triangle DEF$ and $\\triangle DEF \\cong \\triangle GHI$",
            "Therefore $\\triangle ABC \\cong \\triangle GHI$",
            f"By CPCTC, $BC \\cong HI$",
            f"${val2} = 3x - 5$",
            f"$3x = {val2 + 5}$",
            f"$x = {ans}$"
        )
        
        difficulty = (1700, 1850)
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty,
        topic="geometry/triangle_congruence",
        solution=solution
    )

emit(generate())