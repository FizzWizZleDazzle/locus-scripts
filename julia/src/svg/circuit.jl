#= CircuitDiagram — schematic circuit diagrams for physics =#

"""
Simple circuit diagram with battery, resistors, and capacitors.

    cd = CircuitDiagram(; width=300, height=200)
    add_battery!(cd, 12; label="12V")
    add_resistor!(cd, 100; label="R₁ = 100Ω")
    add_resistor!(cd, 200; label="R₂ = 200Ω")
    set_topology!(cd, :series)
    svg = render(cd)
"""
mutable struct CircuitDiagram
    _width::Int
    _height::Int
    _battery::Union{Nothing,Tuple{Float64,String}}      # (voltage, label)
    _resistors::Vector{Tuple{Float64,String}}            # (ohms, label)
    _capacitors::Vector{Tuple{Float64,String}}           # (farads, label)
    _topology::Symbol                                     # :series, :parallel, :combo

    function CircuitDiagram(; width::Int=300, height::Int=200)
        new(width, height, nothing, Tuple{Float64,String}[], Tuple{Float64,String}[], :series)
    end
end

"""Add battery with voltage and optional label."""
function add_battery!(cd::CircuitDiagram, voltage; label::String="")
    cd._battery = (Float64(voltage), label)
end

"""Add a resistor with resistance and optional label."""
function add_resistor!(cd::CircuitDiagram, ohms; label::String="")
    push!(cd._resistors, (Float64(ohms), label))
end

"""Add a capacitor with capacitance and optional label."""
function add_capacitor!(cd::CircuitDiagram, farads; label::String="")
    push!(cd._capacitors, (Float64(farads), label))
end

"""Set circuit topology: :series, :parallel, or :combo."""
function set_topology!(cd::CircuitDiagram, topology::Symbol)
    topology in (:series, :parallel, :combo) || error("topology must be :series, :parallel, or :combo")
    cd._topology = topology
end

# Internal: draw a zigzag resistor symbol centered at (cx, cy), horizontal
function _draw_resistor(cx, cy, label; seg_w=50)
    parts = String[]
    hw = seg_w / 2
    peak_h = 9
    # Standard resistor zigzag: lead-in, 6 zigzag segments, lead-out
    n_zigs = 6
    zig_w = seg_w / (n_zigs + 2)  # leave space for lead-in/out
    pts = String[]
    # Lead-in
    push!(pts, "$(round(cx - hw; digits=1)),$(round(cy; digits=1))")
    x_start = cx - hw + zig_w
    push!(pts, "$(round(x_start; digits=1)),$(round(cy; digits=1))")
    # Zigzag peaks
    for i in 1:n_zigs
        px = x_start + (i - 0.5) * zig_w
        py = cy + (isodd(i) ? -peak_h : peak_h)
        push!(pts, "$(round(px; digits=1)),$(round(py; digits=1))")
    end
    # Lead-out
    x_end = cx + hw - zig_w
    push!(pts, "$(round(x_end; digits=1)),$(round(cy; digits=1))")
    push!(pts, "$(round(cx + hw; digits=1)),$(round(cy; digits=1))")
    push!(parts, """<polyline points="$(join(pts, " "))" fill="none" stroke="currentColor" stroke-width="1.5"/>""")
    if !isempty(label)
        push!(parts, """<text x="$(round(cx; digits=1))" y="$(round(cy - peak_h - 6; digits=1))" font-size="10" fill="currentColor" text-anchor="middle">$(label)</text>""")
    end
    return join(parts)
end

# Internal: draw a capacitor symbol centered at (cx, cy), horizontal
function _draw_capacitor(cx, cy, label; gap=6, plate_h=14)
    parts = String[]
    push!(parts, """<line x1="$(round(cx - gap/2; digits=1))" y1="$(round(cy - plate_h/2; digits=1))" x2="$(round(cx - gap/2; digits=1))" y2="$(round(cy + plate_h/2; digits=1))" stroke="currentColor" stroke-width="2"/>""")
    push!(parts, """<line x1="$(round(cx + gap/2; digits=1))" y1="$(round(cy - plate_h/2; digits=1))" x2="$(round(cx + gap/2; digits=1))" y2="$(round(cy + plate_h/2; digits=1))" stroke="currentColor" stroke-width="2"/>""")
    if !isempty(label)
        push!(parts, """<text x="$(round(cx; digits=1))" y="$(round(cy - plate_h/2 - 6; digits=1))" font-size="10" fill="currentColor" text-anchor="middle">$(label)</text>""")
    end
    return join(parts)
