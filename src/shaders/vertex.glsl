#pragma glslify: cnoise = require(./perlin-noise.glsl)

uniform float uTime;
float PI = 3.14159265359;
float waveHeight = 0.1;
float waveFrequency = 4.0;
float waveSpeed = 1.0;

varying float vElevation;

void main() {

  vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  float elevation = sin(modelPosition.x * waveFrequency + uTime * waveSpeed)
                     * cos(modelPosition.z * waveFrequency + uTime * waveSpeed)
                     * waveHeight;

  for (float i = 1.0; i <= 5.0; i++) {
    
    elevation -= abs((0.06 / i) * cnoise(vec3(modelPosition.xz * 2.0 * i, uTime * 0.1)));

  }

  modelPosition.y += elevation;

  vElevation = elevation;

  vec4 viewPosition = viewMatrix * modelPosition;
  vec4 projectedPosition = projectionMatrix * viewPosition;

  gl_Position = projectedPosition;

}