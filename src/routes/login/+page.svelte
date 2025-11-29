<script lang="ts">
    import {connected} from "$stores/connected";
    import Input from "$components/Input.svelte";
    import Button from "$components/Button.svelte";
    import {pb} from "$utils/pb";
    import {goto} from "$app/navigation";
    import {onMount} from "svelte";

    let error: boolean = $state(false);

    async function login() {
        const form = document.getElementById("loginForm") as HTMLFormElement;
        const email = form.email.value;
        const password = form.password.value;

        if (email && password) {
            try{
                await pb.collection('users').authWithPassword(email, password);
                await goto('/');
            } catch (_) {
                error = true;
            }
            // console.log(data);
        }
        form.reset();
    }

    function shake() {
        return {
            duration: 80,
            css: (t: number) => `transform: translateX(${t * 20}px)`
        }
    }

    onMount(() => {
        if (pb.authStore.isValid) goto("/")
    })
</script>


<main class="w-screen fixed min-h-screen flex flex-col items-center justify-start gap-6 p-8 pt-16 {$connected ? 'bg-shapes-g' : 'bg-shapes-r'}">
    <section class="w-full flex flex-col gap-4">
        <h1 class="heading text-(--white) text-center">Вход</h1>
        <h2 class="subheading text-(--white) text-center">Влез в профила си</h2>
    </section>
    <form onsubmit={login} id="loginForm" class="flex flex-col items-center justify-end h-full gap-6 p-8 pt-16 w-screen mt-10">
        <Input name="email" placeholder="Имейл" type="email" required />
        <Input name="password" placeholder="Парола" type="password" required />
        <a href="/" class="muller-next text-(--white) text-sm text-right w-80">Забравена парола ?</a>
        <div class="min-h-10">
            {#if error}
                <p class="subheading text-red-300" transition:shake>Грешен имейл или парола</p>
            {/if}
        </div>
        <Button id="loginBtn" className="mt-10">Влез</Button>
    </form>
</main>