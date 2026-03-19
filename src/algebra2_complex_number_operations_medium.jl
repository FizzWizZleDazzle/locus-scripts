# algebra2 - complex_number_operations (medium)
# Generated: 2026-03-08T20:14:04.038890

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/complex_number_operations")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Addition/subtraction of complex numbers (1200-1400)
        a = randint(-15, 15)
        b = nonzero(-15, 15)
        c = randint(-15, 15)
        d = nonzero(-15, 15)
        
        z1 = "$a + $(b)i"
        z2 = "$c + $(d)i"
        
        if rand(Bool)
            real_part = a + c
            imag_part = b + d
            operation = "+"
            op_word = "Add"
        else
            real_part = a - c
            imag_part = b - d
            operation = "-"
            op_word = "Subtract"
        end
        
        ans = "$(real_part) + $(imag_part)i"
        
        problem(
            question="$op_word the complex numbers: \\(($z1) $operation ($z2)\\)",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: \\(($z1) $operation ($z2)\\)",
                "Combine real parts and imaginary parts separately",
                "Real: $a $operation $c = $real_part",
                "Imaginary: $(b)i $operation $(d)i = $(imag_part)i",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif prob_type == 2
        # Multiplication of complex numbers (1300-1500)
        a = randint(-10, 10)
        b = nonzero(-10, 10)
        c = randint(-10, 10)
        d = nonzero(-10, 10)
        
        z1 = "$a + $(b)i"
        z2 = "$c + $(d)i"
        
        real_part = a*c - b*d
        imag_part = a*d + b*c
        
        ans = "$(real_part) + $(imag_part)i"
        
        problem(
            question="Multiply the complex numbers: \\(($z1)($z2)\\)",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Given: \\(($z1)($z2)\\)",
                "Use FOIL: \\($(a*c) + $(a*d)i + $(b*c)i + $(b*d)i^2\\)",
                "Recall \\(i^2 = -1\\), so \\($(b*d)i^2 = $(b*d)(-1) = $(-b*d)\\)",
                "Real part: $a \\cdot $c + $b \\cdot $d \\cdot (-1) = $(a*c) - $(b*d) = $real_part",
                "Imaginary part: $a \\cdot $d + $b \\cdot $c = $(a*d) + $(b*c) = $imag_part",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif prob_type == 3
        # Division of complex numbers (1400-1600)
        a = randint(-12, 12)
        b = nonzero(-12, 12)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        z1 = "$a + $(b)i"
        z2 = "$c + $(d)i"
        
        denom = c^2 + d^2
        real_part = (a*c + b*d) // denom
        imag_part = (b*c - a*d) // denom
        
        ans = "$(real_part) + $(imag_part)i"
        
        problem(
            question="Divide the complex numbers: \\(\\frac{$z1}{$z2}\\)",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                "Given: \\(\\frac{$z1}{$z2}\\)",
                "Multiply by conjugate: \\(\\frac{$z1}{$z2} \\cdot \\frac{$c - $(d)i}{$c - $(d)i}\\)",
                "Numerator: \\(($(a) + $(b)i)($(c) - $(d)i) = $(a*c + b*d) + $(b*c - a*d)i\\)",
                "Denominator: \\(($(c) + $(d)i)($(c) - $(d)i) = $(c)^2 + $(d)^2 = $denom\\)",
                "Simplify: \\(\\frac{$(a*c + b*d) + $(b*c - a*d)i}{$denom}\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif prob_type == 4
        # Powers of i (1200-1300)
        n = randint(4, 50)
        remainder = mod(n, 4)
        
        ans_map = Dict(0 => "1", 1 => "i", 2 => "-1", 3 => "-i")
        ans = ans_map[remainder]
        
        problem(
            question="Simplify: \\(i^{$n}\\)",
            answer=ans,
            difficulty=(1200, 1300),
            solution=steps(
                "Given: \\(i^{$n}\\)",
                "Recall the pattern: \\(i^1 = i, i^2 = -1, i^3 = -i, i^4 = 1\\)",
                "Find remainder when $n is divided by 4: \\($n = 4 \\cdot $(div(n,4)) + $remainder\\)",
                "Therefore \\(i^{$n} = i^{$remainder}\\)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif prob_type == 5
        # Complex conjugate operations (1300-1500)
        a = randint(-12, 12)
        b = nonzero(-12, 12)
        
        z = "$a + $(b)i"
        z_conj = "$a - $(b)i"
        
        if rand(Bool)
            # Product with conjugate
            ans = a^2 + b^2
            problem(
                question="If \\(z = $z\\), find \\(z \\cdot \\overline{z}\\)",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    "Given: \\(z = $z\\)",
                    "Conjugate: \\(\\overline{z} = $z_conj\\)",
                    "Multiply: \\(($z)($z_conj)\\)",
                    "\\(= $(a)^2 - ($(b)i)^2 = $(a^2) - $(b^2)i^2\\)",
                    "Since \\(i^2 = -1\\): \\($(a^2) + $(b^2) = $ans\\)",
                    sol("Answer", ans)
                ),
                time=120
            )
        else
            # Sum with conjugate
            ans = 2*a
            problem(
                question="If \\(z = $z\\), find \\(z + \\overline{z}\\)",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Given: \\(z = $z\\)",
                    "Conjugate: \\(\\overline{z} = $z_conj\\)",
                    "Add: \\(($z) + ($z_conj)\\)",
                    "Combine: \\($(2*a) + 0i\\)",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    else
        # Modulus (absolute value) of complex number (1300-1500)
        a = randint(-15, 15)
        b = nonzero(-15, 15)
        
        z = "$a + $(b)i"
        mod_squared = a^2 + b^2
        
        # Check if it's a perfect square
        mod_val = sqrt(mod_squared)
        if isinteger(mod_val)
            ans = Int(mod_val)
        else
            ans = "sqrt($mod_squared)"
        end
        
        problem(
            question="Find the modulus (absolute value) of the complex number: \\($z\\)",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Given: \\(z = $z\\)",
                "Use formula: \\(|z| = \\sqrt{a^2 + b^2}\\) where \\(z = a + bi\\)",
                "\\(|z| = \\sqrt{$(a)^2 + $(b)^2}\\)",
                "\\(|z| = \\sqrt{$(a^2) + $(b^2)} = \\sqrt{$mod_squared}\\)",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end