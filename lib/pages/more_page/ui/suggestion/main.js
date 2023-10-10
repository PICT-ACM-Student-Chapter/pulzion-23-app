import * as THREE from 'https://unpkg.com/three@0.152.2/build/three.module.js'
const scene = new THREE.Scene()
const camera = new THREE.PerspectiveCamera(
  75,
  innerWidth / innerHeight,
  0.1,
  1000
)

import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js'
import { FBXLoader } from 'three/examples/jsm/loaders/FBXLoader'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
//Pumpkins
import * as SkeletonUtils from 'three/addons/utils/SkeletonUtils.js'
//Particle System
import { DRACOLoader } from 'three/examples/jsm/loaders/DRACOLoader.js'
import { MeshSurfaceSampler } from 'three/examples/jsm/math/MeshSurfaceSampler.js'
import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer.js'
import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass.js'
import { ShaderPass } from 'three/examples/jsm/postprocessing/ShaderPass.js'
// import { LensDistortionShader } from '../static/shaders/LensDistortionShader.js'

import * as TWEEN from '@tweenjs/tween.js'

//DracoLoader
const dracoLoader = new DRACOLoader()
const newLoader = new GLTFLoader()
dracoLoader.setDecoderPath('https://www.gstatic.com/draco/v1/decoders/')
dracoLoader.setDecoderConfig({ type: 'js' })
newLoader.setDRACOLoader(dracoLoader)
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pumpkins
const renderer = new THREE.WebGLRenderer()
renderer.setSize(innerWidth, innerHeight)
renderer.setPixelRatio(devicePixelRatio) //reduce jaggedness
document.body.appendChild(renderer.domElement)
const controls = new OrbitControls(camera, renderer.domElement)
camera.position.z = 5
//background
const bgr_loader = new THREE.TextureLoader()
const environmentMap = bgr_loader.load('assets/img/2.jpg')
scene.background = environmentMap

scene.fog = new THREE.Fog(0x444444, 1, 30)

const light = new THREE.DirectionalLight(0xffffff, 1)
light.position.set(5, 5, 5)
scene.add(light)
const backLight = new THREE.DirectionalLight(0xffffff, 1)
backLight.position.set(0, 0, -5)
scene.add(backLight)

const pumpkinPositions = [
  { x: -3, y: 0, z: 1 },
  { x: -1, y: 2, z: -4 },
  { x: 5, y: -3, z: -1 },
  { x: 9, y: 3, z: -3 },
  { x: -10, y: -7, z: -7 },
  { x: -3, y: 0, z: 10 },
  { x: 0, y: 7, z: -6 },
  { x: 12, y: -3, z: -1 },
  { x: 5, y: 5, z: -10 },
  { x: -4, y: -7, z: -12 }
]
let pumpkinArr = []
const loader = new GLTFLoader()
loader.load(
  'assets/pumpkin1.glb',
  function (gltf) {
    let pumpkin = gltf.scene
    // scene.add(pumpkin);
    for (let i = 0; i < pumpkinPositions.length; i++) {
      const tempPumpkin = SkeletonUtils.clone(pumpkin)
      const tempGroup = new THREE.Group()
      const tempPumpkinLight = new THREE.PointLight(0xff7700, 30, 10)
      tempPumpkinLight.position.set(0, 0, 0)
      tempGroup.add(tempPumpkin)
      tempGroup.add(tempPumpkinLight)
      tempGroup.position.x = pumpkinPositions[i].x
      tempGroup.position.y = pumpkinPositions[i].y
      tempGroup.position.z = pumpkinPositions[i].z
      pumpkinArr[i] = tempGroup
    }
    for (let i = 0; i < pumpkinArr.length; i++) {
      scene.add(pumpkinArr[i])
    }
  },
  undefined,
  function (error) {
    console.error(error)
  }
)

/////////////////////////////////////////////////////////////////////////
//Background
//background
const texture = new THREE.TextureLoader().load('assets/img/2.jpg')
const geometry = new THREE.SphereGeometry(15, 32, 16)
const material = new THREE.MeshPhongMaterial({
  //  color: 0xffff00,
  color: 0x550099,
  side: THREE.BackSide,
  map: texture
})
const sphere = new THREE.Mesh(geometry, material)
scene.add(sphere)

