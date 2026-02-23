"""
differential_equations - laplace_transforms (medium)
Generated: 2026-02-22T05:30:53.211836
"""

from problem_utils import *
s = symbols('s')

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # L{t^n * e^(at)}  — first shifting theorem, n in 1..4, a nonzero(-5,5)
        n_val = randint(1, 4)
        a_val = nonzero(-5, 5)
        f_t = exp(a_val * t) * t**n_val
        fact_n = factorial(n_val)
        ans = fact_n / (s - a_val)**(n_val + 1)

        return problem(
            question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Use the first shifting theorem: $\\mathcal{{L}}\\{{e^{{at}}f(t)\\}} = F(s-a)$",
                f"$\\mathcal{{L}}\\{{t^{{{n_val}}}\\}} = \\frac{{{n_val}!}}{{s^{{{n_val + 1}}}}} = \\frac{{{fact_n}}}{{s^{{{n_val + 1}}}}}$",
                f"Replace $s$ with $s - ({a_val})$:",
                f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{{fact_n}}}{{(s - {a_val})^{{{n_val + 1}}}}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # L{e^(at) * sin(bt)}  with a nonzero(-4,4), b in 1..8
        a_val = nonzero(-4, 4)
        b_val = randint(1, 8)
        f_t = exp(a_val * t) * sin(b_val * t)
        ans = b_val / ((s - a_val)**2 + b_val**2)

        return problem(
            question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
            answer=ans,
            difficulty=(1400, 1520),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Use first shifting: $\\mathcal{{L}}\\{{e^{{at}}f(t)\\}} = F(s-a)$",
                f"$\\mathcal{{L}}\\{{\\sin({b_val}t)\\}} = \\frac{{{b_val}}}{{s^2 + {b_val**2}}}$",
                f"Replace $s$ with $s - ({a_val})$:",
                f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{{b_val}}}{{(s - {a_val})^2 + {b_val**2}}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # L{e^(at) * cos(bt)}  with a nonzero(-4,4), b in 1..8
        a_val = nonzero(-4, 4)
        b_val = randint(1, 8)
        f_t = exp(a_val * t) * cos(b_val * t)
        ans = (s - a_val) / ((s - a_val)**2 + b_val**2)

        return problem(
            question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
            answer=ans,
            difficulty=(1400, 1520),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Use first shifting: $\\mathcal{{L}}\\{{e^{{at}}f(t)\\}} = F(s-a)$",
                f"$\\mathcal{{L}}\\{{\\cos({b_val}t)\\}} = \\frac{{s}}{{s^2 + {b_val**2}}}$",
                f"Replace $s$ with $s - ({a_val})$:",
                f"$\\mathcal{{L}}\\{{{latex(f_t)}\\}} = \\frac{{s - ({a_val})}}{{(s - {a_val})^2 + {b_val**2}}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # Inverse Laplace: n!/(s-a)^(n+1) -> t^n * e^(at)
        n_val = randint(1, 4)
        a_val = nonzero(-5, 5)
        fact_n = factorial(n_val)
        F_s = fact_n / (s - a_val)**(n_val + 1)
        ans = t**n_val * exp(a_val * t)

        return problem(
            question=f"Find the inverse Laplace transform of $F(s) = {latex(F_s)}$",
            answer=ans,
            difficulty=(1420, 1550),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Recognise the form $\\frac{{n!}}{{(s-a)^{{n+1}}}}$ with $n = {n_val}$, $a = {a_val}$",
                f"$\\mathcal{{L}}^{{-1}}\\left[\\frac{{n!}}{{(s-a)^{{n+1}}}}\\right] = t^n e^{{at}}$",
                f"$f(t) = {latex(ans)}$"
            ),
        )

    else:
        # Linear combination: L{p*t^m + q*e^(a*t) + r*sin(b*t)}
        p_val = nonzero(-4, 4)
        m_val = randint(1, 3)
        q_val = nonzero(-4, 4)
        a_val = nonzero(-4, 4)
        r_val = nonzero(-4, 4)
        b_val = randint(1, 6)

        f_t = p_val * t**m_val + q_val * exp(a_val * t) + r_val * sin(b_val * t)
        fact_m = factorial(m_val)
        ans = (p_val * fact_m / s**(m_val + 1)
               + q_val / (s - a_val)
               + r_val * b_val / (s**2 + b_val**2))

        return problem(
            question=f"Find the Laplace transform of $f(t) = {latex(f_t)}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                "Use linearity of the Laplace transform",
                f"$\\mathcal{{L}}\\{{{p_val}t^{{{m_val}}}\\}} = {p_val} \\cdot \\frac{{{m_val}!}}{{s^{{{m_val + 1}}}}} = {latex(p_val * fact_m / s**(m_val + 1))}$",
                f"$\\mathcal{{L}}\\{{{q_val}e^{{{a_val}t}}\\}} = {q_val} \\cdot \\frac{{1}}{{s - {a_val}}} = {latex(q_val / (s - a_val))}$",
                f"$\\mathcal{{L}}\\{{{r_val}\\sin({b_val}t)\\}} = {r_val} \\cdot \\frac{{{b_val}}}{{s^2 + {b_val**2}}} = {latex(r_val * b_val / (s**2 + b_val**2))}$",
                f"Sum: $\\mathcal{{L}}\\{{f(t)\\}} = {latex(ans)}$"
            ),
        )


emit(generate())
