// Animated Glow/Bloom shader for Ghostty terminal targeting #81A1C1 color text
// Adapted from bloom shader to create an occasional sweeping shine effect on the specified color.
// Original source: https://gist.github.com/qwerasd205/c3da6c610c8ffe17d6d2d3cc7068f17f
// Credits: https://github.com/qwerasd205
// This shader samples nearby pixels using a golden spiral pattern and adds a saturated bloom
// only for pixels matching the target color #81A1C1 (with some tolerance).
// The glow is modulated by a moving "shine" wave that sweeps horizontally across the screen
// every ~2 seconds, creating an occasional highlight effect on the text.

// Golden spiral samples, [x, y, weight] where weight is inverse of distance.
vec3 samples[24] = vec3[](
  vec3(0.1693761725038636, 0.9855514761735895, 1),
  vec3(-1.333070830962943, 0.4721463328627773, 0.7071067811865475),
  vec3(-0.8464394909806497, -1.51113870578065, 0.5773502691896258),
  vec3(1.554155680728463, -1.2588090085709776, 0.5),
  vec3(1.681364377589461, 1.4741145918052656, 0.4472135954999579),
  vec3(-1.2795157692199817, 2.088741103228784, 0.4082482904638631),
  vec3(-2.4575847530631187, -0.9799373355024756, 0.3779644730092272),
  vec3(0.5874641440200847, -2.7667464429345077, 0.35355339059327373),
  vec3(2.997715703369726, 0.11704939884745152, 0.3333333333333333),
  vec3(0.41360842451688395, 3.1351121305574803, 0.31622776601683794),
  vec3(-3.167149933769243, 0.9844599011770256, 0.30151134457776363),
  vec3(-1.5736713846521535, -3.0860263079123245, 0.2886751345948129),
  vec3(2.888202648340422, -2.1583061557896213, 0.2773500981126146),
  vec3(2.7150778983300325, 2.5745586041105715, 0.2672612419124244),
  vec3(-2.1504069972377464, 3.2211410627650165, 0.2581988897471611),
  vec3(-3.6548858794907493, -1.6253643308191343, 0.25),
  vec3(1.0130775986052671, -3.9967078676335834, 0.24253562503633297),
  vec3(4.229723673607257, 0.33081361055181563, 0.23570226039551587),
  vec3(0.40107790291173834, 4.340407413572593, 0.22941573387056174),
  vec3(-4.319124570236028, 1.159811599693438, 0.22360679774997896),
  vec3(-1.9209044802827355, -4.160543952132907, 0.2182178902359924),
  vec3(3.8639122286635708, -2.6589814382925123, 0.21320071635561041),
  vec3(3.3486228404946234, 3.4331800232609, 0.20851441405707477),
  vec3(-2.8769733643574344, 3.9652268864187157, 0.20412414523193154)
);

float lum(vec4 c) {
  return 0.299 * c.r + 0.587 * c.g + 0.114 * c.b;
}

vec3 adjustSaturation(vec3 color, float saturation) {
  float luminance = dot(color, vec3(0.299, 0.587, 0.114));
  return mix(vec3(luminance), color, saturation);
}

bool isTargetColor(vec3 rgb) {
vec3 targetColor = vec3(193.0/255.0, 201.0/255.0, 247.0/255.0); // #c1c9f7
 
  float threshold = 0.25; // Adjustable threshold for color similarity (Euclidean distance in RGB space)
 
  float dist = length(rgb - targetColor);
 
  return (dist < threshold);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;
  vec4 color = texture(iChannel0, uv);
  vec2 step = vec2(1.414) / iResolution.xy;
  
  float saturationBoost = 1.5; // Vibrant shine
  float glowIntensity = 0.1; // Intensity for shine moments
  
  // Animated sweep: A moving sine wave creates a shine that sweeps left-to-right every ~2 seconds
  // Adjust 'sweepSpeed' to change frequency (lower = less often), 'waveFreq' for shine width
  float sweepSpeed = 0.9; // Sweeps every 2π / speed ≈ 2 seconds per full cycle
  float waveFreq = 20.0; // Higher = narrower shine
  float t = iTime * sweepSpeed;
  float shine = sin(t + uv.x * waveFreq);
  shine = smoothstep(0.0, 1.0, (shine + 1.0) / 2.0); // Convert to 0-1 ramp
  shine *= 0.8; // Scale down to keep it subtle even at peak
  
  for (int i = 0; i < 24; i++) {
    vec3 s = samples[i];
    vec4 c = texture(iChannel0, uv + s.xy * step);
    float l = lum(c);
    if (isTargetColor(c.rgb) && l > 0.3) { // Original luminance threshold
      vec3 saturatedBloom = adjustSaturation(c.rgb, saturationBoost);
      // Modulate glow by the shine factor: zero most of the time, peaks during sweep
      color += l * s.z * vec4(saturatedBloom, 1.0) * glowIntensity * shine;
    }
  }
  fragColor = color;
}
