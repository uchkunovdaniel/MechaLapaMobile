<script lang="ts">
    import Navbar from "$lib/components/Navbar.svelte";
    import {connected} from "$stores/connected";
    import {pb} from "$lib/utils/pb";
    import {onMount} from "svelte";
    import type {RecordModel} from "pocketbase";
    import user from '$lib/assets/profile.svg'
    import { geocoding, config } from "@maptiler/sdk";
    import Input from "$components/Input.svelte";
    import Button from "$components/Button.svelte";

    config.apiKey = import.meta.env.VITE_MAPTILER_KEY as string;

    let friendsIds: string[] = $state([])
    let friends: RecordModel[] = $state([])
    async function getFriends(): Promise<string[]> {
        if (pb.authStore.isValid) {
            return (await pb.collection("users").getOne(pb.authStore.record?.id as string)).friends
        } else return []
    }
    onMount(async () => {
        friendsIds = await getFriends()
        friends = await Promise.all(friendsIds.map(id => pb.collection("users").getOne(id)))
    })

    async function getFriendLocation(id: string) {
        const location = (await pb.collection("locations").getOne(id)).location
        return (await geocoding.reverse([ location.lon, location.lat ], {limit: 1, language: "local"})).features[0].place_name
    }

    let hidden = $state(true)
</script>


<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <h1 class="heading text-(--white) text-center">Приятели</h1>
    <h1 class="subheading text-(--white) text-center">Виж какво са посетили те</h1>


    {#each friends as friend}
        <section class="glassContainer w-80 h-20 gap-6 rounded-xl flex flex-row items-center justify-center pl-8">
            <img src={user} alt="">
            <section class="flex flex-col items-start justify-between">
                <h1 class="text-white subheading">{friend.name}</h1>
                <p class="muller-next text-(--white) text-xs font-light">{await getFriendLocation(friend.locations[0])}</p>
            </section>
        </section>
    {/each}
    <Button shimmer={false} className="flex justify-between" onclick={() => hidden = !hidden}><span class="text-2xl mr-10 pt-1 font-light muller-next">+</span> Добави приятел</Button>
    {#if !hidden}
        <section class="flex items-center justify-start w-80">
            <input class="w-70 pl-2 pr-12 h-10 muller-next font-light text-(--white) border-0 outline-none focus:outline-none" placeholder="ID: 1234567890">
            <button class="text-(--white) muller-next opacity-45 font-medium -ml-10">Добави</button>
        </section>
    {/if}

    <Navbar style={"mt-auto"} />
</main>