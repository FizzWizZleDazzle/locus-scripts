"""
precalculus - dot_cross_product (hard)
Generated: 2026-02-22T04:57:59.878116
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Dot product with finding angle between vectors in 3D
        a1, a2, a3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        b1, b2, b3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        
        vec_a = Matrix([a1, a2, a3])
        vec_b = Matrix([b1, b2, b3])
        
        dot_prod = vec_a.dot(vec_b)
        mag_a = sqrt(a1**2 + a2**2 + a3**2)
        mag_b = sqrt(b1**2 + b2**2 + b3**2)
        
        cos_theta = simplify(dot_prod / (mag_a * mag_b))
        
        return problem(
            question=f"Find the cosine of the angle between vectors $\\vec{{u}} = {latex(vec_a)}$ and $\\vec{{v}} = {latex(vec_b)}$. Simplify your answer.",
            answer=cos_theta,
            difficulty=(1600, 1750),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Use the formula $\\cos\\theta = \\frac{{\\vec{{u}} \\cdot \\vec{{v}}}}{{|\\vec{{u}}||\\vec{{v}}|}}$",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({a1})({b1}) + ({a2})({b2}) + ({a3})({b3}) = {dot_prod}$",
                f"$|\\vec{{u}}| = \\sqrt{{{a1}^2 + {a2}^2 + {a3}^2}} = {latex(mag_a)}$",
                f"$|\\vec{{v}}| = \\sqrt{{{b1}^2 + {b2}^2 + {b3}^2}} = {latex(mag_b)}$",
                f"$\\cos\\theta = \\frac{{{dot_prod}}}{{{latex(mag_a * mag_b)}}} = {latex(cos_theta)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Cross product magnitude to find area of parallelogram
        a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        b1, b2, b3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        
        vec_a = Matrix([a1, a2, a3])
        vec_b = Matrix([b1, b2, b3])
        
        cross_prod = vec_a.cross(vec_b)
        area = sqrt(cross_prod[0]**2 + cross_prod[1]**2 + cross_prod[2]**2)
        area_simplified = simplify(area)
        
        return problem(
            question=f"Find the area of the parallelogram spanned by vectors $\\vec{{a}} = {latex(vec_a)}$ and $\\vec{{b}} = {latex(vec_b)}$.",
            answer=area_simplified,
            difficulty=(1650, 1800),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"The area equals $|\\vec{{a}} \\times \\vec{{b}}|$",
                f"$\\vec{{a}} \\times \\vec{{b}} = \\begin{{vmatrix}} \\vec{{i}} & \\vec{{j}} & \\vec{{k}} \\\\ {a1} & {a2} & {a3} \\\\ {b1} & {b2} & {b3} \\end{{vmatrix}}$",
                f"$= \\vec{{i}}({a2} \\cdot {b3} - {a3} \\cdot {b2}) - \\vec{{j}}({a1} \\cdot {b3} - {a3} \\cdot {b1}) + \\vec{{k}}({a1} \\cdot {b2} - {a2} \\cdot {b1})$",
                f"$= {latex(cross_prod)}$",
                f"$|\\vec{{a}} \\times \\vec{{b}}| = \\sqrt{{{cross_prod[0]}^2 + {cross_prod[1]}^2 + {cross_prod[2]}^2}} = {latex(area_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Projection of one vector onto another
        a1, a2, a3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        b1, b2, b3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        vec_a = Matrix([a1, a2, a3])
        vec_b = Matrix([b1, b2, b3])
        
        dot_prod = vec_a.dot(vec_b)
        mag_b_sq = b1**2 + b2**2 + b3**2
        
        proj_scalar = Rational(dot_prod, mag_b_sq)
        proj_vec = simplify(proj_scalar * vec_b)
        
        return problem(
            question=f"Find the vector projection of $\\vec{{u}} = {latex(vec_a)}$ onto $\\vec{{v}} = {latex(vec_b)}$.",
            answer=proj_vec,
            difficulty=(1700, 1850),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Use the formula $\\text{{proj}}_{{\\vec{{v}}}}\\vec{{u}} = \\frac{{\\vec{{u}} \\cdot \\vec{{v}}}}{{\\vec{{v}} \\cdot \\vec{{v}}}} \\vec{{v}}$",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({a1})({b1}) + ({a2})({b2}) + ({a3})({b3}) = {dot_prod}$",
                f"$\\vec{{v}} \\cdot \\vec{{v}} = {b1}^2 + {b2}^2 + {b3}^2 = {mag_b_sq}$",
                f"$\\text{{proj}}_{{\\vec{{v}}}}\\vec{{u}} = \\frac{{{dot_prod}}}{{{mag_b_sq}}} {latex(vec_b)} = {latex(proj_vec)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Volume of parallelepiped using scalar triple product
        a1, a2, a3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        b1, b2, b3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        c1, c2, c3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        vec_a = Matrix([a1, a2, a3])
        vec_b = Matrix([b1, b2, b3])
        vec_c = Matrix([c1, c2, c3])
        
        mat = Matrix([[a1, a2, a3], [b1, b2, b3], [c1, c2, c3]])
        det_val = mat.det()
        volume = abs(det_val)
        
        return problem(
            question=f"Find the volume of the parallelepiped determined by vectors $\\vec{{a}} = {latex(vec_a)}$, $\\vec{{b}} = {latex(vec_b)}$, and $\\vec{{c}} = {latex(vec_c)}$.",
            answer=volume,
            difficulty=(1750, 1900),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Volume = $|\\vec{{a}} \\cdot (\\vec{{b}} \\times \\vec{{c}})|$, which equals the absolute value of the determinant",
                f"$V = \\left|\\begin{{vmatrix}} {a1} & {a2} & {a3} \\\\ {b1} & {b2} & {b3} \\\\ {c1} & {c2} & {c3} \\end{{vmatrix}}\\right|$",
                f"$= |{a1}({b2} \\cdot {c3} - {b3} \\cdot {c2}) - {a2}({b1} \\cdot {c3} - {b3} \\cdot {c1}) + {a3}({b1} \\cdot {c2} - {b2} \\cdot {c1})|$",
                f"$= |{det_val}| = {volume}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Find unit vector perpendicular to two given vectors using cross product
        a1, a2, a3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        b1, b2, b3 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)
        
        vec_a = Matrix([a1, a2, a3])
        vec_b = Matrix([b1, b2, b3])
        
        cross_prod = vec_a.cross(vec_b)
        magnitude = sqrt(cross_prod[0]**2 + cross_prod[1]**2 + cross_prod[2]**2)
        
        unit_vec = simplify(cross_prod / magnitude)
        
        return problem(
            question=f"Find a unit vector perpendicular to both $\\vec{{u}} = {latex(vec_a)}$ and $\\vec{{v}} = {latex(vec_b)}$.",
            answer=unit_vec,
            difficulty=(1650, 1800),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Find $\\vec{{u}} \\times \\vec{{v}}$ and normalize it",
                f"$\\vec{{u}} \\times \\vec{{v}} = \\begin{{vmatrix}} \\vec{{i}} & \\vec{{j}} & \\vec{{k}} \\\\ {a1} & {a2} & {a3} \\\\ {b1} & {b2} & {b3} \\end{{vmatrix}}$",
                f"$= {latex(cross_prod)}$",
                f"$|\\vec{{u}} \\times \\vec{{v}}| = {latex(magnitude)}$",
                f"Unit vector = $\\frac{{1}}{{{latex(magnitude)}}} {latex(cross_prod)} = {latex(unit_vec)}$"
            ),
            calculator="scientific"
        )

emit(generate())