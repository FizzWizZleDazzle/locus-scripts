"""
algebra1 - systems_substitution (hard)
Generated: 2026-02-22T03:56:19.391106
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: System with fractions and coefficients requiring careful substitution (1600-1700)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        # Clean solution
        x_val = nonzero(-5, 5)
        y_val = nonzero(-5, 5)
        
        # Build equations backward
        # First equation: ax + by = const1
        const1 = a * x_val + b * y_val
        
        # Second equation: y = cx + d
        const2 = d
        # We need y_val = c*x_val + d, so adjust d
        d = y_val - c * x_val
        
        eq1_str = f"{a}x" + (f" + {b}y" if b > 0 else f" - {-b}y") + f" = {const1}"
        eq2_str = f"y = {c}x" + (f" + {d}" if d > 0 else f" - {-d}" if d < 0 else "")
        
        ans = FiniteSet((x_val, y_val))
        
        return problem(
            question=f"Solve the system by substitution:\\n\\n$\\begin{{cases}} {latex(a*x + b*y)} = {const1} \\\\ y = {latex(c*x + d)} \\end{{cases}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/systems_substitution",
            solution=steps(
                f"Substitute $y = {latex(c*x + d)}$ into the first equation:",
                f"${latex(a*x + b*(c*x + d))} = {const1}$",
                f"${latex(a*x + b*c*x + b*d)} = {const1}$",
                f"${latex((a + b*c)*x)} = {const1 - b*d}$",
                f"$x = {x_val}$",
                f"Substitute back: $y = {c}({x_val}) + {d} = {y_val}$",
                f"Solution: $({x_val}, {y_val})$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: System requiring isolation then substitution (1650-1750)
        # Build from clean solution
        x_val = nonzero(-6, 6)
        y_val = nonzero(-6, 6)
        
        a = nonzero(-3, 3)
        b = nonzero(2, 5)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        
        # ax + y = const1
        const1 = a * x_val + y_val
        
        # cx + dy = const2
        const2 = c * x_val + d * y_val
        
        ans = FiniteSet((x_val, y_val))
        
        return problem(
            question=f"Solve the system by substitution:\\n\\n$\\begin{{cases}} {latex(a*x + y)} = {const1} \\\\ {latex(c*x + d*y)} = {const2} \\end{{cases}}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/systems_substitution",
            solution=steps(
                f"Solve the first equation for $y$:",
                f"$y = {latex(const1 - a*x)}$",
                f"Substitute into the second equation:",
                f"${latex(c*x + d*(const1 - a*x))} = {const2}$",
                f"${latex(c*x + d*const1 - d*a*x)} = {const2}$",
                f"${latex((c - d*a)*x)} = {const2 - d*const1}$",
                f"$x = {x_val}$",
                f"Substitute back: $y = {const1} - {a}({x_val}) = {y_val}$",
                f"Solution: $({x_val}, {y_val})$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: System with variables on both sides, more complex (1700-1800)
        x_val = randint(-4, 4)
        y_val = nonzero(-5, 5)
        
        a = nonzero(-3, 3)
        b = nonzero(2, 4)
        c = nonzero(-3, 3)
        d = nonzero(2, 4)
        e = nonzero(-4, 4)
        
        # ax - by = const1
        const1 = a * x_val - b * y_val
        
        # cx + y = dx + const2
        # So: (c-d)x + y = const2
        const2 = (c - d) * x_val + y_val
        
        ans = FiniteSet((x_val, y_val))
        
        return problem(
            question=f"Solve the system by substitution:\\n\\n$\\begin{{cases}} {latex(a*x - b*y)} = {const1} \\\\ {latex(c*x + y)} = {latex(d*x + const2)} \\end{{cases}}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra1/systems_substitution",
            solution=steps(
                f"Simplify the second equation:",
                f"${latex(c*x + y)} = {latex(d*x + const2)}$",
                f"${latex((c-d)*x + y)} = {const2}$",
                f"$y = {latex((d-c)*x + const2)}$",
                f"Substitute into the first equation:",
                f"${latex(a*x - b*((d-c)*x + const2))} = {const1}$",
                f"${latex(a*x - b*(d-c)*x - b*const2)} = {const1}$",
                f"${latex((a - b*(d-c))*x)} = {const1 + b*const2}$",
                f"$x = {x_val}$",
                f"$y = {latex((d-c)*x_val + const2)} = {y_val}$",
                f"Solution: $({x_val}, {y_val})$"
            )
        )
    
    else:
        # Type 4: System with one equation already solved for expression (1750-1900)
        x_val = nonzero(-4, 4)
        y_val = nonzero(-4, 4)
        
        a = nonzero(2, 5)
        b = nonzero(2, 4)
        c = nonzero(-3, 3)
        d = nonzero(-4, 4)
        e = nonzero(-3, 3)
        
        # a(x + c) + b(y + d) = const1
        const1 = a * (x_val + c) + b * (y_val + d)
        
        # x + c = e*y + f
        f = (x_val + c) - e * y_val
        
        ans = FiniteSet((x_val, y_val))
        
        return problem(
            question=f"Solve the system by substitution:\\n\\n$\\begin{{cases}} {a}(x + {c}) + {b}(y + {d}) = {const1} \\\\ x + {c} = {latex(e*y + f)} \\end{{cases}}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra1/systems_substitution",
            solution=steps(
                f"From the second equation: $x + {c} = {latex(e*y + f)}$",
                f"Substitute into the first equation:",
                f"${a}({latex(e*y + f)}) + {b}(y + {d}) = {const1}$",
                f"${latex(a*e*y + a*f)} + {latex(b*y + b*d)} = {const1}$",
                f"${latex((a*e + b)*y)} = {const1 - a*f - b*d}$",
                f"$y = {y_val}$",
                f"Substitute back: $x + {c} = {e}({y_val}) + {f} = {x_val + c}$",
                f"$x = {x_val}$",
                f"Solution: $({x_val}, {y_val})$"
            )
        )

emit(generate())