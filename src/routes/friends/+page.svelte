<script lang="ts">
    import Navbar from "$lib/components/Navbar.svelte";
    import {connected} from "$stores/connected";
    import {pb} from "$lib/utils/pb";
    import {onMount} from "svelte";
    import type {RecordModel} from "pocketbase";
    import Item from "$lib/components/Item.svelte";
    import user from '$lib/assets/profile.svg'

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
</script>


<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <h1 class="heading text-(--white) text-center">Приятели</h1>
    <h1 class="subheading text-(--white) text-center">Виж какво са посетили те</h1>


    <!--{#each friends as friend}-->
        <Item classes="gap-4 justify-end">
            <img src="{user} " alt="">
            <h1 class="text-white subheading">Иван Иванов</h1>
        </Item>
    <!--{/each}-->
    <Navbar style={"mt-auto"} />
</main>