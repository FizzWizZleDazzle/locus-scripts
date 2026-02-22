"""
multivariable_calculus - line_integrals (hard)
Generated: 2026-02-22T05:44:47.706376
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Line integral of a vector field along a parametric curve (conservative field check)
        # Difficulty: 1600-1750
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        
        # Conservative field: F = grad(f) where f = a*x*y + b*y*z + c*x*z
        # So F = (a*y + c*z, a*x + b*z, b*y + c*x)
        F_x = a_val*y + c_val*z
        F_y = a_val*x + b_val*z
        F_z = b_val*y + c_val*x
        
        # Endpoints
        x0, y0, z0 = randint(-2, 2), randint(-2, 2), randint(-2, 2)
        x1, y1, z1 = randint(-2, 2), randint(-2, 2), randint(-2, 2)
        
        # For conservative field, integral = f(end) - f(start)
        f_start = a_val*x0*y0 + b_val*y0*z0 + c_val*x0*z0
        f_end = a_val*x1*y1 + b_val*y1*z1 + c_val*x1*z1
        ans = f_end - f_start
        
        return problem(
            question=f"Evaluate the line integral $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, {latex(F_z)} \\rangle$ and $C$ is any path from $({x0}, {y0}, {z0})$ to $({x1}, {y1}, {z1})$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Check if $\\mathbf{{F}}$ is conservative by verifying $\\nabla \\times \\mathbf{{F}} = \\mathbf{{0}}$",
                f"$\\frac{{\\partial F_z}}{{\\partial y}} - \\frac{{\\partial F_y}}{{\\partial z}} = {latex(diff(F_z, y))} - {latex(diff(F_y, z))} = 0$",
                f"$\\frac{{\\partial F_x}}{{\\partial z}} - \\frac{{\\partial F_z}}{{\\partial x}} = {latex(diff(F_x, z))} - {latex(diff(F_z, x))} = 0$",
                f"$\\frac{{\\partial F_y}}{{\\partial x}} - \\frac{{\\partial F_x}}{{\\partial y}} = {latex(diff(F_y, x))} - {latex(diff(F_x, y))} = 0$",
                f"Since $\\mathbf{{F}}$ is conservative, find potential function $f$ where $\\nabla f = \\mathbf{{F}}$",
                f"$f(x,y,z) = {latex(a_val*x*y + b_val*y*z + c_val*x*z)}$",
                f"Line integral = $f({x1},{y1},{z1}) - f({x0},{y0},{z0}) = {f_end} - {f_start} = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Line integral along a helix with non-conservative field
        # Difficulty: 1700-1850
        a_coeff = nonzero(-2, 2)
        b_coeff = nonzero(-2, 2)
        
        # F = <y, -x, z>  (not conservative, typical rotation field)
        # Parametrize helix: r(t) = <cos(t), sin(t), t> for t in [0, 2*pi]
        # r'(t) = <-sin(t), cos(t), 1>
        # F(r(t)) = <sin(t), -cos(t), t>
        # F · r' = -sin²(t) - cos²(t) + t = -1 + t
        # Integral from 0 to 2π of (-1 + t) dt = [-t + t²/2] from 0 to 2π
        
        t_end = 2  # Use 2π for cleaner computation
        
        ans = -t_end + Rational(t_end**2, 2)
        
        return problem(
            question=f"Evaluate $\\int_C (y\\,dx - x\\,dy + z\\,dz)$ where $C$ is the helix parametrized by $\\mathbf{{r}}(t) = \\langle \\cos(t), \\sin(t), t \\rangle$ for $t \\in [0, {t_end}]$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Compute $\\mathbf{{r}}'(t) = \\langle -\\sin(t), \\cos(t), 1 \\rangle$",
                f"On the curve: $x = \\cos(t)$, $y = \\sin(t)$, $z = t$",
                f"The integrand becomes: $y(-\\sin(t)) - x(\\cos(t)) + z(1)$",
                f"$= \\sin(t)(-\\sin(t)) - \\cos(t)(\\cos(t)) + t = -\\sin^2(t) - \\cos^2(t) + t = -1 + t$",
                f"$\\int_0^{{{t_end}}} (-1 + t)\\,dt = \\left[-t + \\frac{{t^2}}{{2}}\\right]_0^{{{t_end}}}$",
                f"$= -{t_end} + \\frac{{{t_end**2}}}{{2}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Work done by force field along a line segment
        # Difficulty: 1650-1800
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        # F = <ax, by>, line segment from (0,0) to (1,1)
        # r(t) = <t, t>, r'(t) = <1, 1> for t in [0,1]
        # F(r(t)) = <a*t, b*t>
        # F · r' = a*t + b*t = (a+b)*t
        # Integral = (a+b) * t²/2 from 0 to 1 = (a+b)/2
        
        ans = Rational(a_val + b_val, 2)
        
        return problem(
            question=f"Calculate the work done by the force field $\\mathbf{{F}}(x,y) = \\langle {a_val}x, {b_val}y \\rangle$ on a particle moving along the line segment from $(0,0)$ to $(1,1)$.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parametrize the line segment: $\\mathbf{{r}}(t) = \\langle t, t \\rangle$ for $t \\in [0,1]$",
                f"Compute $\\mathbf{{r}}'(t) = \\langle 1, 1 \\rangle$",
                f"Evaluate $\\mathbf{{F}}(\\mathbf{{r}}(t)) = \\langle {a_val}t, {b_val}t \\rangle$",
                f"$\\mathbf{{F}} \\cdot \\mathbf{{r}}' = {a_val}t \\cdot 1 + {b_val}t \\cdot 1 = {a_val + b_val}t$",
                f"Work = $\\int_0^1 {a_val + b_val}t\\,dt = {a_val + b_val} \\cdot \\frac{{t^2}}{{2}}\\bigg|_0^1 = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Line integral with respect to arc length
        # Difficulty: 1600-1750
        a_val = nonzero(1, 4)
        
        # Integrate f(x,y) = xy along the circle x² + y² = a²
        # Parametrize: x = a*cos(t), y = a*sin(t), t in [0, 2π]
        # ds = a dt
        # f = a²*cos(t)*sin(t) = (a²/2)*sin(2t)
        # Integral of (a²/2)*sin(2t) * a dt from 0 to 2π
        # = (a³/2) * [-cos(2t)/2] from 0 to 2π = 0
        
        ans = 0
        
        return problem(
            question=f"Evaluate $\\int_C xy\\,ds$ where $C$ is the circle $x^2 + y^2 = {a_val**2}$ traversed counterclockwise.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parametrize the circle: $x = {a_val}\\cos(t)$, $y = {a_val}\\sin(t)$ for $t \\in [0, 2\\pi]$",
                f"Compute $ds = \\sqrt{{x'(t)^2 + y'(t)^2}}\\,dt = \\sqrt{{{a_val**2}\\sin^2(t) + {a_val**2}\\cos^2(t)}}\\,dt = {a_val}\\,dt$",
                f"On the curve: $xy = {a_val**2}\\cos(t)\\sin(t) = \\frac{{{a_val**2}}}{{2}}\\sin(2t)$",
                f"$\\int_C xy\\,ds = \\int_0^{{2\\pi}} \\frac{{{a_val**2}}}{{2}}\\sin(2t) \\cdot {a_val}\\,dt$",
                f"$= \\frac{{{a_val**3}}}{{2}} \\int_0^{{2\\pi}} \\sin(2t)\\,dt = \\frac{{{a_val**3}}}{{2}} \\left[-\\frac{{\\cos(2t)}}{{2}}\\right]_0^{{2\\pi}}$",
                f"$= \\frac{{{a_val**3}}}{{4}}[-\\cos(4\\pi) + \\cos(0)] = \\frac{{{a_val**3}}}{{4}}[-1 + 1] = 0$"
            ),
        )
    
    else:  # problem_type == 5
        # Circulation around a closed curve using Green's theorem verification
        # Difficulty: 1750-1900
        a_val = nonzero(-2, 2)
        b_val = nonzero(-2, 2)
        
        # F = <-y + ax, x + by>, rectangle [0,2] × [0,1]
        # Green's: ∮ F·dr = ∬ (∂Q/∂x - ∂P/∂y) dA
        # P = -y + ax, Q = x + by
        # ∂Q/∂x = 1, ∂P/∂y = -1
        # ∂Q/∂x - ∂P/∂y = 1 - (-1) = 2
        # Area = 2*1 = 2, so integral = 2*2 = 4
        
        ans = 4
        
        return problem(
            question=f"Compute the circulation $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle -y + {a_val}x, x + {b_val}y \\rangle$ and $C$ is the boundary of the rectangle $[0,2] \\times [0,1]$ traversed counterclockwise.",
            answer=ans,
            difficulty=(1750, 1900),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Use Green's Theorem: $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right) dA$",
                f"Here $P = -y + {a_val}x$ and $Q = x + {b_val}y$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = 1$, $\\frac{{\\partial P}}{{\\partial y}} = -1$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = 1 - (-1) = 2$",
                f"$\\iint_D 2\\,dA = 2 \\cdot \\text{{Area}}(D) = 2 \\cdot (2 \\times 1) = 4$"
            ),
        )

emit(generate())