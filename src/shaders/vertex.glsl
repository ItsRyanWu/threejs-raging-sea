uniform float uTime;
float PI = 3.14159265359;
float waveHeight = 0.2;
float waveFrequency = 2.0;
float waveSpeed = 1.0;

varying float vElevation;

void main() {

  vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  float elevation = sin(modelPosition.x * waveFrequency + uTime * waveSpeed)
                     * sin(modelPosition.z * waveFrequency + uTime * waveSpeed)
                     * waveHeight;

  modelPosition.y += elevation;

  vElevation = elevation;

  vec4 viewPosition = viewMatrix * modelPosition;
  vec4 projectedPosition = projectionMatrix * viewPosition;

  gl_Position = projectedPosition;

}