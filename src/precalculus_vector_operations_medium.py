"""
precalculus - vector_operations (medium)
Generated: 2026-02-22T04:55:53.810891
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Vector addition (1300-1400)
        v1_x, v1_y = nonzero(-8, 8), nonzero(-8, 8)
        v2_x, v2_y = nonzero(-8, 8), nonzero(-8, 8)
        
        ans_x = v1_x + v2_x
        ans_y = v1_y + v2_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find $\\vec{{u}} + \\vec{{v}}$ where $\\vec{{u}} = \\langle {v1_x}, {v1_y} \\rangle$ and $\\vec{{v}} = \\langle {v2_x}, {v2_y} \\rangle$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Add corresponding components:",
                f"$x$-component: ${v1_x} + {v2_x} = {ans_x}$",
                f"$y$-component: ${v1_y} + {v2_y} = {ans_y}$",
                f"Result: $\\langle {ans_x}, {ans_y} \\rangle$"
            )
        )
    
    elif problem_type == 2:
        # Scalar multiplication (1300-1400)
        scalar = nonzero(-5, 5)
        v_x, v_y = nonzero(-6, 6), nonzero(-6, 6)
        
        ans_x = scalar * v_x
        ans_y = scalar * v_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find ${scalar}\\vec{{v}}$ where $\\vec{{v}} = \\langle {v_x}, {v_y} \\rangle$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Multiply each component by ${scalar}$:",
                f"$x$-component: ${scalar} \\cdot {v_x} = {ans_x}$",
                f"$y$-component: ${scalar} \\cdot {v_y} = {ans_y}$",
                f"Result: $\\langle {ans_x}, {ans_y} \\rangle$"
            )
        )
    
    elif problem_type == 3:
        # Dot product (1400-1500)
        v1_x, v1_y = nonzero(-7, 7), nonzero(-7, 7)
        v2_x, v2_y = nonzero(-7, 7), nonzero(-7, 7)
        
        ans = v1_x * v2_x + v1_y * v2_y
        
        return problem(
            question=f"Find $\\vec{{u}} \\cdot \\vec{{v}}$ where $\\vec{{u}} = \\langle {v1_x}, {v1_y} \\rangle$ and $\\vec{{v}} = \\langle {v2_x}, {v2_y} \\rangle$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Use dot product formula: $\\vec{{u}} \\cdot \\vec{{v}} = u_x v_x + u_y v_y$",
                f"$= {v1_x} \\cdot {v2_x} + {v1_y} \\cdot {v2_y}$",
                f"$= {v1_x * v2_x} + {v1_y * v2_y}$",
                f"$= {ans}$"
            )
        )
    
    elif problem_type == 4:
        # Magnitude (1400-1500)
        # Choose values that give a clean answer
        mag_squared = choice([4, 9, 16, 25, 36, 49, 64, 81, 100])
        mag = sqrt(mag_squared)
        
        # Generate components
        v_x = nonzero(-8, 8)
        v_y_squared = mag_squared - v_x**2
        
        if v_y_squared > 0:
            v_y = int(sqrt(v_y_squared))
            if v_y**2 == v_y_squared:
                ans = simplify(sqrt(v_x**2 + v_y**2))
                
                return problem(
                    question=f"Find the magnitude of $\\vec{{v}} = \\langle {v_x}, {v_y} \\rangle$",
                    answer=ans,
                    difficulty=(1400, 1500),
                    topic="precalculus/vector_operations",
                    solution=steps(
                        f"Use magnitude formula: $\\|\\vec{{v}}\\| = \\sqrt{{v_x^2 + v_y^2}}$",
                        f"$= \\sqrt{{{v_x}^2 + {v_y}^2}}$",
                        f"$= \\sqrt{{{v_x**2} + {v_y**2}}}$",
                        f"$= \\sqrt{{{v_x**2 + v_y**2}}}$",
                        f"$= {ans}$"
                    )
                )
        
        # Fallback: non-perfect square
        v_x = randint(1, 5)
        v_y = randint(1, 5)
        ans = simplify(sqrt(v_x**2 + v_y**2))
        
        return problem(
            question=f"Find the magnitude of $\\vec{{v}} = \\langle {v_x}, {v_y} \\rangle$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Use magnitude formula: $\\|\\vec{{v}}\\| = \\sqrt{{v_x^2 + v_y^2}}$",
                f"$= \\sqrt{{{v_x}^2 + {v_y}^2}}$",
                f"$= \\sqrt{{{v_x**2 + v_y**2}}}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 5:
        # Linear combination (1500-1600)
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        v1_x, v1_y = nonzero(-5, 5), nonzero(-5, 5)
        v2_x, v2_y = nonzero(-5, 5), nonzero(-5, 5)
        
        ans_x = a_coeff * v1_x + b_coeff * v2_x
        ans_y = a_coeff * v1_y + b_coeff * v2_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find ${a_coeff}\\vec{{u}} + {b_coeff}\\vec{{v}}$ where $\\vec{{u}} = \\langle {v1_x}, {v1_y} \\rangle$ and $\\vec{{v}} = \\langle {v2_x}, {v2_y} \\rangle$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Compute ${a_coeff}\\vec{{u}} = {a_coeff}\\langle {v1_x}, {v1_y} \\rangle = \\langle {a_coeff*v1_x}, {a_coeff*v1_y} \\rangle$",
                f"Compute ${b_coeff}\\vec{{v}} = {b_coeff}\\langle {v2_x}, {v2_y} \\rangle = \\langle {b_coeff*v2_x}, {b_coeff*v2_y} \\rangle$",
                f"Add: $\\langle {a_coeff*v1_x}, {a_coeff*v1_y} \\rangle + \\langle {b_coeff*v2_x}, {b_coeff*v2_y} \\rangle$",
                f"$= \\langle {ans_x}, {ans_y} \\rangle$"
            )
        )
    
    else:
        # Unit vector (1500-1600)
        # Choose clean magnitude
        mag = choice([3, 4, 5, 6, 10, 12])
        v_x = nonzero(-mag + 1, mag - 1)
        v_y_squared = mag**2 - v_x**2
        
        if v_y_squared > 0 and int(sqrt(v_y_squared))**2 == v_y_squared:
            v_y = int(sqrt(v_y_squared))
            
            ans_x = Rational(v_x, mag)
            ans_y = Rational(v_y, mag)
            ans = Matrix([ans_x, ans_y])
            
            return problem(
                question=f"Find the unit vector in the direction of $\\vec{{v}} = \\langle {v_x}, {v_y} \\rangle$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/vector_operations",
                solution=steps(
                    f"Find magnitude: $\\|\\vec{{v}}\\| = \\sqrt{{{v_x}^2 + {v_y}^2}} = \\sqrt{{{v_x**2 + v_y**2}}} = {mag}$",
                    f"Unit vector: $\\hat{{v}} = \\frac{{1}}{{{mag}}}\\langle {v_x}, {v_y} \\rangle$",
                    f"$= \\langle {latex(ans_x)}, {latex(ans_y)} \\rangle$"
                )
            )
        
        # Fallback
        v_x, v_y = 3, 4
        mag = 5
        ans = Matrix([Rational(3, 5), Rational(4, 5)])
        
        return problem(
            question=f"Find the unit vector in the direction of $\\vec{{v}} = \\langle {v_x}, {v_y} \\rangle$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Find magnitude: $\\|\\vec{{v}}\\| = \\sqrt{{{v_x}^2 + {v_y}^2}} = \\sqrt{{25}} = 5$",
                f"Unit vector: $\\hat{{v}} = \\frac{{1}}{{5}}\\langle 3, 4 \\rangle$",
                f"$= \\langle \\frac{{3}}{{5}}, \\frac{{4}}{{5}} \\rangle$"
            )
        )

emit(generate())