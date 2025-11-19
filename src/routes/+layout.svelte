<script lang="ts">
	import '../app.css';
    import '../fonts.css'
	import favicon from '$lib/assets/favicon.svg';
    import Navbar from "$lib/components/Navbar.svelte";
	import {connected} from "../connected";

    let { children } = $props();
</script>

<svelte:head>
    <link rel="icon" href={favicon} />
</svelte:head>

{@render children()}
<style>
    :global(body) {
        background: var(--black);
        padding: 0;
        margin: 0;
        user-select: none;
    }

    :root{
        --black: #202020;
        --white: #FFF4E6;
        --red: #D48788;
        --green: #64936D;
    }
    :global(.maplibregl-ctrl-attrib-inner, .maplibregl-ctrl-bottom-left ) {
        display: none;
    }

    :global(button, a){
        cursor: pointer;
    }
</style>