"""
algebra2 - rational_equations (hard)
Generated: 2026-02-22T04:25:21.418605
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Rational equation with multiple fractions requiring LCD
        # Harder version: 3 fractions with different denominators
        a1 = nonzero(-5, 5)
        b1 = nonzero(-8, 8)
        a2 = nonzero(-5, 5)
        b2 = nonzero(-8, 8)
        a3 = nonzero(-5, 5)
        b3 = nonzero(-8, 8)
        
        # Create denominators that share factors for interesting LCD
        d1 = nonzero(2, 4)
        d2 = nonzero(2, 4)
        while d2 == d1:
            d2 = nonzero(2, 4)
        d3 = d1 * d2
        
        # Equation: a1/(d1(x-b1)) + a2/(d2(x-b2)) = a3/(d3(x-b3))
        eq = Eq(a1/(d1*(x - b1)) + a2/(d2*(x - b2)), a3/(d3*(x - b3)))
        
        sols = solve(eq, x)
        # Filter out solutions that make denominators zero
        valid_sols = [s for s in sols if s != b1 and s != b2 and s != b3 and s.is_real]
        
        if len(valid_sols) == 0:
            # Fallback to simpler problem
            a1, b1, a2, b2 = 2, 3, 1, 5
            d1, d2 = 1, 1
            eq = Eq(a1/(x - b1) + a2/(x - b2), 1)
            sols = solve(eq, x)
            valid_sols = [s for s in sols if s != b1 and s != b2 and s.is_real]
        
        ans = valid_sols[0] if len(valid_sols) > 0 else 0
        
        return problem(
            question=f"Solve for $x$: ${latex(eq.lhs)} = {latex(eq.rhs)}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Given: ${latex(eq)}$",
                f"Multiply both sides by the LCD of all denominators",
                f"Simplify and solve the resulting equation",
                f"Check for extraneous solutions (values that make denominators zero)",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Rational equation leading to quadratic
        # (x+a)/(x-b) = c/(x-d) leads to quadratic after cross-multiplying
        a_val = nonzero(-6, 6)
        b_val = nonzero(-6, 6)
        c_val = nonzero(-6, 6)
        d_val = nonzero(-6, 6)
        
        while b_val == d_val:
            d_val = nonzero(-6, 6)
        
        eq = Eq((x + a_val)/(x - b_val), c_val/(x - d_val))
        
        sols = solve(eq, x)
        valid_sols = [s for s in sols if s != b_val and s != d_val and s.is_real]
        
        if len(valid_sols) == 0:
            # Fallback
            a_val, b_val, c_val, d_val = 3, 2, 4, -1
            eq = Eq((x + a_val)/(x - b_val), c_val/(x - d_val))
            sols = solve(eq, x)
            valid_sols = [s for s in sols if s != b_val and s != d_val and s.is_real]
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        else:
            ans = FiniteSet(*valid_sols)
        
        return problem(
            question=f"Solve for $x$: ${latex(eq.lhs)} = {latex(eq.rhs)}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Given: ${latex(eq)}$",
                f"Cross-multiply: ${latex((x + a_val)*(x - d_val))} = {latex(c_val*(x - b_val))}$",
                f"Expand and simplify to get a quadratic equation",
                f"Solve the quadratic and check for extraneous solutions",
                f"Solution: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Work/rate problem leading to rational equation
        # Person A takes a hours, Person B takes b hours, together they take t hours
        # 1/a + 1/b = 1/t, solve for one variable
        a_time = randint(4, 12)
        together_time = randint(2, a_time - 1)
        
        # Find b such that 1/a + 1/b = 1/t
        # 1/b = 1/t - 1/a = (a - t)/(a*t)
        # b = a*t/(a - t)
        
        eq = Eq(1/a_time + 1/x, 1/together_time)
        sols = solve(eq, x)
        valid_sols = [s for s in sols if s.is_real and s > 0]
        
        if len(valid_sols) == 0 or not valid_sols[0].is_rational:
            # Pick values that work nicely
            a_time = 6
            together_time = 2
            eq = Eq(1/a_time + 1/x, 1/together_time)
            sols = solve(eq, x)
            valid_sols = [s for s in sols if s.is_real and s > 0]
        
        ans = valid_sols[0]
        
        return problem(
            question=f"Machine A can complete a job in ${a_time}$ hours. When Machine A and Machine B work together, they can complete the job in ${together_time}$ hours. How many hours would it take Machine B to complete the job alone?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Machine A's rate: $\\frac{{1}}{{{a_time}}}$ of the job per hour",
                f"Combined rate: $\\frac{{1}}{{{together_time}}}$ of the job per hour",
                f"Let $x$ = hours for Machine B alone, so Machine B's rate is $\\frac{{1}}{{x}}$",
                f"Set up equation: $\\frac{{1}}{{{a_time}}} + \\frac{{1}}{{x}} = \\frac{{1}}{{{together_time}}}$",
                f"Solve: $\\frac{{1}}{{x}} = \\frac{{1}}{{{together_time}}} - \\frac{{1}}{{{a_time}}}$",
                f"$x = {latex(ans)}$ hours"
            ),
        )
    
    else:
        # Type 4: Complex rational equation with variable in multiple places
        # (x+a)/(x+b) + (x+c)/(x+d) = k
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        c_val = nonzero(-5, 5)
        d_val = nonzero(-5, 5)
        k_val = randint(2, 4)
        
        while b_val == d_val or abs(b_val - d_val) < 2:
            d_val = nonzero(-5, 5)
        
        eq = Eq((x + a_val)/(x + b_val) + (x + c_val)/(x + d_val), k_val)
        
        sols = solve(eq, x)
        valid_sols = [s for s in sols if s != -b_val and s != -d_val and s.is_real]
        
        if len(valid_sols) == 0:
            # Fallback
            a_val, b_val, c_val, d_val, k_val = 1, 2, 3, -1, 3
            eq = Eq((x + a_val)/(x + b_val) + (x + c_val)/(x + d_val), k_val)
            sols = solve(eq, x)
            valid_sols = [s for s in sols if s != -b_val and s != -d_val and s.is_real]
        
        if len(valid_sols) == 1:
            ans = valid_sols[0]
        else:
            ans = FiniteSet(*valid_sols)
        
        return problem(
            question=f"Solve for $x$: ${latex(eq.lhs)} = {latex(eq.rhs)}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Given: ${latex(eq)}$",
                f"Find LCD: $(x + {b_val})(x + {d_val})$",
                f"Multiply both sides by the LCD",
                f"Expand and collect terms to form a quadratic equation",
                f"Solve and verify solutions don't make denominators zero",
                f"Solution: ${latex(ans)}$"
            ),
        )

emit(generate())