#pragma glslify: cnoise = require(./perlin-noise.glsl)

float PI = 3.14159265359;

uniform float uTime;
uniform float uWaveHeight;
uniform float uWaveWidth;
uniform float uWaveSpeed;
uniform float uSparyMovingSpeed;
uniform float uSparyChangeSpeed;
uniform float uSprayHeight;
uniform float uSprayWidth;
 
varying float vElevation;

void main() {

  vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  float elevation = sin(modelPosition.x * uWaveWidth + uTime * uWaveSpeed)
                    * cos(modelPosition.z * uWaveWidth * 2.0 + uTime * uWaveSpeed)
                    * uWaveHeight;

  for (float i = 1.0; i <= 3.0; i++) {
    
    elevation -= abs((uSprayHeight / i) * cnoise(vec3((modelPosition.xz + vec2(uTime * uSparyMovingSpeed)) * uSprayWidth * i, uTime * uSparyChangeSpeed)));

  }

  modelPosition.y += elevation;

  vElevation = elevation;

  vec4 viewPosition = viewMatrix * modelPosition;
  vec4 projectedPosition = projectionMatrix * viewPosition;

  gl_Position = projectedPosition;

}