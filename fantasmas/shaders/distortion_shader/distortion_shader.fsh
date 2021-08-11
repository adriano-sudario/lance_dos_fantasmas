//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D distortion_texture_page;

void main()
{
    vec2 distort_amount = vec2((v_vColour * texture2D(distortion_texture_page, v_vTexcoord)).xy);
    distort_amount.x = 1.0 - distort_amount.x;
    distort_amount -= 0.5;
    if (distort_amount.x > 0.5) { distort_amount.x -= 1.0; }
    if (distort_amount.y > 0.5) { distort_amount.y -= 1.0; }
    distort_amount /= 4.0;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord + distort_amount);
}