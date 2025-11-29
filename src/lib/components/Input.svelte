<script lang="ts">

    type Props = {type?: string, id?: string, placeholder?:string, required?: boolean, name?: string}

    let {type = "text",
        id,
        placeholder,
        required,
        name
    }: Props = $props();
</script>

<section class="flex flex-col-reverse items-end justify-start">
    <input {type} {id} {name} {placeholder} {required} class="glassContainer subheading text-(--white) text-2xl px-4 py-2 pr-10 rounded-xl border border-gray-300 focus:outline-none focus:ring-2 w-80 h-14" />
</section>
