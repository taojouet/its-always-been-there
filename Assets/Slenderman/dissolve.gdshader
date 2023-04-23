shader_type spatial;

<<<<<<< HEAD
uniform float time;
uniform sampler2D noise;

void fragment() {
	vec4 color = texture(noise, UV);
	float dist = distance(UV, vec2(0.5));
	float dissolve = sin(time * 10.0 + dist * 30.0) * 0.5 + 0.5;
	vec4 world_pos = VIEW_MATRIX * vec4(VERTEX, 1.0);
	float size = sin(time * 2.0 + dist * 30.0) * 0.5 + 0.5;
	float dist_to_sphere = length(world_pos.xyz);
	float dissolve_factor = clamp((dist_to_sphere - size) / (size * 0.1), 0.0, 1.0);
	vec4 dissolve_color = mix(color, vec4(1.0, 1.0, 1.0, 0.0), dissolve * dissolve_factor);
	ALBEDO = dissolve_color.rgb;
=======
uniform sampler2D noise;
uniform sampler2D albedo_texture;
uniform float bias;

void fragment() {
	float sampledNoise = texture(noise, VERTEX.xy).x;
	float test = (sampledNoise - 0.5) * 10.0 + 0.5 + 0.0;
	float transition = mix(0.0, mix(test, 1.0, bias), bias);
	ALPHA = mix(0.0, 1.0, transition);
	ALBEDO = texture(albedo_texture, UV).xyz;
	ROUGHNESS = 0.27;
	METALLIC = 0.4;
	SPECULAR = 0.5;
>>>>>>> main
}
