"""
algebra2 - complex_number_equations (hard)
Generated: 2026-02-22T04:22:56.250958
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Solve quadratic equation in complex numbers z^2 + bz + c = 0
        # where discriminant is negative
        real_part = nonzero(-5, 5)
        imag_part = nonzero(1, 4)
        
        # Roots are real_part ± imag_part*i
        # So z^2 - 2*real_part*z + (real_part^2 + imag_part^2) = 0
        b_coeff = -2 * real_part
        c_coeff = real_part**2 + imag_part**2
        
        equation = x**2 + b_coeff*x + c_coeff
        sol1 = real_part + imag_part*I
        sol2 = real_part - imag_part*I
        ans = FiniteSet(sol1, sol2)
        
        return problem(
            question=f"Solve for $z$ in $\\mathbb{{C}}$: ${latex(equation)} = 0$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"Use the quadratic formula: $z = \\frac{{-({b_coeff}) \\pm \\sqrt{{({b_coeff})^2 - 4(1)({c_coeff})}}}}{{2}}$",
                f"Discriminant: $\\Delta = {b_coeff**2} - {4*c_coeff} = {b_coeff**2 - 4*c_coeff}$",
                f"Since $\\Delta < 0$, we have complex roots",
                f"$z = \\frac{{{-b_coeff} \\pm \\sqrt{{{b_coeff**2 - 4*c_coeff}}}i}}{{2}}$",
                f"$z = \\frac{{{-b_coeff} \\pm {abs(b_coeff**2 - 4*c_coeff)}^{{1/2}}i}}{{2}}$",
                f"$z = {latex(sol1)}$ or $z = {latex(sol2)}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Solve z^3 = complex number
        # Pick a complex number in polar form
        r = choice([1, 2, 4, 8])
        theta_num = choice([1, 2, 3, 4, 5])
        theta_den = choice([3, 4, 6])
        
        # z^3 = r * e^(i*theta)
        # Solutions: r^(1/3) * e^(i*(theta + 2πk)/3) for k=0,1,2
        
        target = r * exp(I * theta_num * pi / theta_den)
        
        cube_root_r = r**(Rational(1, 3))
        angle1 = theta_num * pi / (3 * theta_den)
        angle2 = angle1 + 2*pi/3
        angle3 = angle1 + 4*pi/3
        
        sol1 = cube_root_r * exp(I * angle1)
        sol2 = cube_root_r * exp(I * angle2)
        sol3 = cube_root_r * exp(I * angle3)
        
        ans = FiniteSet(sol1, sol2, sol3)
        
        return problem(
            question=f"Find all complex solutions to $z^3 = {latex(target)}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"Write in polar form: $z^3 = {r}e^{{i\\cdot {latex(theta_num*pi/theta_den)}}}$",
                f"Take cube roots: $z = {latex(cube_root_r)} e^{{i({latex(theta_num*pi/theta_den)} + 2\\pi k)/3}}$ for $k = 0, 1, 2$",
                f"For $k=0$: $z_1 = {latex(sol1)}$",
                f"For $k=1$: $z_2 = {latex(sol2)}$",
                f"For $k=2$: $z_3 = {latex(sol3)}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Solve |z - a| = |z - b| (locus is perpendicular bisector)
        a_real = nonzero(-4, 4)
        a_imag = nonzero(-4, 4)
        b_real = nonzero(-4, 4)
        b_imag = nonzero(-4, 4)
        
        while a_real == b_real and a_imag == b_imag:
            b_real = nonzero(-4, 4)
            b_imag = nonzero(-4, 4)
        
        a_complex = a_real + a_imag*I
        b_complex = b_real + b_imag*I
        
        # The solution is a line (perpendicular bisector)
        # Expanding |x + iy - a| = |x + iy - b| leads to a linear equation
        # (x - a_real)^2 + (y - a_imag)^2 = (x - b_real)^2 + (y - b_imag)^2
        # Simplifies to: 2(b_real - a_real)x + 2(b_imag - a_imag)y = b_real^2 + b_imag^2 - a_real^2 - a_imag^2
        
        coeff_x = 2*(b_real - a_real)
        coeff_y = 2*(b_imag - a_imag)
        rhs = b_real**2 + b_imag**2 - a_real**2 - a_imag**2
        
        if coeff_y != 0:
            # Express as y = mx + c equation
            m = -coeff_x / coeff_y
            c = rhs / coeff_y
            ans_eq = Eq(y, m*x + c)
        else:
            # Vertical line
            ans_eq = Eq(x, rhs/coeff_x)
        
        return problem(
            question=f"Find the set of all complex numbers $z = x + iy$ satisfying $|z - ({latex(a_complex)})| = |z - ({latex(b_complex)})|$. Express your answer as an equation in $x$ and $y$.",
            answer=ans_eq,
            difficulty=(1650, 1750),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"Let $z = x + iy$. Then $|z - ({latex(a_complex)})| = |(x - {a_real}) + i(y - {a_imag})|$",
                f"$= \\sqrt{{(x - {a_real})^2 + (y - {a_imag})^2}}$",
                f"Similarly, $|z - ({latex(b_complex)})| = \\sqrt{{(x - {b_real})^2 + (y - {b_imag})^2}}$",
                f"Setting them equal and squaring both sides:",
                f"$(x - {a_real})^2 + (y - {a_imag})^2 = (x - {b_real})^2 + (y - {b_imag})^2$",
                f"Expanding and simplifying: ${coeff_x}x + {coeff_y}y = {rhs}$",
                f"${latex(ans_eq)}$"
            )
        )
    
    elif problem_type == 4:
        # Type 4: Solve z^2 + conjugate(z)^2 = constant
        # This leads to a quartic, but we can use z = x + iy
        k = choice([2, 4, 6, 8, 10])
        
        # z^2 + conj(z)^2 = (x+iy)^2 + (x-iy)^2 = 2x^2 - 2y^2 = k
        # So x^2 - y^2 = k/2
        # This is a hyperbola: x^2 - y^2 = k/2
        
        ans_eq = Eq(x**2 - y**2, k/2)
        
        return problem(
            question=f"Find all complex numbers $z = x + iy$ satisfying $z^2 + \\overline{{z}}^2 = {k}$. Express your answer as an equation in $x$ and $y$.",
            answer=ans_eq,
            difficulty=(1700, 1800),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"Let $z = x + iy$, so $\\overline{{z}} = x - iy$",
                f"$z^2 = (x + iy)^2 = x^2 + 2ixy - y^2 = (x^2 - y^2) + 2ixy$",
                f"$\\overline{{z}}^2 = (x - iy)^2 = x^2 - 2ixy - y^2 = (x^2 - y^2) - 2ixy$",
                f"$z^2 + \\overline{{z}}^2 = 2(x^2 - y^2)$",
                f"Setting equal to ${k}$: $2(x^2 - y^2) = {k}$",
                f"${latex(ans_eq)}$"
            )
        )
    
    else:
        # Type 5: Solve (z - a)(conjugate(z) - b) = c where a, b, c are complex
        a_val = nonzero(-3, 3) + nonzero(-3, 3)*I
        c_val = randint(1, 12)
        
        # Let b = conjugate(a) for symmetry
        b_val = conjugate(a_val)
        
        # (z - a)(conj(z) - conj(a)) = c
        # Let z = x + iy
        # (x + iy - a)(x - iy - conj(a)) = c
        # This gives |z - a|^2 = c
        # So z lies on a circle centered at a with radius sqrt(c)
        
        center_real = re(a_val)
        center_imag = im(a_val)
        radius_sq = c_val
        
        ans_eq = Eq((x - center_real)**2 + (y - center_imag)**2, radius_sq)
        
        return problem(
            question=f"Find all complex numbers $z = x + iy$ satisfying $(z - ({latex(a_val)}))(\\overline{{z}} - ({latex(b_val)})) = {c_val}$. Express your answer as an equation in $x$ and $y$.",
            answer=ans_eq,
            difficulty=(1750, 1850),
            topic="algebra2/complex_number_equations",
            solution=steps(
                f"Note that $\\overline{{z}} - ({latex(b_val)}) = \\overline{{z - {latex(a_val)}}}$",
                f"So $(z - ({latex(a_val)}))(\\overline{{z}} - ({latex(b_val)})) = (z - ({latex(a_val)}))\\overline{{(z - ({latex(a_val)}))}}$",
                f"$= |z - ({latex(a_val)})|^2 = {c_val}$",
                f"Let $z = x + iy$. Then $|z - ({latex(a_val)})|^2 = (x - {center_real})^2 + (y - {center_imag})^2$",
                f"${latex(ans_eq)}$",
                f"This is a circle centered at $({center_real}, {center_imag})$ with radius $\\sqrt{{{c_val}}}$"
            )
        )

emit(generate())