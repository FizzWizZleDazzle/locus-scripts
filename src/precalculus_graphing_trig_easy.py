"""
precalculus - graphing_trig (easy)
"""

from problem_utils import *
from svg_utils import Graph

# Wide pools for varied problems
AMP_POOL   = [1, 2, 3, 4, 5]
B_POOL     = [Rational(1, 2), 1, 2, 3, 4]
PHASE_POOL = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi]
VERT_POOL  = [-4, -3, -2, -1, 1, 2, 3, 4]


def generate():
    problem_type = randint(1, 7)

    if problem_type == 1:
        # Amplitude of y = A*f(x)
        amp = choice(AMP_POOL[1:])   # 2..5
        func_name = choice(['sin', 'cos'])
        return problem(
            question=f"What is the amplitude of $y = {amp}\\{func_name}(x)$?",
            answer=amp,
            difficulty=(1000, 1100),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Amplitude $= |A|$ where $A$ is the coefficient of $\\{func_name}$",
                f"$|{amp}| = {amp}$"
            )
        )

    elif problem_type == 2:
        # Period of y = f(Bx)
        b = choice([Rational(1, 2), Rational(1, 3), 2, 3, 4, 5])
        func_name = choice(['sin', 'cos'])
        period = simplify(2 * pi / b)
        return problem(
            question=f"What is the period of $y = \\{func_name}\\!\\left({latex(b)}x\\right)$?",
            answer=period,
            difficulty=(1100, 1200),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Period $= \\dfrac{{2\\pi}}{{|B|}}$",
                f"$B = {latex(b)}$, so period $= \\dfrac{{2\\pi}}{{{latex(b)}}} = {latex(period)}$"
            )
        )

    elif problem_type == 3:
        # Phase shift of y = f(x - C)
        C = choice([pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi,
                    -pi/6, -pi/4, -pi/3, -pi/2])
        func_name = choice(['sin', 'cos'])
        shift_dir = "right" if C > 0 else "left"
        C_display = latex(C)
        return problem(
            question=f"What is the phase shift of $y = \\{func_name}\\!\\left(x - {latex(C)}\\right)$?",
            answer=C,
            difficulty=(1100, 1200),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"For $y = f(x - C)$, the phase shift is $C$ ({shift_dir} if $C>0$, left if $C<0$)",
                f"$C = {C_display}$"
            )
        )

    elif problem_type == 4:
        # Vertical shift (midline)
        k = choice(VERT_POOL)
        func_name = choice(['sin', 'cos'])
        sign_str = "+" if k > 0 else ""
        return problem(
            question=f"What is the midline of $y = \\{func_name}(x) {sign_str if k >= 0 else ''} {k}$?",
            answer=k,
            difficulty=(1000, 1100),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"The midline is $y = k$ where $k$ is the vertical shift",
                f"$k = {k}$, so midline: $y = {k}$"
            )
        )

    elif problem_type == 5:
        # Maximum value of y = A*f(x) + k
        amp = choice(AMP_POOL[1:])
        k = choice([-3, -2, -1, 0, 1, 2, 3])
        func_name = choice(['sin', 'cos'])
        max_val = amp + k
        return problem(
            question=f"What is the maximum value of $y = {amp}\\{func_name}(x) + {k}$?",
            answer=max_val,
            difficulty=(1100, 1200),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Maximum of $\\{func_name}(x)$ is $1$",
                f"Maximum of ${amp}\\{func_name}(x)$ is ${amp}$",
                f"Adding vertical shift: ${amp} + ({k}) = {max_val}$"
            )
        )

    elif problem_type == 6:
        # Minimum value of y = A*f(x) + k
        amp = choice(AMP_POOL[1:])
        k = choice([-3, -2, -1, 0, 1, 2, 3])
        func_name = choice(['sin', 'cos'])
        min_val = -amp + k
        return problem(
            question=f"What is the minimum value of $y = {amp}\\{func_name}(x) + {k}$?",
            answer=min_val,
            difficulty=(1100, 1200),
            topic="precalculus/graphing_trig",
            solution=steps(
                f"Minimum of $\\{func_name}(x)$ is $-1$",
                f"Minimum of ${amp}\\{func_name}(x)$ is $-{amp}$",
                f"Adding vertical shift: $-{amp} + ({k}) = {min_val}$"
            )
        )

    else:
        # Identify which parameter changes the period vs amplitude
        amp = choice(AMP_POOL[1:])
        b = choice([2, 3, 4])
        func_name = choice(['sin', 'cos'])
        period = simplify(2 * pi / b)
        ask = choice(['amplitude', 'period'])
        if ask == 'amplitude':
            return problem(
                question=f"For $y = {amp}\\{func_name}({b}x)$, what is the amplitude?",
                answer=amp,
                difficulty=(1100, 1250),
                topic="precalculus/graphing_trig",
                solution=steps(
                    "Amplitude is the absolute value of the leading coefficient",
                    f"Amplitude $= {amp}$"
                )
            )
        else:
            return problem(
                question=f"For $y = {amp}\\{func_name}({b}x)$, what is the period?",
                answer=period,
                difficulty=(1100, 1250),
                topic="precalculus/graphing_trig",
                solution=steps(
                    f"Period $= \\dfrac{{2\\pi}}{{B}} = \\dfrac{{2\\pi}}{{{b}}} = {latex(period)}$"
                )
            )


emit(generate())
