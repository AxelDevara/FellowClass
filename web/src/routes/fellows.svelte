<script lang="ts">
	//@ts-nocheck
	import { onMount } from 'svelte';
	import { combine } from '$lib/utils/combine';
  import ABI from "../abi/fellowBentoBox.json";


  async function mint() {
		stats = await Moralis.Web3API.native.runContractFunction({
			chain: 'kovan',
			address: '0x4a879Fd41EC08696985B79a4A01DFA4DC6DFEF90',
			function_name: 'mint',
			abi: ABI
		});
		console.log(stats);
	}  

	const options = {
		chain: 'kovan',
		address: '0xcbfe1B8dC5eD5a9f407D7671C3b511e7cc619340',
		token_address: '0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78'
	};
	let nfts = [];
	let choosenPhase = 0;
	function choose(phase) {
		choosenPhase = phase;
	}

	const phases = [
		'QmR4htzpe4Ks96vg5zhW1ijp8c2PghXBYnDqqM1xAQhb2m',
		'QmWKRKRACk6VZT7thPkZrrYWiqdZqik8JitcsNs1gRbM9P',
		'QmcAhLd7DVGpds4mmGRTe2cHXWTyw4xHveqPBmYq5NLPFX'
	];

	onMount(async () => {
		const res = await Moralis.Web3API.account.getNFTsForContract(options);
		nfts = res.result;

		console.log(nfts);
	});
</script>

<symbol id="icon-spinner6" viewBox="0 0 32 32">
	<path
		d="M12 4c0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.209-1.791 4-4 4s-4-1.791-4-4zM24.719 16c0 0 0 0 0 0 0-1.812 1.469-3.281 3.281-3.281s3.281 1.469 3.281 3.281c0 0 0 0 0 0 0 1.812-1.469 3.281-3.281 3.281s-3.281-1.469-3.281-3.281zM21.513 24.485c0-1.641 1.331-2.972 2.972-2.972s2.972 1.331 2.972 2.972c0 1.641-1.331 2.972-2.972 2.972s-2.972-1.331-2.972-2.972zM13.308 28c0-1.487 1.205-2.692 2.692-2.692s2.692 1.205 2.692 2.692c0 1.487-1.205 2.692-2.692 2.692s-2.692-1.205-2.692-2.692zM5.077 24.485c0-1.346 1.092-2.438 2.438-2.438s2.438 1.092 2.438 2.438c0 1.346-1.092 2.438-2.438 2.438s-2.438-1.092-2.438-2.438zM1.792 16c0-1.22 0.989-2.208 2.208-2.208s2.208 0.989 2.208 2.208c0 1.22-0.989 2.208-2.208 2.208s-2.208-0.989-2.208-2.208zM5.515 7.515c0 0 0 0 0 0 0-1.105 0.895-2 2-2s2 0.895 2 2c0 0 0 0 0 0 0 1.105-0.895 2-2 2s-2-0.895-2-2zM28.108 7.515c0 2.001-1.622 3.623-3.623 3.623s-3.623-1.622-3.623-3.623c0-2.001 1.622-3.623 3.623-3.623s3.623 1.622 3.623 3.623z"
	/>
</symbol>

<div class="w-full flex flex-col mt-10 text-center">
	<h1 class="text-4xl font-extrabold">Class of 2021</h1>
	<h2 class="text-xl pb-10">Semester 1</h2>
	<button on:click={()=> mint()} class="mx-auto bg-blue-500 text-white py-4 px-8 rounded"> Claim a Fellow </button>
</div>

<div class="grid grid-cols-3 gap-4 mt-10 text-center max-w-2xl mx-auto">
	<p class={choosenPhase == 0 ? 'border-4 cursor-pointer' : 'border-0 cursor-pointer'} on:click={() => choose(0)}>Baby</p>
	<p class={choosenPhase == 1 ? 'border-4 cursor-pointer' : 'border-0 cursor-pointer'} on:click={() => choose(1)}>Teen</p>
	<p class={choosenPhase == 2 ? 'border-4 cursor-pointer' : 'border-0 cursor-pointer'} on:click={() => choose(2)}>Adult</p>
</div>

<div class="grid grid-cols-3 gap-4 mt-10 max-w-2xl mx-auto">
	{#each Array(25) as _, i}
		<div>
			<img
				width="400"
				height="400"
				src={'https://ipfs.moralis.io:2053/ipfs/' +
					phases[choosenPhase] +
					'/' +
					(i + 1).toString() +
					'.png'}
				alt=""
			/>
		</div>
	{/each}
</div>

<div class="text-center text-lg mt-10 font-bold mb-5">Your Fellows</div>
<div class="grid grid-cols-3 gap-4 max-w-2xl mb-10 mx-auto">
	{#each nfts as n, i}
		<div>
			<img
				width="400"
				height="400"
				src={n.metadata != null ? JSON.parse(n.metadata).image : 'https://via.placeholder.com/400'}
				alt=""
			/>
			<p>{n.name + ' #' + n.token_id}</p>
		</div>
	{/each}
</div>

<!-- <WalletAccess>
   
  </WalletAccess> -->
