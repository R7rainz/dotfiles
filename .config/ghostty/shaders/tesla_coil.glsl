float ease(float x) {
    return pow(1.0 - x, 10.0);
}

float sdBox(in vec2 p, in vec2 xy, in vec2 b) {
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b) {
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);
    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);
    return s * sqrt(d);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float blend(float t) {
    float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalize(vec2(2., 2.), 0.).x, distance);
}

float determineStartVertexFactor(vec2 a, vec2 b) {
    float condition1 = step(b.x, a.x) * step(a.y, b.y);
    float condition2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(condition1, condition2);
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

// Tesla coil effect functions
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    for (int i = 0; i < 4; i++) {
        value += amplitude * noise(p);
        p *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

// Function to create electric arc effect
float electricArc(vec2 p, vec2 a, vec2 b, float time, float progress) {
    vec2 dir = normalize(b - a);
    vec2 perp = vec2(-dir.y, dir.x);
    float dist = distance(a, b);
    
    // Base arc with noise for tesla coil effect
    float t = clamp(dot(p - a, dir) / dist, 0.0, 1.0);
    vec2 projected = a + dir * t * dist;
    vec2 offset = perp * (fbm(vec2(t * 10.0, time * 10.0)) - 0.5) * 0.1 * progress;
    
    // Main arc
    float d = length(p - (projected + offset));
    
    // Add branching effects
    float branch = 0.0;
    if (progress > 0.5) {
        float branchTime = time * 15.0;
        float branchFreq = 5.0;
        vec2 branchOffset = perp * (sin(t * branchFreq + branchTime) * 0.03 * progress);
        branch = length(p - (projected + branchOffset));
        d = min(d, branch);
    }
    
    return d;
}

const vec4 TRAIL_COLOR = vec4(129.0/255.0, 161.0/255.0, 193.0/255.0, 1.0); // #81A1C1
const vec4 CURRENT_CURSOR_COLOR = TRAIL_COLOR;
const vec4 PREVIOUS_CURSOR_COLOR = TRAIL_COLOR;
const vec4 TRAIL_COLOR_ACCENT = vec4(0.705, 0.831, 0.957, 1.0); // Brighter variant of #81A1C1
const vec4 ELECTRIC_COLOR = vec4(0.5, 0.8, 1.0, 1.0); // Electric blue color
const float DURATION = 2.2;
const float OPACITY = .001;
const float TAIL_EXTENSION = 1.5;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif
    
    // Normalization for fragCoord to a space of -1 to 1;
    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);
    
    // Normalization for cursor position and size;
    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));
    
    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    vec2 centerCP_new = centerCP + (centerCP - centerCC) * TAIL_EXTENSION;
    
    float progress = blend(clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1));
    float easedProgress = ease(progress);
    
    float lineLength = distance(centerCC, centerCP_new);
    float distanceToEnd = distance(vu.xy, centerCC);
    float alphaModifier = distanceToEnd / (lineLength * easedProgress);
    if (alphaModifier > 1.0) {
        alphaModifier = 1.0;
    }
    
    // Enhanced tapering with smoothstep for smoother opacity falloff towards tail end
    float trailOpacity = 1.0 - smoothstep(0.0, 1.0, alphaModifier);
    
    // Create electric arc effect
    float arcThickness = 0.005 + 0.003 * sin(iTime * 30.0); // Pulsating thickness
    float arc = electricArc(vu, centerCC, centerCP_new, iTime, easedProgress);
    float arcAlpha = 1.0 - smoothstep(arcThickness * 0.5, arcThickness, arc);
    
    // Add glow effect
    float glow = 1.0 - smoothstep(arcThickness, arcThickness * 2.0, arc);
    
    vec4 newColor = fragColor;
    
    // Apply electric arc with glow
    if (arcAlpha > 0.0) {
        vec4 arcColor = mix(ELECTRIC_COLOR, TRAIL_COLOR_ACCENT, 
                          0.5 + 0.5 * sin(iTime * 20.0)); // Pulsating color
        newColor = mix(newColor, arcColor, arcAlpha * trailOpacity);
        newColor = mix(newColor, ELECTRIC_COLOR * 0.5, glow * trailOpacity * 0.3);
    }
    
    // Draw cursor
    float sdfCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
    newColor = mix(newColor, CURRENT_CURSOR_COLOR, 1.0 - smoothstep(0.0, 0.01, sdfCursor));
    
    fragColor = newColor;
}
