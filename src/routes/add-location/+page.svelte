<script lang="ts">
    import {connected} from "$stores/connected";
    import Navbar from "$components/Navbar.svelte";
    import {pb} from "$utils/pb.js";
    import {data} from "$stores/data";
    import {Geolocation} from "@capacitor/geolocation";
    import {onMount} from "svelte";
    import toast, { Toaster } from 'svelte-french-toast';

    async function addLocation() {
        const location = await Geolocation.getCurrentPosition()
        await pb.collection("locations").create({location: {lon: location.coords.longitude, lat: location.coords.latitude}, readings: $data})
        toast.success("Локацията е добавена успешно!", {position: "bottom-center"})
    }

    onMount(async () => {
        const locations = await pb.collection('locations').getFullList();
        const currentLocation = await Geolocation.getCurrentPosition()
        locations.forEach(location => {
            if (location.location.lon.toFixed(3) === currentLocation.coords.longitude.toFixed(3) && location.location.lat.toFixed(3) === currentLocation.coords.latitude.toFixed(3)) {
                disabled = true
            }
        }
        )
    })

    let disabled = $state(false)
</script>

<Toaster />
<main class="w-screen h-screen flex flex-col items-center gap-6 justify-start p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <section class="w-full flex flex-col gap-4">
        <h1 class="muller-next text-4xl font-bold text-(--white) text-center">Добави локация</h1>
        <h2 class="subheading text-(--white) text-center">Сподели с приятелите си</h2>
    </section>

    {#if !$connected}
        <p class="subheading text-(--white) mt-auto">Моля свържете устройството</p>
    {:else }
        <ul class="flex flex-col gap-4 items-center mt-20">
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Температура: {$data ? ($data["temperature"]-8).toFixed(0) : 0} °C</li>
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Влажност: {$data ? $data["humidity"].toFixed(0) : 0} %</li>
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Надморска височина: {$data ? ($data["altitude"] - 20).toFixed(0) : 0} m</li>
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Качество на въздуха: {$data ? ($data["iaq"] + 22 > 100 ? 100 : $data["iaq"] + 22).toFixed(0) : 0} %</li>
        </ul>
        <button disabled={disabled} class="w-80 h-16 rounded-xl bg-(--white) subheading" onclick={async () => await addLocation()}>{disabled ? "Локацията вече е доабвена" : "Добави текуща локация"}</button>
    {/if}
    <Navbar style={"mt-auto"} />
</main>