shader_type spatial;

uniform float intencity = 300;
uniform float dist = 4;


void vertex()
{
	POSITION = vec4(VERTEX, 1.0);
}


void fragment()
{
    float depth1 = texture(DEPTH_TEXTURE, SCREEN_UV).r;
    float depth2 = texture(DEPTH_TEXTURE, SCREEN_UV + vec2(0f, dist / 1000f)).r;
    float depth3 = texture(DEPTH_TEXTURE, SCREEN_UV + vec2(dist / 1000f, 0f)).r;
       
    float fac = abs(depth1 - depth2) + abs(depth1 - depth3);
	float x = fac * intencity;
	vec4 sub = vec4(x, x, x, 0);
       
	EMISSION = (texture(SCREEN_TEXTURE, SCREEN_UV) - sub).rgb;
}