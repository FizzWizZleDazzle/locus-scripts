"""
precalculus - dot_cross_product (medium)
Generated: 2026-02-22T04:57:30.675189
"""

from problem_utils import *

def generate():
    problem_type = choice(['dot_product_2d', 'dot_product_3d', 'cross_product_3d', 
                          'angle_between', 'orthogonal_check', 'projection'])
    
    if problem_type == 'dot_product_2d':
        # 2D dot product calculation
        v1 = [nonzero(-5, 5), nonzero(-5, 5)]
        v2 = [nonzero(-5, 5), nonzero(-5, 5)]
        ans = v1[0]*v2[0] + v1[1]*v2[1]
        
        return problem(
            question=f"Calculate the dot product of $\\vec{{u}} = \\langle {v1[0]}, {v1[1]} \\rangle$ and $\\vec{{v}} = \\langle {v2[0]}, {v2[1]} \\rangle$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({v1[0]})({v2[0]}) + ({v1[1]})({v2[1]})$",
                f"$= {v1[0]*v2[0]} + {v1[1]*v2[1]}$",
                f"$= {ans}$"
            )
        )
    
    elif problem_type == 'dot_product_3d':
        # 3D dot product calculation
        v1 = [nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)]
        v2 = [nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)]
        ans = v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2]
        
        return problem(
            question=f"Calculate the dot product of $\\vec{{u}} = \\langle {v1[0]}, {v1[1]}, {v1[2]} \\rangle$ and $\\vec{{v}} = \\langle {v2[0]}, {v2[1]}, {v2[2]} \\rangle$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({v1[0]})({v2[0]}) + ({v1[1]})({v2[1]}) + ({v1[2]})({v2[2]})$",
                f"$= {v1[0]*v2[0]} + {v1[1]*v2[1]} + {v1[2]*v2[2]}$",
                f"$= {ans}$"
            )
        )
    
    elif problem_type == 'cross_product_3d':
        # 3D cross product - use smaller numbers for cleaner results
        v1 = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
        v2 = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
        
        # Calculate cross product components
        i_comp = v1[1]*v2[2] - v1[2]*v2[1]
        j_comp = -(v1[0]*v2[2] - v1[2]*v2[0])
        k_comp = v1[0]*v2[1] - v1[1]*v2[0]
        
        ans = Matrix([i_comp, j_comp, k_comp])
        
        return problem(
            question=f"Calculate the cross product $\\vec{{u}} \\times \\vec{{v}}$ where $\\vec{{u}} = \\langle {v1[0]}, {v1[1]}, {v1[2]} \\rangle$ and $\\vec{{v}} = \\langle {v2[0]}, {v2[1]}, {v2[2]} \\rangle$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Using the cross product formula:",
                f"$\\vec{{u}} \\times \\vec{{v}} = \\begin{{vmatrix}} \\vec{{i}} & \\vec{{j}} & \\vec{{k}} \\\\ {v1[0]} & {v1[1]} & {v1[2]} \\\\ {v2[0]} & {v2[1]} & {v2[2]} \\end{{vmatrix}}$",
                f"$= \\vec{{i}}({v1[1]} \\cdot {v2[2]} - {v1[2]} \\cdot {v2[1]}) - \\vec{{j}}({v1[0]} \\cdot {v2[2]} - {v1[2]} \\cdot {v2[0]}) + \\vec{{k}}({v1[0]} \\cdot {v2[1]} - {v1[1]} \\cdot {v2[0]})$",
                f"$= \\vec{{i}}({i_comp}) - \\vec{{j}}({-j_comp}) + \\vec{{k}}({k_comp})$",
                f"$= \\langle {i_comp}, {j_comp}, {k_comp} \\rangle$"
            )
        )
    
    elif problem_type == 'angle_between':
        # Angle between two vectors - construct to get nice angles
        angles_deg = [30, 45, 60, 90, 120, 135, 150]
        theta_deg = choice(angles_deg)
        theta_rad = theta_deg * 3.14159 / 180
        
        # Create vectors with controlled dot product
        mag_u = randint(2, 4)
        mag_v = randint(2, 4)
        dot_prod = int(mag_u * mag_v * cos(theta_rad * pi / 3.14159))
        
        # Construct specific vectors
        v1 = [mag_u, 0, 0]
        v2 = [dot_prod // mag_u, randint(1, 3), 0]
        
        actual_dot = v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2]
        mag_u_calc = sqrt(v1[0]**2 + v1[1]**2 + v1[2]**2)
        mag_v_calc = sqrt(v2[0]**2 + v2[1]**2 + v2[2]**2)
        
        cos_theta = actual_dot / (mag_u_calc * mag_v_calc)
        ans = acos(cos_theta)
        
        return problem(
            question=f"Find the angle (in radians) between vectors $\\vec{{u}} = \\langle {v1[0]}, {v1[1]}, {v1[2]} \\rangle$ and $\\vec{{v}} = \\langle {v2[0]}, {v2[1]}, {v2[2]} \\rangle$. Round to three decimal places if necessary.",
            answer=ans.evalf(4),
            difficulty=(1500, 1600),
            topic="precalculus/dot_cross_product",
            calculator="scientific",
            solution=steps(
                f"Use the formula $\\cos(\\theta) = \\frac{{\\vec{{u}} \\cdot \\vec{{v}}}}{{||\\vec{{u}}|| \\cdot ||\\vec{{v}}||}}$",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = {actual_dot}$",
                f"$||\\vec{{u}}|| = {latex(mag_u_calc)}$, $||\\vec{{v}}|| = {latex(mag_v_calc)}$",
                f"$\\cos(\\theta) = {latex(cos_theta)}$",
                f"$\\theta = {latex(ans.evalf(4))}$ radians"
            )
        )
    
    elif problem_type == 'orthogonal_check':
        # Check if vectors are orthogonal (dot product = 0)
        is_orthogonal = choice([True, False])
        
        if is_orthogonal:
            # Make orthogonal vectors
            a1, a2 = nonzero(-4, 4), nonzero(-4, 4)
            # Choose b1, b2 such that a1*b1 + a2*b2 = 0
            b1 = nonzero(-4, 4)
            b2 = -(a1 * b1) // a2 if a2 != 0 else nonzero(-4, 4)
            # Verify orthogonality
            if a1*b1 + a2*b2 != 0:
                b2 = -a2
                b1 = a1
        else:
            a1, a2 = nonzero(-4, 4), nonzero(-4, 4)
            b1, b2 = nonzero(-4, 4), nonzero(-4, 4)
            # Make sure they're not orthogonal
            if a1*b1 + a2*b2 == 0:
                b2 = b2 + 1
        
        dot_prod = a1*b1 + a2*b2
        ans = (dot_prod == 0)
        
        return problem(
            question=f"Are the vectors $\\vec{{u}} = \\langle {a1}, {a2} \\rangle$ and $\\vec{{v}} = \\langle {b1}, {b2} \\rangle$ orthogonal?",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Two vectors are orthogonal if their dot product is zero.",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({a1})({b1}) + ({a2})({b2}) = {dot_prod}$",
                f"Since the dot product is {'zero' if ans else 'not zero'}, the vectors are {'orthogonal' if ans else 'not orthogonal'}."
            )
        )
    
    else:  # projection
        # Scalar projection of u onto v
        v1 = [nonzero(-4, 4), nonzero(-4, 4)]
        v2 = [nonzero(-3, 3), nonzero(-3, 3)]
        
        dot_prod = v1[0]*v2[0] + v1[1]*v2[1]
        mag_v = sqrt(v2[0]**2 + v2[1]**2)
        ans = dot_prod / mag_v
        
        return problem(
            question=f"Find the scalar projection of $\\vec{{u}} = \\langle {v1[0]}, {v1[1]} \\rangle$ onto $\\vec{{v}} = \\langle {v2[0]}, {v2[1]} \\rangle$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/dot_cross_product",
            calculator="scientific",
            solution=steps(
                f"The scalar projection is $\\text{{comp}}_{{\\vec{{v}}}}\\vec{{u}} = \\frac{{\\vec{{u}} \\cdot \\vec{{v}}}}{{||\\vec{{v}}||}}$",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({v1[0]})({v2[0]}) + ({v1[1]})({v2[1]}) = {dot_prod}$",
                f"$||\\vec{{v}}|| = \\sqrt{{{v2[0]}^2 + {v2[1]}^2}} = {latex(mag_v)}$",
                f"$\\text{{comp}}_{{\\vec{{v}}}}\\vec{{u}} = \\frac{{{dot_prod}}}{{{latex(mag_v)}}} = {latex(ans)}$"
            )
        )

emit(generate())