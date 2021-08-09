uniform float uTime;
float PI = 3.14159265359;
float waveHeight = 0.1;
float waveFrequency = 3.0;
float waveSpeed = 1.0;

varying float vElevation;

void main() {

  vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  float elevation = sin(modelPosition.x * waveFrequency + uTime * waveSpeed)
                     * cos(modelPosition.z * waveFrequency + uTime * waveSpeed)
                     * waveHeight;

  modelPosition.y += elevation;

  vElevation = elevation;

  vec4 viewPosition = viewMatrix * modelPosition;
  vec4 projectedPosition = projectionMatrix * viewPosition;

  gl_Position = projectedPosition;

}