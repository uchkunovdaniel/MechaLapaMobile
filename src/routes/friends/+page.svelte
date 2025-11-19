<script lang="ts">
    import Navbar from "$lib/components/Navbar.svelte";
    import {connected} from "../../connected";
    import {pb} from "../../pb";

    let friendsIds: string[] = $state([])

    async function getFriends(): Promise<string[]> {
        if (pb.authStore.isValid) {
            return (await pb.collection("users").getOne(pb.authStore.record?.id as string)).friends
        } else return []
    }

    friendsIds = await getFriends()

    // const friends = await pb.collection("users").getOne(friendsIds[0])

    console.log(friendsIds[0])
</script>


<main class="w-screen min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <h1 class="heading text-(--white) text-center">Приятели</h1>
    <h1 class="subheading text-(--white) text-center">Виж какво са посетили те</h1>


    <!--{#each friends as friend}-->
    <!--    <h1>{friend}</h1>-->
    <!--{/each}-->
    <Navbar style={"mt-auto"} />
</main>