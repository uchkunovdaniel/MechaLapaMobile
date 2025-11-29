<script lang="ts">
    import Navbar from "$components/Navbar.svelte";
    import {BleClient} from "@capacitor-community/bluetooth-le";
    import { Canvas } from "@threlte/core"
    import Scene from "$components/Scene.svelte";
    import {connected} from "$stores/connected";
    import {Readings} from "$utils/readings";
    const SERVICE_UUID = "7d8b5ccd-ff95-4228-80fa-e7c51e09b54b"
    const CHARACTERISTIC_UUID = "90acaf49-dbdb-4c7b-8667-ada568397170"


    async function connect(){
        try {
            await BleClient.initialize();
            const device = await BleClient.requestDevice({
                services: [SERVICE_UUID]
            })
            await BleClient.connect(device.deviceId, () => $connected = false).then(
                async () => {
                    console.log('connected to device', device.deviceId);
                    $connected = true
                    await BleClient.startNotifications(device.deviceId, SERVICE_UUID, CHARACTERISTIC_UUID, (value) => {
                        data = JSON.parse(dataViewToString(value));
                        console.log(data["temperature"]);
                    })
                },
            )
        } catch (error) {
            console.error(error);
        }
    }

    async function disconnect() {
        try {
            // await BleClient.initialize()
            BleClient.getConnectedDevices([SERVICE_UUID]).then(async devices => {
                if (devices[0].name!.includes("Mecha Lapa")) {
                    await BleClient.disconnect(devices[0].deviceId)
                    $connected = false
            }})
            // await BleClient.disconnect(id)
        } catch (error) {
            console.error(error);
        }
    }

    function dataViewToString(dataView: DataView): string {
        const decoder = new TextDecoder("utf-8");
        return decoder.decode(dataView.buffer);
    }

    let data = $state()

</script>

<main class="w-screen h-screen flex flex-col items-center gap-6 justify-start p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <section class="w-full flex flex-col gap-4">
        <h1 class="heading text-(--white) text-center">Здравей</h1>
        <h2 class="subheading text-(--white) text-center">Меча Лапа те очаква...</h2>
    </section>
    <section class="w-90 h-80 flex justify-center items-center mb-40">
        <Canvas>
            <div id="control" class="hidden"></div>
            <Scene />
        </Canvas>
    </section>
    {#if !$connected}
        <section class="flex gap-4 items-center">
            <div class="rounded-full bg-(--red) w-3 h-3">&nbsp;</div>
            <p class="subheading text-(--white)">Устройството не е свързано</p>
        </section>
        {:else}
        <section class="flex gap-4 items-center">
            <div class="rounded-full bg-(--green) w-3 h-3">&nbsp;</div>
            <p class="subheading text-(--white)">Устройството е свързано</p>
        </section>
    {/if}
    {#if !$connected}
        <button class="glassContainer subheading mt-2 min-h-8 text-(--white) min-w-48 rounded-xl" onclick={async () => {await connect()}}>Свържи се</button>
    {:else }
        <ul class="flex flex-col gap-4 items-center">
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Температура: {data ? (data["temperature"]-8).toFixed(0) : 0} °C</li>
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Влажност: {data ? data["humidity"].toFixed(0) : 0} %</li>
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Надморска височина: {data ? (data["altitude"] - 20).toFixed(0) : 0} m</li>
            <li class="glassContainer w-80 h-16 subheading text-(--white) rounded-xl">Качество на въздуха: {data ? (data["iaq"] + 22 > 100 ? 100 : data["iaq"] + 22).toFixed(0) : 0} %</li>
        </ul>
        <button class="glassContainer subheading mt-2 min-h-8 text-(--white) min-w-48 rounded-xl" onclick={async () => {await disconnect()}}>Прекрати връзка</button>
    {/if}

    <Navbar style={"mt-auto mb-10 h-16 py-4"} />
    <div class="h-16 w-full">&nbsp;</div>
</main>
