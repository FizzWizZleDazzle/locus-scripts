"""
algebra2 - radical_equations (hard)
Generated: 2026-02-22T04:27:45.035985
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Radical equation with variable under two radicals, requires squaring twice
        # Example: sqrt(x+a) + sqrt(x+b) = c
        a = randint(1, 8)
        b = randint(a+1, a+8)
        
        # Work backward from a clean solution
        x_val = randint(5, 15)
        c = int(sqrt(x_val + a) + sqrt(x_val + b))
        
        # Verify it's a good problem (integer under both radicals)
        if not (isinstance(sqrt(x_val + a), int) or (x_val + a) == int(sqrt(x_val + a))**2):
            x_val = randint(1, 20)
            c = randint(4, 10)
        
        equation = Eq(sqrt(x + a) + sqrt(x + b), c)
        solutions = solve(equation, x)
        
        # Filter for valid solutions (non-negative under radicals)
        valid_sols = []
        for sol in solutions:
            if sol.is_real and sol + a >= 0 and sol + b >= 0:
                # Check it's actually a solution (not extraneous)
                check = sqrt(sol + a) + sqrt(sol + b)
                if simplify(check - c) == 0:
                    valid_sols.append(sol)
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        elif len(valid_sols) > 1:
            ans = FiniteSet(*valid_sols)
        else:
            ans = FiniteSet()
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x+{a}}} + \\sqrt{{x+{b}}} = {c}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Isolate one radical: $\\sqrt{{x+{a}}} = {c} - \\sqrt{{x+{b}}}$",
                f"Square both sides: $x+{a} = {c**2} - {2*c}\\sqrt{{x+{b}}} + (x+{b})$",
                f"Simplify: ${a} = {c**2 + b} - {2*c}\\sqrt{{x+{b}}}$",
                f"Isolate the radical: ${2*c}\\sqrt{{x+{b}}} = {c**2 + b - a}$",
                f"Square again and solve for $x$",
                f"Check solution(s) in original equation to eliminate extraneous roots",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Radical equation with rational expression under radical
        # Example: sqrt((ax+b)/(cx+d)) = e
        e = randint(2, 4)
        c = randint(1, 3)
        d = nonzero(-5, 5)
        
        # Work backward: if result is e^2, then (ax+b)/(cx+d) = e^2
        # Choose x_val, then find a, b
        x_val = randint(2, 10)
        denominator = c * x_val + d
        if denominator == 0:
            x_val += 2
            denominator = c * x_val + d
        
        numerator = e**2 * denominator
        a = randint(1, 4)
        b = numerator - a * x_val
        
        equation = Eq(sqrt((a*x + b)/(c*x + d)), e)
        solutions = solve(equation, x)
        
        valid_sols = []
        for sol in solutions:
            denom_val = c*sol + d
            if denom_val != 0 and sol.is_real:
                numer_val = a*sol + b
                if numer_val/denom_val >= 0:
                    valid_sols.append(sol)
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        elif len(valid_sols) > 1:
            ans = FiniteSet(*valid_sols)
        else:
            ans = FiniteSet()
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{\\frac{{{latex(a*x + b)}}}{{{latex(c*x + d)}}}}} = {e}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $\\frac{{{latex(a*x + b)}}}{{{latex(c*x + d)}}} = {e**2}$",
                f"Cross multiply: ${latex(a*x + b)} = {e**2}({latex(c*x + d)})$",
                f"Expand and solve: ${latex(a*x + b)} = {latex(e**2 * (c*x + d))}$",
                f"Check that denominator $\\neq 0$ and radicand $\\geq 0$",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Nested radicals
        # Example: sqrt(x + sqrt(x)) = a
        a = randint(2, 4)
        
        # Work backward: if sqrt(x + sqrt(x)) = a, then x + sqrt(x) = a^2
        # Let sqrt(x) = t, then x = t^2, so t^2 + t = a^2
        # Solve: t^2 + t - a^2 = 0
        from sympy import symbols
        temp = symbols('t', positive=True, real=True)
        t_vals = solve(temp**2 + temp - a**2, temp)
        
        valid_x = []
        for t_val in t_vals:
            if t_val >= 0 and t_val.is_real:
                x_val = t_val**2
                # Verify
                check = sqrt(x_val + sqrt(x_val))
                if simplify(check - a) == 0:
                    valid_x.append(x_val)
        
        equation = Eq(sqrt(x + sqrt(x)), a)
        solutions = solve(equation, x)
        
        valid_sols = []
        for sol in solutions:
            if sol >= 0 and sol.is_real:
                valid_sols.append(sol)
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        elif len(valid_sols) > 1:
            ans = FiniteSet(*valid_sols)
        else:
            ans = FiniteSet()
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x + \\sqrt{{x}}}} = {a}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $x + \\sqrt{{x}} = {a**2}$",
                f"Let $u = \\sqrt{{x}}$, so $x = u^2$",
                f"Substitute: $u^2 + u = {a**2}$",
                f"Solve quadratic: $u^2 + u - {a**2} = 0$",
                f"Find $u$, then $x = u^2$",
                f"Verify solution in original equation",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Type 4: Radical equation with product
        # Example: sqrt(x) * sqrt(x+a) = b
        a = randint(3, 12)
        
        # Work backward: sqrt(x) * sqrt(x+a) = sqrt(x(x+a)) = b
        # So x(x+a) = b^2, or x^2 + ax - b^2 = 0
        b = randint(3, 8)
        
        equation = Eq(sqrt(x) * sqrt(x + a), b)
        solutions = solve(equation, x)
        
        valid_sols = []
        for sol in solutions:
            if sol >= 0 and sol + a >= 0 and sol.is_real:
                check = sqrt(sol) * sqrt(sol + a)
                if abs(simplify(check - b)) < 0.001 or simplify(check - b) == 0:
                    valid_sols.append(sol)
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        elif len(valid_sols) > 1:
            ans = FiniteSet(*valid_sols)
        else:
            ans = FiniteSet()
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x}} \\cdot \\sqrt{{x+{a}}} = {b}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Use property $\\sqrt{{x}} \\cdot \\sqrt{{x+{a}}} = \\sqrt{{x(x+{a})}}$",
                f"So $\\sqrt{{x^2 + {a}x}} = {b}$",
                f"Square both sides: $x^2 + {a}x = {b**2}$",
                f"Solve quadratic: $x^2 + {a}x - {b**2} = 0$",
                f"Check solutions are non-negative",
                f"$x = {latex(ans)}$"
            ),
        )
    
    else:
        # Type 5: Radical equation with variable in exponent position
        # Example: sqrt(x^2 + ax + b) = cx + d
        c = randint(1, 2)
        d = randint(1, 4)
        
        # Work backward from clean solution
        x_val = randint(2, 6)
        rhs = c * x_val + d
        
        # x^2 + ax + b = (cx + d)^2
        expanded_rhs = expand((c*x_val + d)**2)
        a = randint(1, 10)
        b = expanded_rhs - x_val**2 - a*x_val
        
        equation = Eq(sqrt(x**2 + a*x + b), c*x + d)
        solutions = solve(equation, x)
        
        valid_sols = []
        for sol in solutions:
            if sol.is_real:
                radicand = sol**2 + a*sol + b
                rhs_val = c*sol + d
                if radicand >= 0 and rhs_val >= 0:
                    check = sqrt(radicand) - rhs_val
                    if simplify(check) == 0:
                        valid_sols.append(sol)
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        elif len(valid_sols) > 1:
            ans = FiniteSet(*valid_sols)
        else:
            ans = FiniteSet()
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x^2 + {a}x + {b}}} = {latex(c*x + d)}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra2/radical_equations",
            solution=steps(
                f"Square both sides: $x^2 + {a}x + {b} = ({latex(c*x + d)})^2$",
                f"Expand right side: $x^2 + {a}x + {b} = {latex(expand((c*x + d)**2))}$",
                f"Simplify and solve resulting equation",
                f"Check for extraneous solutions (RHS must be non-negative)",
                f"$x = {latex(ans)}$"
            ),
        )

emit(generate())