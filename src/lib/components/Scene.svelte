<script lang="ts">
    import { OrbitControls } from '@threlte/extras'
    import {T, useLoader} from '@threlte/core';
    import {GLTFLoader} from "three/examples/jsm/loaders/GLTFLoader.js";

    const gltf = useLoader(GLTFLoader).load("https://raw.githubusercontent.com/uchkunovdaniel/MechaLapaMobile/refs/heads/main/3Dmodels/model.gltf");
    let position = $state([-20, 20, 20]);
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
            target={[0, 0, 0]}
    >
    </OrbitControls>
</T.PerspectiveCamera>

{#each [-2, 1, 0, 1, 2] as i}
    <T.DirectionalLight position={[i*10, 20, 20]} intensity={10}/>
{/each}
<T.AmbientLight intensity={10}/>

<section class="flex justify-center items-center">
    {#if $gltf}
        <T is={$gltf.scene} scale={300} rotation.x={.89}/>
    {/if}
</section>