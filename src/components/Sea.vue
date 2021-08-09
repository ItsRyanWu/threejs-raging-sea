<template>
    <canvas ref="canvasRef" class="webgl"></canvas>
</template>

<script lang="ts">
import { ref, defineComponent, onMounted } from 'vue'
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'
import vertexShader from '../shaders/vertex.glsl'
import fragmentShader from '../shaders/fragment.glsl'
export default defineComponent({
  name: 'Sea',
  setup: () => {

    const canvasRef = ref(null)

    onMounted(() => {

      const canvas = canvasRef.value
      const sizes = {
        width: window.innerWidth,
        height: window.innerHeight
      }
      const color = {
        darkestColor: '#186691',
        lightestColor: '#9bd8ff'
      }

      const scene = new THREE.Scene()
      const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height, 0.1, 100)
      camera.position.set(1, 1, 1)
      scene.add(camera)

      const waterGeometry = new THREE.PlaneBufferGeometry(2, 2, 128, 128)
      const waterMaterial = new THREE.ShaderMaterial({
        side: THREE.DoubleSide,
        vertexShader,
        fragmentShader,
        uniforms: {
          uTime: { value: 0.0 },
          uDarkestColor: { value: new THREE.Color(color.darkestColor) },
          uLightestColor: { value: new THREE.Color(color.lightestColor) }
        }
      })

      const water = new THREE.Mesh(waterGeometry, waterMaterial)
      water.rotation.x = - Math.PI * 0.5
      scene.add(water)

      const controls = new OrbitControls(camera, canvas)
      controls.enableDamping = true

      const renderer = new THREE.WebGLRenderer({
        canvas
      })
      
      renderer.setSize(sizes.width, sizes.height)
      renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

      window.addEventListener('resize', () => {
          // Update sizes
          sizes.width = window.innerWidth
          sizes.height = window.innerHeight

          // Update camera
          camera.aspect = sizes.width / sizes.height
          camera.updateProjectionMatrix()

          // Update renderer
          renderer.setSize(sizes.width, sizes.height)
          renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
      })

      const clock = new THREE.Clock()

      const tick = () => {
          waterMaterial.uniforms.uTime.value = clock.getElapsedTime()
          controls.update()
          renderer.render(scene, camera)
          window.requestAnimationFrame(tick)
      }

      tick()

    })
    
    return { canvasRef }
  }
})
</script>

<style>
  canvas {
    display: block;
  }
</style>
