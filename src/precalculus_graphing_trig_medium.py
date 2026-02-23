"""
precalculus - graphing_trig (medium)
"""

from problem_utils import *
from svg_utils import Graph

AMP_POOL   = [Rational(1, 2), 1, 2, 3, 4, 5, Rational(3, 2)]
B_POOL     = [Rational(1, 3), Rational(1, 2), 1, 2, 3, 4, Rational(2, 3)]
PHASE_POOL = [pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi,
              -pi/6, -pi/4, -pi/3, -pi/2]
VERT_POOL  = list(range(-4, 5))   # -4..4


def generate():
    problem_type = choice([
        'amplitude_period',
        'phase_shift',
        'vertical_shift',
        'combined_transform',
        'identify_features',
        'range_of_function',
        'max_min',
    ])

    if problem_type == 'amplitude_period':
        func_name = choice(['sin', 'cos'])
        A = choice(AMP_POOL)
        B = choice(B_POOL)
        while B == 0:
            B = choice(B_POOL)
        expr_obj = A * (sin(B * x) if func_name == 'sin' else cos(B * x))
        amplitude = abs(A)
        period = simplify(2 * pi / B)

        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-6, 6), width=400, height=300)
        g.plot(expr_obj)

        return problem(
            question=f"Find the amplitude and period of $y = {latex(expr_obj)}$. Enter as a tuple (amplitude, period).",
            answer=fmt_tuple(amplitude, period),
            difficulty=(1300, 1400),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Amplitude $= |A| = |{latex(A)}| = {latex(amplitude)}$",
                f"Period $= \\dfrac{{2\\pi}}{{|B|}} = \\dfrac{{2\\pi}}{{{latex(abs(B))}}} = {latex(period)}$",
                f"Answer: $({latex(amplitude)},\\,{latex(period)})$"
            ),
            image=g.render()
        )

    elif problem_type == 'phase_shift':
        func_name = choice(['sin', 'cos'])
        A = choice([1, 2, 3, 4])
        B = choice([1, 2, 3])
        C = choice(PHASE_POOL)
        expr_obj = A * (sin(B * x - C) if func_name == 'sin' else cos(B * x - C))
        # phase shift = C/B
        phase_shift = simplify(C / B)

        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-6, 6), width=400, height=300)
        g.plot(expr_obj)

        return problem(
            question=f"Find the phase shift of $y = {latex(expr_obj)}$.",
            answer=phase_shift,
            difficulty=(1350, 1500),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Write in form $y = A\\,{func_name}\\!\\left(B\\left(x - \\tfrac{{C}}{{B}}\\right)\\right)$",
                f"$B = {B}$, coefficient of $x$ inside: $Bx - C = {B}x - ({latex(C)})$",
                f"Phase shift $= \\dfrac{{C}}{{B}} = \\dfrac{{{latex(C)}}}{{{B}}} = {latex(phase_shift)}$",
                "Positive = shift right, negative = shift left"
            ),
            image=g.render()
        )

    elif problem_type == 'vertical_shift':
        func_name = choice(['sin', 'cos'])
        A = choice([1, 2, 3, 4])
        B = choice([1, 2, 3])
        D = choice([v for v in VERT_POOL if v != 0])
        expr_obj = A * (sin(B * x) if func_name == 'sin' else cos(B * x)) + D
        sign_str = "+" if D > 0 else ""

        g = Graph(x_range=(-2*pi, 2*pi), y_range=(-8, 8), width=400, height=300)
        g.plot(expr_obj)
        g.hline(float(D), dashed=True)

        return problem(
            question=f"Find the midline of $y = {latex(expr_obj)}$.",
            answer=D,
            difficulty=(1300, 1400),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The vertical shift is $D = {D}$",
                f"Midline: $y = {D}$"
            ),
            image=g.render()
        )

    elif problem_type == 'combined_transform':
        func_name = choice(['sin', 'cos'])
        A = choice([2, 3, 4, Rational(1, 2), Rational(3, 2)])
        B = choice([2, 3, Rational(1, 2), Rational(1, 3)])
        C = choice([0, pi/6, pi/4, pi/3, pi/2, -pi/4, -pi/3])
        D = choice([-3, -2, -1, 0, 1, 2, 3])
        expr_obj = A * (sin(B * (x - C)) if func_name == 'sin' else cos(B * (x - C))) + D
        amplitude = abs(A)
        period = simplify(2 * pi / B)

        # Ask for one of amplitude/period/midline/phase shift
        ask = choice(['amplitude', 'period', 'midline', 'phase_shift'])

        g = Graph(x_range=(-2*pi, 3*pi), y_range=(-8, 8), width=400, height=300)
        g.plot(expr_obj)
        if D != 0:
            g.hline(float(D), dashed=True)

        if ask == 'amplitude':
            return problem(
                question=f"For $y = {latex(expr_obj)}$, find the amplitude.",
                answer=amplitude,
                difficulty=(1400, 1550),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Amplitude $= |A| = |{latex(A)}| = {latex(amplitude)}$"
                ),
                image=g.render()
            )
        elif ask == 'period':
            return problem(
                question=f"For $y = {latex(expr_obj)}$, find the period.",
                answer=period,
                difficulty=(1400, 1550),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"$B = {latex(B)}$",
                    f"Period $= \\dfrac{{2\\pi}}{{B}} = \\dfrac{{2\\pi}}{{{latex(B)}}} = {latex(period)}$"
                ),
                image=g.render()
            )
        elif ask == 'midline':
            return problem(
                question=f"For $y = {latex(expr_obj)}$, find the midline.",
                answer=D,
                difficulty=(1400, 1500),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"The vertical shift is $D = {D}$",
                    f"Midline: $y = {D}$"
                ),
                image=g.render()
            )
        else:
            return problem(
                question=f"For $y = {latex(expr_obj)}$, find the phase shift.",
                answer=C,
                difficulty=(1450, 1600),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"The function is $y = A\\,{func_name}\\!\\left(B(x - C)\\right) + D$",
                    f"Here $C = {latex(C)}$",
                    f"Phase shift $= {latex(C)}$"
                ),
                image=g.render()
            )

    elif problem_type == 'identify_features':
        func_name = choice(['sin', 'cos'])
        A = choice([2, 3, 4])
        B = choice([2, 3, 4, Rational(1, 2)])
        C = choice([0, pi/4, pi/3, pi/2, -pi/4])
        D = choice([-2, -1, 0, 1, 2])
        expr_obj = A * (sin(B * x - C) if func_name == 'sin' else cos(B * x - C)) + D
        period = simplify(2 * pi / B)

        g = Graph(x_range=(-pi, 3*pi), y_range=(-8, 8), width=400, height=300)
        g.plot(expr_obj)

        return problem(
            question=f"Find the period of $y = {latex(expr_obj)}$.",
            answer=period,
            difficulty=(1400, 1550),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Identify $B$ in $y = A\\,{func_name}(Bx - C) + D$",
                f"$B = {latex(B)}$",
                f"Period $= \\dfrac{{2\\pi}}{{{latex(B)}}} = {latex(period)}$"
            ),
            image=g.render(),
            calculator="scientific"
        )

    elif problem_type == 'range_of_function':
        func_name = choice(['sin', 'cos'])
        A = choice([1, 2, 3, 4, 5])
        D = choice([-3, -2, -1, 0, 1, 2, 3])
        max_v = A + D
        min_v = -A + D
        return problem(
            question=f"What is the range of $y = {A}\\{func_name}(x) + {D}$?",
            answer=fmt_interval(min_v, max_v, False, False),
            difficulty=(1350, 1500),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"$\\{func_name}(x) \\in [-1, 1]$",
                f"${A}\\{func_name}(x) \\in [-{A}, {A}]$",
                f"Adding $D={D}$: $y \\in [{min_v}, {max_v}]$"
            )
        )

    else:
        # Max and min values together
        func_name = choice(['sin', 'cos'])
        A = choice([2, 3, 4, 5])
        B = choice([1, 2, 3])
        D = choice([-3, -2, -1, 0, 1, 2, 3])
        expr_obj = A * (sin(B * x) if func_name == 'sin' else cos(B * x)) + D
        max_v = A + D
        min_v = -A + D
        ask = choice(['max', 'min'])
        if ask == 'max':
            return problem(
                question=f"What is the maximum value of $y = {latex(expr_obj)}$?",
                answer=max_v,
                difficulty=(1300, 1450),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Maximum of $\\{func_name}$ is $1$",
                    f"Max of ${A}\\{func_name}({B}x)$ is ${A}$",
                    f"Max value: ${A} + ({D}) = {max_v}$"
                )
            )
        else:
            return problem(
                question=f"What is the minimum value of $y = {latex(expr_obj)}$?",
                answer=min_v,
                difficulty=(1300, 1450),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Minimum of $\\{func_name}$ is $-1$",
                    f"Min of ${A}\\{func_name}({B}x)$ is $-{A}$",
                    f"Min value: $-{A} + ({D}) = {min_v}$"
                )
            )


emit(generate())
