"""
precalculus - polar_curves (easy)
"""

from problem_utils import *

THETA_OPTIONS = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6,
                 pi, 7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2, 5*pi/3, 7*pi/4, 11*pi/6]


def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Convert polar point to Cartesian — wide r and theta range
        r_val = randint(1, 12)
        theta_val = choice(THETA_OPTIONS)

        x_coord = simplify(r_val * cos(theta_val))
        y_coord = simplify(r_val * sin(theta_val))

        return problem(
            question=f"Convert the polar point $\\left({r_val},\\, {latex(theta_val)}\\right)$ to Cartesian coordinates $(x, y)$.",
            answer=(x_coord, y_coord),
            difficulty=(1000, 1200),
            topic="precalculus/polar_curves",
            solution=steps(
                f"$x = r\\cos\\theta = {r_val}\\cos\\!\\left({latex(theta_val)}\\right) = {latex(x_coord)}$",
                f"$y = r\\sin\\theta = {r_val}\\sin\\!\\left({latex(theta_val)}\\right) = {latex(y_coord)}$",
                f"Answer: $\\left({latex(x_coord)},\\, {latex(y_coord)}\\right)$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Evaluate r for a simple polar curve at a given theta
        a_val = randint(1, 10)
        curve_type = choice(['constant', 'cosine', 'sine', 'linear_theta'])

        if curve_type == 'constant':
            theta_val = choice(THETA_OPTIONS)
            ans = a_val
            return problem(
                question=f"For the polar curve $r = {a_val}$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1000, 1100),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r = {a_val}$ is constant for all $\\theta$",
                    f"$r = {a_val}$"
                )
            )

        elif curve_type == 'cosine':
            theta_val = choice([0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi])
            ans = simplify(a_val * cos(theta_val))
            return problem(
                question=f"For the polar curve $r = {a_val}\\cos(\\theta)$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1100, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Substitute: $r = {a_val}\\cos\\!\\left({latex(theta_val)}\\right) = {a_val} \\cdot {latex(cos(theta_val))} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif curve_type == 'sine':
            theta_val = choice([0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi])
            ans = simplify(a_val * sin(theta_val))
            return problem(
                question=f"For the polar curve $r = {a_val}\\sin(\\theta)$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1100, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Substitute: $r = {a_val}\\sin\\!\\left({latex(theta_val)}\\right) = {a_val} \\cdot {latex(sin(theta_val))} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        else:  # r = a*theta
            theta_val = choice([pi/6, pi/4, pi/3, pi/2, pi])
            ans = simplify(a_val * theta_val)
            return problem(
                question=f"For the spiral $r = {a_val}\\theta$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=ans,
                difficulty=(1100, 1200),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Substitute: $r = {a_val} \\cdot {latex(theta_val)} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 3:
        # Convert Cartesian to polar: find r
        x_val = choice([0, 1, 2, 3, 4, 5, 6, 7, 8])
        y_val = choice([0, 1, 2, 3, 4, 5, 6, 7, 8])
        while x_val == 0 and y_val == 0:
            x_val = randint(1, 8)
        r_sq = x_val**2 + y_val**2
        ans = sqrt(r_sq)

        return problem(
            question=f"Find $r$ for the Cartesian point $({x_val},\\, {y_val})$.",
            answer=ans,
            difficulty=(1100, 1300),
            topic="precalculus/polar_curves",
            solution=steps(
                f"$r = \\sqrt{{x^2 + y^2}} = \\sqrt{{{x_val}^2 + {y_val}^2}} = \\sqrt{{{r_sq}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Identify curve type from polar equation
        curve_choice = randint(1, 5)

        if curve_choice == 1:
            a_val = randint(1, 8)
            return problem(
                question=f"What shape is the polar curve $r = {a_val}$?",
                answer="circle",
                difficulty=(1000, 1100),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r = {a_val}$ means constant distance from the origin — a circle of radius ${a_val}$"
                )
            )
        elif curve_choice == 2:
            theta_val = choice([pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4])
            return problem(
                question=f"What shape is the polar curve $\\theta = {latex(theta_val)}$?",
                answer="line",
                difficulty=(1050, 1150),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Constant angle $\\theta = {latex(theta_val)}$ describes a ray (line) through the origin"
                )
            )
        elif curve_choice == 3:
            a_val = randint(1, 5)
            return problem(
                question=f"What is the name of the curve $r = {a_val}(1 + \\cos\\theta)$?",
                answer="cardioid",
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"The form $r = a(1 + \\cos\\theta)$ is a cardioid (heart-shaped curve)"
                )
            )
        elif curve_choice == 4:
            n = choice([2, 3, 4, 5])
            a_val = randint(1, 5)
            return problem(
                question=f"How many petals does the rose $r = {a_val}\\cos({n}\\theta)$ have?",
                answer=n if n % 2 == 1 else 2*n,
                difficulty=(1150, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"For $r = a\\cos(n\\theta)$: odd $n$ gives $n$ petals; even $n$ gives $2n$ petals",
                    f"$n = {n}$ is {'odd' if n % 2 == 1 else 'even'}: {n if n % 2 == 1 else 2*n} petals"
                )
            )
        else:
            a_val = randint(1, 5)
            return problem(
                question=f"Is the curve $r = {a_val}\\cos\\theta$ a circle or a cardioid?",
                answer="circle",
                difficulty=(1150, 1250),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"$r = {a_val}\\cos\\theta$ converts to $(x - \\frac{{{a_val}}}{{2}})^2 + y^2 = (\\frac{{{a_val}}}{{2}})^2$, a circle"
                )
            )

    elif problem_type == 5:
        # Find smallest positive theta where r = 0 for r = a*cos or a*sin
        a_val = randint(1, 8)
        trig_choice = choice(['cos', 'sin', 'cos2', 'sin2'])

        if trig_choice == 'cos':
            return problem(
                question=f"Find the smallest positive $\\theta$ where $r = 0$ for $r = {a_val}\\cos(\\theta)$.",
                answer=pi/2,
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set $r = 0$: $\\cos\\theta = 0$",
                    f"Smallest positive solution: $\\theta = \\dfrac{{\\pi}}{{2}}$"
                ),
                calculator="scientific"
            )
        elif trig_choice == 'sin':
            return problem(
                question=f"Find the smallest positive $\\theta$ where $r = 0$ for $r = {a_val}\\sin(\\theta)$.",
                answer=pi,
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set $r = 0$: $\\sin\\theta = 0$",
                    f"Smallest positive solution: $\\theta = \\pi$"
                ),
                calculator="scientific"
            )
        elif trig_choice == 'cos2':
            return problem(
                question=f"Find the smallest positive $\\theta$ where $r = 0$ for $r = {a_val}\\cos(2\\theta)$.",
                answer=pi/4,
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set $r = 0$: $\\cos(2\\theta) = 0 \\Rightarrow 2\\theta = \\dfrac{{\\pi}}{{2}}$",
                    f"Smallest positive: $\\theta = \\dfrac{{\\pi}}{{4}}$"
                ),
                calculator="scientific"
            )
        else:  # sin2
            return problem(
                question=f"Find the smallest positive $\\theta$ where $r = 0$ for $r = {a_val}\\sin(2\\theta)$.",
                answer=pi/2,
                difficulty=(1200, 1300),
                topic="precalculus/polar_curves",
                solution=steps(
                    f"Set $r = 0$: $\\sin(2\\theta) = 0 \\Rightarrow 2\\theta = \\pi$",
                    f"Smallest positive: $\\theta = \\dfrac{{\\pi}}{{2}}$"
                ),
                calculator="scientific"
            )

    else:
        # Maximum value of r for simple polar curves
        a_val = randint(1, 8)
        b_val = randint(1, 8)
        limacon_type = choice(['cos', 'sin'])
        trig_str = '\\cos' if limacon_type == 'cos' else '\\sin'

        ans = a_val + b_val

        return problem(
            question=f"Find the maximum value of $r$ for the curve $r = {a_val} + {b_val}{trig_str}(\\theta)$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="precalculus/polar_curves",
            solution=steps(
                f"Maximum of ${trig_str}(\\theta)$ is $1$",
                f"Maximum $r = {a_val} + {b_val} \\cdot 1 = {ans}$"
            )
        )

emit(generate())
