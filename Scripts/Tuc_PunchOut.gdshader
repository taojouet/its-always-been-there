shader_type spatial;

uniform sampler2D fracture;

void vertex(){
	
}

void fragment() {
	vec4 frac = texture(fracture,VERTEX.xy);
	ALPHA = 1.0-frac.r;
	ALBEDO = COLOR.rgb;
}
