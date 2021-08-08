varying float vElevation;

void main() {

  float color = vElevation + 0.2;
    
  gl_FragColor = vec4(color, color, color, 1.0);

}