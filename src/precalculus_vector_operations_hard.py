"""
precalculus - vector_operations (hard)
Generated: 2026-02-22T04:56:36.331053
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Cross product with parameter finding
        # Given vectors u and v, find parameter k such that u × v has specific property
        u1, u2, u3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        v1, v2 = nonzero(-3, 3), nonzero(-3, 3)
        
        # u = <u1, u2, u3>, v = <v1, v2, k>
        # Cross product: u × v = <u2*k - u3*v2, u3*v1 - u1*k, u1*v2 - u2*v1>
        # We'll ask: find k such that the z-component equals a target value
        
        z_component_base = u1*v2 - u2*v1
        target = nonzero(-10, 10)
        
        # Set up: we want k such that a specific component equals target
        # Let's use: the magnitude of the cross product equals some value
        # Or simpler: the y-component equals target
        # u3*v1 - u1*k = target
        # k = (u3*v1 - target) / u1
        
        ans_k = Rational(u3*v1 - target, u1)
        
        u_vec = Matrix([u1, u2, u3])
        v_vec = Matrix([v1, v2, k])
        
        return problem(
            question=f"Let $\\vec{{u}} = {latex(u_vec)}$ and $\\vec{{v}} = {latex(v_vec)}$. Find the value of $k$ such that the $y$-component of $\\vec{{u}} \\times \\vec{{v}}$ equals ${target}$.",
            answer=ans_k,
            difficulty=(1650, 1750),
            topic="precalculus/vector_operations",
            solution=steps(
                f"The cross product is $\\vec{{u}} \\times \\vec{{v}} = \\begin{{vmatrix}} \\vec{{i}} & \\vec{{j}} & \\vec{{k}} \\\\ {u1} & {u2} & {u3} \\\\ {v1} & {v2} & k \\end{{vmatrix}}$",
                f"$= \\vec{{i}}({u2} \\cdot k - {u3} \\cdot {v2}) - \\vec{{j}}({u1} \\cdot k - {u3} \\cdot {v1}) + \\vec{{k}}({u1} \\cdot {v2} - {u2} \\cdot {v1})$",
                f"The $y$-component is $-({u1}k - {u3*v1}) = {u3*v1} - {u1}k$",
                f"Set equal to ${target}$: ${u3*v1} - {u1}k = {target}$",
                f"${-u1}k = {target - u3*v1}$",
                f"$k = {latex(ans_k)}$"
            )
        )
    
    elif problem_type == 2:
        # Projection and orthogonal decomposition
        # Decompose vector a into components parallel and perpendicular to b
        a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        b1, b2, b3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        
        a_vec = Matrix([a1, a2, a3])
        b_vec = Matrix([b1, b2, b3])
        
        # proj_b(a) = ((a·b)/(b·b)) * b
        dot_ab = a1*b1 + a2*b2 + a3*b3
        dot_bb = b1*b1 + b2*b2 + b3*b3
        
        scalar = Rational(dot_ab, dot_bb)
        proj = scalar * b_vec
        perp = a_vec - proj
        
        # Ask for the perpendicular component
        ans = perp
        
        return problem(
            question=f"Find the component of $\\vec{{a}} = {latex(a_vec)}$ that is orthogonal to $\\vec{{b}} = {latex(b_vec)}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/vector_operations",
            answer_type="matrix",
            solution=steps(
                f"First find the projection: $\\text{{proj}}_{{\\vec{{b}}}}(\\vec{{a}}) = \\frac{{\\vec{{a}} \\cdot \\vec{{b}}}}{{\\vec{{b}} \\cdot \\vec{{b}}}} \\vec{{b}}$",
                f"$\\vec{{a}} \\cdot \\vec{{b}} = {a1}({b1}) + {a2}({b2}) + {a3}({b3}) = {dot_ab}$",
                f"$\\vec{{b}} \\cdot \\vec{{b}} = {b1}^2 + {b2}^2 + {b3}^2 = {dot_bb}$",
                f"$\\text{{proj}}_{{\\vec{{b}}}}(\\vec{{a}}) = {latex(scalar)} {latex(b_vec)} = {latex(proj)}$",
                f"The orthogonal component is $\\vec{{a}} - \\text{{proj}}_{{\\vec{{b}}}}(\\vec{{a}}) = {latex(a_vec)} - {latex(proj)} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Triple scalar product and volume
        # Given three vectors, find the volume of parallelepiped
        u1, u2, u3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        v1, v2, v3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        w1, w2, w3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        u_vec = Matrix([u1, u2, u3])
        v_vec = Matrix([v1, v2, v3])
        w_vec = Matrix([w1, w2, w3])
        
        # Volume = |u · (v × w)|
        det_val = u1*(v2*w3 - v3*w2) - u2*(v1*w3 - v3*w1) + u3*(v1*w2 - v2*w1)
        ans = abs(det_val)
        
        return problem(
            question=f"Find the volume of the parallelepiped determined by the vectors $\\vec{{u}} = {latex(u_vec)}$, $\\vec{{v}} = {latex(v_vec)}$, and $\\vec{{w}} = {latex(w_vec)}$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="precalculus/vector_operations",
            solution=steps(
                f"The volume is $|\\vec{{u}} \\cdot (\\vec{{v}} \\times \\vec{{w}})|$, which equals the absolute value of the determinant:",
                f"$\\begin{{vmatrix}} {u1} & {u2} & {u3} \\\\ {v1} & {v2} & {v3} \\\\ {w1} & {w2} & {w3} \\end{{vmatrix}}$",
                f"$= {u1}({v2*w3 - v3*w2}) - {u2}({v1*w3 - v3*w1}) + {u3}({v1*w2 - v2*w1})$",
                f"$= {u1}({v2*w3 - v3*w2}) - {u2}({v1*w3 - v3*w1}) + {u3}({v1*w2 - v2*w1})$",
                f"$= {det_val}$",
                f"Volume $= |{det_val}| = {ans}$"
            )
        )
    
    elif problem_type == 4:
        # Angle between vectors in different forms
        # Find angle given dot product constraint
        a1, a2 = nonzero(-4, 4), nonzero(-4, 4)
        b1, b2 = nonzero(-4, 4), nonzero(-4, 4)
        
        # ||a|| and ||b||
        mag_a_sq = a1**2 + a2**2
        mag_b_sq = b1**2 + b2**2
        mag_a = sqrt(mag_a_sq)
        mag_b = sqrt(mag_b_sq)
        
        # Compute actual dot product
        dot_prod = a1*b1 + a2*b2
        
        # cos(theta) = dot_prod / (mag_a * mag_b)
        cos_theta = Rational(dot_prod, 1) / (mag_a * mag_b)
        
        # Simplify and find angle
        theta_rad = acos(cos_theta)
        
        a_vec = Matrix([a1, a2])
        b_vec = Matrix([b1, b2])
        
        ans = simplify(theta_rad)
        
        return problem(
            question=f"Find the angle (in radians) between the vectors $\\vec{{a}} = {latex(a_vec)}$ and $\\vec{{b}} = {latex(b_vec)}$. Give your answer in exact form.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Use the formula $\\cos(\\theta) = \\frac{{\\vec{{a}} \\cdot \\vec{{b}}}}{{||\\vec{{a}}|| \\cdot ||\\vec{{b}}||}}$",
                f"$\\vec{{a}} \\cdot \\vec{{b}} = {a1}({b1}) + {a2}({b2}) = {dot_prod}$",
                f"$||\\vec{{a}}|| = \\sqrt{{{a1}^2 + {a2}^2}} = \\sqrt{{{mag_a_sq}}} = {latex(mag_a)}$",
                f"$||\\vec{{b}}|| = \\sqrt{{{b1}^2 + {b2}^2}} = \\sqrt{{{mag_b_sq}}} = {latex(mag_b)}$",
                f"$\\cos(\\theta) = \\frac{{{dot_prod}}}{{{latex(mag_a * mag_b)}}} = {latex(cos_theta)}$",
                f"$\\theta = \\arccos\\left({latex(cos_theta)}\\right) = {latex(ans)}$"
            )
        )
    
    else:  # problem_type == 5
        # Vector equation with cross product
        # Find vector x such that a × x = b, given that x is perpendicular to c
        a1, a2, a3 = nonzero(-3, 3), nonzero(-3, 3), 0  # Make a in xy-plane for solvability
        
        # Choose b perpendicular to a
        b1, b2, b3 = -a2, a1, nonzero(-4, 4)
        
        # We need to find x such that a × x = b
        # This is solvable when b ⊥ a (which we ensured)
        
        a_vec = Matrix([a1, a2, a3])
        b_vec = Matrix([b1, b2, b3])
        
        # One solution: x = (a × b) / ||a||^2
        cross_ab = a_vec.cross(b_vec)
        mag_a_sq = a1**2 + a2**2 + a3**2
        
        ans = cross_ab / mag_a_sq
        
        return problem(
            question=f"Find a vector $\\vec{{x}}$ such that $\\vec{{a}} \\times \\vec{{x}} = \\vec{{b}}$, where $\\vec{{a}} = {latex(a_vec)}$ and $\\vec{{b}} = {latex(b_vec)}$. (Give the solution with smallest magnitude.)",
            answer=ans,
            difficulty=(1750, 1850),
            topic="precalculus/vector_operations",
            answer_type="matrix",
            solution=steps(
                f"For $\\vec{{a}} \\times \\vec{{x}} = \\vec{{b}}$ to have a solution, we need $\\vec{{b}} \\perp \\vec{{a}}$",
                f"Check: $\\vec{{a}} \\cdot \\vec{{b}} = {a1}({b1}) + {a2}({b2}) + {a3}({b3}) = {a1*b1 + a2*b2 + a3*b3}$ ✓",
                f"The solution with smallest magnitude is $\\vec{{x}} = \\frac{{\\vec{{a}} \\times \\vec{{b}}}}{{||\\vec{{a}}||^2}}$",
                f"$\\vec{{a}} \\times \\vec{{b}} = {latex(cross_ab)}$",
                f"$||\\vec{{a}}||^2 = {a1}^2 + {a2}^2 + {a3}^2 = {mag_a_sq}$",
                f"$\\vec{{x}} = {latex(ans)}$"
            )
        )

emit(generate())