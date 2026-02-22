"""
differential_equations - variation_of_parameters (medium)
Generated: 2026-02-22T05:29:15.106930
"""

from problem_utils import *

def generate():
    # Variation of parameters is used for non-homogeneous 2nd order linear ODEs
    # Standard problems (1300-1600) should involve:
    # - Simple complementary solutions (exponentials, trig functions)
    # - Straightforward non-homogeneous terms
    # - Calculation of Wronskian and particular solution
    
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # Difficulty ~1300-1400: Distinct real roots, polynomial forcing
        r1 = nonzero(-3, 3)
        r2 = nonzero(-3, 3)
        while r2 == r1:
            r2 = nonzero(-3, 3)
        
        # Complementary solution: y_c = c1*e^(r1*x) + c2*e^(r2*x)
        y1 = exp(r1*x)
        y2 = exp(r2*x)
        
        # Non-homogeneous term: polynomial
        poly_coeff = nonzero(-5, 5)
        g = poly_coeff * x
        
        # Calculate Wronskian
        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        
        # Calculate u1' and u2'
        u1_prime = simplify(-y2 * g / W)
        u2_prime = simplify(y1 * g / W)
        
        # Integrate to get u1 and u2
        u1 = integrate(u1_prime, x)
        u2 = integrate(u2_prime, x)
        
        # Particular solution
        y_p = simplify(u1 * y1 + u2 * y2)
        
        # Characteristic equation
        char_eq = f"r^2 - {r1 + r2}r + {r1*r2} = 0"
        
        question = f"Use variation of parameters to find a particular solution for the differential equation $y'' - {r1 + r2}y' + {r1*r2}y = {latex(g)}$. The complementary solution is $y_c = c_1 e^{{{r1}x}} + c_2 e^{{{r2}x}}$."
        
        solution = steps(
            f"Given $y_1 = {latex(y1)}$ and $y_2 = {latex(y2)}$",
            f"Calculate the Wronskian: $W = {latex(y1)} \\cdot {latex(diff(y2, x))} - {latex(y2)} \\cdot {latex(diff(y1, x))} = {latex(W)}$",
            f"Find $u_1' = -\\frac{{y_2 \\cdot g}}{{W}} = {latex(u1_prime)}$",
            f"Find $u_2' = \\frac{{y_1 \\cdot g}}{{W}} = {latex(u2_prime)}$",
            f"Integrate: $u_1 = {latex(u1)}$ and $u_2 = {latex(u2)}$",
            f"Particular solution: $y_p = u_1 y_1 + u_2 y_2 = {latex(y_p)}$"
        )
        
        return problem(
            question=question,
            answer=y_p,
            difficulty=(1300, 1400),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )
    
    elif difficulty_choice == 2:
        # Difficulty ~1400-1500: Complex roots, exponential forcing
        alpha = nonzero(-2, 2)
        beta = randint(1, 3)
        
        # Complementary solution with complex roots: y_c = e^(alpha*x)(c1*cos(beta*x) + c2*sin(beta*x))
        y1 = exp(alpha*x) * cos(beta*x)
        y2 = exp(alpha*x) * sin(beta*x)
        
        # Non-homogeneous term
        exp_coeff = nonzero(-4, 4)
        exp_power = nonzero(-2, 2)
        while exp_power == alpha:
            exp_power = nonzero(-2, 2)
        g = exp_coeff * exp(exp_power*x)
        
        # Calculate Wronskian
        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        
        # Calculate u1' and u2'
        u1_prime = simplify(-y2 * g / W)
        u2_prime = simplify(y1 * g / W)
        
        # Integrate
        u1 = integrate(u1_prime, x)
        u2 = integrate(u2_prime, x)
        
        # Particular solution
        y_p = simplify(u1 * y1 + u2 * y2)
        
        question = f"Use variation of parameters to find a particular solution for $y'' - {2*alpha}y' + ({alpha**2 + beta**2})y = {latex(g)}$. The complementary solution is $y_c = e^{{{alpha}x}}(c_1\\cos({beta}x) + c_2\\sin({beta}x))$."
        
        solution = steps(
            f"Given $y_1 = {latex(y1)}$ and $y_2 = {latex(y2)}$",
            f"Calculate the Wronskian: $W = {latex(W)}$",
            f"Find $u_1' = -\\frac{{y_2 g}}{{W}} = {latex(u1_prime)}$",
            f"Find $u_2' = \\frac{{y_1 g}}{{W}} = {latex(u2_prime)}$",
            f"Integrate: $u_1 = {latex(u1)}$, $u_2 = {latex(u2)}$",
            f"Particular solution: $y_p = {latex(y_p)}$"
        )
        
        return problem(
            question=question,
            answer=y_p,
            difficulty=(1400, 1500),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )
    
    else:
        # Difficulty ~1500-1600: Trig forcing function
        omega = randint(1, 3)
        
        # Complementary solution: y_c = c1*cos(omega*x) + c2*sin(omega*x)
        y1 = cos(omega*x)
        y2 = sin(omega*x)
        
        # Non-homogeneous term with sec (challenging)
        g = sec(omega*x)
        
        # Wronskian
        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        
        # u1' and u2'
        u1_prime = -y2 * g / W
        u2_prime = y1 * g / W
        
        # Simplify before integration
        u1_prime = simplify(u1_prime)
        u2_prime = simplify(u2_prime)
        
        # For sec(omega*x), these integrate to known forms
        # u1 = -tan(omega*x)/omega
        # u2 = -ln|cos(omega*x)|/omega
        u1 = -tan(omega*x)/omega
        u2 = -log(cos(omega*x))/omega
        
        y_p = simplify(u1 * y1 + u2 * y2)
        
        question = f"Use variation of parameters to find a particular solution for $y'' + {omega**2}y = \\sec({omega}x)$. The complementary solution is $y_c = c_1\\cos({omega}x) + c_2\\sin({omega}x)$."
        
        solution = steps(
            f"Given $y_1 = \\cos({omega}x)$ and $y_2 = \\sin({omega}x)$",
            f"Wronskian: $W = {omega}$",
            f"$u_1' = -\\sin({omega}x)\\sec({omega}x) / {omega} = -\\tan({omega}x) / {omega}$",
            f"$u_2' = \\cos({omega}x)\\sec({omega}x) / {omega} = 1 / {omega}$",
            f"Integrate: $u_1 = \\frac{{\\ln|\\cos({omega}x)|}}{{{omega**2}}}$, $u_2 = \\frac{{x}}{{{omega}}}$",
            f"Particular solution: $y_p = {latex(y_p)}$"
        )
        
        return problem(
            question=question,
            answer=y_p,
            difficulty=(1500, 1600),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )

emit(generate())