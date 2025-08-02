shader_type canvas_item;

uniform float offset_multiplier: hint_range(0.0, 1.0, 0.001);
uniform sampler2D offset: repeat_enable;
uniform sampler2D fade;
uniform sampler2D color;
uniform sampler2D bobble;
uniform float time = 0.4;

uniform int pixels: hint_range(0, 128, 1) = 16;

void vertex() {
}

float f(float x) {
    return sqrt(0.1 * x * x * pow(E, -2.6 * (x - 1.9)));
}

void fragment() {

    vec2 uv = vec2(ivec2(UV * 128.) / (128 / pixels)) / (128. / float(128 / pixels));
    uv = uv + (texture(offset, uv + vec2(time)).xx -0.5) * offset_multiplier;



	float noise = texture(fade, vec2(uv.x, 1. - uv.y)).x;

    vec2 from_center = (uv - vec2(0.5, 0.5)) * 2.;

    float edge_penalty = mix(
        max(from_center.x * from_center.x, from_center.y * from_center.y),
        from_center.x * from_center.x + from_center.y * from_center.y,
        0.3
    );

    if (noise + edge_penalty > f(time * 2.)) {
        COLOR = vec4(0.);
    } else {
        float b = texture(bobble, uv).x;

        float t = mix(1. - (noise + edge_penalty), b, 0.4);
        float p = 1. - mix(time, edge_penalty, 0.5);
        t /= 2. * time + 0.5;
        COLOR = vec4(texture(color, vec2(t)).xyz, (1. - edge_penalty) / time / 2.);
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
