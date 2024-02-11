#version 460 core

#include <flutter/runtime_effect.glsl>

uniform float uTime;
uniform vec2 uResolution;
out vec4 fragColor;


vec3 pal( in float t )
{
    vec3 a = vec3(0.9882, 1.0, 0.2275);
    vec3 b = vec3(0.7922, 0.4118, 0.4118);
    vec3 c = vec3(0.8275, 0.7098, 0.7098);
    vec3 d = vec3(0.5804, 0.6078, 0.6314);

    return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
  vec2 uv = (FlutterFragCoord() * 2. - uResolution.xy) / uResolution.y;
  vec2 uv0 = uv;
  vec3 finalColor = vec3(0.);
  float iTime = uTime * 1.;
  for (float i = 0.; i < 3.; i++){
      uv = fract(uv * 1.5) - .5;
      float d = length(uv) * exp(-length(uv0));
      vec3 color = pal(length(uv0) + iTime * .3 + i);
      d = sin(d * 10. + iTime) / 10.;
      d = abs(d) - length(uv0) * .01;
      d = .01/d;
      d = pow(d,1.);
      
      finalColor += color * d;
  }

  fragColor = vec4(finalColor,1.);
}