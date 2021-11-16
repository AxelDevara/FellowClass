<script lang="ts">
  type LinkInfo = {href: string; title: string};
  export let links: LinkInfo[];
  import NavLink from './NavLink.svelte';
  import Loading from '../Loading.svelte';
  import {urlOfPath} from '$lib/utils/url';
  import {page, navigating} from '$app/stores';
</script>

<!-- {JSON.stringify($page, null, '  ')} -->

<!-- {JSON.stringify($navigating, null, '  ')} -->

<ul class="flex mt-6 px-10 border-b border-black">
  <NavLink href="/">
    <h2 class="font-bold text-2xl">Fellow Class</h2>
  </NavLink>
  <div class="w-20"></div>
  {#each links as link}
    <NavLink href={link.href} active={urlOfPath(link.href, $page.path)}>
      {link.title}
      <!-- ({link.href}) -->
    </NavLink>
  {/each}
</ul>

{#if $navigating}
  <Loading />
{/if}
