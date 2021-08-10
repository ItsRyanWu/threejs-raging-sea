varying float vElevation;

uniform vec3 uColorLowest;
uniform vec3 uColorHighest;

void main() {

  vec3 color = mix(uColorLowest, uColorHighest, (vElevation + 0.1) * 5.0);
    
  gl_FragColor = vec4(color, 1);

}