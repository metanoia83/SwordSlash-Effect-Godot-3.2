shader_type spatial;
render_mode unshaded,cull_disabled, blend_add;

uniform sampler2D color: hint_albedo;
uniform sampler2D mask;
uniform float alpha : hint_range(0,1);
uniform float rotation : hint_range(-5,5);
uniform vec4 albedo : hint_color;


void fragment(){
	vec2 UVmask = UV;

    float rotation_index = rotation;
    
   UVmask -= vec2(0.5, 0.5);

    mat2 rotation_matrix = mat2(vec2(sin(rotation_index), -cos(rotation_index)),
                                vec2(cos(rotation_index), sin(rotation_index)));
    UVmask = UVmask * rotation_matrix;

    UVmask += vec2(0.5, 0.5);
	
	vec4 baseColor = texture(color,UV);
	vec4 maskColor = texture(mask,UVmask);
    
	ALBEDO = baseColor.rgb * albedo.rgb;
	ALPHA = alpha * maskColor.r;
	
}
