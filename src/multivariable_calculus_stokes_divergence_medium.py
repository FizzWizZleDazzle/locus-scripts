"""
multivariable_calculus - stokes_divergence (medium)
Generated: 2026-02-22T05:47:12.391552
"""

from problem_utils import *

def generate():
    problem_type = choice(['divergence_compute', 'stokes_verify', 'divergence_theorem', 'stokes_line_integral'])
    
    if problem_type == 'divergence_compute':
        # Compute divergence of a vector field
        # Standard difficulty: polynomial or trigonometric components
        
        field_type = choice(['polynomial', 'mixed'])
        
        if field_type == 'polynomial':
            # F = (P(x,y,z), Q(x,y,z), R(x,y,z))
            deg = randint(1, 2)
            
            # P component
            p_coeff = nonzero(-3, 3)
            p_var = choice([x, y, z, x*y, x*z, y*z, x**2, y**2, z**2])
            P = p_coeff * p_var
            
            # Q component
            q_coeff = nonzero(-3, 3)
            q_var = choice([x, y, z, x*y, x*z, y*z, x**2, y**2, z**2])
            Q = q_coeff * q_var
            
            # R component
            r_coeff = nonzero(-3, 3)
            r_var = choice([x, y, z, x*y, x*z, y*z, x**2, y**2, z**2])
            R = r_coeff * r_var
            
        else:  # mixed
            P = choice([sin(x), cos(y), x*y, x**2])
            Q = choice([cos(x), sin(z), y*z, y**2])
            R = choice([sin(z), cos(x), x*z, z**2])
        
        # Compute divergence
        div_F = diff(P, x) + diff(Q, y) + diff(R, z)
        div_F = simplify(div_F)
        
        return problem(
            question=f"Compute the divergence of the vector field $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)}, {latex(R)} \\rangle$",
            answer=div_F,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"The divergence is $\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial P}}{{\\partial x}} + \\frac{{\\partial Q}}{{\\partial y}} + \\frac{{\\partial R}}{{\\partial z}}$",
                f"$\\frac{{\\partial}}{{\\partial x}}\\left({latex(P)}\\right) = {latex(diff(P, x))}$",
                f"$\\frac{{\\partial}}{{\\partial y}}\\left({latex(Q)}\\right) = {latex(diff(Q, y))}$",
                f"$\\frac{{\\partial}}{{\\partial z}}\\left({latex(R)}\\right) = {latex(diff(R, z))}$",
                f"$\\nabla \\cdot \\mathbf{{F}} = {latex(div_F)}$"
            )
        )
    
    elif problem_type == 'stokes_verify':
        # Verify Stokes' theorem for a simple surface
        # Compute curl of a vector field
        
        # Simple vector field
        p_coeff = nonzero(-2, 2)
        q_coeff = nonzero(-2, 2)
        r_coeff = nonzero(-2, 2)
        
        P = p_coeff * y
        Q = q_coeff * x
        R = r_coeff * z
        
        # Compute curl
        curl_x = diff(R, y) - diff(Q, z)
        curl_y = diff(P, z) - diff(R, x)
        curl_z = diff(Q, x) - diff(P, y)
        
        curl_x = simplify(curl_x)
        curl_y = simplify(curl_y)
        curl_z = simplify(curl_z)
        
        return problem(
            question=f"Compute the curl of the vector field $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)}, {latex(R)} \\rangle$",
            answer=fmt_tuple(curl_x, curl_y, curl_z),
            difficulty=(1300, 1500),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"The curl is $\\nabla \\times \\mathbf{{F}} = \\left\\langle \\frac{{\\partial R}}{{\\partial y}} - \\frac{{\\partial Q}}{{\\partial z}}, \\frac{{\\partial P}}{{\\partial z}} - \\frac{{\\partial R}}{{\\partial x}}, \\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} \\right\\rangle$",
                f"$\\frac{{\\partial R}}{{\\partial y}} - \\frac{{\\partial Q}}{{\\partial z}} = {latex(diff(R, y))} - {latex(diff(Q, z))} = {latex(curl_x)}$",
                f"$\\frac{{\\partial P}}{{\\partial z}} - \\frac{{\\partial R}}{{\\partial x}} = {latex(diff(P, z))} - {latex(diff(R, x))} = {latex(curl_y)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(diff(Q, x))} - {latex(diff(P, y))} = {latex(curl_z)}$",
                f"$\\nabla \\times \\mathbf{{F}} = \\langle {latex(curl_x)}, {latex(curl_y)}, {latex(curl_z)} \\rangle$"
            )
        )
    
    elif problem_type == 'divergence_theorem':
        # Apply divergence theorem to compute flux
        # Use a box region for simplicity
        
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(1, 3)
        
        # Simple vector field where divergence is constant or linear
        P = x
        Q = y
        R = z
        
        div_F = 3  # divergence is constant
        
        # Volume of box
        volume = a_val * b_val * c_val
        
        # Flux = integral of divergence over volume
        flux = div_F * volume
        
        return problem(
            question=f"Use the Divergence Theorem to find the flux of $\\mathbf{{F}} = \\langle x, y, z \\rangle$ through the boundary of the box $[0, {a_val}] \\times [0, {b_val}] \\times [0, {c_val}]$",
            answer=flux,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"By the Divergence Theorem, $\\iint_S \\mathbf{{F}} \\cdot d\\mathbf{{S}} = \\iiint_E \\nabla \\cdot \\mathbf{{F}} \\, dV$",
                f"Compute the divergence: $\\nabla \\cdot \\mathbf{{F}} = \\frac{{\\partial x}}{{\\partial x}} + \\frac{{\\partial y}}{{\\partial y}} + \\frac{{\\partial z}}{{\\partial z}} = 1 + 1 + 1 = 3$",
                f"The volume integral is $\\iiint_E 3 \\, dV = 3 \\cdot V$",
                f"The volume of the box is $V = {a_val} \\cdot {b_val} \\cdot {c_val} = {volume}$",
                f"Therefore, the flux is $3 \\cdot {volume} = {flux}$"
            ),
            calculator="scientific"
        )
    
    else:  # stokes_line_integral
        # Use Stokes' theorem to evaluate a line integral
        # Simple case: circle in xy-plane
        
        radius = randint(1, 3)
        
        # Vector field with simple curl
        coeff = nonzero(-3, 3)
        P = -coeff * y
        Q = coeff * x
        R = 0
        
        # Curl has only z-component
        curl_z = diff(Q, x) - diff(P, y)
        curl_z = simplify(curl_z)
        
        # Integral over disk
        area = radius**2
        line_integral = curl_z * area * pi
        
        return problem(
            question=f"Use Stokes' Theorem to evaluate $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)}, {latex(R)} \\rangle$ and $C$ is the circle $x^2 + y^2 = {radius**2}$ in the xy-plane, oriented counterclockwise",
            answer=line_integral,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/stokes_divergence",
            solution=steps(
                f"By Stokes' Theorem, $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\iint_S (\\nabla \\times \\mathbf{{F}}) \\cdot d\\mathbf{{S}}$",
                f"Compute the curl: $(\\nabla \\times \\mathbf{{F}})_z = \\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(diff(Q, x))} - ({latex(diff(P, y))}) = {latex(curl_z)}$",
                f"The surface is the disk $x^2 + y^2 \\leq {radius**2}$ with upward normal $\\mathbf{{k}}$",
                f"$\\iint_S (\\nabla \\times \\mathbf{{F}}) \\cdot \\mathbf{{k}} \\, dS = \\iint_D {latex(curl_z)} \\, dA$",
                f"$= {latex(curl_z)} \\cdot \\pi \\cdot {radius}^2 = {latex(line_integral)}$"
            ),
            calculator="scientific"
        )

emit(generate())