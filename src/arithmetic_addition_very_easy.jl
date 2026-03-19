# arithmetic - addition (very_easy)
# Generated: 2026-03-08T19:45:22.882004

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/addition")
    
    difficulty_target = randint(100, 700)
    
    if difficulty_target <= 300
        # Very basic: single digit addition
        a = randint(1, 9)
        b = randint(1, 9)
        ans = a + b
        
        problem(
            question="What is \\($a + $b\\)?",
            answer=ans,
            difficulty=(100, 300),
            solution=steps(
                "We need to add $a and $b",
                "Count: $a + $b",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif difficulty_target <= 500
        # Elementary: two-digit addition without carrying
        a = randint(10, 44)
        b = randint(10, 44)
        # Ensure no carrying by keeping digits small
        for _attempt in 1:1000
            (a % 10) + (b % 10) >= 10 || break
            b = randint(10, 44)
        end
        ans = a + b
        
        problem(
            question="Calculate \\($a + $b\\)",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", "$a + $b"),
                "Add ones place: $(a % 10) + $(b % 10) = $(ans % 10)",
                "Add tens place: $(div(a, 10)) + $(div(b, 10)) = $(div(ans, 10))",
                sol("Answer", ans)
            ),
            time=45
        )
    else
        # Upper elementary: two-digit addition with carrying
        a = randint(25, 89)
        b = randint(25, 89)
        # Ensure carrying happens
        for _attempt in 1:1000
            (a % 10) + (b % 10) < 10 || break
            b = randint(25, 89)
        end
        ans = a + b
        ones_sum = (a % 10) + (b % 10)
        carry = div(ones_sum, 10)
        
        problem(
            question="Find the sum: \\($a + $b\\)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "$a + $b"),
                "Add ones place: $(a % 10) + $(b % 10) = $ones_sum, write $(ones_sum % 10) and carry $carry",
                "Add tens place with carry: $(div(a, 10)) + $(div(b, 10)) + $carry = $(div(ans, 10))",
                sol("Answer", ans)
            ),
            time=60
        )
    end
end