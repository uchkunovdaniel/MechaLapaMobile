<script lang="ts">
    import {pb} from "$lib/utils/pb";
    import {goto} from "$app/navigation";
    import {connected} from "$stores/connected";
    import Navbar from "$lib/components/Navbar.svelte";
    import {browser} from "$app/environment";
    import Button from "$components/Button.svelte";

    if(!pb.authStore.isValid && browser) goto("/login");

</script>

<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <section class="w-full flex flex-col gap-4">
        <h1 class="heading text-(--white) text-center">Профил</h1>
        <h2 class="subheading text-(--white) text-center">{pb.authStore.record?.name}</h2>
    </section>
    {#if pb.authStore.record?.avatar}
        <img src={pb.authStore.record?.avatar} alt="" class="w-24 h-24 mt-10">
    {:else}
        <div class="w-32 h-32 bg-(--white) rounded-full mt-10 flex items-center justify-center pl-5">
            <span class="text-6xl w-16 h-16">{pb.authStore.record?.name[0]}</span>
        </div>
    {/if}
    <ul class="flex flex-col gap-4 mt-10">
        <li><Button>Информация за профила</Button></li>
        <li><Button onclick={() => goto("/add-location")}>Добави локация</Button></li>
        <li><Button>Характеристики</Button></li>
        <li><Button onclick={() => pb.authStore.clear()}>Изход</Button></li>
    </ul>

    <Navbar style={"mt-auto"} />
</main>