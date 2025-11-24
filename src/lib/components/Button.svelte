<script lang="ts">
    import {onMount, type Snippet} from "svelte";

    type Props = {
        children: Snippet,
        id?: string,
        className?: string,
        onclick?: () => void
    }

    let {children,
        id,
        className,
        onclick}: Props = $props();

    onMount(() => {
        document.addEventListener("touchstart", function() {}, true);
    })
</script>

<button {id} {onclick} class="btn glassContainer text-white subheading rounded-xl w-80 h-14 {className}">
    {@render children()}
</button>


<style>
    .btn {
        background: linear-gradient(45deg, rgba(255, 255, 255, 0.05) 40%, rgba(255, 255, 255, 0.2) 50%, rgba(255, 255, 255, 0.05) 60%);
        background-size: 300%;
        background-position-x: 100%;
    }
    .btn:hover, .btn:focus, .btn:active {
        animation: shimmer 1s linear;
    }

    @keyframes shimmer {
        to{
            background-position-x: 0;
        }
    }
</style>