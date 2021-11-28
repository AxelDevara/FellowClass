<script lang="ts">
    import WalletAccess from '$lib/WalletAccess.svelte';
    import NavButton from '$lib/components/navigation/NavButton.svelte';
    import Blockie from '$lib/components/Blockie.svelte';
    import {onMount} from 'svelte';
    import {combine} from '$lib/utils/combine';
  
  </script>
  
  <symbol id="icon-spinner6" viewBox="0 0 32 32">
    <path
      d="M12 4c0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.209-1.791 4-4 4s-4-1.791-4-4zM24.719 16c0 0 0 0 0 0 0-1.812 1.469-3.281 3.281-3.281s3.281 1.469 3.281 3.281c0 0 0 0 0 0 0 1.812-1.469 3.281-3.281 3.281s-3.281-1.469-3.281-3.281zM21.513 24.485c0-1.641 1.331-2.972 2.972-2.972s2.972 1.331 2.972 2.972c0 1.641-1.331 2.972-2.972 2.972s-2.972-1.331-2.972-2.972zM13.308 28c0-1.487 1.205-2.692 2.692-2.692s2.692 1.205 2.692 2.692c0 1.487-1.205 2.692-2.692 2.692s-2.692-1.205-2.692-2.692zM5.077 24.485c0-1.346 1.092-2.438 2.438-2.438s2.438 1.092 2.438 2.438c0 1.346-1.092 2.438-2.438 2.438s-2.438-1.092-2.438-2.438zM1.792 16c0-1.22 0.989-2.208 2.208-2.208s2.208 0.989 2.208 2.208c0 1.22-0.989 2.208-2.208 2.208s-2.208-0.989-2.208-2.208zM5.515 7.515c0 0 0 0 0 0 0-1.105 0.895-2 2-2s2 0.895 2 2c0 0 0 0 0 0 0 1.105-0.895 2-2 2s-2-0.895-2-2zM28.108 7.515c0 2.001-1.622 3.623-3.623 3.623s-3.623-1.622-3.623-3.623c0-2.001 1.622-3.623 3.623-3.623s3.623 1.622 3.623 3.623z"
    />
  </symbol>

  <div class="w-full flex flex-col mt-10 text-center">
    <h1 class="text-4xl font-extrabold">Welcome to the Academy</h1>
    <h2 class="text-xl pb-10">Select the subjects you want to learn</h2>
    <div class="flex flex-wrap mx-4 overflow-hidden">

        <div class="my-4 px-4 w-1/3 overflow-hidden">
            <img src="https://via.placeholder.com/600x400.png?text=Mathematic" alt="">
        </div>
      
        <div class="my-4 px-4 w-1/3 overflow-hidden">
            <img src="https://via.placeholder.com/600x400.png?text=Science" alt="">
        </div>
      
        <div class="my-4 px-4 w-1/3 overflow-hidden">
            <img src="https://via.placeholder.com/600x400.png?text=Literacy" alt="">
        </div>
      
      </div>
  </div>
  
  <!-- <WalletAccess>
   
  </WalletAccess> -->
  
  