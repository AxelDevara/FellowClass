<script lang="ts">
  export let active = false;
  export let href: string;
</script>

{#if active}
  <li class="-mb-px mr-1">
    <span
      class="bg-white  inline-block border-t  py-2 px-4 border-black font-semibold"
      {href}
    >
      <slot />
    </span>
  </li>
{:else}
  <li class="-mb-px mr-1">
    <a class="bg-white  inline-block py-2 px-4" {href}>
      <slot />
    </a>
  </li>
{/if}
