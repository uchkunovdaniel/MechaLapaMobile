<script>
    import { OrbitControls } from '@threlte/extras'
    import {T, useLoader} from '@threlte/core';
    import {GLTFLoader} from "three/examples/jsm/loaders/GLTFLoader.js";
    const gltf = useLoader(GLTFLoader).load("https://raw.githubusercontent.com/uchkunovdaniel/MechaLapaMobile/refs/heads/main/model3d/model.gltf");
</script>

<T.PerspectiveCamera
        makeDefault
        position={[10, 5,10]}
        lookAt.y={1}
        zoom={3}
>
    <OrbitControls
            enableDamping
            rotateSpeed={0.9}
            zoomToCursor
            minPolarAngle={0}
            maxPolarAngle={Math.PI}
            enableZoom={false}
    >
    </OrbitControls>

</T.PerspectiveCamera>

<T.DirectionalLight
        position.x={20}
        position.y={20}
        position.z={20}
        intensity={30}
/>

<T.AmbientLight intensity={200} />

<section class="flex justify-center items-center">
    {#if $gltf}
        <T is={$gltf.scene} scale={0.29} rotation.x={Math.PI/2}/>
    {/if}
</section>