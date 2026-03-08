#= WaveDiagram — sinusoidal wave visualization for physics =#

"""
Sine wave diagram with labeled amplitude and wavelength.

    wd = WaveDiagram(; amplitude=2.0, wavelength=4.0, n_cycles=2)
    label_amplitude!(wd)
    label_wavelength!(wd)
    svg = render(wd)
"""
mutable struct WaveDiagram
    _amplitude::Float64
    _wavelength::Float64
    _n_cycles::Int
    _width::Int
    _height::Int
    _padding::Int
    _show_amplitude::Bool
    _show_wavelength::Bool
    _second_wave::Union{Nothing,Tuple{Float64,Float64,Float64}}  # (amplitude, wavelength, phase_deg)

    function WaveDiagram(; amplitude::Real=2.0, wavelength::Real=4.0, n_cycles::Int=2,
                          width::Int=320, height::Int=180, padding::Int=30)
        new(Float64(amplitude), Float64(wavelength), n_cycles, width, height, padding,
            false, false, nothing)
    end
end

"""Show amplitude label with arrow."""
label_amplitude!(wd::WaveDiagram) = (wd._show_amplitude = true)

"""Show wavelength label with arrow."""
label_wavelength!(wd::WaveDiagram) = (wd._show_wavelength = true)

"""Add a second wave for superposition or comparison."""
function add_second_wave!(wd::WaveDiagram; amplitude::Real=1.0, wavelength::Real=4.0, phase_deg::Real=0)
    wd._second_wave = (Float64(amplitude), Float64(wavelength), Float64(phase_deg))
end

function render(wd::WaveDiagram)
    parts = String[]
    pad = wd._padding
    w, h = wd._width, wd._height
    inner_w = w - 2 * pad
    inner_h = h - 2 * pad

    A = wd._amplitude
    λ = wd._wavelength
    total_x = λ * wd._n_cycles
    y_max = A * 1.3
    second_A = wd._second_wave !== nothing ? wd._second_wave[1] : 0.0
    y_max = max(y_max, second_A * 1.3)

    to_sx(x) = round(pad + x / total_x * inner_w; digits=1)
    to_sy(y) = round(pad + (y_max - y) / (2 * y_max) * inner_h; digits=1)

    # Equilibrium line (dashed)
    eq_y = to_sy(0)
    push!(parts, """<line x1="$(pad)" y1="$(eq_y)" x2="$(pad + inner_w)" y2="$(eq_y)" stroke="currentColor" stroke-width="1" stroke-dasharray="4,3" stroke-opacity="0.4"/>""")

    # Primary wave
    n_pts = 200
    pts1 = String[]
    for i in 0:n_pts
        x = total_x * i / n_pts
        y = A * sin(2π * x / λ)
        push!(pts1, "$(to_sx(x)),$(to_sy(y))")
    end
    push!(parts, """<polyline points="$(join(pts1, " "))" fill="none" stroke="#3b82f6" stroke-width="2"/>""")

    # Second wave (if any)
    if wd._second_wave !== nothing
        A2, λ2, phase = wd._second_wave
        pts2 = String[]
        for i in 0:n_pts
            x = total_x * i / n_pts
            y = A2 * sin(2π * x / λ2 + phase * π / 180)
            push!(pts2, "$(to_sx(x)),$(to_sy(y))")
        end
        push!(parts, """<polyline points="$(join(pts2, " "))" fill="none" stroke="#ef4444" stroke-width="2" stroke-dasharray="6,3"/>""")
    end

    # Arrow marker
    push!(parts, """<defs><marker id="wd-ah" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="currentColor"/></marker><marker id="wd-ab" markerWidth="8" markerHeight="6" refX="0" refY="3" orient="auto"><polygon points="8 0,0 3,8 6" fill="currentColor"/></marker></defs>""")

    # Amplitude label
    if wd._show_amplitude
        # Arrow from equilibrium to peak at x = λ/4
        ax = to_sx(λ / 4)
        push!(parts, """<line x1="$(ax)" y1="$(eq_y)" x2="$(ax)" y2="$(to_sy(A))" stroke="currentColor" stroke-width="1.5" marker-end="url(#wd-ah)" marker-start="url(#wd-ab)"/>""")
        push!(parts, """<text x="$(round(ax + 8; digits=1))" y="$(to_sy(A / 2))" font-size="11" fill="currentColor" font-style="italic">A</text>""")
    end

    # Wavelength label
    if wd._show_wavelength
        # Arrow between two consecutive peaks
        lx1 = to_sx(λ / 4)
        lx2 = to_sx(λ + λ / 4)
        ly = to_sy(A) - 12
        push!(parts, """<line x1="$(lx1)" y1="$(round(ly; digits=1))" x2="$(lx2)" y2="$(round(ly; digits=1))" stroke="currentColor" stroke-width="1.5" marker-end="url(#wd-ah)" marker-start="url(#wd-ab)"/>""")
        push!(parts, """<text x="$(to_sx(λ * 3/4))" y="$(round(ly - 6; digits=1))" font-size="11" fill="currentColor" text-anchor="middle" font-style="italic">λ</text>""")
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
