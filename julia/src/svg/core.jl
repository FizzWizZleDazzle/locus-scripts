#= Shared SVG infrastructure: label collision, coordinate transforms, markers, palette =#

# ---------------------------------------------------------------------------
# Label collision avoidance helpers
# ---------------------------------------------------------------------------

struct _BBox
    x::Float64
    y::Float64
    w::Float64
    h::Float64
end

function _boxes_overlap(b1::_BBox, b2::_BBox)
    return b1.x < b2.x + b2.w && b1.x + b1.w > b2.x &&
           b1.y < b2.y + b2.h && b1.y + b1.h > b2.y
end

"""
Push label position outward until no overlap with placed labels.
Returns (final_x, final_y).
8 compass directions tried first, then outward nudge with 8 attempts.
"""
function _nudge_label(px, py, ox, oy, placed::Vector{_BBox};
                      font_w=7.0, font_h=14.0, text_len::Int=1)
    actual_w = font_w * max(text_len, 1)
    half_w = actual_w / 2.0

    # 8 compass offsets: N, NE, E, SE, S, SW, W, NW
    compass = [
        ( 0.0, -1.0),  # N
        ( 0.7, -0.7),  # NE
        ( 1.0,  0.0),  # E
        ( 0.7,  0.7),  # SE
        ( 0.0,  1.0),  # S
        (-0.7,  0.7),  # SW
        (-1.0,  0.0),  # W
        (-0.7, -0.7),  # NW
    ]
    base_dist = hypot(ox, oy)
    base_dist = max(base_dist, 12.0)

    # Sort compass directions by proximity to caller's intended direction
    if hypot(ox, oy) > 0
        ang = atan(oy, ox)
        sort!(compass; by=c -> let a = atan(c[2], c[1]); min(mod(a - ang, 2π), mod(ang - a, 2π)) end)
    end

    # Try 8 compass positions at base distance
    for (cx, cy) in compass
        lx = px + cx * base_dist
        ly = py + cy * base_dist
        bbox = _BBox(lx - half_w, ly - font_h, actual_w, font_h)
        if !any(b -> _boxes_overlap(bbox, b), placed)
            push!(placed, bbox)
            return round(lx; digits=1), round(ly; digits=1)
        end
    end

    # Fallback: outward nudge with 8 attempts, 1.3x factor
    for attempt in 1:8
        factor = 1.3 ^ attempt
        lx = px + ox * factor
        ly = py + oy * factor
        bbox = _BBox(lx - half_w, ly - font_h, actual_w, font_h)
        if !any(b -> _boxes_overlap(bbox, b), placed)
            push!(placed, bbox)
            return round(lx; digits=1), round(ly; digits=1)
        end
    end

    # Final fallback: use last attempt position
    factor = 1.3 ^ 8
    lx = round(px + ox * factor; digits=1)
    ly = round(py + oy * factor; digits=1)
    push!(placed, _BBox(lx - half_w, ly - font_h, actual_w, font_h))
    return lx, ly
end

# ---------------------------------------------------------------------------
# Centralized coordinate transform
# ---------------------------------------------------------------------------

struct _CoordTransform
    padding::Float64
    width::Float64
    height::Float64
    x_min::Float64
    x_max::Float64
    y_min::Float64
    y_max::Float64
end

function _apply(t::_CoordTransform, px, py)
    inner_w = t.width - 2 * t.padding
    inner_h = t.height - 2 * t.padding
    sx = inner_w / (t.x_max - t.x_min)
    sy = inner_h / (t.y_max - t.y_min)
    scale = min(sx, sy)
    svgx = t.padding + (px - t.x_min) * scale
    svgy = t.padding + (t.y_max - py) * scale
    return round(svgx; digits=1), round(svgy; digits=1)
end

function _apply_graph(t::_CoordTransform, px, py)
    inner_w = t.width - 2 * t.padding
    inner_h = t.height - 2 * t.padding
    sx = inner_w / (t.x_max - t.x_min)
    sy = inner_h / (t.y_max - t.y_min)
    svgx = t.padding + (px - t.x_min) * sx
    svgy = t.padding + (t.y_max - py) * sy
    return round(svgx; digits=1), round(svgy; digits=1)
end

function _apply_x(t::_CoordTransform, x)
    inner_w = t.width - 2 * t.padding
    return round(t.padding + (x - t.x_min) / (t.x_max - t.x_min) * inner_w; digits=1)
end

# ---------------------------------------------------------------------------
# Centralized marker definitions
# ---------------------------------------------------------------------------

const _MARKER_DEFS = Dict{Symbol,String}(
    :arrow_head => """<marker id="ah" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto"><polygon points="0 0,10 3.5,0 7" fill="currentColor"/></marker>""",
    :axis_fwd => """<marker id="ax" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="currentColor"/></marker>""",
    :axis_bwd => """<marker id="nlb" markerWidth="8" markerHeight="6" refX="0" refY="3" orient="auto"><polygon points="8 0,0 3,8 6" fill="currentColor"/></marker>""",
)

function _emit_markers(needed::Set{Symbol})
    isempty(needed) && return ""
    inner = join([_MARKER_DEFS[k] for k in needed if haskey(_MARKER_DEFS, k)])
    isempty(inner) && return ""
    return "<defs>$(inner)</defs>"
end

# ---------------------------------------------------------------------------
# Plot color palette
# ---------------------------------------------------------------------------

const _PLOT_COLORS = ["#3b82f6", "#ef4444", "#10b981", "#f59e0b", "#8b5cf6", "#ec4899"]
