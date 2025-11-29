<script lang="ts">
    import { onMount } from 'svelte'
    import {Map, MapStyle, config, Marker, geocoding} from '@maptiler/sdk';
    import "@maptiler/sdk/dist/maptiler-sdk.css";
    import {connected} from "$stores/connected";
    import {pb} from "$utils/pb";
    import searchicon from '$lib/assets/search.svg'
    import Navbar from "$lib/components/Navbar.svelte";

    let map: Map;
    let mapContainer: HTMLElement;

    config.apiKey = import.meta.env.VITE_MAPTILER_KEY as string;

    onMount(async () => {
        const initialState = { lng: 24.875271, lat: 42.010186, zoom: 10 };

        map = new Map({
            container: mapContainer,
            style: MapStyle.STREETS,
            center: [initialState.lng, initialState.lat],
            zoom: initialState.zoom,
            navigationControl: false,
            scrollZoom: true,
        });

        let locations = await pb.collection('locations').getFullList();
        locations.forEach(location => {
            displayMarker(location.location.lon, location.location.lat, location.readings)
        })

    });

    function displayMarker(lng: number, lat: number, readings: any) {
        new Marker({color: "var(&#45;&#45;black)"})
            .setLngLat([lng, lat])
            .addTo(map)
            .getElement().addEventListener('click', async () => {
                data = readings
        })
    }
    let data = $state()

</script>

<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <section class="w-full flex flex-col gap-4">
        <h1 class="heading text-(--white) text-center">Карта</h1>
        <h2 class="subheading text-(--white) text-center">Отркий споделени данни</h2>
    </section>
    <search class="w-10/12 h-10 glassContainer rounded-2xl">
        <input type="text" list="search" class="w-full h-10 rounded-2xl subheading text-(--white) outline-0 p-2" placeholder="Къде отиваш?">
        <button class="mr-4"><img src="{searchicon}" alt="search"></button>
    </search>
<!--    <GeocodingControl {mapController} apiKey={VITE_MAPTILER_KEY} {maptilersdk} />-->
    <div class="w-72 h-96 rounded-2xl" bind:this={mapContainer}></div>

    <section class="w-full flex flex-col gap-4 mb-4">
        <h1 class="subheading text-center text-(--white)">Измерени стойности:</h1>
            <ul class="flex flex-col gap-4 items-center">
                <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Температура: {data ? (data["temperature"]).toFixed(0) : 0} °C</li>
                <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Влажност: {data ? data["humidity"].toFixed(0) : 0} %</li>
                <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Надморска височина: {data ? (data["altitude"]).toFixed(0) : 0} m</li>
                <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Качество на въздуха: {data ? (data["iaq"]).toFixed(0) : 0} %</li>
            </ul>
    </section>

    <Navbar style={"mt-auto"} />
</main>
