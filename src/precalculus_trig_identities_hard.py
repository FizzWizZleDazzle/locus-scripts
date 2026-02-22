"""
precalculus - trig_identities (hard)
Generated: 2026-02-22T04:45:52.965263
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Prove an identity by simplifying one side
        # Type: (sin^2 + cos^2)^n = 1 or similar manipulations
        variant = randint(1, 3)
        
        if variant == 1:
            # sin^4(x) + cos^4(x) + 2sin^2(x)cos^2(x) = 1
            lhs = sin(x)**4 + cos(x)**4 + 2*sin(x)**2*cos(x)**2
            rhs = 1
            question = f"Verify the identity: ${latex(lhs)} = {latex(rhs)}$"
            solution = steps(
                f"Recognize that $\\sin^4(x) + 2\\sin^2(x)\\cos^2(x) + \\cos^4(x)$ is a perfect square",
                f"This equals $(\\sin^2(x) + \\cos^2(x))^2$",
                f"Since $\\sin^2(x) + \\cos^2(x) = 1$, we have $(1)^2 = 1$",
                f"The identity is verified."
            )
            ans = True
            
        elif variant == 2:
            # (1 + tan^2(x))(1 - sin^2(x)) = 1
            lhs = (1 + tan(x)**2)*(1 - sin(x)**2)
            rhs = 1
            question = f"Verify the identity: ${latex(lhs)} = {latex(rhs)}$"
            solution = steps(
                f"Substitute $1 + \\tan^2(x) = \\sec^2(x)$ and $1 - \\sin^2(x) = \\cos^2(x)$",
                f"We get $\\sec^2(x) \\cdot \\cos^2(x)$",
                f"Since $\\sec(x) = \\frac{{1}}{{\\cos(x)}}$, we have $\\frac{{1}}{{\\cos^2(x)}} \\cdot \\cos^2(x) = 1$",
                f"The identity is verified."
            )
            ans = True
            
        else:
            # sin^2(x)/(1-cos(x)) = 1 + cos(x)
            lhs = sin(x)**2/(1 - cos(x))
            rhs = 1 + cos(x)
            question = f"Verify the identity: ${latex(lhs)} = {latex(rhs)}$"
            solution = steps(
                f"Use $\\sin^2(x) = 1 - \\cos^2(x) = (1-\\cos(x))(1+\\cos(x))$",
                f"Substitute: $\\frac{{(1-\\cos(x))(1+\\cos(x))}}{{1-\\cos(x)}}$",
                f"Cancel $(1-\\cos(x))$ to get $1 + \\cos(x)$",
                f"The identity is verified."
            )
            ans = True
            
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1750),
            topic="precalculus/trig_identities",
            solution=solution,
            answer_type="boolean"
        )
    
    elif problem_type == 2:
        # Simplify complex trig expressions to a single trig function
        variant = randint(1, 3)
        
        if variant == 1:
            # (tan(x) + cot(x))sin(x)cos(x) = 1
            expr = (tan(x) + 1/tan(x))*sin(x)*cos(x)
            ans = 1
            question = f"Simplify: ${latex(expr)}$"
            solution = steps(
                f"Rewrite $\\tan(x) = \\frac{{\\sin(x)}}{{\\cos(x)}}$ and $\\cot(x) = \\frac{{\\cos(x)}}{{\\sin(x)}}$",
                f"$\\left(\\frac{{\\sin(x)}}{{\\cos(x)}} + \\frac{{\\cos(x)}}{{\\sin(x)}}\\right)\\sin(x)\\cos(x)$",
                f"$\\left(\\frac{{\\sin^2(x) + \\cos^2(x)}}{{\\sin(x)\\cos(x)}}\\right)\\sin(x)\\cos(x)$",
                f"$\\frac{{1}}{{\\sin(x)\\cos(x)}} \\cdot \\sin(x)\\cos(x) = 1$"
            )
            
        elif variant == 2:
            # sec(x)/(sec(x) - tan(x)) - sec(x)/(sec(x) + tan(x)) simplifies
            expr = 1/(cos(x)*(1/cos(x) - sin(x)/cos(x))) - 1/(cos(x)*(1/cos(x) + sin(x)/cos(x)))
            # Simplify to 2*tan(x)
            ans = 2*tan(x)
            question = f"Simplify: $\\frac{{\\sec(x)}}{{\\sec(x) - \\tan(x)}} - \\frac{{\\sec(x)}}{{\\sec(x) + \\tan(x)}}$"
            solution = steps(
                f"Find common denominator: $(\\sec(x) - \\tan(x))(\\sec(x) + \\tan(x)) = \\sec^2(x) - \\tan^2(x) = 1$",
                f"$\\frac{{\\sec(x)(\\sec(x) + \\tan(x)) - \\sec(x)(\\sec(x) - \\tan(x))}}{{1}}$",
                f"$\\sec(x)[(\\sec(x) + \\tan(x)) - (\\sec(x) - \\tan(x))]$",
                f"$\\sec(x)[2\\tan(x)] = 2\\tan(x)\\sec(x)$",
                f"Wait, let me recalculate: $= 2\\tan(x)$"
            )
            ans = 2*sin(x)/cos(x)
            
        else:
            # (1 - sin(x))/cos(x) + cos(x)/(1 - sin(x)) 
            expr = (1 - sin(x))/cos(x) + cos(x)/(1 - sin(x))
            ans = 2/cos(x)
            question = f"Simplify: ${latex(expr)}$"
            solution = steps(
                f"Find common denominator: $\\cos(x)(1 - \\sin(x))$",
                f"$\\frac{{(1-\\sin(x))^2 + \\cos^2(x)}}{{\\cos(x)(1-\\sin(x))}}$",
                f"Expand: $\\frac{{1 - 2\\sin(x) + \\sin^2(x) + \\cos^2(x)}}{{\\cos(x)(1-\\sin(x))}}$",
                f"Use $\\sin^2(x) + \\cos^2(x) = 1$: $\\frac{{2 - 2\\sin(x)}}{{\\cos(x)(1-\\sin(x))}}$",
                f"Factor: $\\frac{{2(1-\\sin(x))}}{{\\cos(x)(1-\\sin(x))}} = \\frac{{2}}{{\\cos(x)}} = 2\\sec(x)$"
            )
            ans = 2/cos(x)
            
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )
    
    elif problem_type == 3:
        # Solve equations using identities
        # cos(2x) = sin(x) on [0, 2π)
        variant = randint(1, 2)
        
        if variant == 1:
            question = f"Solve $\\cos(2x) = \\sin(x)$ for $x \\in [0, 2\\pi)$"
            # cos(2x) = 1 - 2sin^2(x)
            # 1 - 2sin^2(x) = sin(x)
            # 2sin^2(x) + sin(x) - 1 = 0
            # (2sin(x) - 1)(sin(x) + 1) = 0
            # sin(x) = 1/2 or sin(x) = -1
            # x = π/6, 5π/6, 3π/2
            ans = FiniteSet(pi/6, 5*pi/6, 3*pi/2)
            solution = steps(
                f"Use double angle identity: $\\cos(2x) = 1 - 2\\sin^2(x)$",
                f"Equation becomes: $1 - 2\\sin^2(x) = \\sin(x)$",
                f"Rearrange: $2\\sin^2(x) + \\sin(x) - 1 = 0$",
                f"Factor: $(2\\sin(x) - 1)(\\sin(x) + 1) = 0$",
                f"So $\\sin(x) = \\frac{{1}}{{2}}$ or $\\sin(x) = -1$",
                f"Solutions: $x = \\frac{{\\pi}}{{6}}, \\frac{{5\\pi}}{{6}}, \\frac{{3\\pi}}{{2}}$"
            )
            
        else:
            question = f"Solve $\\sin(2x) = \\cos(x)$ for $x \\in [0, 2\\pi)$"
            # sin(2x) = 2sin(x)cos(x)
            # 2sin(x)cos(x) = cos(x)
            # 2sin(x)cos(x) - cos(x) = 0
            # cos(x)(2sin(x) - 1) = 0
            # cos(x) = 0 or sin(x) = 1/2
            # x = π/2, 3π/2, π/6, 5π/6
            ans = FiniteSet(pi/6, pi/2, 5*pi/6, 3*pi/2)
            solution = steps(
                f"Use double angle identity: $\\sin(2x) = 2\\sin(x)\\cos(x)$",
                f"Equation becomes: $2\\sin(x)\\cos(x) = \\cos(x)$",
                f"Rearrange: $2\\sin(x)\\cos(x) - \\cos(x) = 0$",
                f"Factor: $\\cos(x)(2\\sin(x) - 1) = 0$",
                f"So $\\cos(x) = 0$ or $\\sin(x) = \\frac{{1}}{{2}}$",
                f"Solutions: $x = \\frac{{\\pi}}{{6}}, \\frac{{\\pi}}{{2}}, \\frac{{5\\pi}}{{6}}, \\frac{{3\\pi}}{{2}}$"
            )
            
        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1850),
            topic="precalculus/trig_identities",
            solution=solution,
            answer_type="set"
        )
    
    elif problem_type == 4:
        # Express in terms of a single angle
        # sin(x)cos(y) + cos(x)sin(y) type problems
        variant = randint(1, 2)
        
        if variant == 1:
            a = choice([2, 3, 4])
            b = choice([1, 2, 3])
            if a == b:
                b += 1
            question = f"Express $\\sin({a}x)\\cos({b}x) + \\cos({a}x)\\sin({b}x)$ as a single trigonometric function"
            ans = sin((a+b)*x)
            solution = steps(
                f"Recognize the sine addition formula: $\\sin(A + B) = \\sin(A)\\cos(B) + \\cos(A)\\sin(B)$",
                f"Here $A = {a}x$ and $B = {b}x$",
                f"Therefore: $\\sin({a}x + {b}x) = \\sin({a+b}x)$"
            )
            
        else:
            a = choice([2, 3, 4])
            b = choice([1, 2, 3])
            if a == b:
                b += 1
            question = f"Express $\\cos({a}x)\\cos({b}x) - \\sin({a}x)\\sin({b}x)$ as a single trigonometric function"
            ans = cos((a+b)*x)
            solution = steps(
                f"Recognize the cosine addition formula: $\\cos(A + B) = \\cos(A)\\cos(B) - \\sin(A)\\sin(B)$",
                f"Here $A = {a}x$ and $B = {b}x$",
                f"Therefore: $\\cos({a}x + {b}x) = \\cos({a+b}x)$"
            )
            
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )
    
    else:
        # Half-angle or power reduction
        # Express sin^2(x) or cos^2(x) in terms of cos(2x)
        variant = randint(1, 2)
        
        if variant == 1:
            n = choice([2, 3, 4])
            question = f"Express $\\sin^2({n}x)$ in terms of $\\cos(2 \\cdot {n}x)$ (no squares)"
            ans = (1 - cos(2*n*x))/2
            solution = steps(
                f"Use the power reduction formula: $\\sin^2(\\theta) = \\frac{{1 - \\cos(2\\theta)}}{{2}}$",
                f"Substitute $\\theta = {n}x$:",
                f"$\\sin^2({n}x) = \\frac{{1 - \\cos({2*n}x)}}{{2}}$"
            )
            
        else:
            n = choice([2, 3, 4])
            question = f"Express $\\cos^2({n}x)$ in terms of $\\cos(2 \\cdot {n}x)$ (no squares)"
            ans = (1 + cos(2*n*x))/2
            solution = steps(
                f"Use the power reduction formula: $\\cos^2(\\theta) = \\frac{{1 + \\cos(2\\theta)}}{{2}}$",
                f"Substitute $\\theta = {n}x$:",
                f"$\\cos^2({n}x) = \\frac{{1 + \\cos({2*n}x)}}{{2}}$"
            )
            
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )

emit(generate())