end

# Battery plate half-gap (connection points are cy ± _BATT_HG)
const _BATT_HG = 5

# Internal: draw battery symbol at (cx, cy) with horizontal plates
# Wires connect at (cx, cy - _BATT_HG) top and (cx, cy + _BATT_HG) bottom
# signs_side: :right (for vertical wires) or :left (for horizontal wires)
function _draw_battery(cx, cy, label; signs_side::Symbol=:right)
    parts = String[]
    long_hw = 12.0   # positive plate half-width (long, thin)
    short_hw = 7.0   # negative plate half-width (short, thick)
    top_y = cy - _BATT_HG  # positive terminal
    bot_y = cy + _BATT_HG  # negative terminal
    # Positive plate (long, thin) — top
    push!(parts, """<line x1="$(round(cx - long_hw; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(cx + long_hw; digits=1))" y2="$(round(top_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
    # Negative plate (short, thick) — bottom
    push!(parts, """<line x1="$(round(cx - short_hw; digits=1))" y1="$(round(bot_y; digits=1))" x2="$(round(cx + short_hw; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="3"/>""")
    # + and - signs (placed away from wire direction)
    if signs_side == :right
        push!(parts, """<text x="$(round(cx + long_hw + 4; digits=1))" y="$(round(top_y + 4; digits=1))" font-size="10" fill="currentColor">+</text>""")
        push!(parts, """<text x="$(round(cx + short_hw + 4; digits=1))" y="$(round(bot_y + 4; digits=1))" font-size="10" fill="currentColor">−</text>""")
    else
        push!(parts, """<text x="$(round(cx - long_hw - 4; digits=1))" y="$(round(top_y + 4; digits=1))" font-size="10" fill="currentColor" text-anchor="end">+</text>""")
        push!(parts, """<text x="$(round(cx - short_hw - 4; digits=1))" y="$(round(bot_y + 4; digits=1))" font-size="10" fill="currentColor" text-anchor="end">−</text>""")
    end
    if !isempty(label)
        if signs_side == :left
            # Parallel: label below battery
            push!(parts, """<text x="$(round(cx; digits=1))" y="$(round(cy + _BATT_HG + 16; digits=1))" font-size="10" fill="currentColor" text-anchor="middle">$(label)</text>""")
        else
            # Series/combo: label to the left of battery
            push!(parts, """<text x="$(round(cx - long_hw - 6; digits=1))" y="$(round(cy + 4; digits=1))" font-size="10" fill="currentColor" text-anchor="end">$(label)</text>""")
        end
    end
    return join(parts)
end

