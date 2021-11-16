<script lang="ts">
  export let title = '';
  import {chainName} from './config';
  import NavButton from './components/navigation/NavButton.svelte';
  import Modal from './components/Modal.svelte';
  import {base} from '$app/paths';

  import {walletStores, login} from './stores/wallet';
</script>


{#if $walletStores == null}
  <Modal {title} cancelable={true} on:close={() => console.log("closed")} closeButton={false}>
        <div class="text-center">
          <p>You need to connect your wallet.</p>
        </div>
        <div class="flex flex-wrap justify-center pb-3">
         
            <img
              class="cursor-pointer p-2 m-2 border-2 h-12 w-12 object-contain"
              alt={`Login with Metamask`}
              src={`${base}/metamask.svg`}
              on:click={() => login()}
            />
        </div>
        
          <div class="text-center">OR</div>
          <div class="flex justify-center">
            <NavButton
              label="Download Metamask"
              blank={true}
              href="https://metamask.io/download.html"
              class="m-4 w-max-content"
            >
              <img
                class="cursor-pointer p-0 mx-2 h-10 w-10 object-contain"
                alt={`Download Metamask}`}
                src={`${base}/images/metamask.svg`}
              />
              Download metamask
            </NavButton>
          </div>
  </Modal>
  {:else if $walletStores == 0}
  <div class="w-full flex items-center justify-center fixed top-0 pointer-events-none" style="z-index: 5;">
    <p class="w-64 text-center rounded-bl-xl rounded-br-xl text-gray-200 bg-pink-600 p-1">
      Wrong network, use
      {chainName}
    </p>
  </div>
  {:else}
  <slot />
{/if}
