<script lang="ts">
    import logo from '$lib/assets/logo.svg';
    import map from '$lib/assets/map.svg';
    import friends from '$lib/assets/friends.svg';
    import profile from '$lib/assets/profile.svg';
    import {goto} from "$app/navigation";

    type Props = {style?: string};

    let {style}: Props = $props();
</script>

<nav class="glassContainer w-80 h-16 flex justify-between items-center rounded-2xl {style}">
    <ul class="flex gap-6">
        <li class="py-2 px-3 rounded-full"><button onclick={() => goto("/")}><img src="{logo}" alt="home"></button></li>
        <li class="py-2 px-4 rounded-full"><button onclick={() => goto("/map")}><img src="{map}" alt="map"></button></li>
        <li class="py-2 px-4 rounded-full"><button onclick={() => goto("/friends")}><img src="{friends}" alt="friends"></button></li>
        <li class="py-2 px-4 rounded-full"><button onclick={() => goto("/profile")}><img src="{profile}" alt="profile"></button></li>
    </ul>
</nav>
