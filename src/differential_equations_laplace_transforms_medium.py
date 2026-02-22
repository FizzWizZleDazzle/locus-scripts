"""
differential_equations - laplace_transforms (medium)
Generated: 2026-02-22T05:30:53.211836
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Basic Laplace transform of elementary functions
        func_type = randint(1, 4)
        
        if func_type == 1:
            # Power function: t^n
            n_val = randint(1, 4)
            f_t = t**n_val
            ans = factorial(n_val) / s**(n_val + 1)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We use the formula $\\mathcal{{L}}\\{{t^n\\}} = \\frac{{n!}}{{s^{{n+1}}}}$",
                    f"For $n = {n_val}$, we have $\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{{n_val}!}}{{s^{{{n_val + 1}}}}}$",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = {latex(ans)}$"
                ),
            )
        
        elif func_type == 2:
            # Exponential: e^(at)
            a_val = nonzero(-5, 5)
            f_t = exp(a_val * t)
            ans = 1 / (s - a_val)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We use the formula $\\mathcal{{L}}\\{{e^{{at}}\\}} = \\frac{{1}}{{s - a}}$",
                    f"For $a = {a_val}$, we have $\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{1}}{{s - ({a_val})}}$",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = {latex(ans)}$"
                ),
            )
        
        elif func_type == 3:
            # Sin function: sin(at)
            a_val = randint(1, 5)
            f_t = sin(a_val * t)
            ans = a_val / (s**2 + a_val**2)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We use the formula $\\mathcal{{L}}\\{{\\sin(at)\\}} = \\frac{{a}}{{s^2 + a^2}}$",
                    f"For $a = {a_val}$, we have $\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{{a_val}}}{{s^2 + {a_val**2}}}$",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = {latex(ans)}$"
                ),
            )
        
        else:
            # Cos function: cos(at)
            a_val = randint(1, 5)
            f_t = cos(a_val * t)
            ans = s / (s**2 + a_val**2)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We use the formula $\\mathcal{{L}}\\{{\\cos(at)\\}} = \\frac{{s}}{{s^2 + a^2}}$",
                    f"For $a = {a_val}$, we have $\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{s}}{{s^2 + {a_val**2}}}$",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = {latex(ans)}$"
                ),
            )
    
    elif problem_type == 2:
        # Linear combination of functions
        coeff1 = nonzero(-5, 5)
        coeff2 = nonzero(-5, 5)
        n1 = randint(1, 3)
        a_val = nonzero(-4, 4)
        
        f_t = coeff1 * t**n1 + coeff2 * exp(a_val * t)
        ans = coeff1 * factorial(n1) / s**(n1 + 1) + coeff2 / (s - a_val)
        
        return problem(
            question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                "Use linearity: $\\mathcal{L}\\{af(t) + bg(t)\\} = a\\mathcal{L}\\{f(t)\\} + b\\mathcal{L}\\{g(t)\\}$",
                f"$\\mathcal{{L}}\\{{{coeff1} \\cdot t^{{{n1}}}\\}} = {coeff1} \\cdot \\frac{{{n1}!}}{{s^{{{n1 + 1}}}}} = {latex(coeff1 * factorial(n1) / s**(n1 + 1))}$",
                f"$\\mathcal{{L}}\\{{{coeff2} \\cdot e^{{{a_val}t}}\\}} = {coeff2} \\cdot \\frac{{1}}{{s - {a_val}}} = {latex(coeff2 / (s - a_val))}$",
                f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Inverse Laplace transform - simple
        inverse_type = randint(1, 3)
        
        if inverse_type == 1:
            # 1/(s-a) -> e^(at)
            a_val = nonzero(-5, 5)
            F_s = 1 / (s - a_val)
            ans = exp(a_val * t)
            
            return problem(
                question=f"Find the inverse Laplace transform of $F(s) = {latex(F_s)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We recognize this as the form $\\frac{{1}}{{s - a}}$",
                    f"Using $\\mathcal{{L}}^{{-1}}\\left\\{{\\frac{{1}}{{s - a}}\\right\\}} = e^{{at}}$",
                    f"With $a = {a_val}$, we get $f(t) = {latex(ans)}$"
                ),
            )
        
        elif inverse_type == 2:
            # n!/(s^(n+1)) -> t^n
            n_val = randint(1, 4)
            F_s = factorial(n_val) / s**(n_val + 1)
            ans = t**n_val
            
            return problem(
                question=f"Find the inverse Laplace transform of $F(s) = {latex(F_s)}$",
                answer=ans,
                difficulty=(1300, 1400),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We recognize this as the form $\\frac{{n!}}{{s^{{n+1}}}}$",
                    f"Using $\\mathcal{{L}}^{{-1}}\\left\\{{\\frac{{n!}}{{s^{{n+1}}}}\\right\\}} = t^n$",
                    f"With $n = {n_val}$, we get $f(t) = {latex(ans)}$"
                ),
            )
        
        else:
            # a/(s^2 + a^2) -> sin(at)
            a_val = randint(2, 5)
            F_s = a_val / (s**2 + a_val**2)
            ans = sin(a_val * t)
            
            return problem(
                question=f"Find the inverse Laplace transform of $F(s) = {latex(F_s)}$",
                answer=ans,
                difficulty=(1400, 1500),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    f"We recognize this as the form $\\frac{{a}}{{s^2 + a^2}}$",
                    f"Using $\\mathcal{{L}}^{{-1}}\\left\\{{\\frac{{a}}{{s^2 + a^2}}\\right\\}} = \\sin(at)$",
                    f"With $a = {a_val}$, we get $f(t) = {latex(ans)}$"
                ),
            )
    
    else:
        # First shifting theorem (s-shifting): e^(at) * f(t)
        a_val = nonzero(-4, 4)
        func_choice = randint(1, 3)
        
        if func_choice == 1:
            # e^(at) * t^n
            n_val = randint(1, 3)
            f_t = exp(a_val * t) * t**n_val
            ans = factorial(n_val) / (s - a_val)**(n_val + 1)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    "Use the first shifting theorem: $\\mathcal{L}\\{e^{at}f(t)\\} = F(s-a)$",
                    f"We know $\\mathcal{{L}}\\{{t^{{{n_val}}}\\}} = \\frac{{{n_val}!}}{{s^{{{n_val + 1}}}}}$",
                    f"Replace $s$ with $s - ({a_val})$:",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{{n_val}!}}{{(s - {a_val})^{{{n_val + 1}}}}} = {latex(ans)}$"
                ),
            )
        
        elif func_choice == 2:
            # e^(at) * sin(bt)
            b_val = randint(2, 5)
            f_t = exp(a_val * t) * sin(b_val * t)
            ans = b_val / ((s - a_val)**2 + b_val**2)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    "Use the first shifting theorem: $\\mathcal{L}\\{e^{at}f(t)\\} = F(s-a)$",
                    f"We know $\\mathcal{{L}}\\{{\\sin({b_val}t)\\}} = \\frac{{{b_val}}}{{s^2 + {b_val**2}}}$",
                    f"Replace $s$ with $s - ({a_val})$:",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{{b_val}}}{{(s - {a_val})^2 + {b_val**2}}} = {latex(ans)}$"
                ),
            )
        
        else:
            # e^(at) * cos(bt)
            b_val = randint(2, 5)
            f_t = exp(a_val * t) * cos(b_val * t)
            ans = (s - a_val) / ((s - a_val)**2 + b_val**2)
            
            return problem(
                question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    "Use the first shifting theorem: $\\mathcal{L}\\{e^{at}f(t)\\} = F(s-a)$",
                    f"We know $\\mathcal{{L}}\\{{\\cos({b_val}t)\\}} = \\frac{{s}}{{s^2 + {b_val**2}}}$",
                    f"Replace $s$ with $s - ({a_val})$:",
                    f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{s - ({a_val})}}{{(s - {a_val})^2 + {b_val**2}}} = {latex(ans)}$"
                ),
            )

emit(generate())