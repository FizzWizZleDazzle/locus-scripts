"""
geometry - volume (easy)
Generated: 2026-02-22T04:15:49.286592
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Rectangular prism volume
        length = randint(2, 10)
        width = randint(2, 10)
        height = randint(2, 10)
        ans = length * width * height
        
        return problem(
            question=f"Find the volume of a rectangular prism with length ${length}$ cm, width ${width}$ cm, and height ${height}$ cm.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="geometry/volume",
            solution=steps(
                f"Use the formula $V = l \\times w \\times h$",
                f"$V = {length} \\times {width} \\times {height}$",
                f"$V = {ans}$ cubic cm"
            ),
            calculator="none"
        )
    
    elif problem_type == 2:
        # Cube volume
        side = randint(2, 10)
        ans = side ** 3
        
        return problem(
            question=f"Find the volume of a cube with side length ${side}$ m.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="geometry/volume",
            solution=steps(
                f"Use the formula $V = s^3$",
                f"$V = {side}^3$",
                f"$V = {ans}$ cubic m"
            ),
            calculator="none"
        )
    
    elif problem_type == 3:
        # Cylinder volume (with pi in answer)
        radius = randint(2, 8)
        height = randint(3, 12)
        ans = pi * radius**2 * height
        
        return problem(
            question=f"Find the volume of a cylinder with radius ${radius}$ cm and height ${height}$ cm. Leave your answer in terms of $\\pi$.",
            answer=ans,
            difficulty=(1200, 1300),
            topic="geometry/volume",
            solution=steps(
                f"Use the formula $V = \\pi r^2 h$",
                f"$V = \\pi \\cdot {radius}^2 \\cdot {height}$",
                f"$V = \\pi \\cdot {radius**2} \\cdot {height}$",
                f"$V = {latex(ans)}$ cubic cm"
            ),
            calculator="none"
        )
    
    else:
        # Rectangular prism - find missing dimension
        length = randint(2, 8)
        width = randint(2, 8)
        height = randint(2, 8)
        volume = length * width * height
        
        missing = choice(['length', 'width', 'height'])
        
        if missing == 'length':
            ans = length
            return problem(
                question=f"A rectangular prism has a volume of ${volume}$ cubic cm, width ${width}$ cm, and height ${height}$ cm. Find the length.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="geometry/volume",
                solution=steps(
                    f"Use the formula $V = l \\times w \\times h$",
                    f"${volume} = l \\times {width} \\times {height}$",
                    f"${volume} = l \\times {width * height}$",
                    f"$l = \\frac{{{volume}}}{{{width * height}}}$",
                    f"$l = {ans}$ cm"
                ),
                calculator="none"
            )
        elif missing == 'width':
            ans = width
            return problem(
                question=f"A rectangular prism has a volume of ${volume}$ cubic cm, length ${length}$ cm, and height ${height}$ cm. Find the width.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="geometry/volume",
                solution=steps(
                    f"Use the formula $V = l \\times w \\times h$",
                    f"${volume} = {length} \\times w \\times {height}$",
                    f"${volume} = w \\times {length * height}$",
                    f"$w = \\frac{{{volume}}}{{{length * height}}}$",
                    f"$w = {ans}$ cm"
                ),
                calculator="none"
            )
        else:
            ans = height
            return problem(
                question=f"A rectangular prism has a volume of ${volume}$ cubic cm, length ${length}$ cm, and width ${width}$ cm. Find the height.",
                answer=ans,
                difficulty=(1200, 1300),
                topic="geometry/volume",
                solution=steps(
                    f"Use the formula $V = l \\times w \\times h$",
                    f"${volume} = {length} \\times {width} \\times h$",
                    f"${volume} = h \\times {length * width}$",
                    f"$h = \\frac{{{volume}}}{{{length * width}}}$",
                    f"$h = {ans}$ cm"
                ),
                calculator="none"
            )

emit(generate())