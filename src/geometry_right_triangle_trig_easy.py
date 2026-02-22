"""
geometry - right_triangle_trig (easy)
Generated: 2026-02-22T04:18:52.199856
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Finding a side using a single trig ratio (1000-1200)
        angle = choice([30, 45, 60])
        if angle == 30:
            ratio_type = choice(['sin', 'cos'])
            if ratio_type == 'sin':
                hypotenuse = choice([10, 20, 30, 40, 50])
                ans = hypotenuse / 2
                question_text = f"In a right triangle, if the hypotenuse is ${hypotenuse}$ and one angle is $30°$, find the length of the side opposite to the $30°$ angle."
                solution_text = steps(
                    f"Use $\\sin(30°) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}}$",
                    f"$\\sin(30°) = \\frac{{1}}{{2}}$",
                    f"$\\frac{{1}}{{2}} = \\frac{{\\text{{opposite}}}}{{{hypotenuse}}}$",
                    f"opposite $= {hypotenuse} \\cdot \\frac{{1}}{{2}} = {ans}$"
                )
            else:
                hypotenuse = choice([10, 20, 30, 40])
                ans = hypotenuse * sqrt(3) / 2
                question_text = f"In a right triangle, if the hypotenuse is ${hypotenuse}$ and one angle is $30°$, find the length of the side adjacent to the $30°$ angle."
                solution_text = steps(
                    f"Use $\\cos(30°) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}}$",
                    f"$\\cos(30°) = \\frac{{\\sqrt{{3}}}}{{2}}$",
                    f"$\\frac{{\\sqrt{{3}}}}{{2}} = \\frac{{\\text{{adjacent}}}}{{{hypotenuse}}}$",
                    f"adjacent $= {hypotenuse} \\cdot \\frac{{\\sqrt{{3}}}}{{2}} = {latex(ans)}$"
                )
        elif angle == 45:
            hypotenuse = choice([10, 20, 30, 40])
            ans = hypotenuse * sqrt(2) / 2
            question_text = f"In a $45°$-$45°$-$90°$ triangle, if the hypotenuse is ${hypotenuse}$, find the length of one leg."
            solution_text = steps(
                f"Use $\\sin(45°) = \\frac{{\\text{{leg}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\sin(45°) = \\frac{{\\sqrt{{2}}}}{{2}}$",
                f"$\\frac{{\\sqrt{{2}}}}{{2}} = \\frac{{\\text{{leg}}}}{{{hypotenuse}}}$",
                f"leg $= {hypotenuse} \\cdot \\frac{{\\sqrt{{2}}}}{{2}} = {latex(ans)}$"
            )
        else:  # 60
            ratio_type = choice(['sin', 'cos'])
            if ratio_type == 'sin':
                hypotenuse = choice([10, 20, 30, 40])
                ans = hypotenuse * sqrt(3) / 2
                question_text = f"In a right triangle, if the hypotenuse is ${hypotenuse}$ and one angle is $60°$, find the length of the side opposite to the $60°$ angle."
                solution_text = steps(
                    f"Use $\\sin(60°) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}}$",
                    f"$\\sin(60°) = \\frac{{\\sqrt{{3}}}}{{2}}$",
                    f"$\\frac{{\\sqrt{{3}}}}{{2}} = \\frac{{\\text{{opposite}}}}{{{hypotenuse}}}$",
                    f"opposite $= {hypotenuse} \\cdot \\frac{{\\sqrt{{3}}}}{{2}} = {latex(ans)}$"
                )
            else:
                hypotenuse = choice([10, 20, 30, 40, 50])
                ans = hypotenuse / 2
                question_text = f"In a right triangle, if the hypotenuse is ${hypotenuse}$ and one angle is $60°$, find the length of the side adjacent to the $60°$ angle."
                solution_text = steps(
                    f"Use $\\cos(60°) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}}$",
                    f"$\\cos(60°) = \\frac{{1}}{{2}}$",
                    f"$\\frac{{1}}{{2}} = \\frac{{\\text{{adjacent}}}}{{{hypotenuse}}}$",
                    f"adjacent $= {hypotenuse} \\cdot \\frac{{1}}{{2}} = {ans}$"
                )
        
        return problem(
            question=question_text,
            answer=ans,
            difficulty=(1000, 1200),
            topic="geometry/right_triangle_trig",
            solution=solution_text
        )
    
    elif problem_type == 2:
        # Finding an angle given a simple ratio (1100-1250)
        angle = choice([30, 45, 60])
        trig_func = choice(['sin', 'cos', 'tan'])
        
        if angle == 30:
            if trig_func == 'sin':
                opp = randint(1, 5)
                hyp = 2 * opp
                question_text = f"In a right triangle, the side opposite an angle is ${opp}$ and the hypotenuse is ${hyp}$. Find the angle in degrees."
                ans = 30
                solution_text = steps(
                    f"$\\sin(\\theta) = \\frac{{{opp}}}{{{hyp}}} = \\frac{{1}}{{2}}$",
                    f"$\\theta = \\sin^{{-1}}\\left(\\frac{{1}}{{2}}\\right) = 30°$"
                )
            elif trig_func == 'cos':
                adj = randint(1, 5) * sqrt(3)
                hyp = 2 * randint(1, 5)
                question_text = f"In a right triangle, the side adjacent to an angle is ${latex(adj)}$ and the hypotenuse is ${hyp}$. Find the angle in degrees."
                ans = 30
                solution_text = steps(
                    f"$\\cos(\\theta) = \\frac{{{latex(adj)}}}{{{hyp}}} = \\frac{{\\sqrt{{3}}}}{{2}}$",
                    f"$\\theta = \\cos^{{-1}}\\left(\\frac{{\\sqrt{{3}}}}{{2}}\\right) = 30°$"
                )
            else:
                opp = randint(1, 5)
                adj = opp * sqrt(3)
                question_text = f"In a right triangle, the side opposite an angle is ${opp}$ and the side adjacent is ${latex(adj)}$. Find the angle in degrees."
                ans = 30
                solution_text = steps(
                    f"$\\tan(\\theta) = \\frac{{{opp}}}{{{latex(adj)}}} = \\frac{{1}}{{\\sqrt{{3}}}}$",
                    f"$\\theta = \\tan^{{-1}}\\left(\\frac{{1}}{{\\sqrt{{3}}}}\\right) = 30°$"
                )
        elif angle == 45:
            leg = randint(2, 8)
            if trig_func == 'tan':
                question_text = f"In a right triangle, both legs have length ${leg}$. Find one of the non-right angles in degrees."
                ans = 45
                solution_text = steps(
                    f"$\\tan(\\theta) = \\frac{{{leg}}}{{{leg}}} = 1$",
                    f"$\\theta = \\tan^{{-1}}(1) = 45°$"
                )
            else:
                hyp = leg * sqrt(2)
                question_text = f"In a right triangle, one leg is ${leg}$ and the hypotenuse is ${latex(hyp)}$. Find the angle opposite this leg in degrees."
                ans = 45
                solution_text = steps(
                    f"$\\sin(\\theta) = \\frac{{{leg}}}{{{latex(hyp)}}} = \\frac{{1}}{{\\sqrt{{2}}}}$",
                    f"$\\theta = \\sin^{{-1}}\\left(\\frac{{1}}{{\\sqrt{{2}}}}\\right) = 45°$"
                )
        else:  # 60
            if trig_func == 'sin':
                opp = randint(1, 5) * sqrt(3)
                hyp = 2 * randint(1, 5)
                question_text = f"In a right triangle, the side opposite an angle is ${latex(opp)}$ and the hypotenuse is ${hyp}$. Find the angle in degrees."
                ans = 60
                solution_text = steps(
                    f"$\\sin(\\theta) = \\frac{{{latex(opp)}}}{{{hyp}}} = \\frac{{\\sqrt{{3}}}}{{2}}$",
                    f"$\\theta = \\sin^{{-1}}\\left(\\frac{{\\sqrt{{3}}}}{{2}}\\right) = 60°$"
                )
            elif trig_func == 'cos':
                adj = randint(1, 5)
                hyp = 2 * adj
                question_text = f"In a right triangle, the side adjacent to an angle is ${adj}$ and the hypotenuse is ${hyp}$. Find the angle in degrees."
                ans = 60
                solution_text = steps(
                    f"$\\cos(\\theta) = \\frac{{{adj}}}{{{hyp}}} = \\frac{{1}}{{2}}$",
                    f"$\\theta = \\cos^{{-1}}\\left(\\frac{{1}}{{2}}\\right) = 60°$"
                )
            else:
                opp = randint(1, 5) * sqrt(3)
                adj = randint(1, 5)
                question_text = f"In a right triangle, the side opposite an angle is ${latex(opp)}$ and the side adjacent is ${adj}$. Find the angle in degrees."
                ans = 60
                solution_text = steps(
                    f"$\\tan(\\theta) = \\frac{{{latex(opp)}}}{{{adj}}} = \\sqrt{{3}}$",
                    f"$\\theta = \\tan^{{-1}}(\\sqrt{{3}}) = 60°$"
                )
        
        return problem(
            question=question_text,
            answer=ans,
            difficulty=(1100, 1250),
            topic="geometry/right_triangle_trig",
            solution=solution_text
        )
    
    elif problem_type == 3:
        # Simple SOH-CAH-TOA identification (1000-1150)
        angle_label = choice(['A', 'B', 'C'])
        side1 = randint(3, 10)
        side2 = randint(3, 10)
        ratio_type = choice(['sin', 'cos', 'tan'])
        
        if ratio_type == 'sin':
            question_text = f"In a right triangle, the side opposite angle ${angle_label}$ is ${side1}$ and the hypotenuse is ${side2}$. Write the value of $\\sin({angle_label})$ as a fraction."
            ans = Rational(side1, side2)
            solution_text = steps(
                f"$\\sin({angle_label}) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\sin({angle_label}) = \\frac{{{side1}}}{{{side2}}}$"
            )
        elif ratio_type == 'cos':
            question_text = f"In a right triangle, the side adjacent to angle ${angle_label}$ is ${side1}$ and the hypotenuse is ${side2}$. Write the value of $\\cos({angle_label})$ as a fraction."
            ans = Rational(side1, side2)
            solution_text = steps(
                f"$\\cos({angle_label}) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\cos({angle_label}) = \\frac{{{side1}}}{{{side2}}}$"
            )
        else:
            question_text = f"In a right triangle, the side opposite angle ${angle_label}$ is ${side1}$ and the side adjacent is ${side2}$. Write the value of $\\tan({angle_label})$ as a fraction."
            ans = Rational(side1, side2)
            solution_text = steps(
                f"$\\tan({angle_label}) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}}$",
                f"$\\tan({angle_label}) = \\frac{{{side1}}}{{{side2}}}$"
            )
        
        return problem(
            question=question_text,
            answer=ans,
            difficulty=(1000, 1150),
            topic="geometry/right_triangle_trig",
            solution=solution_text
        )
    
    else:
        # Two-step: find one side, then use it to find another (1200-1300)
        angle = choice([30, 60])
        hypotenuse = choice([10, 20, 30])
        
        if angle == 30:
            short_leg = hypotenuse / 2
            long_leg = hypotenuse * sqrt(3) / 2
            question_text = f"In a $30°$-$60°$-$90°$ triangle, the hypotenuse is ${hypotenuse}$. Find the length of the longer leg."
            ans = long_leg
            solution_text = steps(
                f"In a $30°$-$60°$-$90°$ triangle, the sides are in ratio $1 : \\sqrt{{3}} : 2$",
                f"The shorter leg (opposite $30°$) is $\\frac{{{hypotenuse}}}{{2}} = {latex(short_leg)}$",
                f"The longer leg (opposite $60°$) is $\\frac{{{hypotenuse}} \\sqrt{{3}}}}{{2}} = {latex(long_leg)}$"
            )
        else:  # 60 degree case
            short_leg = hypotenuse / 2
            long_leg = hypotenuse * sqrt(3) / 2
            question_text = f"In a $30°$-$60°$-$90°$ triangle, the hypotenuse is ${hypotenuse}$. Find the length of the shorter leg."
            ans = short_leg
            solution_text = steps(
                f"In a $30°$-$60°$-$90°$ triangle, the sides are in ratio $1 : \\sqrt{{3}} : 2$",
                f"The shorter leg (opposite $30°$) is $\\frac{{{hypotenuse}}}{{2}} = {latex(short_leg)}$"
            )
        
        return problem(
            question=question_text,
            answer=ans,
            difficulty=(1200, 1300),
            topic="geometry/right_triangle_trig",
            solution=solution_text
        )

emit(generate())