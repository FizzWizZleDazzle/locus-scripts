"""
multivariable_calculus - line_integrals (easy)
Generated: 2026-02-22T05:43:28.436916
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Constant times arc length
        c = nonzero(-6, 6)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        x2, y2 = randint(-3, 3), randint(-3, 3)
        while x1 == x2 and y1 == y2:
            x2, y2 = randint(-3, 3), randint(-3, 3)
        arc_length = sqrt((x2 - x1)**2 + (y2 - y1)**2)
        ans = c * arc_length
        return problem(
            question=f"Evaluate $\\int_C {c} \\, ds$ where $C$ is the segment from $({x1},{y1})$ to $({x2},{y2})$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Arc length $= \\sqrt{{({x2}-{x1})^2+({y2}-{y1})^2}} = {latex(arc_length)}$",
                f"$\\int_C {c} \\, ds = {c} \\cdot {latex(arc_length)} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # F·dr with constant F along segment
        fx = nonzero(-5, 5)
        fy = nonzero(-5, 5)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        x2, y2 = randint(-3, 3), randint(-3, 3)
        while x1 == x2 and y1 == y2:
            x2, y2 = randint(-3, 3), randint(-3, 3)
        ans = fx * (x2 - x1) + fy * (y2 - y1)
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {fx}, {fy} \\rangle$ along segment $({x1},{y1})$ to $({x2},{y2})$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"$\\mathbf{{r}}(t) = ({x1}+t \\cdot {x2-x1},\\ {y1}+t \\cdot {y2-y1})$, $t \\in [0,1]$",
                f"$\\mathbf{{F}} \\cdot \\frac{{d\\mathbf{{r}}}}{{dt}} = {fx}\\cdot{x2-x1} + {fy}\\cdot{y2-y1} = {fx*(x2-x1)+fy*(y2-y1)}$",
                f"$\\int_0^1 {fx*(x2-x1)+fy*(y2-y1)} \\, dt = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Horizontal segment: integral of x
        y_val = nonzero(-4, 4)
        x_start = randint(-4, 0)
        x_end = randint(1, 5)
        ans = Rational(x_end**2 - x_start**2, 2)
        return problem(
            question=f"Evaluate $\\int_C x \\, ds$ where $C$: $({x_start},{y_val})$ to $({x_end},{y_val})$.",
            answer=ans,
            difficulty=(1050, 1200),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize $\\mathbf{{r}}(t)=(t,{y_val})$, $t \\in [{x_start},{x_end}]$, $ds = dt$",
                f"$\\int_{{{x_start}}}^{{{x_end}}} t \\, dt = \\frac{{{x_end}^2-{x_start}^2}}{{2}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Vertical segment: integral of y
        x_val = nonzero(-4, 4)
        y_start = randint(-4, 0)
        y_end = randint(1, 5)
        ans = Rational(y_end**2 - y_start**2, 2)
        return problem(
            question=f"Evaluate $\\int_C y \\, ds$ where $C$: $({x_val},{y_start})$ to $({x_val},{y_end})$.",
            answer=ans,
            difficulty=(1050, 1200),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize $\\mathbf{{r}}(t)=({x_val},t)$, $t \\in [{y_start},{y_end}]$, $ds=dt$",
                f"$\\int_{{{y_start}}}^{{{y_end}}} t \\, dt = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 5:
        # Along x-axis, integral of cx^n
        a_val = randint(1, 5)
        coeff = nonzero(-4, 4)
        power = randint(1, 3)
        ans = coeff * Rational(a_val**(power + 1), power + 1)
        istr = f"{coeff}x^{{{power}}}" if power > 1 else f"{coeff}x"
        return problem(
            question=f"Evaluate $\\int_C {istr} \\, ds$ where $C$: $(0,0)$ to $({a_val},0)$.",
            answer=ans,
            difficulty=(1150, 1280),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize $\\mathbf{{r}}(t)=(t,0)$, $t \\in [0,{a_val}]$, $ds=dt$",
                f"$\\int_0^{{{a_val}}} {istr} \\, dt = {coeff} \\cdot \\frac{{{a_val}^{{{power+1}}}}}{{{power+1}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # 3D constant F · dr along segment
        fx = nonzero(-4, 4)
        fy = nonzero(-4, 4)
        fz = nonzero(-4, 4)
        x1, y1, z1 = randint(-2, 2), randint(-2, 2), randint(-2, 2)
        x2, y2, z2 = randint(-2, 2), randint(-2, 2), randint(-2, 2)
        while x1 == x2 and y1 == y2 and z1 == z2:
            x2, y2, z2 = randint(-2, 2), randint(-2, 2), randint(-2, 2)
        ans = fx * (x2 - x1) + fy * (y2 - y1) + fz * (z2 - z1)
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {fx},{fy},{fz} \\rangle$ from $({x1},{y1},{z1})$ to $({x2},{y2},{z2})$.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"$d\\mathbf{{r}} = \\langle {x2-x1},{y2-y1},{z2-z1} \\rangle dt$",
                f"$\\mathbf{{F}} \\cdot d\\mathbf{{r}} = {fx*(x2-x1)+fy*(y2-y1)+fz*(z2-z1)} \\, dt$",
                f"$\\int_0^1 \\ldots \\, dt = {ans}$"
            ),
            calculator="scientific"
        )

emit(generate())
