<script lang="ts">
    import type {Snippet} from "svelte";

    let { children, classes }: {children?: Snippet, classes?: string} = $props();
</script>

<section class="glassContainer w-80 h-16 rounded-2xl flex items-center {classes}">
    {@render children?.()}
</section>