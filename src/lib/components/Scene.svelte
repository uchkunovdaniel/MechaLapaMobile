<script>
    import { OrbitControls } from '@threlte/extras'
    import {T, useLoader} from '@threlte/core';
    import {GLTFLoader} from "three/examples/jsm/loaders/GLTFLoader.js";

    const gltf = useLoader(GLTFLoader).load("https://raw.githubusercontent.com/uchkunovdaniel/MechaLapaMobile/refs/heads/main/3Dmodels/model.gltf");
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
            minPolarAngle={0}
            maxPolarAngle={Math.PI}
            enableZoom={false}
    >
    </OrbitControls>

</T.PerspectiveCamera>

<T.AmbientLight intensity={10}/>


<section class="flex justify-center items-center">
    {#if $gltf}
        <T.Mesh is={$gltf.scene} scale={0.3} rotation.x={Math.PI/2}/>
    {/if}
</section>