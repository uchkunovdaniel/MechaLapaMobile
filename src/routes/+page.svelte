<script lang="ts">
    import device from '$lib/assets/device.svg'
    import Navbar from "$lib/components/Navbar.svelte";
    import {BleClient} from "@capacitor-community/bluetooth-le";

    import {connected} from "../connected";
    const SERVICE_UUID = "7d8b5ccd-ff95-4228-80fa-e7c51e09b54b"
    const CHARACTERISTIC_UUID = "90acaf49-dbdb-4c7b-8667-ada568397170"

    async function scan() {
        try {
            await BleClient.initialize();
            let ids: string[] = $state([])
            await BleClient.requestLEScan({}, device => ids.push(device.device.deviceId));
            setTimeout(async () => {
                await BleClient.stopLEScan();
                console.log(ids);
            }, 2000);
        } catch (error) {
            console.error(error);
        }
    }

    async function connect() {
        try {
            await BleClient.initialize();
            const device = await BleClient.requestDevice({
                services: [SERVICE_UUID]
            })
            await BleClient.connect(device.deviceId).then(
                () => {
                    console.log('connected to device', device.deviceId);
                    $connected = true
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

    async function read() {
        try {
            // await BleClient.initialize()
            BleClient.getConnectedDevices([SERVICE_UUID]).then(async devices => {
                if (devices[0].name!.includes("Mecha Lapa")) {
                    const res = await BleClient.read(devices[0].deviceId, SERVICE_UUID, CHARACTERISTIC_UUID)
                    console.log(res.getUint8(0))
                }})
            // await BleClient.disconnect(id)
        } catch (error) {
            console.error(error);
        }
    }

</script>

<main class="w-screen h-screen flex flex-col items-center gap-6 justify-start p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <section class="w-full flex flex-col gap-4">
        <h1 class="heading text-(--white) text-center">Здравей</h1>
        <h2 class="subheading text-(--white) text-center">Меча Лапа те очаква...</h2>
    </section>

    <img src={device} alt="device" class="w-7/12 h-7/12">

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
        <button class="glassContainer subheading mt-2 min-h-8 text-(--white) min-w-48 rounded-xl" onclick={async () => {await disconnect()}}>Прекрати връзка</button>
    {/if}

    <Navbar style={"absolute bottom-8"} />
</main>
