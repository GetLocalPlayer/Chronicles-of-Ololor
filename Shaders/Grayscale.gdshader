shader_type canvas_item;


void fragment()
{
	vec3 color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	float average = (color.r + color.g + color.b) / 3.0;
	COLOR = vec4(average, average, average, 1.0);
}