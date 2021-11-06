<script context="module">
  // export const hydrate = false;
</script>

<script lang="ts">
  import NavButton from '$lib/components/navigation/NavButton.svelte';
  import Feature from '$lib/components/Feature.svelte';
  import {url} from '$lib/utils/url';
  const name = 'Fellow Class';

  function _select(elem: HTMLElement) {
    const range = document.createRange();
    const selection = window.getSelection();
    range.selectNodeContents(elem);
    console.log({selection: range.toString()});
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (selection as any).removeAllRanges();
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (selection as any).addRange(range);
  }
  function select(e: MouseEvent) {
    _select(e.currentTarget as HTMLElement);
  }
</script>

<section class=" py-20 px-4 text-center">
  <div class="max-w-auto md:max-w-lg mx-auto">
    <p class="text-8xl">$120,000</p>
    <p class="text-3xl pt-10">Raised in Treasury</p>
    <p>4.27% APY</p>
  </div>

  <div class="border-b my-20 border-black max-w-4xl mx-auto"></div>

  <div class="pt-8 pb-4 dark:bg-black bg-white">
    <h2 class="text-3xl underline mb-4 text-gray-600 dark:text-gray-400">Features</h2>
    <div class="max-w-xl mx-auto px-4 sm:px-6 lg:max-w-screen-xl lg:px-8">
      <div class="lg:grid lg:grid-cols-2 lg:gap-8">
        <Feature title="All Included">
          This template include setup for smart contracts, subgraph (contract api) and frontend. All is setup as a
          monorepo with a shared common library.
        </Feature>
        <Feature title="PWA ready: 100% Lighthouse score">
          The web app is fully PWA compliant, with offline caching, etc... The javascript code necessary to launch the
          app is less than 50kB (15kB compressed), including the home page content. The rest is loaded on demand.
        </Feature>
        <Feature title="Great Dev experience">
          <a class="text-blue-600" href="https://hardhat.org" target="_blank" rel="noopener">Hardhat</a>
          for contracts,
          <a class="text-blue-600" href="https://github.com/wighawag/hardhat-deploy" target="_blank" rel="noopener"
            >hardhat-deploy</a
          >
          for contract deployment,
          <a class="text-blue-600" href="https://thegraph.com" target="_blank" rel="noopener">The Graph</a>
          for contract api,
          <a class="text-blue-600" href="https://svelte.dev" target="_blank" rel="noopener">svelte + Svelte Kit</a>
          for frontend with HMR (Hot Module Replacement) and production build.
        </Feature>
        <Feature title="Everything Hot Reload">
          On contract changes, contract get to keep their address and code get updated automatically. On frontend
          changes, module get replaced using blazing fast
          <a class="text-blue-600" href="https://vite.dev" target="_blank" rel="noopener">Vite</a>
          es module hot reload. On subgraph changes, the graph get updated and reexecuted.
        </Feature>
        <Feature title="Fully IPFS Ready">
          Fully IPFS ready with proper url routing. The web app works on both IPFS urls and ENS/DNS urls. PWA works on
          IPFS too with scoped service workers.
        </Feature>
        <Feature title="All in Typescript">The whole app including contracts tests, is written in typescript.</Feature>
        <Feature title="Code Splitting and Tree Shaking">
          By using Svelte Kit (and so Vite) and ES modules, the frontend benefit from code splitting an dynamic imports
          as well as tree shaking.
        </Feature>
        <Feature title="VSCode Setup">
          The repo is setup as a vscode workspace with recommended plugins. Execute tests from the editor. Auto format,
          etc...
        </Feature>
        <Feature title="One command deploy">
          Everything is setup, except for the private ENV variable to deploy the contracts, the subgraph and the web
          app, all at once. It also include
          <a class="text-blue-600" href="https://fleek.co" target="_blank" rel="noopener">fleek</a>
          config for automatic web deployment on ipfs.
        </Feature>
      </div>
    </div>
  </div>
</section>
