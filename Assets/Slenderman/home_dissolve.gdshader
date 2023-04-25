shader_type spatial;

uniform sampler2D noise;
uniform float bias : hint_range(0.0, 1.0, 0.1) = 1.0;

void fragment() {
	ALBEDO = vec3(COLOR[0],COLOR[1],COLOR[2]);
	if(bias<1.0){
    	vec4 sampledNoise = texture(noise, VERTEX.xy*0.1);
		if(bias==0.0 || sampledNoise.r>bias){
			ALPHA = 0.0;
		}
	}
}