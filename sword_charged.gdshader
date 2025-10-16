shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.1;
uniform float range: hint_range(0.0, 1.0) = 0.2;
uniform float blend_strength: hint_range(0.0, 1.0) = 1;

void fragment() {
    // Get the original texture color
    vec4 color = texture(TEXTURE, UV);
    
    // 1. Determine if the current pixel is white-ish
    // A simple test for whiteness: check if R, G, and B are all high.
    // dot(color.rgb, vec3(1.0)) / 3.0 gives an average of the color channels.
    // If it's close to 1.0, it's close to white.
    float brightness = (color.r + color.g + color.b) / 3.0;
    float is_white = step(0.7 - range, brightness); // 1.0 if brightness > (1.0 - range), 0.0 otherwise

    // 2. Determine the vertical blend factor
    // UV.y is 0.0 at the top, 1.0 at the bottom.
    // We want the blend to start at the bottom (1.0) and decrease towards the top (0.0).
    // The 'progress' uniform determines the vertical point where the full red color is reached.
    
    // blend_factor is 1.0 at UV.y = 1.0 (bottom) and 0.0 at UV.y = progress
    float vertical_blend = smoothstep(progress, 1.0, UV.y);
    
    // 3. Combine the factors and calculate the new color
    // The final blend amount is a mix of the vertical position and the whiteness test.
    float final_blend = vertical_blend * is_white * blend_strength;

    // Create a new red color with the original alpha
    vec4 red_color = vec4(130.0, 0.0, 0.0, color.a);
    
    // Mix the original color with the red color
    COLOR = mix(color, red_color, final_blend);
}