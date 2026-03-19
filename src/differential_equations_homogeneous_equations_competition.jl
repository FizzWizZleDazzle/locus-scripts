# differential_equations - homogeneous_equations (competition)
# Generated: 2026-03-08T20:52:56.568341

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/homogeneous_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Homogeneous ODE with non-polynomial coefficients requiring clever substitution
        # (x^2 + y^2)dx + (xy - x^2)dy = 0 type problems
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        # Construct M(x,y)dx + N(x,y)dy = 0 where M and N are homogeneous of same degree
        # Example: (ax^2 + by^2)dx + (cxy + dx^2)dy = 0
        m_coeffs = [a, b]
        n_coeffs = [c, d]
        
        question_text = "Solve the homogeneous differential equation: \$\$($(a)x^2 + $(b)y^2)dx + ($(c)xy + $(d)x^2)dy = 0\$\$"
        
        solution_text = steps(
            "Verify homogeneity: Both \$M(x,y) = $(a)x^2 + $(b)y^2\$ and \$N(x,y) = $(c)xy + $(d)x^2\$ are homogeneous of degree 2",
            "Use substitution \$y = vx\$, so \$dy = vdx + xdv\$",
            "Substitute: \$($(a)x^2 + $(b)v^2x^2)dx + ($(c)vx^2 + $(d)x^2)(vdx + xdv) = 0\$",
            "Factor \$x^2\$: \$x^2[($(a) + $(b)v^2)dx + ($(c)v + $(d))(vdx + xdv)] = 0\$",
            "Expand and separate variables: \$[$(a) + $(b)v^2 + $(c)v^2 + $(d)v]dx + ($(c)v + $(d))xdv = 0\$",
            "Rearrange: \$\\frac{dx}{x} = -\\frac{($(c)v + $(d))dv}{$(a) + $(b+c)v^2 + $(d)v}\$",
            "Integrate both sides and back-substitute \$v = y/x\$ to obtain the implicit solution",
            "The solution involves logarithmic and arctangent terms after integration"
        )
        
        answer_text = "implicit"
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(3500, 4000),
            solution=solution_text,
            time=300,
            answer_type="expression"
        )
        
    elseif problem_type == 2
        # Higher-order homogeneous ODE with parametric complexity
        # x^2y'' + axy' + by = 0 (Euler-Cauchy with twist)
        a = nonzero(-8, 8)
        b = nonzero(-15, 15)
        
        # Characteristic equation: r(r-1) + ar + b = 0
        # r^2 + (a-1)r + b = 0
        discriminant = (a-1)^2 - 4*b
        
        question_text = "Solve the homogeneous Euler-Cauchy equation for \$x > 0\$: \$\$x^2y'' + $(a)xy' + $(b)y = 0\$\$"
        
        if discriminant > 0
            r1 = ((1-a) + sqrt(discriminant)) / 2
            r2 = ((1-a) - sqrt(discriminant)) / 2
            sol_form = "y = C_1 x^{$(r1)} + C_2 x^{$(r2)}"
        elseif discriminant == 0
            r = (1-a) / 2
            sol_form = "y = (C_1 + C_2\\ln x)x^{$(r)}"
        else
            α = (1-a) / 2
            β = sqrt(-discriminant) / 2
            sol_form = "y = x^{$(α)}(C_1\\cos($(β)\\ln x) + C_2\\sin($(β)\\ln x))"
        end
        
        solution_text = steps(
            "This is an Euler-Cauchy equation. Try solution \$y = x^r\$",
            "Compute derivatives: \$y' = rx^{r-1}\$, \$y'' = r(r-1)x^{r-2}\$",
            "Substitute: \$x^2 \\cdot r(r-1)x^{r-2} + $(a)x \\cdot rx^{r-1} + $(b)x^r = 0\$",
            "Factor \$x^r\$: \$r(r-1) + $(a)r + $(b) = 0\$",
            "Characteristic equation: \$r^2 + $(a-1)r + $(b) = 0\$",
            "Discriminant: \$\\Delta = $(discriminant)\$",
            discriminant >= 0 ? "Two distinct/repeated real roots case" : "Complex conjugate roots case",
            "General solution: \$$(sol_form)\$"
        )
        
        problem(
            question=question_text,
            answer=sol_form,
            difficulty=(3800, 4300),
            solution=solution_text,
            time=360,
            answer_type="expression"
        )
        
    elseif problem_type == 3
        # System of homogeneous linear ODEs with eigenvalue analysis
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        # Ensure interesting eigenvalues
        trace = a + d
        det = a*d - b*c
        disc = trace^2 - 4*det
        
        question_text = "Solve the homogeneous system: \$\$\\frac{dx}{dt} = $(a)x + $(b)y, \\quad \\frac{dy}{dt} = $(c)x + $(d)y\$\$"
        
        solution_text = steps(
            "Write in matrix form: \$\\mathbf{x}' = A\\mathbf{x}\$ where \$A = \\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}\$",
            "Find eigenvalues: \$\\det(A - \\lambda I) = 0\$",
            "Characteristic polynomial: \$\\lambda^2 - $(trace)\\lambda + $(det) = 0\$",
            "Discriminant: \$\\Delta = $(disc)\$",
            disc >= 0 ? "Real eigenvalues: solve for \$\\lambda_1, \\lambda_2\$" : "Complex eigenvalues: \$\\lambda = \\alpha \\pm i\\beta\$",
            "Find eigenvectors for each eigenvalue",
            "General solution: \$\\mathbf{x}(t) = c_1\\mathbf{v}_1e^{\\lambda_1 t} + c_2\\mathbf{v}_2e^{\\lambda_2 t}\$",
            "Or in complex case: use Euler's formula to write in terms of sine and cosine"
        )
        
        problem(
            question=question_text,
            answer="parametric",
            difficulty=(4000, 4500),
            solution=solution_text,
            time=420,
            answer_type="expression"
        )
        
    else
        # Non-standard homogeneous ODE requiring advanced transformation
        # (x + y)^2 dy/dx = a^2 type or similar
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        k = rand(2:5)
        
        question_text = "Solve the differential equation: \$\$(x + y)^$(k) \\frac{dy}{dx} = $(a)^2(x - y)^$(k)\$\$"
        
        solution_text = steps(
            "This is a homogeneous equation. Let \$v = \\frac{y}{x}\$, so \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Divide both sides by \$x^$(k)\$: \$(1 + v)^$(k)(v + x\\frac{dv}{dx}) = $(a)^2(1 - v)^$(k)\$",
            "Separate variables: \$(1 + v)^$(k) v + x(1 + v)^$(k)\\frac{dv}{dx} = $(a)^2(1 - v)^$(k)\$",
            "Rearrange: \$x\\frac{dv}{dx} = \\frac{$(a)^2(1 - v)^$(k) - v(1 + v)^$(k)}{(1 + v)^$(k)}\$",
            "Separate: \$\\frac{(1 + v)^$(k)dv}{$(a)^2(1 - v)^$(k) - v(1 + v)^$(k)} = \\frac{dx}{x}\$",
            "Integrate both sides (may require partial fractions or substitution)",
            "Back-substitute \$v = y/x\$ to obtain implicit solution",
            "The integral on the left involves advanced techniques for degree $(k) polynomials"
        )
        
        problem(
            question=question_text,
            answer="implicit",
            difficulty=(4200, 4800),
            solution=solution_text,
            time=480,
            answer_type="expression"
        )
    end
end