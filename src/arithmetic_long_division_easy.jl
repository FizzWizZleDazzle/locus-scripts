# arithmetic - long_division (easy)
# Generated: 2026-03-08T19:47:06.418661

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/long_division")
    
    # Choose problem type based on difficulty range
    prob_type = choice([:basic_division, :remainder_problem, :decimal_result, :word_problem])
    
    if prob_type == :basic_division
        # Simple long division with no remainder
        divisor = randint(2, 12)
        quotient = randint(5, 25)
        dividend = divisor * quotient
        
        problem(
            question="Divide $dividend by $divisor using long division.",
            answer=quotient,
            difficulty=(700, 850),
            solution=steps(
                "Set up long division: $dividend ÷ $divisor",
                "Divide: $dividend ÷ $divisor = $quotient",
                sol("Answer", quotient)
            ),
            time=90
        )
        
    elseif prob_type == :remainder_problem
        # Division with remainder
        divisor = randint(6, 18)
        quotient = randint(8, 30)
        remainder = randint(1, divisor - 1)
        dividend = divisor * quotient + remainder
        
        problem(
            question="Divide $dividend by $divisor. Express your answer as quotient with remainder (e.g., \"12 R 3\").",
            answer="$quotient R $remainder",
            difficulty=(800, 950),
            answer_type="string",
            solution=steps(
                "Set up long division: $dividend ÷ $divisor",
                "Find quotient: $divisor × $quotient = $(divisor * quotient)",
                "Calculate remainder: $dividend - $(divisor * quotient) = $remainder",
                sol("Answer", "$quotient R $remainder")
            ),
            time=120
        )
        
    elseif prob_type == :decimal_result
        # Division resulting in decimal (terminating)
        # Construct so it terminates nicely
        base = choice([2, 4, 5, 8, 10, 20, 25])
        quotient_int = randint(3, 15)
        quotient_dec = choice([5, 25, 75, 125, 375, 625])
        
        if base == 2
            dividend = quotient_int * 2 + 1
            divisor = 2
            ans = dividend / divisor
        elseif base == 4
            dividend = quotient_int * 4 + choice([1, 2, 3])
            divisor = 4
            ans = dividend / divisor
        elseif base == 5
            dividend = quotient_int * 5 + choice([1, 2, 3, 4])
            divisor = 5
            ans = dividend / divisor
        else
            divisor = base
            dividend = randint(divisor + 1, divisor * 20 + divisor - 1)
            ans = dividend / divisor
        end
        
        problem(
            question="Divide $dividend by $divisor. Express your answer as a decimal.",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Set up long division: $dividend ÷ $divisor",
                "Perform division with decimal places",
                sol("Answer", ans)
            ),
            time=150,
            calculator="scientific"
        )
        
    else  # word_problem
        # Word problem involving division
        items_per_group = randint(4, 15)
        num_groups = randint(6, 20)
        total_items = items_per_group * num_groups
        
        contexts = [
            ("cookies", "boxes", "cookies per box"),
            ("students", "buses", "students per bus"),
            ("books", "shelves", "books per shelf"),
            ("apples", "bags", "apples per bag"),
            ("pencils", "packages", "pencils per package")
        ]
        
        item, container, desc = choice(contexts)
        
        problem(
            question="There are $total_items $item that need to be divided equally into $num_groups $container. How many $item will be in each $(container[1:end-1])?",
            answer=items_per_group,
            difficulty=(950, 1200),
            solution=steps(
                "Total $item: $total_items",
                "Number of $container: $num_groups",
                "Divide: $total_items ÷ $num_groups = $items_per_group",
                sol("Answer", "$items_per_group $desc")
            ),
            time=120
        )
    end
end