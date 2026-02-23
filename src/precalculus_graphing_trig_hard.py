"""
precalculus - graphing_trig (hard)
"""

from problem_utils import *
from svg_utils import Graph

AMP_POOL   = [Rational(1, 2), 1, 2, 3, 4, 5, Rational(3, 2), Rational(5, 2)]
B_POOL     = [Rational(1, 4), Rational(1, 3), Rational(1, 2), 1, 2, 3, 4, Rational(2, 3)]
PHASE_POOL = [pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi,
              -pi/6, -pi/4, -pi/3, -pi/2, -2*pi/3]
VERT_POOL  = list(range(-5, 6))


def generate():
    problem_type = choice([
        'phase_shift_combined',
        'midline_reflection',
        'period_change',
        'combined_transformations',
        'inverse_trig_range',
        'parametric_elimination',
        'find_equation_from_features',
        'tan_transformations',
    ])

    if problem_type == 'phase_shift_combined':
        func_name = choice(['sin', 'cos'])
        A = choice([1, 2, 3, 4, 5, Rational(1, 2), Rational(3, 2)])
        B = choice([1, 2, 3])
        C = choice(PHASE_POOL)
        D = choice([v for v in VERT_POOL if v != 0])
        expr_obj = A * (sin(B * x - C) if func_name == 'sin' else cos(B * x - C)) + D
        phase_shift = simplify(C / B)
        amplitude = abs(A)
        period = simplify(2 * pi / B)

        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-9, 9), width=400, height=300)
        g.plot(expr_obj)
        g.hline(float(D), dashed=True)

        ask = choice(['phase_shift', 'amplitude', 'period'])
        if ask == 'phase_shift':
            return problem(
                question=f"The graph shows $y = {latex(expr_obj)}$. What is the phase shift?",
                answer=phase_shift,
                difficulty=(1600, 1750),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Write $y = {latex(A)}\\,{func_name}\\!\\left({B}x - {latex(C)}\\right) + {D}$",
                    f"$= {latex(A)}\\,{func_name}\\!\\left({B}\\!\\left(x - \\dfrac{{{latex(C)}}}{{{B}}}\\right)\\right) + {D}$",
                    f"Phase shift $= {latex(phase_shift)}$ ({'right' if phase_shift > 0 else 'left'})"
                ),
                image=g.render()
            )
        elif ask == 'amplitude':
            return problem(
                question=f"For $y = {latex(expr_obj)}$, find the amplitude.",
                answer=amplitude,
                difficulty=(1600, 1700),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Amplitude $= |A| = |{latex(A)}| = {latex(amplitude)}$"
                ),
                image=g.render()
            )
        else:
            return problem(
                question=f"For $y = {latex(expr_obj)}$, find the period.",
                answer=period,
                difficulty=(1600, 1750),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"$B = {B}$",
                    f"Period $= \\dfrac{{2\\pi}}{{{B}}} = {latex(period)}$"
                ),
                image=g.render()
            )

    elif problem_type == 'midline_reflection':
        func_name = choice(['sin', 'cos'])
        A = choice([-5, -4, -3, -2, -1, 2, 3, 4, 5])  # negative = reflection
        D = choice([v for v in VERT_POOL if v != 0])
        expr_obj = A * (sin(x) if func_name == 'sin' else cos(x)) + D
        max_val = abs(A) + D
        min_val = -abs(A) + D
        midline_val = D

        g = Graph(x_range=(-2*pi, 2*pi), y_range=(min_val - 2, max_val + 2), width=400, height=300)
        g.plot(expr_obj)
        g.hline(float(midline_val), dashed=True)

        ask = choice(['midline', 'max', 'min'])
        if ask == 'midline':
            return problem(
                question=f"Find the midline of $y = {latex(expr_obj)}$.",
                answer=Eq(y, midline_val),
                difficulty=(1650, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Max $= {max_val}$, Min $= {min_val}$",
                    f"Midline $y = \\dfrac{{{max_val} + {min_val}}}{{2}} = {midline_val}$"
                ),
                image=g.render()
            )
        elif ask == 'max':
            return problem(
                question=f"Find the maximum value of $y = {latex(expr_obj)}$.",
                answer=max_val,
                difficulty=(1600, 1700),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Amplitude $= |{A}| = {abs(A)}$",
                    f"Maximum $= D + |A| = {D} + {abs(A)} = {max_val}$"
                ),
                image=g.render()
            )
        else:
            return problem(
                question=f"Find the minimum value of $y = {latex(expr_obj)}$.",
                answer=min_val,
                difficulty=(1600, 1700),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Amplitude $= |{A}| = {abs(A)}$",
                    f"Minimum $= D - |A| = {D} - {abs(A)} = {min_val}$"
                ),
                image=g.render()
            )

    elif problem_type == 'period_change':
        func_name = choice(['sin', 'cos'])
        B = choice([Rational(1, 4), Rational(1, 3), Rational(1, 2),
                    2, 3, 4, Rational(2, 3), Rational(3, 2)])
        expr_obj = sin(B * x) if func_name == 'sin' else cos(B * x)
        period = simplify(2 * pi / B)

        g = Graph(x_range=(0, float(2 * period)), y_range=(-2, 2), width=400, height=300)
        g.plot(expr_obj)

        return problem(
            question=f"What is the period of $y = \\{func_name}\\!\\left({latex(B)}x\\right)$?",
            answer=period,
            difficulty=(1650, 1800),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Period $= \\dfrac{{2\\pi}}{{|B|}}$",
                f"$B = {latex(B)}$",
                f"Period $= \\dfrac{{2\\pi}}{{{latex(abs(B))}}} = {latex(period)}$"
            ),
            image=g.render()
        )

    elif problem_type == 'combined_transformations':
        func_name = choice(['sin', 'cos'])
        A = choice([1, 2, 3, 4, Rational(1, 2), Rational(3, 2)])
        B = choice([2, 3, Rational(1, 2), Rational(1, 3)])
        C = choice([0, pi/6, pi/4, pi/3, pi/2, -pi/4, -pi/3, -pi/2])
        D = choice(VERT_POOL)
        expr_obj = A * (sin(B * x - C) if func_name == 'sin' else cos(B * x - C)) + D
        amplitude = abs(A)
        period = simplify(2 * pi / B)
        phase_shift = simplify(C / B)

        ask = choice(['amplitude', 'period', 'range', 'phase'])
        if ask == 'amplitude':
            return problem(
                question=f"Find the amplitude of $f(x) = {latex(expr_obj)}$.",
                answer=amplitude,
                difficulty=(1650, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Amplitude $= |A| = {latex(amplitude)}$"
                )
            )
        elif ask == 'period':
            return problem(
                question=f"Find the period of $f(x) = {latex(expr_obj)}$.",
                answer=period,
                difficulty=(1700, 1850),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"$B = {latex(B)}$",
                    f"Period $= \\dfrac{{2\\pi}}{{{latex(abs(B))}}} = {latex(period)}$"
                )
            )
        elif ask == 'range':
            max_v = amplitude + D
            min_v = -amplitude + D
            return problem(
                question=f"Find the range of $f(x) = {latex(expr_obj)}$.",
                answer=fmt_interval(min_v, max_v, False, False),
                difficulty=(1700, 1850),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Amplitude $= {latex(amplitude)}$, vertical shift $D = {D}$",
                    f"Max $= {latex(amplitude)} + {D} = {latex(max_v)}$",
                    f"Min $= -{latex(amplitude)} + {D} = {latex(min_v)}$",
                    f"Range: $[{latex(min_v)},\\,{latex(max_v)}]$"
                )
            )
        else:
            return problem(
                question=f"Find the phase shift of $f(x) = {latex(expr_obj)}$.",
                answer=phase_shift,
                difficulty=(1700, 1850),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Write $f(x) = {latex(A)}\\,{func_name}\\!\\left({latex(B)}\\cdot\\left(x - \\dfrac{{{latex(C)}}}{{{latex(B)}}}\\right)\\right) + {D}$",
                    f"Phase shift $= {latex(phase_shift)}$"
                )
            )

    elif problem_type == 'inverse_trig_range':
        func_choice = choice(['arcsin', 'arccos', 'arctan'])
        if func_choice == 'arcsin':
            ans = fmt_interval(-pi/2, pi/2, False, False)
            return problem(
                question="What is the range of $y = \\arcsin(x)$?",
                answer=ans,
                difficulty=(1700, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The principal range of $\\arcsin$ is restricted to give a one-to-one function",
                    "Range: $\\left[-\\dfrac{\\pi}{2},\\,\\dfrac{\\pi}{2}\\right]$"
                )
            )
        elif func_choice == 'arccos':
            ans = fmt_interval(0, pi, False, False)
            return problem(
                question="What is the range of $y = \\arccos(x)$?",
                answer=ans,
                difficulty=(1700, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The principal range of $\\arccos$ is $[0, \\pi]$"
                )
            )
        else:
            ans = fmt_interval(-pi/2, pi/2, True, True)
            return problem(
                question="What is the range of $y = \\arctan(x)$?",
                answer=ans,
                difficulty=(1750, 1850),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The range of $\\arctan$ is $\\left(-\\dfrac{\\pi}{2},\\,\\dfrac{\\pi}{2}\\right)$ (open interval)",
                    "Horizontal asymptotes at $y = \\pm\\dfrac{\\pi}{2}$"
                )
            )

    elif problem_type == 'parametric_elimination':
        A = choice([1, 2, 3, 4, 5])
        B = choice([1, 2, 3, 4, 5])
        while B == A:
            B = choice([1, 2, 3, 4, 5])
        # x = A cos(t), y = B sin(t) => ellipse
        ans = Eq((x / A)**2 + (y / B)**2, 1)
        return problem(
            question=(f"Eliminate the parameter from $x = {A}\\cos t$, $y = {B}\\sin t$ "
                      f"to find a Cartesian equation."),
            answer=ans,
            difficulty=(1800, 1950),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"$\\cos t = \\dfrac{{x}}{{{A}}}$, $\\sin t = \\dfrac{{y}}{{{B}}}$",
                "$\\cos^2 t + \\sin^2 t = 1$",
                f"$\\left(\\dfrac{{x}}{{{A}}}\\right)^2 + \\left(\\dfrac{{y}}{{{B}}}\\right)^2 = 1$"
            )
        )

    elif problem_type == 'find_equation_from_features':
        # Given amplitude, period, phase shift, vertical shift — write the equation
        func_name = choice(['sin', 'cos'])
        A = choice([2, 3, 4, 5])
        B = choice([2, 3, Rational(1, 2)])
        C = choice([0, pi/6, pi/4, pi/3, pi/2])
        D = choice([-3, -2, -1, 0, 1, 2, 3])
        period = simplify(2 * pi / B)

        # Ask: what is the equation?
        # Represent as a string description
        sign_str = f"+ {D}" if D > 0 else (f"- {abs(D)}" if D < 0 else "")
        if C == 0:
            phase_str = f"{latex(B)}x"
        else:
            phase_str = f"{latex(B)}x - {latex(C)}"

        ans_str = f"{A}\\{func_name}({phase_str}) {sign_str}".strip()
        # The answer is the expression value
        expr_ans = A * (sin(B * x - C) if func_name == 'sin' else cos(B * x - C)) + D
        return problem(
            question=(f"Write the equation of a $\\{func_name}$ function with "
                      f"amplitude ${A}$, period ${latex(period)}$, "
                      f"phase shift ${latex(C)}$ to the right, and vertical shift ${D}$."),
            answer=expr_ans,
            difficulty=(1750, 1900),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"$y = A\\,\\{func_name}(B(x - C)) + D$",
                f"$A={A}$, $B=\\dfrac{{2\\pi}}{{{latex(period)}}}={latex(B)}$, $C={latex(C)}$, $D={D}$",
                f"$y = {A}\\,\\{func_name}({phase_str}) {sign_str}$"
            )
        )

    else:
        # Tan transformations
        B = choice([Rational(1, 2), 1, 2, 3])
        D = choice([-3, -2, -1, 0, 1, 2, 3])
        C = choice([0, pi/6, pi/4, pi/3])
        period = simplify(pi / B)
        expr_obj = tan(B * x - C) + D

        ask = choice(['period', 'vertical_shift', 'asymptote'])
        if ask == 'period':
            return problem(
                question=f"What is the period of $y = {latex(expr_obj)}$?",
                answer=period,
                difficulty=(1700, 1850),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "For $\\tan$, the period formula is $\\dfrac{\\pi}{|B|}$",
                    f"$B = {latex(B)}$",
                    f"Period $= \\dfrac{{\\pi}}{{{latex(abs(B))}}} = {latex(period)}$"
                )
            )
        elif ask == 'vertical_shift':
            return problem(
                question=f"What is the vertical shift of $y = {latex(expr_obj)}$?",
                answer=D,
                difficulty=(1650, 1800),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "The vertical shift is $D$ in $y = \\tan(\\ldots) + D$",
                    f"$D = {D}$"
                )
            )
        else:
            # First positive asymptote of y = tan(Bx - C) at Bx - C = pi/2
            # x = (pi/2 + C) / B
            asymp = simplify((pi / 2 + C) / B)
            return problem(
                question=f"Find the first positive vertical asymptote of $y = \\tan({latex(B)}x - {latex(C)})$.",
                answer=asymp,
                difficulty=(1750, 1900),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "$\\tan$ is undefined when its argument $= \\dfrac{\\pi}{2} + k\\pi$",
                    f"Set ${latex(B)}x - {latex(C)} = \\dfrac{{\\pi}}{{2}}$",
                    f"$x = \\dfrac{{\\pi/2 + {latex(C)}}}{{{latex(B)}}} = {latex(asymp)}$"
                )
            )


emit(generate())
