<script lang="ts">
    import {pb} from "../../pb";
    import {goto} from "$app/navigation";
    import {connected} from "$stores/connected";
    import Navbar from "$lib/components/Navbar.svelte";
    import {browser} from "$app/environment";

    if(!pb.authStore.isValid && browser) goto("/login");

</script>

<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <h1 class="heading text-(--white) text-center">Прoфил</h1>

    <Navbar style={"mt-auto"} />
</main>