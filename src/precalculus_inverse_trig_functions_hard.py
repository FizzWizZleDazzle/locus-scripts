"""
precalculus - inverse_trig_functions (hard)
"""

from problem_utils import *


def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # sin(arctan(a/b)) or cos(arctan(a/b)) or tan(arcsin(a/b)) using right-triangle method
        composition_type = choice(['sin_arctan', 'cos_arctan', 'tan_arcsin', 'cos_arcsin', 'sin_arccos', 'tan_arccos'])

        if composition_type == 'sin_arctan':
            a = randint(1, 12)
            b = randint(1, 12)
            while gcd(a, b) > 1 or a == b:
                b = randint(1, 12)
            hyp = sqrt(a**2 + b**2)
            ans = simplify(Rational(a, 1) / hyp)
            return problem(
                question=f"Simplify $\\sin\\!\\left(\\arctan\\!\\left(\\dfrac{{{a}}}{{{b}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arctan\\!\\left(\\frac{{{a}}}{{{b}}}\\right)$, so $\\tan\\theta = \\frac{{{a}}}{{{b}}}$",
                    f"Right triangle: opposite $= {a}$, adjacent $= {b}$, hypotenuse $= \\sqrt{{{a**2}+{b**2}}} = {latex(hyp)}$",
                    f"$\\sin\\theta = \\frac{{{a}}}{{{latex(hyp)}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif composition_type == 'cos_arctan':
            a = randint(1, 12)
            b = randint(1, 12)
            while gcd(a, b) > 1 or a == b:
                b = randint(1, 12)
            hyp = sqrt(a**2 + b**2)
            ans = simplify(Rational(b, 1) / hyp)
            return problem(
                question=f"Simplify $\\cos\\!\\left(\\arctan\\!\\left(\\dfrac{{{a}}}{{{b}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arctan\\!\\left(\\frac{{{a}}}{{{b}}}\\right)$",
                    f"Hypotenuse $= {latex(hyp)}$",
                    f"$\\cos\\theta = \\frac{{{b}}}{{{latex(hyp)}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif composition_type == 'tan_arcsin':
            hyp = randint(5, 15)
            opp = randint(2, hyp - 1)
            while gcd(opp, hyp) > 1:
                opp = randint(2, hyp - 1)
            adj = sqrt(hyp**2 - opp**2)
            if not adj.is_rational:
                adj = sqrt(hyp**2 - opp**2)
            ans = simplify(Rational(opp, 1) / adj)
            return problem(
                question=f"Simplify $\\tan\\!\\left(\\arcsin\\!\\left(\\dfrac{{{opp}}}{{{hyp}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arcsin\\!\\left(\\frac{{{opp}}}{{{hyp}}}\\right)$, so $\\sin\\theta = \\frac{{{opp}}}{{{hyp}}}$",
                    f"Adjacent $= \\sqrt{{{hyp}^2 - {opp}^2}} = {latex(adj)}$",
                    f"$\\tan\\theta = \\frac{{{opp}}}{{{latex(adj)}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif composition_type == 'cos_arcsin':
            hyp = randint(5, 15)
            opp = randint(2, hyp - 1)
            while gcd(opp, hyp) > 1:
                opp = randint(2, hyp - 1)
            adj = sqrt(hyp**2 - opp**2)
            ans = simplify(adj / hyp)
            return problem(
                question=f"Simplify $\\cos\\!\\left(\\arcsin\\!\\left(\\dfrac{{{opp}}}{{{hyp}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arcsin\\!\\left(\\frac{{{opp}}}{{{hyp}}}\\right)$",
                    f"Adjacent $= {latex(adj)}$",
                    f"$\\cos\\theta = \\frac{{{latex(adj)}}}{{{hyp}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif composition_type == 'sin_arccos':
            hyp = randint(5, 15)
            adj = randint(2, hyp - 1)
            while gcd(adj, hyp) > 1:
                adj = randint(2, hyp - 1)
            opp = sqrt(hyp**2 - adj**2)
            ans = simplify(opp / hyp)
            return problem(
                question=f"Simplify $\\sin\\!\\left(\\arccos\\!\\left(\\dfrac{{{adj}}}{{{hyp}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arccos\\!\\left(\\frac{{{adj}}}{{{hyp}}}\\right)$, so $\\cos\\theta = \\frac{{{adj}}}{{{hyp}}}$",
                    f"Opposite $= \\sqrt{{{hyp}^2 - {adj}^2}} = {latex(opp)}$",
                    f"$\\sin\\theta = \\frac{{{latex(opp)}}}{{{hyp}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

        else:  # tan_arccos
            hyp = randint(5, 15)
            adj = randint(2, hyp - 1)
            while gcd(adj, hyp) > 1:
                adj = randint(2, hyp - 1)
            opp = sqrt(hyp**2 - adj**2)
            ans = simplify(opp / adj)
            return problem(
                question=f"Simplify $\\tan\\!\\left(\\arccos\\!\\left(\\dfrac{{{adj}}}{{{hyp}}}\\right)\\right)$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Let $\\theta = \\arccos\\!\\left(\\frac{{{adj}}}{{{hyp}}}\\right)$",
                    f"Opposite $= {latex(opp)}$",
                    f"$\\tan\\theta = \\frac{{{latex(opp)}}}{{{adj}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 2:
        # Solve arcsin(ax+b) = theta or arctan(ax) = theta
        func = choice(['arcsin', 'arccos', 'arctan'])

        if func == 'arcsin':
            theta_vals = [pi/6, pi/4, pi/3, pi/2, -pi/6, -pi/4, -pi/3, -pi/2]
            theta = choice(theta_vals)
            sin_val = sin(theta)
            a_val = choice([2, 3, 4, 5])
            b_val = choice([-3, -2, -1, 0, 1, 2, 3])
            ans = simplify((sin_val - b_val) / a_val)

            b_str = f" + {b_val}" if b_val > 0 else (f" - {abs(b_val)}" if b_val < 0 else "")
            return problem(
                question=f"Solve for $x$: $\\arcsin({a_val}x{b_str}) = {latex(theta)}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Take $\\sin$ of both sides: ${a_val}x{b_str} = \\sin\\!\\left({latex(theta)}\\right) = {latex(sin_val)}$",
                    f"$x = {latex(ans)}$"
                )
            )

        elif func == 'arccos':
            theta_vals = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi]
            theta = choice(theta_vals)
            cos_val = cos(theta)
            a_val = choice([2, 3, 4, 5])
            b_val = choice([-2, -1, 0, 1, 2])
            ans = simplify((cos_val - b_val) / a_val)

            b_str = f" + {b_val}" if b_val > 0 else (f" - {abs(b_val)}" if b_val < 0 else "")
            return problem(
                question=f"Solve for $x$: $\\arccos({a_val}x{b_str}) = {latex(theta)}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Take $\\cos$ of both sides: ${a_val}x{b_str} = \\cos\\!\\left({latex(theta)}\\right) = {latex(cos_val)}$",
                    f"$x = {latex(ans)}$"
                )
            )

        else:  # arctan
            theta_vals = [pi/6, pi/4, pi/3, -pi/6, -pi/4, -pi/3]
            theta = choice(theta_vals)
            tan_val = tan(theta)
            a_val = choice([2, 3, 4, 5])
            ans = simplify(tan_val / a_val)
            return problem(
                question=f"Solve for $x$: $\\arctan({a_val}x) = {latex(theta)}$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Take $\\tan$ of both sides: ${a_val}x = \\tan\\!\\left({latex(theta)}\\right) = {latex(tan_val)}$",
                    f"$x = {latex(ans)}$"
                )
            )

    elif problem_type == 3:
        # Exact value: arcsin(val1) + arccos(val2) or arctan(val1) - arctan(val2)
        variant = randint(1, 2)

        if variant == 1:
            vals_sin = [(Rational(1,2), pi/6), (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/3),
                        (-Rational(1,2), -pi/6), (-sqrt(2)/2, -pi/4), (-sqrt(3)/2, -pi/3)]
            vals_cos = [(Rational(1,2), pi/3), (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/6),
                        (0, pi/2), (1, 0), (-Rational(1,2), 2*pi/3)]

            val1, theta1 = choice(vals_sin)
            val2, theta2 = choice(vals_cos)
            ans = simplify(theta1 + theta2)

            return problem(
                question=f"Find the exact value: $\\arcsin\\!\\left({latex(val1)}\\right) + \\arccos\\!\\left({latex(val2)}\\right)$",
                answer=ans,
                difficulty=(1600, 1750),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"$\\arcsin\\!\\left({latex(val1)}\\right) = {latex(theta1)}$",
                    f"$\\arccos\\!\\left({latex(val2)}\\right) = {latex(theta2)}$",
                    f"Sum $= {latex(theta1)} + {latex(theta2)} = {latex(ans)}$"
                )
            )
        else:
            # arcsin(x) + arccos(x) = pi/2 identity with a specific value
            val = choice([Rational(1,2), sqrt(2)/2, sqrt(3)/2, 0, 1])
            ans = pi/2
            return problem(
                question=f"Evaluate $\\arcsin\\!\\left({latex(val)}\\right) + \\arccos\\!\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1600, 1750),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "Use the identity: $\\arcsin(x) + \\arccos(x) = \\dfrac{\\pi}{2}$ for all $x \\in [-1,1]$",
                    f"Answer: $\\dfrac{{\\pi}}{{2}}$"
                )
            )

    elif problem_type == 4:
        # Derivative of inverse trig function with chain rule
        deriv_type = choice(['arcsin_linear', 'arccos_linear', 'arctan_linear',
                             'arcsin_power', 'arctan_power'])

        if deriv_type == 'arcsin_linear':
            a_val = nonzero(-5, 5)
            b_val = randint(-3, 3)
            inner = a_val * x + b_val
            expr = asin(inner)
            ans = simplify(diff(expr, x))
            return problem(
                question=f"Find $\\dfrac{{d}}{{dx}}\\left[\\arcsin\\!\\left({latex(inner)}\\right)\\right]$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\dfrac{d}{dx}[\\arcsin(u)] = \\dfrac{1}{\\sqrt{1-u^2}} \\cdot u'$",
                    f"$u = {latex(inner)}$, $u' = {a_val}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif deriv_type == 'arccos_linear':
            a_val = nonzero(-5, 5)
            b_val = randint(-3, 3)
            inner = a_val * x + b_val
            expr = acos(inner)
            ans = simplify(diff(expr, x))
            return problem(
                question=f"Find $\\dfrac{{d}}{{dx}}\\left[\\arccos\\!\\left({latex(inner)}\\right)\\right]$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\dfrac{d}{dx}[\\arccos(u)] = \\dfrac{-1}{\\sqrt{1-u^2}} \\cdot u'$",
                    f"$u = {latex(inner)}$, $u' = {a_val}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif deriv_type == 'arctan_linear':
            a_val = nonzero(-5, 5)
            b_val = randint(-3, 3)
            inner = a_val * x + b_val
            expr = atan(inner)
            ans = simplify(diff(expr, x))
            return problem(
                question=f"Find $\\dfrac{{d}}{{dx}}\\left[\\arctan\\!\\left({latex(inner)}\\right)\\right]$",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\dfrac{d}{dx}[\\arctan(u)] = \\dfrac{1}{1+u^2} \\cdot u'$",
                    f"$u = {latex(inner)}$, $u' = {a_val}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )

        elif deriv_type == 'arcsin_power':
            n = choice([2, 3, 4])
            expr = asin(x**n)
            ans = simplify(diff(expr, x))
            return problem(
                question=f"Find $\\dfrac{{d}}{{dx}}\\left[\\arcsin\\!\\left(x^{{{n}}}\\right)\\right]$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\dfrac{d}{dx}[\\arcsin(u)] = \\dfrac{1}{\\sqrt{1-u^2}} \\cdot u'$",
                    f"$u = x^{{{n}}}$, $u' = {n}x^{{{n-1}}}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )

        else:  # arctan_power
            n = choice([2, 3, 4])
            expr = atan(x**n)
            ans = simplify(diff(expr, x))
            return problem(
                question=f"Find $\\dfrac{{d}}{{dx}}\\left[\\arctan\\!\\left(x^{{{n}}}\\right)\\right]$",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\dfrac{d}{dx}[\\arctan(u)] = \\dfrac{1}{1+u^2} \\cdot u'$",
                    f"$u = x^{{{n}}}$, $u' = {n}x^{{{n-1}}}$",
                    f"Answer: ${latex(ans)}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 5:
        # arctan addition formula: arctan(x) + arctan(y) = arctan((x+y)/(1-xy)) for xy < 1
        # Pick pairs with clean answers
        pairs = [
            (Rational(1,2), Rational(1,3), pi/4),
            (Rational(1,3), Rational(1,2), pi/4),
            (1, Rational(1,2), atan(Rational(3,1))),
            (Rational(2,3), Rational(1,5), atan(1)),
        ]
        x_val, y_val, _ = choice(pairs)
        if x_val * y_val < 1:
            ans = atan((x_val + y_val) / (1 - x_val * y_val))
            ans = simplify(ans)
            return problem(
                question=f"Evaluate $\\arctan\\!\\left({latex(x_val)}\\right) + \\arctan\\!\\left({latex(y_val)}\\right)$ exactly.",
                answer=ans,
                difficulty=(1750, 1900),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Use addition formula: $\\arctan a + \\arctan b = \\arctan\\!\\left(\\dfrac{{a+b}}{{1-ab}}\\right)$ when $ab < 1$",
                    f"$= \\arctan\\!\\left(\\dfrac{{{latex(x_val)}+{latex(y_val)}}}{{1 - {latex(x_val)} \\cdot {latex(y_val)}}}\\right) = {latex(ans)}$"
                )
            )

        # Fallback
        return problem(
            question="Evaluate $\\arctan(1) + \\arctan(1)$.",
            answer=pi/2,
            difficulty=(1700, 1800),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                "$\\arctan(1) = \\dfrac{\\pi}{4}$",
                "$\\dfrac{\\pi}{4} + \\dfrac{\\pi}{4} = \\dfrac{\\pi}{2}$"
            )
        )

    else:
        # arcsin(sin(x)) with x outside principal range — various quadrants
        scenarios = [
            (pi - pi/6, pi/6, "Q2"),
            (pi - pi/4, pi/4, "Q2"),
            (pi - pi/3, pi/3, "Q2"),
            (-pi + pi/6, -pi/6, "Q3 negative"),
            (-pi + pi/4, -pi/4, "Q3 negative"),
            (pi + pi/6, -pi/6, "Q3"),
            (pi + pi/4, -pi/4, "Q3"),
            (2*pi - pi/6, -pi/6, "Q4"),
            (2*pi - pi/4, -pi/4, "Q4"),
            (2*pi - pi/3, -pi/3, "Q4"),
        ]
        x_expr, ans, label = choice(scenarios)

        return problem(
            question=f"Simplify $\\arcsin\\!\\left(\\sin\\!\\left({latex(x_expr)}\\right)\\right)$",
            answer=simplify(ans),
            difficulty=(1600, 1750),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"$\\sin\\!\\left({latex(x_expr)}\\right) = {latex(simplify(sin(x_expr)))}$",
                f"The range of $\\arcsin$ is $\\left[-\\dfrac{{\\pi}}{{2}}, \\dfrac{{\\pi}}{{2}}\\right]$",
                f"Find the angle in that range with the same sine value",
                f"Answer: ${latex(simplify(ans))}$"
            )
        )

emit(generate())
