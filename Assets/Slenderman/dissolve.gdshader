shader_type spatial;

uniform sampler2D noise;
uniform sampler2D albedo_texture;
uniform float bias;

void fragment() {
    float sampledNoise = texture(noise, (VERTEX.xy) * 0.1).x;
    float test = (sampledNoise - 0.5) * 10.0 + 0.5 + 0.0;
    float transition = mix(0.0, mix(test, 1.0, bias), bias);
    ALPHA = mix(0.0, 1.0, transition);
    ALBEDO = texture(albedo_texture, UV).xyz;
    ROUGHNESS = 0.27;
    METALLIC = 0.4;
    SPECULAR = 0.5;
}