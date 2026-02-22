"""
differential_equations - laplace_transforms (easy)
Generated: 2026-02-22T05:30:15.681939
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Direct Laplace transform of basic functions (ELO 1000-1200)
        func_choice = randint(1, 4)
        
        if func_choice == 1:
            # L{1} = 1/s
            return problem(
                question=r"\text{Find the Laplace transform: } \mathcal{L}\{1\}",
                answer=1/s,
                difficulty=(1000, 1100),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    r"The Laplace transform of 1 is given by the formula:",
                    r"$\mathcal{L}\{1\} = \frac{1}{s}$"
                ),
            )
        elif func_choice == 2:
            # L{t} = 1/s^2
            return problem(
                question=r"\text{Find the Laplace transform: } \mathcal{L}\{t\}",
                answer=1/s**2,
                difficulty=(1050, 1150),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    r"The Laplace transform of $t$ is given by the formula:",
                    r"$\mathcal{L}\{t\} = \frac{1}{s^2}$"
                ),
            )
        elif func_choice == 3:
            # L{e^(at)} = 1/(s-a)
            a_val = nonzero(-4, 4)
            if a_val > 0:
                func_str = f"e^{{{a_val}t}}"
            else:
                func_str = f"e^{{{a_val}t}}"
            return problem(
                question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{{func_str}\}}",
                answer=1/(s - a_val),
                difficulty=(1100, 1200),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    rf"Using the formula $\mathcal{{L}}\{{e^{{at}}\}} = \frac{{1}}{{s-a}}$ where $a = {a_val}$:",
                    rf"$\mathcal{{L}}\{{{func_str}\}} = \frac{{1}}{{s - ({a_val})}} = {latex(1/(s - a_val))}$"
                ),
            )
        else:
            # L{sin(at)} = a/(s^2 + a^2)
            a_val = randint(2, 5)
            return problem(
                question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{\sin({a_val}t)\}}",
                answer=a_val/(s**2 + a_val**2),
                difficulty=(1150, 1250),
                topic="differential_equations/laplace_transforms",
                solution=steps(
                    rf"Using the formula $\mathcal{{L}}\{{\sin(at)\}} = \frac{{a}}{{s^2 + a^2}}$ where $a = {a_val}$:",
                    rf"$\mathcal{{L}}\{{\sin({a_val}t)\}} = \frac{{{a_val}}}{{s^2 + {a_val**2}}}$"
                ),
            )
    
    elif problem_type == 2:
        # Laplace transform of cos(at) (ELO 1150-1250)
        a_val = randint(2, 5)
        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{\cos({a_val}t)\}}",
            answer=s/(s**2 + a_val**2),
            difficulty=(1150, 1250),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                rf"Using the formula $\mathcal{{L}}\{{\cos(at)\}} = \frac{{s}}{{s^2 + a^2}}$ where $a = {a_val}$:",
                rf"$\mathcal{{L}}\{{\cos({a_val}t)\}} = \frac{{s}}{{s^2 + {a_val**2}}}$"
            ),
        )
    
    elif problem_type == 3:
        # Laplace transform of t^n (ELO 1100-1250)
        n_val = randint(2, 4)
        factorial_n = 1
        for i in range(1, n_val + 1):
            factorial_n *= i
        
        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{t^{{{n_val}}}\}}",
            answer=factorial_n/s**(n_val + 1),
            difficulty=(1150, 1250),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                rf"Using the formula $\mathcal{{L}}\{{t^n\}} = \frac{{n!}}{{s^{{n+1}}}}$ where $n = {n_val}$:",
                rf"We have ${n_val}! = {factorial_n}$",
                rf"$\mathcal{{L}}\{{t^{{{n_val}}}\}} = \frac{{{factorial_n}}}{{s^{{{n_val + 1}}}}}$"
            ),
        )
    
    else:
        # Simple linear combination (ELO 1200-1300)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        
        # L{a + bt} = a/s + b/s^2
        ans = a_val/s + b_val/s**2
        
        if b_val > 0:
            func_str = f"{a_val} + {b_val}t"
        else:
            func_str = f"{a_val} {b_val}t"
        
        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{{func_str}\}}",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                r"Use the linearity property: $\mathcal{L}\{af(t) + bg(t)\} = a\mathcal{L}\{f(t)\} + b\mathcal{L}\{g(t)\}$",
                rf"$\mathcal{{L}}\{{{func_str}\}} = {a_val}\mathcal{{L}}\{{1\}} + {b_val}\mathcal{{L}}\{{t\}}$",
                rf"$= {a_val} \cdot \frac{{1}}{{s}} + {b_val} \cdot \frac{{1}}{{s^2}}$",
                rf"$= {latex(ans)}$"
            ),
        )

emit(generate())