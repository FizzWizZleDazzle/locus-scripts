"""
calculus - optimization (medium)
Generated: 2026-02-22T05:09:02.906431
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Box optimization - maximize volume with constraint
        side_length = randint(6, 12)
        cut_size = symbols('h', positive=True, real=True)
        
        # Volume as a function of cut size
        volume = cut_size * (side_length - 2*cut_size)**2
        
        # Find derivative
        dV = diff(volume, cut_size)
        
        # Solve for critical points
        critical_points = solve(dV, cut_size)
        valid_critical = [cp for cp in critical_points if cp > 0 and cp < side_length/2]
        
        if valid_critical:
            ans = float(valid_critical[0])
        else:
            ans = float(side_length/6)
        
        return problem(
            question=f"A square piece of cardboard with side length ${side_length}$ inches has squares of side length $h$ cut from each corner. The sides are then folded up to form an open box. What value of $h$ maximizes the volume of the box?",
            answer=ans,
            difficulty=(1400, 1600),
            topic="calculus/optimization",
            solution=steps(
                f"Volume $V(h) = h({side_length} - 2h)^2$",
                f"Expand: $V(h) = h({side_length**2} - {4*side_length}h + 4h^2) = {latex(expand(volume))}$",
                f"Find derivative: $V'(h) = {latex(expand(dV))}$",
                f"Set $V'(h) = 0$ and solve: $h = {ans:.3f}$ inches",
                f"Check endpoints: $h=0$ gives $V=0$, $h={side_length/2}$ gives $V=0$, so $h={ans:.3f}$ is a maximum"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Rectangle with fixed perimeter - maximize area
        perimeter = randint(40, 100)
        
        # If perimeter is P, width = w, length = P/2 - w
        # Area A(w) = w(P/2 - w)
        w = symbols('w', positive=True, real=True)
        area = w * (perimeter/2 - w)
        dA = diff(area, w)
        
        ans = float(perimeter / 4)
        
        return problem(
            question=f"A rectangle has a perimeter of ${perimeter}$ meters. What dimensions maximize the area?",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/optimization",
            solution=steps(
                f"Let width $= w$, then length $= {perimeter/2} - w$",
                f"Area $A(w) = w({perimeter/2} - w) = {perimeter/2}w - w^2$",
                f"Find derivative: $A'(w) = {perimeter/2} - 2w$",
                f"Set $A'(w) = 0$: ${perimeter/2} - 2w = 0 \\Rightarrow w = {ans}$",
                f"The dimensions are ${ans}$ m by ${ans}$ m (a square)"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Minimize surface area of cylinder with fixed volume
        volume_val = choice([100, 200, 500, 1000])
        
        r = symbols('r', positive=True, real=True)
        # V = πr²h, so h = V/(πr²)
        # Surface area S = 2πr² + 2πrh = 2πr² + 2πr(V/(πr²)) = 2πr² + 2V/r
        surface = 2*pi*r**2 + 2*volume_val/r
        dS = diff(surface, r)
        
        critical = solve(dS, r)
        ans = float(critical[0])
        
        return problem(
            question=f"A cylindrical can must hold ${volume_val}$ cm³. What radius minimizes the surface area?",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/optimization",
            solution=steps(
                f"Volume: $V = \\pi r^2 h = {volume_val}$, so $h = \\frac{{{volume_val}}}{{\\pi r^2}}$",
                f"Surface area: $S = 2\\pi r^2 + 2\\pi r h = 2\\pi r^2 + 2\\pi r \\cdot \\frac{{{volume_val}}}{{\\pi r^2}}$",
                f"Simplify: $S(r) = 2\\pi r^2 + \\frac{{{2*volume_val}}}{{r}}$",
                f"Find derivative: $S'(r) = 4\\pi r - \\frac{{{2*volume_val}}}{{r^2}}$",
                f"Set $S'(r) = 0$: $4\\pi r = \\frac{{{2*volume_val}}}{{r^2}} \\Rightarrow r^3 = \\frac{{{volume_val}}}{{2\\pi}}$",
                f"$r = {ans:.3f}$ cm"
            ),
            calculator="scientific"
        )
    
    else:
        # Product of two numbers with fixed sum - maximize product
        sum_val = randint(20, 50)
        
        # If x + y = S, then y = S - x
        # Product P = x(S - x) = Sx - x²
        prod = x * (sum_val - x)
        dP = diff(prod, x)
        
        ans = float(sum_val / 2)
        
        return problem(
            question=f"Two positive numbers sum to ${sum_val}$. What is the maximum possible product of these two numbers?",
            answer=float((sum_val/2) * (sum_val/2)),
            difficulty=(1300, 1400),
            topic="calculus/optimization",
            solution=steps(
                f"Let the numbers be $x$ and ${sum_val} - x$",
                f"Product $P(x) = x({sum_val} - x) = {sum_val}x - x^2$",
                f"Find derivative: $P'(x) = {sum_val} - 2x$",
                f"Set $P'(x) = 0$: ${sum_val} - 2x = 0 \\Rightarrow x = {ans}$",
                f"The two numbers are both ${ans}$",
                f"Maximum product $= {ans} \\times {ans} = {float(ans*ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())