/////////////////////////////////////////////////////////////////////////
///// LOADING GLB/GLTF MODEL FROM BLENDER
newLoader.load('assets/Skull.glb', function (gltf) {
  gltf.scene.traverse(obj => {
    if (obj.isMesh) {
      sampler = new MeshSurfaceSampler(obj).build()
    }
  })
  transformMesh()
})

/////////////////////////////////////////////////////////////////////////
///// TRANSFORM MESH INTO POINTS
let sampler
// let uniforms = { mousePos: {value: new THREE.Vector3()},
//                   timePos : {value : new THREE.Float32BufferAttribute()}}
const uniforms = {
  mousePos: { value: new THREE.Vector3() },
  timePos: { value: 0.0 } // Initialize with 0.0
}
let pointsGeometry = new THREE.BufferGeometry()
const cursor = { x: 0, y: 0 }
const vertices = []
const tempPosition = new THREE.Vector3()
//Edit
const pointsGrp = new THREE.Group()
//
function transformMesh () {
  // Loop to sample a coordinate for each points
  for (let i = 0; i < 99000; i++) {
    // Sample a random position in the model
    sampler.sample(tempPosition)
    // Push the coordinates of the sampled coordinates into the array
    vertices.push(tempPosition.x, tempPosition.y, tempPosition.z)
  }

  // Define all points positions from the previously created array
  pointsGeometry.setAttribute(
    'position',
    new THREE.Float32BufferAttribute(vertices, 3)
  )

  // Define the matrial of the points
  // const pointsMaterial = new THREE.PointsMaterial({
  //     // color: 0x5c0b17,
  //     color: 0x100b30,
  //     size: 0.1,
  //     blending: THREE.AdditiveBlending,
  //     transparent: true,
  //     opacity: 0.8,
  //     depthWrite: false,
  //     sizeAttenuation: true,
  //     lights : false,
  //     alphaMap: new THREE.TextureLoader().load('assets/particle-texture.jpg')
  // })

  // // Create the custom vertex shader injection
  // pointsMaterial.onBeforeCompile = function(shader) {
  //     shader.uniforms.mousePos = uniforms.mousePos

  //     shader.vertexShader = `
  //       uniform vec3 mousePos;
  //       uniform float timePos;
  //       varying float vNormal;

  //       ${shader.vertexShader}`.replace(
  //       `#include <begin_vertex>`,
  //       `#include <begin_vertex>
  //         vec3 seg = position - mousePos;
  //         vec3 dir = normalize(seg);
  //         float dist = length(seg);
  //         // float dist = sin(timePos)*length(seg);
  //         if (dist < 1.5){
  //           float force = clamp(1.0 / (dist * dist), -0., .5);
  //           transformed += dir * timePos*force;
  //           vNormal = force /0.5;
  //         }
  //       `
  //     )
  // }
  const pointsMaterial = new THREE.PointsMaterial({
    color: 0x100b30,
    size: 0.1,
    blending: THREE.AdditiveBlending,
    transparent: true,
    opacity: 0.8,
    depthWrite: false,
    sizeAttenuation: true,
    lights: false,
    alphaMap: new THREE.TextureLoader().load('assets/particle-texture.jpg'),
    uniforms: uniforms // Assign your custom uniforms to the material
  })

  // Update the shader code in onBeforeCompile
  pointsMaterial.onBeforeCompile = function (shader) {
    console.log(shader.fragmentShader)
    shader.uniforms.mousePos = uniforms.mousePos
    shader.uniforms.timePos = uniforms.timePos // Pass the timePos uniform to the shader

    shader.vertexShader = `
        uniform vec3 mousePos;
        uniform float timePos;
        varying float vNormal;

        ${shader.vertexShader}` // No need to modify the vertex shader here

    shader.vertexShader = shader.vertexShader.replace(
      `#include <begin_vertex>`,
      `#include <begin_vertex>
          vec3 seg = position - mousePos;
          vec3 dir = normalize(seg);
          float dist = length(seg);
          if (dist < 1.5){
            float force = clamp(1.0 / (dist * dist), -0., .5);
            transformed += dir * timePos * force;
            vNormal = force / 0.5;
          }`
    )
    shader.fragmentShader = `
        uniform vec3 diffuse;
        uniform float opacity;
        #include <common>
        #include <color_pars_fragment>
        #include <map_particle_pars_fragment>
        #include <alphatest_pars_fragment>
        #include <fog_pars_fragment>
        #include <logdepthbuf_pars_fragment>
        #include <clipping_planes_pars_fragment>
        void main() {
          #include <clipping_planes_fragment>
          vec3 outgoingLight = vec3( 0.0 );
          vec4 diffuseColor = vec4( diffuse, opacity );
          #include <logdepthbuf_fragment>
          #include <map_particle_fragment>
          #include <color_fragment>
          #include <alphatest_fragment>
          outgoingLight = diffuseColor.rgb;
          #include <output_fragment>
          #include <tonemapping_fragment>
          #include <encodings_fragment>
          #include <fog_fragment>
          #include <premultiplied_alpha_fragment>

          // gl_FragColor += vec4(0.01, 0.5, 0.01, 0.0);
        }`
  }

  // Create an instance of points based on the geometry & material
  const points = new THREE.Points(pointsGeometry, pointsMaterial)

  // Add them into the main group
  // scene.add(points)
  pointsGrp.add(points)
  scene.add(points)
}
/////////////////////////////////////////////////////////////////////////
///// POST PROCESSING EFFECTS
let width = window.innerWidth
let height = window.innerHeight
const renderPass = new RenderPass(scene, camera)
const renderTarget = new THREE.WebGLRenderTarget(width, height, {
  minFilter: THREE.LinearFilter,
  magFilter: THREE.LinearFilter,
  format: THREE.RGBAFormat
})

