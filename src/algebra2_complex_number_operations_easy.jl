# algebra2 - complex_number_operations (easy)
# Generated: 2026-03-08T20:13:52.314735

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("algebra2/complex_number_operations")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Addition of complex numbers
        a1 = randint(-12, 12)
        b1 = nonzero(-12, 12)
        a2 = randint(-12, 12)
        b2 = nonzero(-12, 12)
        
        real_part = a1 + a2
        imag_part = b1 + b2
        
        z1_str = b1 >= 0 ? "$(a1) + $(b1)i" : "$(a1) - $(abs(b1))i"
        z2_str = b2 >= 0 ? "$(a2) + $(b2)i" : "$(a2) - $(abs(b2))i"
        ans_str = imag_part >= 0 ? "$(real_part) + $(imag_part)i" : "$(real_part) - $(abs(imag_part))i"
        
        problem(
            question="Add the complex numbers: \\(($(z1_str)) + ($(z2_str))\\)",
            answer=ans_str,
            difficulty=(700, 850),
            solution=steps(
                "Given: \\(($(z1_str)) + ($(z2_str))\\)",
                "Add real parts: \\($(a1) + $(a2) = $(real_part)\\)",
                "Add imaginary parts: \\($(b1)i + $(b2)i = $(imag_part)i\\)",
                "Answer: \\($(ans_str)\\)"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Subtraction of complex numbers
        a1 = randint(-12, 12)
        b1 = nonzero(-12, 12)
        a2 = randint(-12, 12)
        b2 = nonzero(-12, 12)
        
        real_part = a1 - a2
        imag_part = b1 - b2
        
        z1_str = b1 >= 0 ? "$(a1) + $(b1)i" : "$(a1) - $(abs(b1))i"
        z2_str = b2 >= 0 ? "$(a2) + $(b2)i" : "$(a2) - $(abs(b2))i"
        ans_str = imag_part >= 0 ? "$(real_part) + $(imag_part)i" : "$(real_part) - $(abs(imag_part))i"
        
        problem(
            question="Subtract the complex numbers: \\(($(z1_str)) - ($(z2_str))\\)",
            answer=ans_str,
            difficulty=(700, 850),
            solution=steps(
                "Given: \\(($(z1_str)) - ($(z2_str))\\)",
                "Subtract real parts: \\($(a1) - $(a2) = $(real_part)\\)",
                "Subtract imaginary parts: \\($(b1)i - $(b2)i = $(imag_part)i\\)",
                "Answer: \\($(ans_str)\\)"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Multiplication of complex numbers
        a1 = randint(-8, 8)
        b1 = nonzero(-8, 8)
        a2 = randint(-8, 8)
        b2 = nonzero(-8, 8)
        
        real_part = a1*a2 - b1*b2
        imag_part = a1*b2 + a2*b1
        
        z1_str = b1 >= 0 ? "$(a1) + $(b1)i" : "$(a1) - $(abs(b1))i"
        z2_str = b2 >= 0 ? "$(a2) + $(b2)i" : "$(a2) - $(abs(b2))i"
        ans_str = imag_part >= 0 ? "$(real_part) + $(imag_part)i" : "$(real_part) - $(abs(imag_part))i"
        
        problem(
            question="Multiply the complex numbers: \\(($(z1_str))($(z2_str))\\)",
            answer=ans_str,
            difficulty=(900, 1100),
            solution=steps(
                "Given: \\(($(z1_str))($(z2_str))\\)",
                "Use FOIL: \\(($(a1))($(a2)) + ($(a1))($(b2)i) + ($(b1)i)($(a2)) + ($(b1)i)($(b2)i)\\)",
                "Simplify using \\(i^2 = -1\\): \\($(a1*a2) + $(a1*b2)i + $(b1*a2)i + $(b1*b2)i^2\\)",
                "Combine: \\($(a1*a2) - $(b1*b2) + $(imag_part)i = $(ans_str)\\)"
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Complex conjugate
        a = randint(-15, 15)
        b = nonzero(-15, 15)
        
        z_str = b >= 0 ? "$(a) + $(b)i" : "$(a) - $(abs(b))i"
        ans_str = b >= 0 ? "$(a) - $(b)i" : "$(a) + $(abs(b))i"
        
        problem(
            question="Find the complex conjugate of \\(z = $(z_str)\\)",
            answer=ans_str,
            difficulty=(700, 800),
            solution=steps(
                "Given: \\(z = $(z_str)\\)",
                "The complex conjugate changes the sign of the imaginary part",
                "Answer: \\(\\overline{z} = $(ans_str)\\)"
            ),
            time=45
        )
        
    elseif problem_type == 5
        # Modulus (absolute value) of complex number
        a = randint(-10, 10)
        b = nonzero(-10, 10)
        
        modulus_sq = a^2 + b^2
        modulus = sqrt(modulus_sq)
        
        z_str = b >= 0 ? "$(a) + $(b)i" : "$(a) - $(abs(b))i"
        
        problem(
            question="Find the modulus of the complex number \\(z = $(z_str)\\)",
            answer=modulus,
            difficulty=(800, 950),
            solution=steps(
                "Given: \\(z = $(z_str)\\)",
                "Use formula \\(|z| = \\sqrt{a^2 + b^2}\\)",
                "Calculate: \\(|z| = \\sqrt{$(a)^2 + $(b)^2} = \\sqrt{$(modulus_sq)}\\)",
                "Answer: \\(|z| = $(modulus)\\)"
            ),
            time=75
        )
        
    else
        # Division of complex numbers
        a1 = randint(-6, 6)
        b1 = nonzero(-6, 6)
        a2 = nonzero(-6, 6)
        b2 = nonzero(-6, 6)
        
        denom = a2^2 + b2^2
        real_part = (a1*a2 + b1*b2) // denom
        imag_part = (b1*a2 - a1*b2) // denom
        
        z1_str = b1 >= 0 ? "$(a1) + $(b1)i" : "$(a1) - $(abs(b1))i"
        z2_str = b2 >= 0 ? "$(a2) + $(b2)i" : "$(a2) - $(abs(b2))i"
        conj_str = b2 >= 0 ? "$(a2) - $(b2)i" : "$(a2) + $(abs(b2))i"
        
        ans_str = if imag_part >= 0
            "$(real_part) + $(imag_part)i"
        else
            "$(real_part) - $(abs(imag_part))i"
        end
        
        problem(
            question="Divide the complex numbers: \\(\\frac{$(z1_str)}{$(z2_str)}\\)",
            answer=ans_str,
            difficulty=(1000, 1200),
            solution=steps(
                "Given: \\(\\frac{$(z1_str)}{$(z2_str)}\\)",
                "Multiply by conjugate: \\(\\frac{$(z1_str)}{$(z2_str)} \\cdot \\frac{$(conj_str)}{$(conj_str)}\\)",
                "Simplify numerator and denominator using \\(i^2 = -1\\)",
                "Denominator: \\($(a2)^2 + $(b2)^2 = $(denom)\\)",
                "Answer: \\($(ans_str)\\)"
            ),
            time=120
        )
    end
end