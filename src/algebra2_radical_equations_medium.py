"""
algebra2 - radical_equations (medium)
Generated: 2026-02-22T04:27:05.963949
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple radical equation: sqrt(ax + b) = c
        a = randint(2, 5)
        b = randint(1, 10)
        c = randint(2, 6)
        
        # Work backwards: x = (c^2 - b)/a
        x_val = (c**2 - b) / a
        
        # Only use if x is an integer
        if x_val == int(x_val):
            x_val = int(x_val)
            eq = Eq(sqrt(a*x + b), c)
            
            return problem(
                question=f"Solve for $x$: ${latex(eq)}$",
                answer=x_val,
                difficulty=(1300, 1400),
                topic="algebra2/radical_equations",
                solution=steps(
                    f"${latex(eq)}$",
                    f"Square both sides: ${latex(a*x + b)} = {c**2}$",
                    f"${latex(a*x)} = {c**2 - b}$",
                    f"$x = {x_val}$",
                    f"Check: $\\sqrt{{{a*x_val + b}}} = \\sqrt{{{c**2}}} = {c}$ ✓"
                ),
            )
    
    if problem_type == 2:
        # sqrt(ax + b) = x + c
        # Work backwards: choose x, then find a, b, c
        x_val = randint(2, 8)
        c_val = randint(1, 4)
        rhs = x_val + c_val
        lhs_squared = rhs**2
        
        a = randint(2, 4)
        b = lhs_squared - a * x_val
        
        if b > 0 and b < 20:
            eq = Eq(sqrt(a*x + b), x + c_val)
            
            return problem(
                question=f"Solve for $x$: ${latex(eq)}$",
                answer=x_val,
                difficulty=(1400, 1500),
                topic="algebra2/radical_equations",
                solution=steps(
                    f"${latex(eq)}$",
                    f"Square both sides: ${latex(a*x + b)} = (x + {c_val})^2$",
                    f"${latex(a*x + b)} = {latex(expand((x + c_val)**2))}$",
                    f"${latex(a*x + b)} = {latex(x**2 + 2*c_val*x + c_val**2)}$",
                    f"$0 = {latex(x**2 + (2*c_val - a)*x + (c_val**2 - b))}$",
                    f"Solving the quadratic: $x = {x_val}$",
                    f"Check: $\\sqrt{{{a*x_val + b}}} = \\sqrt{{{lhs_squared}}} = {rhs}$ and ${x_val} + {c_val} = {rhs}$ ✓"
                ),
            )
    
    if problem_type == 3:
        # sqrt(ax + b) + c = d, two-step
        a = randint(2, 5)
        d = randint(5, 10)
        c = randint(1, d-2)
        radical_val = d - c
        
        # Work backwards: ax + b = radical_val^2
        b = randint(1, 15)
        x_val = (radical_val**2 - b) / a
        
        if x_val == int(x_val) and x_val > 0:
            x_val = int(x_val)
            eq = Eq(sqrt(a*x + b) + c, d)
            
            return problem(
                question=f"Solve for $x$: ${latex(eq)}$",
                answer=x_val,
                difficulty=(1300, 1400),
                topic="algebra2/radical_equations",
                solution=steps(
                    f"${latex(eq)}$",
                    f"Isolate the radical: $\\sqrt{{{latex(a*x + b)}}} = {d - c}$",
                    f"Square both sides: ${latex(a*x + b)} = {(d-c)**2}$",
                    f"${latex(a*x)} = {(d-c)**2 - b}$",
                    f"$x = {x_val}$",
                    f"Check: $\\sqrt{{{a*x_val + b}}} + {c} = {radical_val} + {c} = {d}$ ✓"
                ),
            )
    
    # Default: sqrt(x + a) = sqrt(2x + b)
    x_val = randint(3, 12)
    a = randint(5, 20)
    b = x_val + a - 2*x_val
    
    if b < a and b > -20:
        eq = Eq(sqrt(x + a), sqrt(2*x + b))
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=x_val,
            difficulty=(1400, 1500),
            topic="algebra2/radical_equations",
            solution=steps(
                f"${latex(eq)}$",
                f"Square both sides: $x + {a} = 2x + {b}$",
                f"${a - b} = x$",
                f"$x = {x_val}$",
                f"Check: $\\sqrt{{{x_val + a}}} = \\sqrt{{{x_val + a}}}$ and $\\sqrt{{{2*x_val + b}}} = \\sqrt{{{2*x_val + b}}}$ ✓"
            ),
        )

emit(generate())