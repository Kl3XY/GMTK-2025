shader_type canvas_item;

uniform float percentage : hint_range(0.0, 1.0, 0.1) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
    vec4 white = vec4(1.0, 1.0, 1.0, tex.a);

    COLOR = mix(tex, white, percentage);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
