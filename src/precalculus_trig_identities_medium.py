"""
precalculus - trig_identities (medium)
Generated: 2026-02-22T04:45:08.463824
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplify using Pythagorean identity: sin^2 + cos^2 = 1
        # Difficulty: 1300-1400
        form = choice(['sin', 'cos'])
        if form == 'sin':
            # sin^2(x) + cos^2(x) = 1, so sin^2(x) = 1 - cos^2(x)
            question = r"\text{Simplify: } \sin^2(x) + \cos^2(x)"
            ans = 1
            solution = steps(
                r"Use the Pythagorean identity: $\sin^2(x) + \cos^2(x) = 1$",
                r"Answer: $1$"
            )
        else:
            # 1 - sin^2(x) = cos^2(x)
            question = r"\text{Simplify: } 1 - \sin^2(x)"
            ans = cos(x)**2
            solution = steps(
                r"Use the Pythagorean identity: $\sin^2(x) + \cos^2(x) = 1$",
                r"Rearrange: $\cos^2(x) = 1 - \sin^2(x)$",
                r"Answer: $\cos^2(x)$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )
    
    elif problem_type == 2:
        # Simplify using double angle formula
        # Difficulty: 1400-1500
        angle_mult = choice([2, 3])
        trig_func = choice(['sin', 'cos'])
        
        if angle_mult == 2 and trig_func == 'sin':
            # 2*sin(x)*cos(x) = sin(2x)
            question = r"\text{Simplify: } 2\sin(x)\cos(x)"
            ans = sin(2*x)
            solution = steps(
                r"Use the double angle identity: $\sin(2x) = 2\sin(x)\cos(x)$",
                r"Answer: $\sin(2x)$"
            )
        else:
            # cos^2(x) - sin^2(x) = cos(2x)
            question = r"\text{Simplify: } \cos^2(x) - \sin^2(x)"
            ans = cos(2*x)
            solution = steps(
                r"Use the double angle identity: $\cos(2x) = \cos^2(x) - \sin^2(x)$",
                r"Answer: $\cos(2x)$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )
    
    elif problem_type == 3:
        # Verify an identity by simplifying one side
        # Difficulty: 1400-1550
        identity_choice = choice(['tan', 'sec', 'csc'])
        
        if identity_choice == 'tan':
            # tan(x) = sin(x)/cos(x)
            question = r"\text{Simplify: } \frac{\sin(x)}{\cos(x)}"
            ans = tan(x)
            solution = steps(
                r"Use the tangent identity: $\tan(x) = \frac{\sin(x)}{\cos(x)}$",
                r"Answer: $\tan(x)$"
            )
        elif identity_choice == 'sec':
            # 1/cos(x) = sec(x)
            question = r"\text{Simplify: } \frac{1}{\cos(x)}"
            ans = sec(x)
            solution = steps(
                r"Use the secant identity: $\sec(x) = \frac{1}{\cos(x)}$",
                r"Answer: $\sec(x)$"
            )
        else:
            # 1/sin(x) = csc(x)
            question = r"\text{Simplify: } \frac{1}{\sin(x)}"
            ans = csc(x)
            solution = steps(
                r"Use the cosecant identity: $\csc(x) = \frac{1}{\sin(x)}$",
                r"Answer: $\csc(x)$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1350, 1450),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )
    
    elif problem_type == 4:
        # Simplify using tan^2 + 1 = sec^2 or 1 + cot^2 = csc^2
        # Difficulty: 1450-1550
        identity_type = choice(['sec', 'csc'])
        
        if identity_type == 'sec':
            # tan^2(x) + 1 = sec^2(x)
            question = r"\text{Simplify: } \tan^2(x) + 1"
            ans = sec(x)**2
            solution = steps(
                r"Use the Pythagorean identity: $\tan^2(x) + 1 = \sec^2(x)$",
                r"Answer: $\sec^2(x)$"
            )
        else:
            # 1 + cot^2(x) = csc^2(x)
            question = r"\text{Simplify: } 1 + \cot^2(x)"
            ans = csc(x)**2
            solution = steps(
                r"Use the Pythagorean identity: $1 + \cot^2(x) = \csc^2(x)$",
                r"Answer: $\csc^2(x)$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1450, 1550),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )
    
    else:
        # More complex simplification combining multiple identities
        # Difficulty: 1500-1600
        problem_variant = choice([1, 2, 3])
        
        if problem_variant == 1:
            # (sin(x) + cos(x))^2 + (sin(x) - cos(x))^2 = 2
            question = r"\text{Simplify: } (\sin(x) + \cos(x))^2 + (\sin(x) - \cos(x))^2"
            ans = 2
            solution = steps(
                r"Expand both squares: $\sin^2(x) + 2\sin(x)\cos(x) + \cos^2(x) + \sin^2(x) - 2\sin(x)\cos(x) + \cos^2(x)$",
                r"Combine like terms: $2\sin^2(x) + 2\cos^2(x)$",
                r"Factor: $2(\sin^2(x) + \cos^2(x))$",
                r"Use Pythagorean identity: $2(1) = 2$"
            )
        elif problem_variant == 2:
            # sin(x)/(1 + cos(x)) + (1 + cos(x))/sin(x) simplifies to 2/sin(x) = 2csc(x)
            question = r"\text{Simplify: } \frac{\sin^2(x)}{1 - \cos^2(x)}"
            ans = 1
            solution = steps(
                r"Use Pythagorean identity: $1 - \cos^2(x) = \sin^2(x)$",
                r"Substitute: $\frac{\sin^2(x)}{\sin^2(x)} = 1$",
                r"Answer: $1$"
            )
        else:
            # sec^2(x) - tan^2(x) = 1
            question = r"\text{Simplify: } \sec^2(x) - \tan^2(x)"
            ans = 1
            solution = steps(
                r"Use the Pythagorean identity: $\tan^2(x) + 1 = \sec^2(x)$",
                r"Rearrange: $\sec^2(x) - \tan^2(x) = 1$",
                r"Answer: $1$"
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/trig_identities",
            solution=solution,
            grading_mode="equivalent"
        )

emit(generate())