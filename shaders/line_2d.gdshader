shader_type canvas_item;

uniform vec4 laser_color : source_color = vec4(1.0, 0.1, 0.1, 1.0);
uniform float flicker_speed = 5.0;
uniform float flicker_strength = 2.0;
uniform float wave_strength = 0.1;
uniform float core_power = 1;

void fragment() {
    float time = TIME * flicker_speed * -1.0;

    float wave = sin(UV.x * 40.0 + time) * wave_strength;

    float flicker = 1.0 + sin(time * 2.0 + UV.x * 10.0) * flicker_strength;

    float center_dist = abs(UV.y - 0.5) * 2.0;
    float core = pow(1.0 - center_dist, core_power);

    float intensity = core * flicker + wave;

    COLOR = laser_color * intensity;
}