function render(cd::CircuitDiagram)
    parts = String[]
    w, h = cd._width, cd._height
    pad = 30

    components = Tuple{Symbol,Float64,String}[]
    for (v, l) in cd._resistors
        push!(components, (:resistor, v, l))
    end
    for (v, l) in cd._capacitors
        push!(components, (:capacitor, v, l))
    end
    n_comp = length(components)

    if cd._topology == :series
        # Battery on left, components along top wire
        bx = pad + 10
        by = h / 2
        # Wire loop: top from battery to right, down, back along bottom
        top_y = pad + 20
        bot_y = h - pad - 10
        right_x = w - pad

        # Battery
        push!(parts, _draw_battery(bx, by, cd._battery !== nothing ? cd._battery[2] : ""))
        # Wires: left vertical up/down from battery terminals
        push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(by - _BATT_HG; digits=1))" x2="$(round(bx; digits=1))" y2="$(round(top_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
        push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(by + _BATT_HG; digits=1))" x2="$(round(bx; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")

        # Top wire
        push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(right_x; digits=1))" y2="$(round(top_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
        # Bottom wire
        push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(bot_y; digits=1))" x2="$(round(right_x; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
        # Right wire
        push!(parts, """<line x1="$(round(right_x; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(right_x; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")

        # Place components along top wire
        if n_comp > 0
            seg = (right_x - bx - 20) / n_comp
            for (i, (typ, _, lbl)) in enumerate(components)
                cx = bx + 20 + (i - 0.5) * seg
                if typ == :resistor
                    push!(parts, _draw_resistor(cx, top_y, lbl))
                else
                    push!(parts, _draw_capacitor(cx, top_y, lbl))
                end
            end
        end

    elseif cd._topology == :parallel
        # Battery on left, components as parallel branches
        bx = pad + 10
        by = h / 2

        push!(parts, _draw_battery(bx, by, cd._battery !== nothing ? cd._battery[2] : ""; signs_side=:left))

        left_x = bx + 55
        right_x = w - pad - 20
        mid_x = (left_x + right_x) / 2

        if n_comp > 0
            spacing = (h - 2 * pad) / (n_comp + 1)
            # Left and right bus lines
            top_bus = pad + spacing / 2
            bot_bus = h - pad - spacing / 2
            push!(parts, """<line x1="$(round(left_x; digits=1))" y1="$(round(top_bus; digits=1))" x2="$(round(left_x; digits=1))" y2="$(round(bot_bus; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
            push!(parts, """<line x1="$(round(right_x; digits=1))" y1="$(round(top_bus; digits=1))" x2="$(round(right_x; digits=1))" y2="$(round(bot_bus; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")

            # Connect battery to left bus with horizontal wires
            push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(by - _BATT_HG; digits=1))" x2="$(round(left_x; digits=1))" y2="$(round(by - _BATT_HG; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
            push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(by + _BATT_HG; digits=1))" x2="$(round(left_x; digits=1))" y2="$(round(by + _BATT_HG; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")

            for (i, (typ, _, lbl)) in enumerate(components)
                branch_y = pad + i * spacing
                # Horizontal wires to component
                push!(parts, """<line x1="$(round(left_x; digits=1))" y1="$(round(branch_y; digits=1))" x2="$(round(mid_x - 28; digits=1))" y2="$(round(branch_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
                push!(parts, """<line x1="$(round(mid_x + 28; digits=1))" y1="$(round(branch_y; digits=1))" x2="$(round(right_x; digits=1))" y2="$(round(branch_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
                if typ == :resistor
                    push!(parts, _draw_resistor(mid_x, branch_y, lbl))
                else
                    push!(parts, _draw_capacitor(mid_x, branch_y, lbl))
                end
            end
        end

    else  # :combo — first resistor in series, rest in parallel
        bx = pad + 10
        by = h / 2
        push!(parts, _draw_battery(bx, by, cd._battery !== nothing ? cd._battery[2] : ""))

        top_y = pad + 15
        bot_y = h - pad - 10
        # Series component on top
        if n_comp >= 1
            (typ1, _, lbl1) = components[1]
            series_cx = bx + 70
            push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(by - _BATT_HG; digits=1))" x2="$(round(bx; digits=1))" y2="$(round(top_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
            push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(series_cx - 28; digits=1))" y2="$(round(top_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
            if typ1 == :resistor
                push!(parts, _draw_resistor(series_cx, top_y, lbl1))
            else
                push!(parts, _draw_capacitor(series_cx, top_y, lbl1))
            end
            # Continue to parallel section
            par_left = series_cx + 30
            par_right = w - pad - 10
            push!(parts, """<line x1="$(round(series_cx + 28; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(par_left; digits=1))" y2="$(round(top_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")

            par_comps = components[2:end]
            if !isempty(par_comps)
                spacing = (bot_y - top_y) / (length(par_comps) + 1)
                push!(parts, """<line x1="$(round(par_left; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(par_left; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
                push!(parts, """<line x1="$(round(par_right; digits=1))" y1="$(round(top_y; digits=1))" x2="$(round(par_right; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
                mid_x = (par_left + par_right) / 2
                for (j, (typ, _, lbl)) in enumerate(par_comps)
                    branch_y = top_y + j * spacing
                    push!(parts, """<line x1="$(round(par_left; digits=1))" y1="$(round(branch_y; digits=1))" x2="$(round(mid_x - 28; digits=1))" y2="$(round(branch_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
                    push!(parts, """<line x1="$(round(mid_x + 28; digits=1))" y1="$(round(branch_y; digits=1))" x2="$(round(par_right; digits=1))" y2="$(round(branch_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
                    if typ == :resistor
                        push!(parts, _draw_resistor(mid_x, branch_y, lbl))
                    else
                        push!(parts, _draw_capacitor(mid_x, branch_y, lbl))
                    end
                end
            end
            # Bottom wire back
            push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(by + _BATT_HG; digits=1))" x2="$(round(bx; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
            push!(parts, """<line x1="$(round(bx; digits=1))" y1="$(round(bot_y; digits=1))" x2="$(round(par_right; digits=1))" y2="$(round(bot_y; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
        end
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
