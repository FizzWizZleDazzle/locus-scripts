"""
algebra2 - exponential_growth_decay (easy)
Generated: 2026-02-22T04:28:05.424471
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple exponential growth: A = P(1 + r)^t with all values given
        P = choice([100, 200, 500, 1000, 1500, 2000])
        r = choice([0.05, 0.10, 0.15, 0.20, 0.25])
        t_val = randint(1, 3)
        
        A_val = P * (1 + r)**t_val
        A_val = round(A_val, 2)
        
        r_percent = int(r * 100)
        
        return problem(
            question=f"An investment of $\\${P}$ grows at ${r_percent}\\%$ per year. What is the value after ${t_val}$ year{'s' if t_val > 1 else ''}? Round to the nearest cent.",
            answer=A_val,
            difficulty=(1000, 1150),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the formula $A = P(1 + r)^t$",
                f"$A = {P}(1 + {r})^{{{t_val}}}$",
                f"$A = {P}({1 + r})^{{{t_val}}}$",
                f"$A = {P} \\cdot {round((1 + r)**t_val, 4)}$",
                f"$A = {A_val}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Simple exponential decay: A = P(1 - r)^t
        P = choice([1000, 1500, 2000, 2500, 3000])
        r = choice([0.10, 0.15, 0.20, 0.25, 0.30])
        t_val = randint(1, 2)
        
        A_val = P * (1 - r)**t_val
        A_val = round(A_val, 2)
        
        r_percent = int(r * 100)
        
        return problem(
            question=f"A car worth $\\${P}$ depreciates at ${r_percent}\\%$ per year. What is its value after ${t_val}$ year{'s' if t_val > 1 else ''}? Round to the nearest cent.",
            answer=A_val,
            difficulty=(1000, 1150),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the decay formula $A = P(1 - r)^t$",
                f"$A = {P}(1 - {r})^{{{t_val}}}$",
                f"$A = {P}({1 - r})^{{{t_val}}}$",
                f"$A = {P} \\cdot {round((1 - r)**t_val, 4)}$",
                f"$A = {A_val}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Identify growth vs decay from an equation
        base = choice([1.05, 1.10, 1.15, 0.85, 0.90, 0.95])
        P = choice([100, 500, 1000])
        
        if base > 1:
            ans_text = "growth"
        else:
            ans_text = "decay"
        
        return problem(
            question=f"Does the function $y = {P}({base})^t$ represent exponential growth or exponential decay?",
            answer=ans_text,
            difficulty=(1050, 1200),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Check the base of the exponential: ${base}$",
                f"If base $> 1$, it's growth; if $0 < $ base $< 1$, it's decay",
                f"Since ${base}$ {'$> 1$' if base > 1 else '$< 1$'}, this is exponential {ans_text}"
            ),
            answer_type="expression"
        )
    
    else:
        # Find growth/decay rate from equation
        rate = choice([5, 10, 15, 20, 25])
        P = choice([100, 200, 500, 1000])
        
        if randint(0, 1) == 0:
            # Growth
            base = 1 + rate/100
            ans = rate
            
            return problem(
                question=f"The function $y = {P}({base})^t$ models exponential growth. What is the growth rate as a percentage?",
                answer=ans,
                difficulty=(1100, 1250),
                topic="algebra2/exponential_growth_decay",
                solution=steps(
                    f"The base is ${base} = 1 + r$ where $r$ is the growth rate",
                    f"$1 + r = {base}$",
                    f"$r = {base} - 1 = {rate/100}$",
                    f"As a percentage: ${rate}\\%$"
                )
            )
        else:
            # Decay
            base = 1 - rate/100
            ans = rate
            
            return problem(
                question=f"The function $y = {P}({base})^t$ models exponential decay. What is the decay rate as a percentage?",
                answer=ans,
                difficulty=(1100, 1250),
                topic="algebra2/exponential_growth_decay",
                solution=steps(
                    f"The base is ${base} = 1 - r$ where $r$ is the decay rate",
                    f"$1 - r = {base}$",
                    f"$r = 1 - {base} = {rate/100}$",
                    f"As a percentage: ${rate}\\%$"
                )
            )

emit(generate())