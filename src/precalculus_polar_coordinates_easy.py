"""
precalculus - polar_coordinates (easy)
"""

from problem_utils import *

# Full set of standard angles for varied theta values
THETA_OPTS = [
    0, pi/6, pi/4, pi/3, pi/2,
    2*pi/3, 3*pi/4, 5*pi/6, pi,
    7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2,
    5*pi/3, 7*pi/4, 11*pi/6,
]

# Rectanglar points with clean polar forms (x, y, r, theta)
RECT_POLAR = [
    (1,  0,  1, 0),
    (0,  1,  1, pi/2),
    (-1, 0,  1, pi),
    (0, -1,  1, 3*pi/2),
    (1,  1,  sqrt(2), pi/4),
    (-1, 1,  sqrt(2), 3*pi/4),
    (-1,-1,  sqrt(2), 5*pi/4),
    (1, -1,  sqrt(2), 7*pi/4),
    (sqrt(3), 1, 2, pi/6),
    (1, sqrt(3), 2, pi/3),
    (-1, sqrt(3), 2, 2*pi/3),
    (-sqrt(3), 1, 2, 5*pi/6),
    (-sqrt(3),-1, 2, 7*pi/6),
    (-1,-sqrt(3), 2, 4*pi/3),
    (1, -sqrt(3), 2, 5*pi/3),
    (sqrt(3),-1, 2, 11*pi/6),
]


