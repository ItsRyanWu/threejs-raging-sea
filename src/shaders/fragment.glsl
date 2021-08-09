varying float vElevation;

uniform vec3 uDarkestColor;
uniform vec3 uLightestColor;

void main() {

  vec4 color = mix(vec4(uDarkestColor, 1), vec4(uLightestColor, 1), (vElevation + 0.1) * 5.0);
    
  gl_FragColor = color;

}