<script lang="ts">
    import WalletAccess from '$lib/WalletAccess.svelte';
    import NavButton from '$lib/components/navigation/NavButton.svelte';
    import Blockie from '$lib/components/Blockie.svelte';
    import {wallet, flow, chain} from '$lib/stores/wallet';
    import {onMount} from 'svelte';
    import {combine} from '$lib/utils/combine';
  
    let message = '';
    async function setMessage() {
      await flow.execute((contracts) => contracts.GreetingsRegistry.setMessage(message));
    }
  
    onMount(() => {
      console.log('mount demo', {
        combine: combine(wallet.address || '0x0000000000000000000000000000000000000000', 'hi').toString(),
      });
    });
  </script>
  
  <symbol id="icon-spinner6" viewBox="0 0 32 32">
    <path
      d="M12 4c0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.209-1.791 4-4 4s-4-1.791-4-4zM24.719 16c0 0 0 0 0 0 0-1.812 1.469-3.281 3.281-3.281s3.281 1.469 3.281 3.281c0 0 0 0 0 0 0 1.812-1.469 3.281-3.281 3.281s-3.281-1.469-3.281-3.281zM21.513 24.485c0-1.641 1.331-2.972 2.972-2.972s2.972 1.331 2.972 2.972c0 1.641-1.331 2.972-2.972 2.972s-2.972-1.331-2.972-2.972zM13.308 28c0-1.487 1.205-2.692 2.692-2.692s2.692 1.205 2.692 2.692c0 1.487-1.205 2.692-2.692 2.692s-2.692-1.205-2.692-2.692zM5.077 24.485c0-1.346 1.092-2.438 2.438-2.438s2.438 1.092 2.438 2.438c0 1.346-1.092 2.438-2.438 2.438s-2.438-1.092-2.438-2.438zM1.792 16c0-1.22 0.989-2.208 2.208-2.208s2.208 0.989 2.208 2.208c0 1.22-0.989 2.208-2.208 2.208s-2.208-0.989-2.208-2.208zM5.515 7.515c0 0 0 0 0 0 0-1.105 0.895-2 2-2s2 0.895 2 2c0 0 0 0 0 0 0 1.105-0.895 2-2 2s-2-0.895-2-2zM28.108 7.515c0 2.001-1.622 3.623-3.623 3.623s-3.623-1.622-3.623-3.623c0-2.001 1.622-3.623 3.623-3.623s3.623 1.622 3.623 3.623z"
    />
  </symbol>
  <WalletAccess>
    <section class="py-8 px-4">
      
    </section>
  
    
  
    {#if $wallet.state === 'Ready'}
      <form class="mt-5 w-full max-w-sm">
        <div class="flex items-center">
          <NavButton
            label="Disconnect"
            disabled={$wallet.unlocking || $chain.connecting}
            on:click={() => wallet.disconnect()}
          >
            Disconnect
          </NavButton>
        </div>
      </form>
    {/if}
  </WalletAccess>
  
  