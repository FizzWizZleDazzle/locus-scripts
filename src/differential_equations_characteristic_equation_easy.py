"""
differential_equations - characteristic_equation (easy)
Generated: 2026-02-22T05:25:54.997458
"""

from problem_utils import *

def generate():
    # For characteristic equation problems at 1000-1300 ELO:
    # - 1000-1150: Simple real distinct roots (r^2 - kr + c = 0 where k and c are small)
    # - 1150-1300: Simple real repeated roots or simple complex roots
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Distinct real roots: (r - r1)(r - r2) = 0
        # Second-order homogeneous ODE with constant coefficients
        r1 = randint(-3, 3)
        r2 = randint(-3, 3)
        while r2 == r1:
            r2 = randint(-3, 3)
        
        # Characteristic equation: r^2 - (r1+r2)r + r1*r2 = 0
        # This comes from: y'' - (r1+r2)y' + r1*r2*y = 0
        
        a_coeff = -(r1 + r2)
        b_coeff = r1 * r2
        
        if a_coeff == 0:
            if b_coeff == 0:
                de_latex = "y'' = 0"
            elif b_coeff == 1:
                de_latex = "y'' + y = 0"
            elif b_coeff == -1:
                de_latex = "y'' - y = 0"
            else:
                de_latex = f"y'' + {b_coeff}y = 0" if b_coeff > 0 else f"y'' - {-b_coeff}y = 0"
        else:
            de_part1 = f"y'' + {a_coeff}y'" if a_coeff > 0 else f"y'' - {-a_coeff}y'"
            if b_coeff == 0:
                de_latex = de_part1 + " = 0"
            elif b_coeff == 1:
                de_latex = de_part1 + " + y = 0"
            elif b_coeff == -1:
                de_latex = de_part1 + " - y = 0"
            else:
                de_latex = de_part1 + (f" + {b_coeff}y = 0" if b_coeff > 0 else f" - {-b_coeff}y = 0")
        
        # Characteristic equation
        char_eq = r**2 + a_coeff*r + b_coeff
        
        ans = FiniteSet(r1, r2)
        
        return problem(
            question=f"Find the roots of the characteristic equation for ${de_latex}$",
            answer=ans,
            difficulty=(1000, 1150),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is $r^2 + ({a_coeff})r + {b_coeff} = 0$",
                f"Factor: $(r - {r1})(r - {r2}) = 0$",
                f"Roots: $r = {r1}, {r2}$"
            ),
        )
    
    elif problem_type == 2:
        # Repeated real root: (r - r1)^2 = 0
        r1 = randint(-3, 3)
        
        # Characteristic equation: r^2 - 2*r1*r + r1^2 = 0
        # This comes from: y'' - 2*r1*y' + r1^2*y = 0
        
        a_coeff = -2 * r1
        b_coeff = r1 * r1
        
        if a_coeff == 0:
            if b_coeff == 0:
                de_latex = "y'' = 0"
            elif b_coeff == 1:
                de_latex = "y'' + y = 0"
            else:
                de_latex = f"y'' + {b_coeff}y = 0"
        else:
            de_part1 = f"y'' + {a_coeff}y'" if a_coeff > 0 else f"y'' - {-a_coeff}y'"
            if b_coeff == 0:
                de_latex = de_part1 + " = 0"
            elif b_coeff == 1:
                de_latex = de_part1 + " + y = 0"
            else:
                de_latex = de_part1 + f" + {b_coeff}y = 0"
        
        ans = FiniteSet(r1)
        
        return problem(
            question=f"Find the roots of the characteristic equation for ${de_latex}$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is $r^2 + ({a_coeff})r + {b_coeff} = 0$",
                f"Factor: $(r - {r1})^2 = 0$",
                f"Repeated root: $r = {r1}$"
            ),
        )
    
    else:
        # Simple complex roots: r^2 + omega^2 = 0, giving r = ±i*omega
        omega = randint(1, 4)
        b_coeff = omega**2
        
        de_latex = f"y'' + {b_coeff}y = 0"
        
        ans = FiniteSet(-I*omega, I*omega)
        
        return problem(
            question=f"Find the roots of the characteristic equation for ${de_latex}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is $r^2 + {b_coeff} = 0$",
                f"$r^2 = -{b_coeff}$",
                f"$r = \\pm {omega}i$"
            ),
        )

emit(generate())