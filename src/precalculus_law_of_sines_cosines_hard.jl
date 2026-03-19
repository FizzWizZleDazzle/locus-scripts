# precalculus - law_of_sines_cosines (hard)
# Generated: 2026-03-08T20:32:26.353702

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script a b c A B C begin
    set_topic!("precalculus/law_of_sines_cosines")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Law of Cosines: given three sides, find largest angle (expert level)
        side_a = randint(8, 25)
        side_b = randint(8, 25)
        side_c = randint(max(abs(side_a - side_b) + 1, 8), min(side_a + side_b - 1, 25))
        
        # Find largest angle (opposite largest side)
        sides = sort([side_a, side_b, side_c], rev=true)
        largest = sides[1]
        other1 = sides[2]
        other2 = sides[3]
        
        # Law of cosines: c² = a² + b² - 2ab cos(C)
        cos_angle = (other1^2 + other2^2 - largest^2) / (2 * other1 * other2)
        angle_rad = acos(cos_angle)
        angle_deg = angle_rad * 180 / π
        
        problem(
            question="A triangle has sides of length $(side_a), $(side_b), and $(side_c). Find the measure of the largest angle in degrees. Round to two decimal places.",
            answer=round(angle_deg, digits=2),
            difficulty=(1850, 2100),
            solution=steps(
                "The largest angle is opposite the largest side (length $(largest))",
                sol("Law of Cosines", "c^2 = a^2 + b^2 - 2ab\\cos(C)"),
                "\\cos(C) = \\frac{$(other1)^2 + $(other2)^2 - $(largest)^2}{2($(other1))($(other2))} = \\frac{$(other1^2 + other2^2 - largest^2)}{$(2*other1*other2)}",
                "C = \\cos^{-1}\\left($(round(cos_angle, digits=4))\\right) \\approx $(round(angle_deg, digits=2))°"
            ),
            calculator="scientific",
            time=180
        )
        
    elseif problem_type == 2
        # Law of Sines with ambiguous case (SSA - competition entry)
        side_a = randint(10, 30)
        angle_A_deg = randint(25, 55)
        angle_A_rad = angle_A_deg * π / 180
        
        # Choose side_b to create ambiguous case
        h = side_a * sin(angle_A_rad)
        side_b = randint(ceil(Int, h) + 2, side_a + 5)
        
        # Two possible angles for B
        sin_B = side_b * sin(angle_A_rad) / side_a
        
        if sin_B < 1 && side_b > side_a * sin(angle_A_rad) && side_b < side_a
            angle_B1_rad = asin(sin_B)
            angle_B1_deg = angle_B1_rad * 180 / π
            angle_B2_deg = 180 - angle_B1_deg
            
            angle_C1_deg = 180 - angle_A_deg - angle_B1_deg
            angle_C2_deg = 180 - angle_A_deg - angle_B2_deg
            
            side_c1 = side_a * sin(angle_C1_deg * π / 180) / sin(angle_A_rad)
            side_c2 = side_a * sin(angle_C2_deg * π / 180) / sin(angle_A_rad)
            
            num_triangles = (angle_C1_deg > 0 && angle_C2_deg > 0) ? 2 : 1
            
            problem(
                question="In triangle ABC, a = $(side_a), b = $(side_b), and A = $(angle_A_deg)°. How many distinct triangles can be formed with these measurements?",
                answer=num_triangles,
                difficulty=(2100, 2400),
                solution=steps(
                    "Check for ambiguous case (SSA): given two sides and non-included angle",
                    sol("Law of Sines", "\\frac{\\sin A}{a} = \\frac{\\sin B}{b}"),
                    "\\sin B = \\frac{b \\sin A}{a} = \\frac{$(side_b) \\sin($(angle_A_deg)°)}{$(side_a)} \\approx $(round(sin_B, digits=4))",
                    "Since 0 < \\sin B < 1, angle B has two possible values: B₁ ≈ $(round(angle_B1_deg, digits=2))° and B₂ ≈ $(round(angle_B2_deg, digits=2))°",
                    "Check if both create valid triangles (C > 0°): $(num_triangles) distinct triangle(s) possible"
                ),
                calculator="scientific",
                time=240
            )
        else
            # Fallback to simpler unique triangle case
            side_b = randint(side_a + 3, side_a + 15)
            sin_B = side_b * sin(angle_A_rad) / side_a
            sin_B = min(sin_B, 0.99)
            
            angle_B_deg = round(asin(sin_B) * 180 / π, digits=2)
            
            problem(
                question="In triangle ABC, a = $(side_a), b = $(side_b), and A = $(angle_A_deg)°. Find angle B in degrees. Round to two decimal places.",
                answer=angle_B_deg,
                difficulty=(1800, 2000),
                solution=steps(
                    sol("Law of Sines", "\\frac{\\sin A}{a} = \\frac{\\sin B}{b}"),
                    "\\sin B = \\frac{b \\sin A}{a} = \\frac{$(side_b) \\sin($(angle_A_deg)°)}{$(side_a)}",
                    "B = \\sin^{-1}\\left($(round(sin_B, digits=4))\\right) \\approx $(angle_B_deg)°"
                ),
                calculator="scientific",
                time=150
            )
        end
        
    elseif problem_type == 3
        # Law of Cosines to find third side (SAS)
        side_a = randint(12, 40)
        side_b = randint(12, 40)
        angle_C_deg = randint(35, 145)
        angle_C_rad = angle_C_deg * π / 180
        
        # c² = a² + b² - 2ab cos(C)
        side_c_sq = side_a^2 + side_b^2 - 2*side_a*side_b*cos(angle_C_rad)
        side_c = sqrt(side_c_sq)
        
        problem(
            question="In triangle ABC, a = $(side_a), b = $(side_b), and C = $(angle_C_deg)°. Find the length of side c. Round to two decimal places.",
            answer=round(side_c, digits=2),
            difficulty=(1850, 2050),
            solution=steps(
                "Use Law of Cosines with SAS (side-angle-side)",
                sol("c^2 = a^2 + b^2 - 2ab\\cos C"),
                "c^2 = $(side_a)^2 + $(side_b)^2 - 2($(side_a))($(side_b))\\cos($(angle_C_deg)°)",
                "c^2 = $(side_a^2) + $(side_b^2) - $(2*side_a*side_b)\\cos($(angle_C_deg)°) \\approx $(round(side_c_sq, digits=2))",
                "c \\approx $(round(side_c, digits=2))"
            ),
            calculator="scientific",
            time=150
        )
        
    elseif problem_type == 4
        # Area using Law of Sines approach (competition level)
        side_a = randint(15, 35)
        angle_B_deg = randint(40, 80)
        angle_C_deg = randint(40, 80)
        
        if angle_B_deg + angle_C_deg >= 180
            angle_C_deg = 180 - angle_B_deg - randint(20, 40)
        end
        
        angle_A_deg = 180 - angle_B_deg - angle_C_deg
        angle_A_rad = angle_A_deg * π / 180
        angle_B_rad = angle_B_deg * π / 180
        angle_C_rad = angle_C_deg * π / 180
        
        # Find other sides using Law of Sines
        side_b = side_a * sin(angle_B_rad) / sin(angle_A_rad)
        
        # Area = (1/2)ab sin(C)
        area = 0.5 * side_a * side_b * sin(angle_C_rad)
        
        problem(
            question="In triangle ABC, a = $(side_a), B = $(angle_B_deg)°, and C = $(angle_C_deg)°. Find the area of the triangle. Round to two decimal places.",
            answer=round(area, digits=2),
            difficulty=(2000, 2300),
            solution=steps(
                "First find angle A: A = 180° - $(angle_B_deg)° - $(angle_C_deg)° = $(angle_A_deg)°",
                sol("Law of Sines", "\\frac{a}{\\sin A} = \\frac{b}{\\sin B}"),
                "b = \\frac{a \\sin B}{\\sin A} = \\frac{$(side_a) \\sin($(angle_B_deg)°)}{\\sin($(angle_A_deg)°)} \\approx $(round(side_b, digits=2))",
                sol("Area", "\\text{Area} = \\frac{1}{2}ab\\sin C"),
                "\\text{Area} = \\frac{1}{2}($(side_a))($(round(side_b, digits=2)))\\sin($(angle_C_deg)°) \\approx $(round(area, digits=2))"
            ),
            calculator="scientific",
            time=210
        )
        
    elseif problem_type == 5
        # Combined Law of Cosines and Sines (expert)
        side_a = randint(18, 35)
        side_b = randint(18, 35)
        side_c = randint(max(abs(side_a - side_b) + 2, 15), min(side_a + side_b - 2, 40))
        
        # Find angle A using Law of Cosines
        cos_A = (side_b^2 + side_c^2 - side_a^2) / (2 * side_b * side_c)
        angle_A_rad = acos(cos_A)
        
        # Area using Heron's formula or (1/2)bc sin(A)
        area = 0.5 * side_b * side_c * sin(angle_A_rad)
        
        problem(
            question="A triangle has sides a = $(side_a), b = $(side_b), and c = $(side_c). Find the area of the triangle. Round to two decimal places.",
            answer=round(area, digits=2),
            difficulty=(2100, 2400),
            solution=steps(
                "Use Law of Cosines to find an angle first",
                "\\cos A = \\frac{b^2 + c^2 - a^2}{2bc} = \\frac{$(side_b^2) + $(side_c^2) - $(side_a^2)}{2($(side_b))($(side_c))} = \\frac{$(side_b^2 + side_c^2 - side_a^2)}{$(2*side_b*side_c)}",
                "A = \\cos^{-1}\\left($(round(cos_A, digits=4))\\right)",
                sol("Area", "\\text{Area} = \\frac{1}{2}bc\\sin A"),
                "\\text{Area} = \\frac{1}{2}($(side_b))($(side_c))\\sin A \\approx $(round(area, digits=2))"
            ),
            calculator="scientific",
            time=240
        )
        
    else
        # Distance between two points using Law of Cosines (application problem)
        dist1 = randint(8, 25)
        dist2 = randint(8, 25)
        angle_deg = randint(30, 150)
        angle_rad = angle_deg * π / 180
        
        # Distance = sqrt(d1² + d2² - 2*d1*d2*cos(angle))
        distance_sq = dist1^2 + dist2^2 - 2*dist1*dist2*cos(angle_rad)
        distance = sqrt(distance_sq)
        
        problem(
            question="Two ships leave a port at the same time. One travels $(dist1) km on a bearing, and the other travels $(dist2) km on a bearing that differs by $(angle_deg)° from the first. How far apart are the two ships? Round to two decimal places.",
            answer=round(distance, digits=2),
            difficulty=(1900, 2200),
            solution=steps(
                "The angle between the two paths is $(angle_deg)°",
                sol("Law of Cosines", "d^2 = a^2 + b^2 - 2ab\\cos\\theta"),
                "d^2 = $(dist1)^2 + $(dist2)^2 - 2($(dist1))($(dist2))\\cos($(angle_deg)°)",
                "d^2 = $(dist1^2) + $(dist2^2) - $(2*dist1*dist2)\\cos($(angle_deg)°) \\approx $(round(distance_sq, digits=2))",
                "d \\approx $(round(distance, digits=2)) \\text{ km}"
            ),
            calculator="scientific",
            time=180
        )
    end
end