import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import glslify from 'rollup-plugin-glslify';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
        vue(),
        glslify({
            include: [
                '**/*.glsl'
            ],
            // Undefined by default
            exclude: 'node_modules/**',
            // Compress shader by default using logic from rollup-plugin-glsl
            compress: true
        })
    ]
})
