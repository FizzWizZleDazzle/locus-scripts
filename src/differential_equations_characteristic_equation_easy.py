"""
differential_equations - characteristic_equation (easy)
Generated: 2026-02-22T05:25:54.997458
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 3)

    if problem_type == 1:
        # Distinct real roots: (r - r1)(r - r2) = 0
        r1 = randint(-6, 6)
        r2 = randint(-6, 6)
        while r2 == r1:
            r2 = randint(-6, 6)

        a_coeff = -(r1 + r2)
        b_coeff = r1 * r2

        # Build LaTeX for the ODE
        terms = ["y''"]
        if a_coeff != 0:
            if a_coeff == 1:
                terms.append("+ y'")
            elif a_coeff == -1:
                terms.append("- y'")
            elif a_coeff > 0:
                terms.append(f"+ {a_coeff}y'")
            else:
                terms.append(f"- {-a_coeff}y'")
        if b_coeff != 0:
            if b_coeff == 1:
                terms.append("+ y")
            elif b_coeff == -1:
                terms.append("- y")
            elif b_coeff > 0:
                terms.append(f"+ {b_coeff}y")
            else:
                terms.append(f"- {-b_coeff}y")
        de_latex = " ".join(terms) + " = 0"

        ans = FiniteSet(r1, r2)

        b_sign = f"+ {a_coeff}" if a_coeff >= 0 else f"- {-a_coeff}"
        c_sign = f"+ {b_coeff}" if b_coeff >= 0 else f"- {-b_coeff}"

        return problem(
            question=f"Find the roots of the characteristic equation for ${de_latex}$",
            answer=ans,
            difficulty=(1000, 1150),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"Substitute $y = e^{{rt}}$ to get the characteristic equation: $r^2 {b_sign}r {c_sign} = 0$",
                f"Factor: $(r - {r1})(r - {r2}) = 0$",
                f"Roots: $r_1 = {r1}$, $r_2 = {r2}$"
            ),
        )

    elif problem_type == 2:
        # Repeated real root: (r - r1)^2 = 0
        r1 = randint(-6, 6)

        a_coeff = -2 * r1
        b_coeff = r1 * r1

        terms = ["y''"]
        if a_coeff != 0:
            if a_coeff == 1:
                terms.append("+ y'")
            elif a_coeff == -1:
                terms.append("- y'")
            elif a_coeff > 0:
                terms.append(f"+ {a_coeff}y'")
            else:
                terms.append(f"- {-a_coeff}y'")
        if b_coeff != 0:
            if b_coeff == 1:
                terms.append("+ y")
            elif b_coeff > 0:
                terms.append(f"+ {b_coeff}y")
        de_latex = " ".join(terms) + " = 0"

        ans = FiniteSet(r1)

        b_sign = f"+ {a_coeff}" if a_coeff >= 0 else f"- {-a_coeff}"
        c_sign = f"+ {b_coeff}" if b_coeff >= 0 else f"- {-b_coeff}"

        return problem(
            question=f"Find the roots of the characteristic equation for ${de_latex}$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is $r^2 {b_sign}r {c_sign} = 0$",
                f"Factor: $(r - {r1})^2 = 0$",
                f"Repeated root: $r = {r1}$ (multiplicity 2)"
            ),
        )

    else:
        # Pure imaginary roots: r^2 + omega^2 = 0, giving r = ±i*omega
        omega = randint(1, 8)
        b_coeff = omega ** 2

        de_latex = f"y'' + {b_coeff}y = 0"

        ans = FiniteSet(-I * omega, I * omega)

        return problem(
            question=f"Find the roots of the characteristic equation for ${de_latex}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is $r^2 + {b_coeff} = 0$",
                f"$r^2 = -{b_coeff}$",
                f"$r = \\pm \\sqrt{{-{b_coeff}}} = \\pm {omega}i$"
            ),
        )


emit(generate())
