shader_type canvas_item;

uniform vec3 color = vec3(0.33, 0.66, 0.71);
uniform int octaves = 4;

float rand(vec2 coord) {
	float r1 = 118.0;
	float r2 = 93.0;
	float r3 = 1000.0;
	float r4 = 1000.0;
	
	return fract(sin(dot(coord, vec2(r1, r2)) * r3) * r4);
}

float noise(vec2 coord) {
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);

	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

// fractal brownian motion
float fbm(vec2 coord) {
	float value = 0.0;
	float scale = 0.5;
	
	for (int i = 0; i < octaves; i += 1) {
		value += noise(coord) * scale;  
		coord *= 2.0;
		scale *= 0.5;
	}
	
	return value;
}

void fragment() {
	vec2 coord = UV * 20.0;
	
	vec2 motion = vec2(fbm(coord + TIME * 0.2));
	
	float final = fbm(coord + motion);
	
	COLOR = vec4(color, final * 0.5);
}