const composer = new EffectComposer(renderer, renderTarget)
composer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

/////DISTORT PASS //////////////////////////////////////////////////////////////
// const distortPass = new ShaderPass( LensDistortionShader )
// distortPass.material.defines.CHROMA_SAMPLES = 4
// distortPass.enabled = true
// distortPass.material.uniforms.baseIor.value = 0.910
// distortPass.material.uniforms.bandOffset.value = 0.0019
// distortPass.material.uniforms.jitterIntensity.value = 20.7
// distortPass.material.defines.BAND_MODE = 2

// composer.addPass( renderPass )
// composer.addPass( distortPass )

/////////////////////////////////////////////////////////////////////////

let dt = 0
function animate () {
  requestAnimationFrame(animate)
  renderer.render(scene, camera)
  dt += 0.01
  for (let i = 0; i < pumpkinArr.length; i++) {
    // pumpkinArr[i].position.y = Math.sin((i+1)*dt+i)
    pumpkinArr[i].position.y =
      (1 + 3 * Math.abs(Math.sin(5 * i))) * Math.sin(dt + i)
    pumpkinArr[i].rotation.y = (Math.PI / 3) * Math.sin(i + ((i + 1) * dt) / 2)
  }
  // scene.fog.color.setRGB(0.1*Math.sin(dt), 0, 0.1*Math.sin(dt/2));
  scene.fog.near = Math.abs(5 * Math.sin(dt))
  scene.fog.far = 15 + Math.abs(15 * Math.sin(dt / 3))
  pointsGrp.position.y += 0.01
  sphere.rotation.y += 0.001
  uniforms.timePos.value = 2.0 + 0.5 * Math.sin(dt * 5.0)
}
//animation experiment
//end

animate()

// addEventListener('mousemove', (event)=>{
//   mouse.x = 2*event.clientX / innerWidth - 1;
//   mouse.y = -2*event.clientY / innerHeight + 1;
// })

addEventListener('resize', () => {
  console.log(camera.aspect)
  renderer.setSize(innerWidth, innerHeight)
  camera.aspect = innerWidth / innerHeight
  camera.updateProjectionMatrix()
})

document.addEventListener(
  'mousemove',
  event => {
    event.preventDefault()
    cursor.x = event.clientX / window.innerWidth - 0.5
    cursor.y = event.clientY / window.innerHeight - 0.5
    uniforms.mousePos.value.set(cursor.x, cursor.y, 0)
    // m.uniforms.mousePos.value.set(cursor.x, cursor.y)
  },
  false
)
