shader_type canvas_item;
render_mode unshaded;

uniform sampler2D gradient : hint_black;
uniform float mix_amount = 1.0;

void fragment()
{
	vec4 input_color = texture(TEXTURE, UV);
	float grayscale_value = mix_amount; // dot(input_color.rgb, vec3(0.299, 0.587, 0.114));
	vec3 sampled_color = texture(gradient, vec2(grayscale_value, 0.0)).rgb;
	
	COLOR.rgb = sampled_color;
	COLOR.a = input_color.a * mix_amount;
}