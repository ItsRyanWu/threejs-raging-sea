varying float vElevation;

uniform vec3 uDarkestColor;
uniform vec3 uLightestColor;

void main() {

  vec3 color = mix(uDarkestColor, uLightestColor, (vElevation + 0.1) * 5.0);
    
  gl_FragColor = vec4(color, 1);

}