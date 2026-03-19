# algebra2 - complex_number_operations (very_easy)
# Generated: 2026-03-08T20:13:53.970846

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("algebra2/complex_number_operations")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Simple addition of complex numbers
        a = randint(-10, 10)
        b = randint(-10, 10)
        c = randint(-10, 10)
        d = randint(-10, 10)
        
        real_part = a + c
        imag_part = b + d
        
        z1_str = a >= 0 ? "$a" : "($a)"
        z2_str = c >= 0 ? "$c" : "($c)"
        i1_str = b >= 0 ? (b == 1 ? "i" : "$(b)i") : (b == -1 ? "-i" : "$(b)i")
        i2_str = d >= 0 ? (d == 1 ? "i" : "$(d)i") : (d == -1 ? "-i" : "$(d)i")
        
        z1 = b >= 0 ? "$z1_str + $i1_str" : "$z1_str $i1_str"
        z2 = d >= 0 ? "$z2_str + $i2_str" : "$z2_str $i2_str"
        
        ans_str = if imag_part >= 0
            imag_part == 0 ? "$real_part" : (imag_part == 1 ? "$real_part + i" : "$real_part + $(imag_part)i")
        else
            imag_part == -1 ? "$real_part - i" : "$real_part - $(abs(imag_part))i"
        end
        
        problem(
            question = "Add the complex numbers: \\(($z1) + ($z2)\\)",
            answer = ans_str,
            difficulty = (200, 400),
            solution = steps(
                "Given: \\(($z1) + ($z2)\\)",
                "Add real parts: \\($a + $c = $real_part\\)",
                "Add imaginary parts: \\($b + $d = $imag_part\\)",
                sol("Answer", ans_str)
            ),
            time = 45
        )
        
    elseif problem_type == 2
        # Simple subtraction of complex numbers
        a = randint(-10, 10)
        b = randint(-10, 10)
        c = randint(-10, 10)
        d = randint(-10, 10)
        
        real_part = a - c
        imag_part = b - d
        
        z1_str = a >= 0 ? "$a" : "($a)"
        z2_str = c >= 0 ? "$c" : "($c)"
        i1_str = b >= 0 ? (b == 1 ? "i" : "$(b)i") : (b == -1 ? "-i" : "$(b)i")
        i2_str = d >= 0 ? (d == 1 ? "i" : "$(d)i") : (d == -1 ? "-i" : "$(d)i")
        
        z1 = b >= 0 ? "$z1_str + $i1_str" : "$z1_str $i1_str"
        z2 = d >= 0 ? "$z2_str + $i2_str" : "$z2_str $i2_str"
        
        ans_str = if imag_part >= 0
            imag_part == 0 ? "$real_part" : (imag_part == 1 ? "$real_part + i" : "$real_part + $(imag_part)i")
        else
            imag_part == -1 ? "$real_part - i" : "$real_part - $(abs(imag_part))i"
        end
        
        problem(
            question = "Subtract the complex numbers: \\(($z1) - ($z2)\\)",
            answer = ans_str,
            difficulty = (300, 500),
            solution = steps(
                "Given: \\(($z1) - ($z2)\\)",
                "Subtract real parts: \\($a - $c = $real_part\\)",
                "Subtract imaginary parts: \\($b - $d = $imag_part\\)",
                sol("Answer", ans_str)
            ),
            time = 60
        )
        
    elseif problem_type == 3
        # Multiply by a real scalar
        k = nonzero(-8, 8)
        a = randint(-10, 10)
        b = nonzero(-10, 10)
        
        real_part = k * a
        imag_part = k * b
        
        i_str = b >= 0 ? (b == 1 ? "i" : "$(b)i") : (b == -1 ? "-i" : "$(b)i")
        z_str = b >= 0 ? "$a + $i_str" : "$a $i_str"
        
        ans_str = if imag_part >= 0
            imag_part == 1 ? "$real_part + i" : "$real_part + $(imag_part)i"
        else
            imag_part == -1 ? "$real_part - i" : "$real_part - $(abs(imag_part))i"
        end
        
        problem(
            question = "Multiply: \\($k($z_str)\\)",
            answer = ans_str,
            difficulty = (400, 600),
            solution = steps(
                "Given: \\($k($z_str)\\)",
                "Distribute: \\($k \\cdot $a = $real_part\\) and \\($k \\cdot $b i = $(imag_part)i\\)",
                sol("Answer", ans_str)
            ),
            time = 60
        )
        
    elseif problem_type == 4
        # Simple multiplication (small integers)
        a = randint(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-5, 5)
        d = nonzero(-5, 5)
        
        real_part = a * c - b * d
        imag_part = a * d + b * c
        
        i1_str = b >= 0 ? (b == 1 ? "i" : "$(b)i") : (b == -1 ? "-i" : "$(b)i")
        i2_str = d >= 0 ? (d == 1 ? "i" : "$(d)i") : (d == -1 ? "-i" : "$(d)i")
        
        z1 = b >= 0 ? "$a + $i1_str" : "$a $i1_str"
        z2 = d >= 0 ? "$c + $i2_str" : "$c $i2_str"
        
        ans_str = if imag_part >= 0
            imag_part == 0 ? "$real_part" : (imag_part == 1 ? "$real_part + i" : "$real_part + $(imag_part)i")
        else
            imag_part == -1 ? "$real_part - i" : "$real_part - $(abs(imag_part))i"
        end
        
        problem(
            question = "Multiply the complex numbers: \\(($z1)($z2)\\)",
            answer = ans_str,
            difficulty = (500, 700),
            solution = steps(
                "Given: \\(($z1)($z2)\\)",
                "Use FOIL: \\($(a*c) + $(a*d)i + $(b*c)i + $(b*d)i^2\\)",
                "Since \\(i^2 = -1\\): Real part = \\($a \\cdot $c - $b \\cdot $d = $real_part\\), Imaginary part = \\($a \\cdot $d + $b \\cdot $c = $imag_part\\)",
                sol("Answer", ans_str)
            ),
            time = 90
        )
        
    elseif problem_type == 5
        # Find the real part
        a = randint(-15, 15)
        b = nonzero(-15, 15)
        
        i_str = b >= 0 ? (b == 1 ? "i" : "$(b)i") : (b == -1 ? "-i" : "$(b)i")
        z_str = b >= 0 ? "$a + $i_str" : "$a $i_str"
        
        problem(
            question = "What is the real part of \\($z_str\\)?",
            answer = a,
            difficulty = (100, 300),
            solution = steps(
                "Given: \\($z_str\\)",
                "A complex number is written as \\(a + bi\\) where \\(a\\) is the real part",
                sol("Answer", a)
            ),
            time = 30
        )
        
    else
        # Find the imaginary part
        a = randint(-15, 15)
        b = nonzero(-15, 15)
        
        i_str = b >= 0 ? (b == 1 ? "i" : "$(b)i") : (b == -1 ? "-i" : "$(b)i")
        z_str = b >= 0 ? "$a + $i_str" : "$a $i_str"
        
        problem(
            question = "What is the imaginary part (coefficient of \\(i\\)) of \\($z_str\\)?",
            answer = b,
            difficulty = (100, 300),
            solution = steps(
                "Given: \\($z_str\\)",
                "A complex number is written as \\(a + bi\\) where \\(b\\) is the imaginary part",
                sol("Answer", b)
            ),
            time = 30
        )
    end
end