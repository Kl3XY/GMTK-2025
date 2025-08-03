shader_type canvas_item;

uniform sampler2D noise: repeat_enable;
uniform float strength: hint_range(0.0, 1.0, 0.01);

varying vec2 pos;

void vertex() {
    pos = (vec4(VERTEX.x, VERTEX.y, 1., 1.) * MODEL_MATRIX).xy;
}

void fragment() {
	vec2 uv = (vec2(ivec2((pos + vec2(4.0)) / 8.))) / 16.;

    COLOR.rgb = mix(COLOR.rgb, texture(noise, uv).xxx, COLOR.rgb * strength);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
