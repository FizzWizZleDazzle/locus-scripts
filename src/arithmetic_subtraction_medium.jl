# arithmetic - subtraction (medium)
# Generated: 2026-03-08T19:46:01.709653

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/subtraction")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Multi-step subtraction with borrowing (1200-1400)
        a = randint(1000, 9999)
        b = randint(100, 999)
        c = randint(50, 500)
        ans = a - b - c
        
        problem(
            question="Calculate: \\($a - $b - $c\\)",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", "$a - $b - $c"),
                sol("First subtraction", "$a - $b = $(a - b)"),
                sol("Second subtraction", "$(a - b) - $c = $ans"),
                sol("Answer", ans)
            ),
            time=90
        )
    elseif problem_type == 2
        # Subtraction with negative result (1300-1500)
        a = randint(100, 800)
        b = randint(a + 200, a + 1500)
        ans = a - b
        
        problem(
            question="Calculate: \\($a - $b\\)",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", "$a - $b"),
                "Since $a < $b, the result will be negative",
                sol("Calculate difference", "$b - $a = $(b - a)"),
                sol("Answer", ans)
            ),
            time=75
        )
    elseif problem_type == 3
        # Word problem requiring equation setup (1400-1700)
        initial = randint(5000, 15000)
        expense1 = randint(500, 2000)
        expense2 = randint(300, 1500)
        expense3 = randint(200, 1000)
        ans = initial - expense1 - expense2 - expense3
        
        items = ["equipment", "supplies", "materials", "furniture", "inventory"]
        item1 = choice(items)
        item2 = choice(filter(x -> x != item1, items))
        item3 = choice(filter(x -> x != item1 && x != item2, items))
        
        problem(
            question="A business starts with \\\$$initial in their account. They spend \\\$$expense1 on $item1, \\\$$expense2 on $item2, and \\\$$expense3 on $item3. How much money remains in the account?",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                sol("Initial amount", "\\\$$initial"),
                sol("Total expenses", "\\\$$expense1 + \\\$$expense2 + \\\$$expense3 = \\\$$(expense1 + expense2 + expense3)"),
                sol("Remaining amount", "\\\$$initial - \\\$$(expense1 + expense2 + expense3) = \\\$$ans"),
                sol("Answer", "\\\$$ans")
            ),
            time=120
        )
    elseif problem_type == 4
        # Subtraction with multiple borrowing steps (1300-1600)
        a = randint(10000, 50000)
        b = randint(5000, 25000)
        c = randint(2000, 10000)
        d = randint(1000, 5000)
        ans = a - b - c - d
        
        problem(
            question="Evaluate: \\($a - $b - $c - $d\\)",
            answer=ans,
            difficulty=(1300, 1600),
            solution=steps(
                sol("Given expression", "$a - $b - $c - $d"),
                sol("First subtraction", "$a - $b = $(a - b)"),
                sol("Second subtraction", "$(a - b) - $c = $(a - b - c)"),
                sol("Third subtraction", "$(a - b - c) - $d = $ans"),
                sol("Answer", ans)
            ),
            time=100
        )
    else
        # Complex word problem with constraints (1500-1800)
        budget = randint(8000, 20000)
        spent1 = randint(1000, 3000)
        spent2 = randint(1500, 4000)
        remaining_needed = randint(500, 2000)
        
        available = budget - spent1 - spent2
        max_spend = available - remaining_needed
        
        problem(
            question="A project has a budget of \\\$$budget. After spending \\\$$spent1 on phase one and \\\$$spent2 on phase two, the manager needs to keep at least \\\$$remaining_needed in reserve. What is the maximum amount that can be spent on phase three?",
            answer=max_spend,
            difficulty=(1500, 1800),
            solution=steps(
                sol("Starting budget", "\\\$$budget"),
                sol("Amount spent so far", "\\\$$spent1 + \\\$$spent2 = \\\$$(spent1 + spent2)"),
                sol("Amount remaining", "\\\$$budget - \\\$$(spent1 + spent2) = \\\$$available"),
                sol("Required reserve", "\\\$$remaining_needed"),
                sol("Maximum for phase three", "\\\$$available - \\\$$remaining_needed = \\\$$max_spend"),
                sol("Answer", "\\\$$max_spend")
            ),
            time=150
        )
    end
end