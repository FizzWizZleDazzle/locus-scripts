# algebra2 - complex_number_equations (very_easy)
# Generated: 2026-03-08T20:14:25.610398

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/complex_number_equations")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple i^n evaluation (ELO 200-400)
        n = randint(1, 8)
        powers_of_i = [im, -1, -im, 1]
        ans = powers_of_i[mod(n - 1, 4) + 1]
        
        problem(
            question="What is \$i^{$n}\$?",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Recall that \$i^1 = i\$, \$i^2 = -1\$, \$i^3 = -i\$, \$i^4 = 1\$",
                "The powers of \$i\$ repeat every 4 terms",
                "\$i^{$n} = $(tex(ans))\$"
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Solve x^2 = negative number (ELO 400-600)
        a = randint(1, 25)
        r1 = im * sqrt(a)
        r2 = -im * sqrt(a)
        
        problem(
            question="Solve \$x^2 = -$a\$",
            answer=fmt_set(Set([r1, r2])),
            difficulty=(400, 600),
            answer_type="set",
            solution=steps(
                sol("Given", x^2 ~ -a),
                "Take square root of both sides: \$x = \\pm\\sqrt{-$a}\$",
                "Simplify: \$x = \\pm $(sqrt(a))i\$",
                "Solution set: \$\\{$(sqrt(a))i, -$(sqrt(a))i\\}\$"
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Solve (x - h)^2 = negative (ELO 500-700)
        h = randint(-10, 10)
        a = randint(1, 16)
        r1 = h + im * sqrt(a)
        r2 = h - im * sqrt(a)
        
        problem(
            question="Solve \$(x - $h)^2 = -$a\$",
            answer=fmt_set(Set([r1, r2])),
            difficulty=(500, 700),
            answer_type="set",
            solution=steps(
                sol("Given", (x - h)^2 ~ -a),
                "Take square root: \$x - $h = \\pm\\sqrt{-$a}\$",
                "Simplify: \$x - $h = \\pm $(sqrt(a))i\$",
                "Add $h to both sides: \$x = $h \\pm $(sqrt(a))i\$",
                "Solution set: \$\\{$(h) + $(sqrt(a))i, $(h) - $(sqrt(a))i\\}\$"
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Add/subtract complex numbers (ELO 300-500)
        a = randint(-15, 15)
        b = nonzero(-15, 15)
        c = randint(-15, 15)
        d = nonzero(-15, 15)
        
        op = choice(["+", "-"])
        if op == "+"
            real_ans = a + c
            imag_ans = b + d
        else
            real_ans = a - c
            imag_ans = b - d
        end
        
        ans = real_ans + imag_ans * im
        
        z1_str = a == 0 ? "$(b)i" : (b > 0 ? "$a + $(b)i" : "$a - $(abs(b))i")
        z2_str = c == 0 ? "$(d)i" : (d > 0 ? "$c + $(d)i" : "$c - $(abs(d))i")
        
        problem(
            question="Simplify \$($z1_str) $op ($z2_str)\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Combine real parts: \$$a $op $c = $real_ans\$",
                "Combine imaginary parts: \$$(b)i $op $(d)i = $(imag_ans)i\$",
                sol("Answer", ans)
            ),
            time=45
        )
        
    else
        # Multiply simple complex numbers (ELO 400-700)
        a = randint(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-8, 8)
        d = nonzero(-8, 8)
        
        real_ans = a * c - b * d
        imag_ans = a * d + b * c
        ans = real_ans + imag_ans * im
        
        z1_str = a == 0 ? "$(b)i" : (b > 0 ? "$a + $(b)i" : "$a - $(abs(b))i")
        z2_str = c == 0 ? "$(d)i" : (d > 0 ? "$c + $(d)i" : "$c - $(abs(d))i")
        
        problem(
            question="Multiply \$($z1_str)($z2_str)\$",
            answer=ans,
            difficulty=(400, 700),
            solution=steps(
                "Use FOIL: \$($a)($c) + ($a)($(d)i) + ($(b)i)($c) + ($(b)i)($(d)i)\$",
                "Simplify: \$$(a*c) + $(a*d)i + $(b*c)i + $(b*d)i^2\$",
                "Since \$i^2 = -1\$: \$$(a*c) + $(a*d)i + $(b*c)i - $(b*d)\$",
                "Combine like terms: \$$(real_ans) + $(imag_ans)i\$"
            ),
            time=90
        )
    end
end