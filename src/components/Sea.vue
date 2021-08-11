<template>
    <canvas ref="canvasRef" class="webgl"></canvas>
</template>

<script lang="ts">
import { ref, defineComponent, onMounted } from 'vue'
import * as THREE from 'three'
import * as dat from 'dat.gui'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'
import vertexShader from '../shaders/vertex.glsl'
import fragmentShader from '../shaders/fragment.glsl'

const gui = new dat.GUI({ width: 340 })

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
        lowestColor: '#186691',
        highestColor: '#9bd8ff'
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
          uColorLowest: { value: new THREE.Color(color.lowestColor) },
          uColorHighest: { value: new THREE.Color(color.highestColor) },
          uWaveSpeed: { value: 1.0 },
          uWaveHeight: { value: 0.1 },
          uWaveWidth: { value: 3.0 },
          uSparyMovingSpeed: { value: 0.05 },
          uSparyChangeSpeed: { value: 0.1 },
          uSprayHeight: { value: 0.06 },
          uSprayWidth: { value: 4.0 }
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

      gui.addColor(color, 'lowestColor').onChange(() => { waterMaterial.uniforms.uColorLowest.value.set(color.lowestColor) })
      gui.addColor(color, 'highestColor').onChange(() => { waterMaterial.uniforms.uColorHighest.value.set(color.highestColor) })
      gui.add(waterMaterial.uniforms.uWaveSpeed, 'value').min(0).max(5).name('waveSpeed')
      gui.add(waterMaterial.uniforms.uWaveHeight, 'value').min(0).max(1).name('waveHeight')
      gui.add(waterMaterial.uniforms.uWaveWidth, 'value').min(0).max(5).name('waveWidth')
      gui.add(waterMaterial.uniforms.uSparyMovingSpeed, 'value').min(0).max(1).name('sparyMovingSpeed')
      gui.add(waterMaterial.uniforms.uSparyChangeSpeed, 'value').min(0).max(1).name('sparyChangeSpeed')
      gui.add(waterMaterial.uniforms.uSprayHeight, 'value').min(0).max(1.5).name('sparyHeight')
      gui.add(waterMaterial.uniforms.uSprayWidth, 'value').min(0).max(10).name('sparyWidth')

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
