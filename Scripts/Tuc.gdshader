shader_type spatial;

void fragment() {
    ALBEDO = vec3(COLOR[0],COLOR[1],COLOR[2]);
    EMISSION = 0.5*vec3(COLOR[0],COLOR[1],COLOR[2]);
}