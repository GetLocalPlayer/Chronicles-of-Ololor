shader_type canvas_item;

uniform int max_samples = 30;
uniform float density = 0;


void fragment()
{
	vec2 uv = SCREEN_UV;
    vec2 uv_delta = uv - vec2(0.5, 0.5);
	uv_delta *= 1.0 / float(max_samples) * density;
	vec4 sample = vec4(1.0);
	float decay = 1.0;
  
	for(int i=0; i < max_samples ; i++)
	{
		uv -= uv_delta;
	    sample += texture(SCREEN_TEXTURE, uv);
	}

	COLOR = sample / float(max_samples);
}