def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Convert polar -> rectangular: (r, theta) -> (x, y)
        r_val = randint(1, 10)
        theta_val = choice(THETA_OPTS)
        x_val = simplify(r_val * cos(theta_val))
        y_val = simplify(r_val * sin(theta_val))
        ans = fmt_tuple([x_val, y_val])
        return problem(
            question=f"Convert the polar coordinates $\\left({r_val},\\,{latex(theta_val)}\\right)$ to rectangular $(x,y)$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "$x = r\\cos\\theta$, $y = r\\sin\\theta$",
                f"$x = {r_val}\\cos\\!\\left({latex(theta_val)}\\right) = {latex(x_val)}$",
                f"$y = {r_val}\\sin\\!\\left({latex(theta_val)}\\right) = {latex(y_val)}$",
                f"$(x,y) = ({latex(x_val)},\\,{latex(y_val)})$"
            ),
            answer_type="tuple"
        )

    elif problem_type == 2:
        # Convert rectangular -> polar: find r and theta
        rec = choice(RECT_POLAR)
        x_v, y_v, r_v, theta_v = rec
        # Scale r by random integer 1-6
        scale = randint(1, 6)
        x_val = simplify(scale * x_v)
        y_val = simplify(scale * y_v)
        r_val = simplify(scale * r_v)

        ask = choice(['r', 'theta', 'both'])
        if ask == 'r':
            ans = r_val
            return problem(
                question=f"Find $r$ for the rectangular point $({latex(x_val)},\\,{latex(y_val)})$.",
                answer=ans,
                difficulty=(1050, 1200),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    "$r = \\sqrt{x^2 + y^2}$",
                    f"$r = \\sqrt{{({latex(x_val)})^2 + ({latex(y_val)})^2}} = {latex(r_val)}$"
                )
            )
        elif ask == 'theta':
            ans = theta_v
            return problem(
                question=f"Find $\\theta \\in [0, 2\\pi)$ for the rectangular point $({latex(x_val)},\\,{latex(y_val)})$.",
                answer=ans,
                difficulty=(1100, 1250),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    "$\\theta = \\operatorname{atan2}(y, x)$, adjusting for quadrant",
                    f"$\\theta = {latex(theta_v)}$"
                )
            )
        else:
            ans = fmt_tuple([r_val, theta_v])
            return problem(
                question=f"Convert $({latex(x_val)},\\,{latex(y_val)})$ to polar form $(r,\\theta)$ with $r>0$, $0\\le\\theta<2\\pi$.",
                answer=ans,
                difficulty=(1100, 1250),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"$r = {latex(r_val)}$",
                    f"$\\theta = {latex(theta_v)}$",
                    f"$(r,\\theta)=({latex(r_val)},\\,{latex(theta_v)})$"
                ),
                answer_type="tuple"
            )

    elif problem_type == 3:
        # Identify shape from simple polar equation
        eq_type = choice(['circle_r', 'ray', 'circle_cos', 'circle_sin', 'line_x', 'line_y'])

        if eq_type == 'circle_r':
            r_val = randint(1, 8)
            return problem(
                question=f"What shape does the polar equation $r = {r_val}$ describe?",
                answer="circle",
                difficulty=(1000, 1100),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"$r = {r_val}$ means all points are at distance ${r_val}$ from the origin",
                    f"This is a circle of radius ${r_val}$ centered at the origin"
                ),
                answer_type="expression"
            )
        elif eq_type == 'ray':
            theta_val = choice([pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6])
            return problem(
                question=f"What shape does $\\theta = {latex(theta_val)}$ describe?",
                answer="line",
                difficulty=(1050, 1150),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    "A constant angle $\\theta = c$ means every point lies on a ray through the origin",
                    "This describes a line (ray) through the origin"
                ),
                answer_type="expression"
            )
        elif eq_type == 'circle_cos':
            a_val = choice([2, 4, 6, 8])
            return problem(
                question=f"What shape does $r = {a_val}\\cos\\theta$ describe?",
                answer="circle",
                difficulty=(1100, 1250),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"Multiply by $r$: $r^2 = {a_val}r\\cos\\theta$",
                    f"Substitute $r^2=x^2+y^2$, $r\\cos\\theta=x$: $x^2+y^2={a_val}x$",
                    f"Complete the square: $(x-{a_val//2})^2+y^2={a_val//2}^2$",
                    "This is a circle"
                ),
                answer_type="expression"
            )
        elif eq_type == 'circle_sin':
            a_val = choice([2, 4, 6, 8])
            return problem(
                question=f"What shape does $r = {a_val}\\sin\\theta$ describe?",
                answer="circle",
                difficulty=(1100, 1250),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"Multiply by $r$: $r^2 = {a_val}r\\sin\\theta$",
                    f"$x^2+y^2={a_val}y$",
                    f"$(x)^2+(y-{a_val//2})^2={a_val//2}^2$: circle"
                ),
                answer_type="expression"
            )
        elif eq_type == 'line_x':
            a_val = randint(1, 6)
            return problem(
                question=f"Convert $r\\cos\\theta = {a_val}$ to rectangular form.",
                answer=Eq(x, a_val),
                difficulty=(1050, 1200),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    "$r\\cos\\theta = x$",
                    f"$x = {a_val}$"
                ),
                answer_type="equation"
            )
        else:
            a_val = randint(1, 6)
            return problem(
                question=f"Convert $r\\sin\\theta = {a_val}$ to rectangular form.",
                answer=Eq(y, a_val),
                difficulty=(1050, 1200),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    "$r\\sin\\theta = y$",
                    f"$y = {a_val}$"
                ),
                answer_type="equation"
            )

    elif problem_type == 4:
        # Evaluate r at given theta for a simple polar curve
        a_val = randint(1, 8)
        theta_val = choice([0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, pi])
        curve = choice(['cos', 'sin', 'const_plus_cos'])

        if curve == 'cos':
            r_result = simplify(a_val * cos(theta_val))
            return problem(
                question=f"For $r = {a_val}\\cos\\theta$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=r_result,
                difficulty=(1000, 1100),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"$r = {a_val}\\cos\\!\\left({latex(theta_val)}\\right) = {a_val} \\cdot {latex(simplify(cos(theta_val)))} = {latex(r_result)}$"
                )
            )
        elif curve == 'sin':
            r_result = simplify(a_val * sin(theta_val))
            return problem(
                question=f"For $r = {a_val}\\sin\\theta$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=r_result,
                difficulty=(1000, 1100),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"$r = {a_val}\\sin\\!\\left({latex(theta_val)}\\right) = {a_val} \\cdot {latex(simplify(sin(theta_val)))} = {latex(r_result)}$"
                )
            )
        else:
            b_val = randint(1, 5)
            r_result = simplify(a_val + b_val * cos(theta_val))
            return problem(
                question=f"For $r = {a_val} + {b_val}\\cos\\theta$, find $r$ when $\\theta = {latex(theta_val)}$.",
                answer=r_result,
                difficulty=(1050, 1200),
                topic="precalculus/polar_coordinates",
                solution=steps(
                    f"$r = {a_val} + {b_val}\\cos\\!\\left({latex(theta_val)}\\right) = {a_val} + {b_val}\\cdot{latex(simplify(cos(theta_val)))} = {latex(r_result)}$"
                )
            )

    elif problem_type == 5:
        # Negative r: plot the equivalent positive-r representation
        r_val = randint(2, 8)
        theta_val = choice(THETA_OPTS)
        neg_theta = simplify(theta_val + pi)
        if neg_theta >= 2 * pi:
            neg_theta = simplify(neg_theta - 2 * pi)

        return problem(
            question=(f"The polar point $(-{r_val},\\,{latex(theta_val)})$ is the same as "
                      f"$({r_val},\\,\\theta)$ for what $\\theta \\in [0, 2\\pi)$?"),
            answer=neg_theta,
            difficulty=(1100, 1250),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "A negative $r$ flips the point through the origin",
                f"$(-{r_val}, {latex(theta_val)}) = ({r_val}, {latex(theta_val)} + \\pi)$",
                f"$= ({r_val}, {latex(neg_theta)})$"
            )
        )

    else:
        # Compute r^2 and theta (easy angle) for a given rectangular point
        x_val = randint(1, 8)
        y_val = randint(1, 8)
        r_sq = x_val**2 + y_val**2
        return problem(
            question=f"For the rectangular point $({x_val},\\,{y_val})$, find $r^2$.",
            answer=r_sq,
            difficulty=(1000, 1100),
            topic="precalculus/polar_coordinates",
            solution=steps(
                "$r^2 = x^2 + y^2$",
                f"$r^2 = {x_val}^2 + {y_val}^2 = {x_val**2} + {y_val**2} = {r_sq}$"
            )
        )


emit(generate())
