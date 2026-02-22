"""
calculus - antiderivatives (hard)
Generated: 2026-02-22T05:12:00.718770
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Integration by parts
        funcs = [
            (x * exp(x), "u = x, dv = e^x dx", "du = dx, v = e^x", x * exp(x) - exp(x)),
            (x * sin(x), "u = x, dv = \\sin(x) dx", "du = dx, v = -\\cos(x)", -x * cos(x) + sin(x)),
            (x * cos(x), "u = x, dv = \\cos(x) dx", "du = dx, v = \\sin(x)", x * sin(x) + cos(x)),
            (x**2 * exp(x), "u = x^2, dv = e^x dx", "du = 2x dx, v = e^x", x**2 * exp(x) - 2*x*exp(x) + 2*exp(x)),
        ]
        f, u_choice, dudv, ans_no_c = choice(funcs)
        C = symbols('C')
        ans = ans_no_c + C
        
        return problem(
            question=f"\\int {latex(f)} \\, dx",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use integration by parts: ${u_choice}$",
                f"Then ${dudv}$",
                f"$\\int u \\, dv = uv - \\int v \\, du$",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )
    
    elif problem_type == 2:
        # U-substitution with chain rule reverse
        inner_funcs = [
            (2*x, 2, sin(2*x), -Rational(1,2)*cos(2*x)),
            (3*x, 3, cos(3*x), Rational(1,3)*sin(3*x)),
            (x**2, 2*x, exp(x**2), Rational(1,2)*exp(x**2)),
            (2*x + 1, 2, (2*x + 1)**3, Rational(1,8)*(2*x + 1)**4),
        ]
        u_expr, du_coeff, f, ans_no_c = choice(inner_funcs)
        C = symbols('C')
        ans = ans_no_c + C
        integrand = f * du_coeff if problem_type == 2 else f
        
        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Let $u = {latex(u_expr)}$, then $du = {latex(du_coeff)} dx$",
                f"The integral becomes $\\int f(u) \\, du$",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )
    
    elif problem_type == 3:
        # Partial fractions
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        while a_val == b_val:
            b_val = nonzero(-3, 3)
        
        # (A/(x-a) + B/(x-b)) integrated
        A = nonzero(-2, 2)
        B = nonzero(-2, 2)
        integrand = A/(x - a_val) + B/(x - b_val)
        C = symbols('C')
        ans = A*log(abs(x - a_val)) + B*log(abs(x - b_val)) + C
        
        return problem(
            question=f"\\int \\left({latex(integrand)}\\right) dx",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate each term separately",
                f"$\\int \\frac{{{A}}}{{x - {a_val}}} dx = {A}\\ln|x - {a_val}|$",
                f"$\\int \\frac{{{B}}}{{x - {b_val}}} dx = {B}\\ln|x - {b_val}|$",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )
    
    elif problem_type == 4:
        # Trigonometric substitution result
        trig_integrals = [
            (sin(x)**2, Rational(1,2)*x - Rational(1,4)*sin(2*x), "\\sin^2(x) = \\frac{1 - \\cos(2x)}{2}"),
            (cos(x)**2, Rational(1,2)*x + Rational(1,4)*sin(2*x), "\\cos^2(x) = \\frac{1 + \\cos(2x)}{2}"),
            (sin(x)*cos(x), Rational(1,2)*sin(x)**2, "u = \\sin(x), du = \\cos(x)dx"),
            (sec(x)**2, tan(x), "\\text{Standard antiderivative}"),
        ]
        f, ans_no_c, hint = choice(trig_integrals)
        C = symbols('C')
        ans = ans_no_c + C
        
        return problem(
            question=f"\\int {latex(f)} \\, dx",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use identity: ${hint}$",
                f"Integrate to get ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )
    
    else:  # problem_type == 5
        # Rational function requiring long division first
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        
        # (x^2 + ax + b)/(x + c) = (x + (a-c)) + (b + c(c-a))/(x+c)
        quotient_linear = 1
        quotient_const = a_val - c_val
        remainder = b_val + c_val*(c_val - a_val)
        
        numerator = x**2 + a_val*x + b_val
        denominator = x + c_val
        
        C = symbols('C')
        ans = Rational(1,2)*x**2 + quotient_const*x + remainder*log(abs(x + c_val)) + C
        
        return problem(
            question=f"\\int \\frac{{{latex(numerator)}}}{{{latex(denominator)}}} dx",
            answer=ans,
            difficulty=(1750, 1850),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Perform polynomial long division",
                f"$\\frac{{{latex(numerator)}}}{{{latex(denominator)}}} = x + {quotient_const} + \\frac{{{remainder}}}{{x + {c_val}}}$",
                f"Integrate term by term",
                f"Answer: ${latex(ans)}$"
            ),
            grading_mode="equivalent"
        )

emit(generate())