"""
differential_equations - laplace_transforms (easy)
Generated: 2026-02-22T05:30:15.681939
"""

from problem_utils import *
s = symbols('s')

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # L{t^n} = n! / s^(n+1)  with n in 1..6
        n_val = randint(1, 6)
        fact_n = factorial(n_val)
        ans = fact_n / s**(n_val + 1)

        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{t^{{{n_val}}}\}}",
            answer=ans,
            difficulty=(1000, 1150),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                rf"Use the formula $\mathcal{{L}}\{{t^n\}} = \frac{{n!}}{{s^{{n+1}}}}$ with $n = {n_val}$",
                rf"${n_val}! = {fact_n}$",
                rf"$\mathcal{{L}}\{{t^{{{n_val}}}\}} = \frac{{{fact_n}}}{{s^{{{n_val + 1}}}}}$"
            ),
        )

    elif problem_type == 2:
        # L{e^(at)} = 1/(s-a)  with a in nonzero(-5,5)
        a_val = nonzero(-5, 5)
        ans = 1 / (s - a_val)
        func_str = f"e^{{{a_val}t}}"

        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{{func_str}\}}",
            answer=ans,
            difficulty=(1050, 1200),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                rf"Use $\mathcal{{L}}\{{e^{{at}}\}} = \frac{{1}}{{s-a}}$ with $a = {a_val}$",
                rf"$\mathcal{{L}}\{{{func_str}\}} = \frac{{1}}{{s - ({a_val})}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # L{sin(at)} = a/(s^2+a^2)  with a in 1..8
        a_val = randint(1, 8)
        ans = a_val / (s**2 + a_val**2)

        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{\sin({a_val}t)\}}",
            answer=ans,
            difficulty=(1100, 1220),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                rf"Use $\mathcal{{L}}\{{\sin(at)\}} = \frac{{a}}{{s^2 + a^2}}$ with $a = {a_val}$",
                rf"$\mathcal{{L}}\{{\sin({a_val}t)\}} = \frac{{{a_val}}}{{s^2 + {a_val**2}}}$"
            ),
        )

    elif problem_type == 4:
        # L{cos(at)} = s/(s^2+a^2)  with a in 1..8
        a_val = randint(1, 8)
        ans = s / (s**2 + a_val**2)

        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{\cos({a_val}t)\}}",
            answer=ans,
            difficulty=(1100, 1220),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                rf"Use $\mathcal{{L}}\{{\cos(at)\}} = \frac{{s}}{{s^2 + a^2}}$ with $a = {a_val}$",
                rf"$\mathcal{{L}}\{{\cos({a_val}t)\}} = \frac{{s}}{{s^2 + {a_val**2}}}$"
            ),
        )

    else:
        # L{a + b*t + c*t^2}  — linear combination
        a_val = nonzero(-6, 6)
        b_val = nonzero(-6, 6)
        c_val = nonzero(-4, 4)

        # L{a} = a/s, L{b*t} = b/s^2, L{c*t^2} = 2c/s^3
        ans = Rational(a_val, 1) / s + Rational(b_val, 1) / s**2 + Rational(2 * c_val, 1) / s**3

        if b_val > 0:
            b_str = f"+ {b_val}t"
        else:
            b_str = f"{b_val}t"

        if c_val > 0:
            c_str = f"+ {c_val}t^2"
        else:
            c_str = f"{c_val}t^2"

        func_str = f"{a_val} {b_str} {c_str}"

        return problem(
            question=rf"\text{{Find the Laplace transform: }} \mathcal{{L}}\{{{func_str}\}}",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                r"Use linearity of the Laplace transform",
                rf"$\mathcal{{L}}\{{{a_val}\}} = \frac{{{a_val}}}{{s}}$",
                rf"$\mathcal{{L}}\{{{b_val}t\}} = \frac{{{b_val}}}{{s^2}}$",
                rf"$\mathcal{{L}}\{{{c_val}t^2\}} = \frac{{2 \cdot {c_val}}}{{s^3}} = \frac{{{2*c_val}}}{{s^3}}$",
                rf"$\mathcal{{L}}\{{{func_str}\}} = {latex(ans)}$"
            ),
        )


emit(generate())
