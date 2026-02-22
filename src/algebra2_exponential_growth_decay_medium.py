"""
algebra2 - exponential_growth_decay (medium)
Generated: 2026-02-22T04:28:31.548601
"""

from problem_utils import *

def generate():
    problem_type = choice(['standard_growth', 'standard_decay', 'half_life', 'doubling_time', 'compound_interest', 'bacteria_growth'])
    
    if problem_type == 'standard_growth':
        # y = a * b^t where b > 1
        initial = choice([100, 200, 500, 1000, 1500, 2000])
        growth_rate = choice([1.05, 1.1, 1.15, 1.2, 1.25, 1.5, 2])
        time = randint(3, 8)
        
        ans = initial * (growth_rate ** time)
        ans = round(float(ans), 2)
        
        return problem(
            question=f"A population starts at {initial} and grows by a factor of {growth_rate} each year. What is the population after {time} years? Round to two decimal places.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the exponential growth formula: $y = a \\cdot b^t$",
                f"Initial amount $a = {initial}$, growth factor $b = {growth_rate}$, time $t = {time}$",
                f"$y = {initial} \\cdot {growth_rate}^{{{time}}}$",
                f"$y = {initial} \\cdot {round(growth_rate**time, 4)}$",
                f"$y = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'standard_decay':
        # y = a * b^t where 0 < b < 1
        initial = choice([1000, 2000, 5000, 10000])
        decay_rate = choice([0.5, 0.6, 0.7, 0.75, 0.8, 0.85, 0.9])
        time = randint(4, 10)
        
        ans = initial * (decay_rate ** time)
        ans = round(float(ans), 2)
        
        return problem(
            question=f"A substance has an initial mass of {initial} grams and decays by a factor of {decay_rate} each hour. What is the mass after {time} hours? Round to two decimal places.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use the exponential decay formula: $y = a \\cdot b^t$",
                f"Initial amount $a = {initial}$, decay factor $b = {decay_rate}$, time $t = {time}$",
                f"$y = {initial} \\cdot {decay_rate}^{{{time}}}$",
                f"$y = {initial} \\cdot {round(decay_rate**time, 6)}$",
                f"$y = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'half_life':
        # Find amount remaining after several half-lives
        initial = choice([800, 1600, 3200, 6400])
        half_life = choice([2, 3, 4, 5])
        time = half_life * randint(2, 4)
        
        num_half_lives = time // half_life
        ans = initial * (0.5 ** num_half_lives)
        
        return problem(
            question=f"A radioactive substance has a half-life of {half_life} years. If you start with {initial} grams, how many grams remain after {time} years?",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Number of half-lives = $\\frac{{{time}}}{{{half_life}}} = {num_half_lives}$",
                f"After each half-life, half of the substance remains",
                f"Amount remaining = ${initial} \\cdot \\left(\\frac{{1}}{{2}}\\right)^{{{num_half_lives}}}$",
                f"Amount remaining = ${initial} \\cdot {0.5**num_half_lives}$",
                f"Amount remaining = ${ans}$ grams"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'doubling_time':
        # Find amount after several doubling periods
        initial = choice([50, 100, 200, 400])
        doubling_time = choice([2, 3, 4, 6])
        time = doubling_time * randint(2, 4)
        
        num_doublings = time // doubling_time
        ans = initial * (2 ** num_doublings)
        
        return problem(
            question=f"A bacteria culture doubles every {doubling_time} hours. If it starts with {initial} bacteria, how many bacteria are there after {time} hours?",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Number of doubling periods = $\\frac{{{time}}}{{{doubling_time}}} = {num_doublings}$",
                f"After each doubling period, the population doubles",
                f"Population = ${initial} \\cdot 2^{{{num_doublings}}}$",
                f"Population = ${initial} \\cdot {2**num_doublings}$",
                f"Population = ${ans}$ bacteria"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'compound_interest':
        # A = P(1 + r)^t
        principal = choice([1000, 2000, 5000, 10000])
        rate_percent = choice([3, 4, 5, 6, 8])
        rate = rate_percent / 100
        time = randint(5, 15)
        
        ans = principal * ((1 + rate) ** time)
        ans = round(float(ans), 2)
        
        return problem(
            question=f"An investment of $\\${principal}$ earns ${rate_percent}\\%$ interest compounded annually. What is the value of the investment after ${time}$ years? Round to two decimal places.",
            answer=ans,
            difficulty=(1400, 1600),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Use compound interest formula: $A = P(1 + r)^t$",
                f"Principal $P = {principal}$, rate $r = {rate}$, time $t = {time}$",
                f"$A = {principal}(1 + {rate})^{{{time}}}$",
                f"$A = {principal} \\cdot {1 + rate}^{{{time}}}$",
                f"$A = {principal} \\cdot {round((1 + rate)**time, 6)}$",
                f"$A = \\${ans}$"
            ),
            calculator="scientific"
        )
    
    else:  # bacteria_growth with percentage
        initial = choice([100, 250, 500, 1000])
        growth_percent = choice([15, 20, 25, 30, 40, 50])
        growth_rate = 1 + (growth_percent / 100)
        time = randint(3, 6)
        
        ans = initial * (growth_rate ** time)
        ans = round(float(ans), 2)
        
        return problem(
            question=f"A bacteria population starts at {initial} and increases by ${growth_percent}\\%$ each day. What is the population after {time} days? Round to two decimal places.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra2/exponential_growth_decay",
            solution=steps(
                f"Growth rate as decimal: ${growth_percent}\\% = {growth_percent/100}$",
                f"Growth factor: $1 + {growth_percent/100} = {growth_rate}$",
                f"Use formula: $y = {initial} \\cdot {growth_rate}^t$",
                f"$y = {initial} \\cdot {growth_rate}^{{{time}}}$",
                f"$y = {initial} \\cdot {round(growth_rate**time, 6)}$",
                f"$y = {ans}$"
            ),
            calculator="scientific"
        )

emit(generate())