<script lang="ts">
    import Navbar from "$lib/components/Navbar.svelte";

    import {connected} from "$stores/connected";
</script>


<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">

    <Navbar style={"mt-auto"} />
</main>