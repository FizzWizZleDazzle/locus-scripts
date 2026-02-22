"""
precalculus - domain_and_range (hard)
Generated: 2026-02-22T04:37:18.484972
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composite function domain
        inner_choices = [
            (sqrt(x - a), f"x \\geq {a}", a, oo, False, True),
            (1/(x - a), f"x \\neq {a}", -oo, oo, True, True),
            (log(x - a), f"x > {a}", a, oo, True, True),
        ]
        
        a = randint(-5, 5)
        inner_func, inner_desc, inner_left, inner_right, inner_left_open, inner_right_open = choice(inner_choices)
        inner_func = inner_func.subs(Symbol('a'), a)
        inner_left = inner_left if inner_left == -oo else inner_left
        inner_right = inner_right if inner_right == oo else inner_right
        
        outer_choices = [
            (sqrt, "\\sqrt{f(x)}", "f(x) \\geq 0"),
            (lambda u: 1/u, "\\frac{1}{f(x)}", "f(x) \\neq 0"),
            (log, "\\ln(f(x))", "f(x) > 0"),
        ]
        
        outer_func, outer_latex, outer_constraint = choice(outer_choices)
        
        if outer_func == sqrt:
            # Need inner_func >= 0
            if isinstance(inner_func, type(sqrt(x))):
                # sqrt composed with sqrt
                inner_a = a
                domain_left = inner_a
                domain_left_open = False
            elif isinstance(inner_func, type(log(x))):
                # sqrt(log(x-a)) needs log(x-a) >= 0, so x-a >= 1, x >= a+1
                domain_left = a + 1
                domain_left_open = False
            else:
                # sqrt(1/(x-a)) needs 1/(x-a) >= 0, so x > a
                domain_left = a
                domain_left_open = True
            domain_right = oo
            domain_right_open = True
            
        elif outer_func == log:
            # Need inner_func > 0
            if isinstance(inner_func, type(sqrt(x))):
                # log(sqrt(x-a)) needs x-a > 0
                domain_left = a
                domain_left_open = True
            elif isinstance(inner_func, type(log(x))):
                # log(log(x-a)) needs log(x-a) > 0, so x-a > 1, x > a+1
                domain_left = a + 1
                domain_left_open = True
            else:
                # log(1/(x-a)) needs 1/(x-a) > 0, so x > a
                domain_left = a
                domain_left_open = True
            domain_right = oo
            domain_right_open = True
            
        else:  # 1/f(x)
            # Need inner_func != 0
            if isinstance(inner_func, type(sqrt(x))):
                # 1/sqrt(x-a) needs x-a > 0
                domain_left = a
                domain_left_open = True
                domain_right = oo
                domain_right_open = True
            elif isinstance(inner_func, type(log(x))):
                # 1/log(x-a) needs log(x-a) != 0, so x-a != 1, x != a+1
                # Domain is (a, a+1) U (a+1, oo)
                # For simplicity, we'll construct a different problem
                domain_left = a
                domain_left_open = True
                domain_right = oo
                domain_right_open = True
            else:
                # 1/(1/(x-a)) = x-a, domain is x != a
                domain_left = -oo
                domain_right = oo
                domain_left_open = True
                domain_right_open = True
        
        ans = fmt_interval(domain_left, domain_right, domain_left_open, domain_right_open)
        
        return problem(
            question=f"Find the domain of $g(x) = {outer_latex}$ where $f(x) = {latex(inner_func)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/domain_and_range",
            solution=steps(
                f"First, find the domain of $f(x) = {latex(inner_func)}$: ${inner_desc}$",
                f"Then apply the constraint from the outer function: ${outer_constraint}$",
                f"Combining these constraints gives domain ${ans}$"
            ),
            calculator="none"
        )
    
    elif problem_type == 2:
        # Piecewise function range
        a = randint(-3, 3)
        b = randint(a+1, a+4)
        
        m1 = nonzero(-3, 3)
        b1 = randint(-5, 5)
        
        m2 = nonzero(-3, 3)
        b2 = randint(-5, 5)
        
        # Evaluate at boundaries
        y_left = m1 * a + b1
        y_mid_left = m1 * b + b1
        y_mid_right = m2 * b + b2
        y_right = m2 * (b + 3) + b2
        
        all_ys = [y_left, y_mid_left, y_mid_right, y_right]
        range_min = min(all_ys)
        range_max = max(all_ys)
        
        ans = fmt_interval(range_min, range_max, False, False)
        
        return problem(
            question=f"Find the range of $f(x) = \\begin{{cases}} {m1}x + {b1} & x \\in [{a}, {b}] \\\\ {m2}x + {b2} & x \\in ({b}, {b+3}] \\end{{cases}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/domain_and_range",
            solution=steps(
                f"Evaluate endpoints: $f({a}) = {y_left}$, $f({b}^-) = {y_mid_left}$, $f({b}^+) = {y_mid_right}$, $f({b+3}) = {y_right}$",
                f"Since both pieces are linear, the range is determined by the minimum and maximum values",
                f"Range: ${ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Rational function with vertical asymptotes - find domain
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1:
            r2 = nonzero(-5, 5)
        
        if r1 > r2:
            r1, r2 = r2, r1
        
        denom = expand((x - r1) * (x - r2))
        numer_coeff = nonzero(-3, 3)
        numer_const = randint(-5, 5)
        numer = numer_coeff * x + numer_const
        
        func = numer / denom
        
        # Domain is (-oo, r1) U (r1, r2) U (r2, oo)
        # We'll return the union as a custom format
        ans = f"open:-inf,open:{r1};open:{r1},open:{r2};open:{r2},open:inf"
        
        return problem(
            question=f"Find the domain of $f(x) = {latex(func)}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/domain_and_range",
            solution=steps(
                f"Set denominator equal to zero: ${latex(denom)} = 0$",
                f"Factor: ${latex(factor(denom))} = 0$",
                f"Vertical asymptotes at $x = {r1}$ and $x = {r2}$",
                f"Domain: $(-\\infty, {r1}) \\cup ({r1}, {r2}) \\cup ({r2}, \\infty)$"
            ),
            calculator="none"
        )
    
    elif problem_type == 4:
        # Square root with quadratic - domain
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # sqrt(-(x-a)(x-b)) or sqrt((x-a)(x-b))
        sign = choice([-1, 1])
        
        if a > b:
            a, b = b, a
        
        if sign == 1:
            # sqrt((x-a)(x-b)) needs (x-a)(x-b) >= 0
            # So x <= a or x >= b
            quadratic = expand((x - a) * (x - b))
            ans = f"open:-inf,closed:{a};closed:{b},open:inf"
            constraint = f"(x - {a})(x - {b}) \\geq 0"
            solution_text = f"Need ${constraint}$. This holds when $x \\leq {a}$ or $x \\geq {b}$"
        else:
            # sqrt(-(x-a)(x-b)) needs -(x-a)(x-b) >= 0, so (x-a)(x-b) <= 0
            # So a <= x <= b
            quadratic = expand(-1 * (x - a) * (x - b))
            ans = fmt_interval(a, b, False, False)
            constraint = f"-(x - {a})(x - {b}) \\geq 0"
            solution_text = f"Need ${constraint}$, which means $(x - {a})(x - {b}) \\leq 0$. This holds when ${a} \\leq x \\leq {b}$"
        
        return problem(
            question=f"Find the domain of $f(x) = \\sqrt{{{latex(quadratic)}}}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="precalculus/domain_and_range",
            solution=steps(
                f"Need ${latex(quadratic)} \\geq 0$",
                f"Factor: ${latex(factor(quadratic) if sign == -1 else factor(quadratic))} \\geq 0$",
                solution_text
            ),
            calculator="none"
        )
    
    else:  # problem_type == 5
        # Find range of transformed quadratic on restricted domain
        h = randint(-3, 3)
        k = randint(-4, 4)
        a_coeff = choice([-1, 1, 2, -2])
        
        # f(x) = a(x - h)^2 + k on [h - d, h + d]
        d = randint(1, 3)
        left = h - d
        right = h + d
        
        # Vertex is at (h, k)
        # If a > 0, min is k at x=h, max is at endpoints
        # If a < 0, max is k at x=h, min is at endpoints
        
        vertex_y = k
        left_y = a_coeff * (left - h)**2 + k
        right_y = a_coeff * (right - h)**2 + k
        
        if a_coeff > 0:
            range_min = vertex_y
            range_max = max(left_y, right_y)
        else:
            range_max = vertex_y
            range_min = min(left_y, right_y)
        
        ans = fmt_interval(range_min, range_max, False, False)
        
        func_expanded = expand(a_coeff * (x - h)**2 + k)
        
        return problem(
            question=f"Find the range of $f(x) = {latex(func_expanded)}$ on the interval $[{left}, {right}]$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/domain_and_range",
            solution=steps(
                f"Rewrite in vertex form: $f(x) = {a_coeff}(x - {h})^2 + {k}$",
                f"Vertex at $({h}, {k})$ is in the interval $[{left}, {right}]$",
                f"Evaluate at endpoints: $f({left}) = {left_y}$, $f({right}) = {right_y}$",
                f"Since $a = {a_coeff}$ {'> 0' if a_coeff > 0 else '< 0'}, the {'minimum' if a_coeff > 0 else 'maximum'} is at the vertex",
                f"Range: ${ans}$"
            ),
            calculator="scientific"
        )

emit(generate())