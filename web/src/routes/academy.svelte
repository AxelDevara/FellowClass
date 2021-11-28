<script lang="ts">
	//@ts-nocheck
	import { onMount } from 'svelte';
	import ABI from '../abi/fellowGame.json';
  import FellowABI from '../abi/fellowABI.json';
	import ProgressBar from '@okrad/svelte-progressbar';

	const options = {
		chain: 'kovan',
		address: '0xcbfe1B8dC5eD5a9f407D7671C3b511e7cc619340',
		token_address: '0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78'
	};
	// function contractOption(props) {
	// 	return {
	// 		chain: 'kovan',
	// 		address: '0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78',
	// 		function_name: 'getLevel',
	// 		abi: ABI,
	// 		params: { _tokenId: props }
	// 	};
	// }

  let learning = false;
	let nfts = [];
	let stats;
	let chosenFellow = 0;

	function choose(tokenId) {
		chosenFellow = tokenId;
		getStats(tokenId);
		console.log(stats);
	}

  async function graduate(tokenId: int){
    await Moralis.enableWeb3();
		stats = await Moralis.executeFunction({
			contractAddress: '0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721',
			functionName: 'graduate',
			abi: ABI,
			params: { tokenId: _tokenId == 0 ? '0' : _tokenId, _fellow: '0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78' }
		});
		console.log(stats);
  }

	async function getStats(tokenId: int) {
		stats = await Moralis.Web3API.native.runContractFunction({
			chain: 'kovan',
			address: '0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78',
			function_name: 'getLevel',
			abi: FellowABI,
			params: { _tokenId: tokenId == 0 ? '0' : tokenId }
		});
		console.log(stats);
	}

  async function learnStrength(_tokenId: int) {
    learning = true;
    await Moralis.enableWeb3();
    // console.log(Moralis.cu)
		stats = await Moralis.executeFunction({
			contractAddress: '0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721',
			functionName: 'learnStrength',
			abi: ABI,
			params: { tokenId: _tokenId == 0 ? '0' : _tokenId, _fellow: '0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78' }
		});
		console.log(stats);
    learning = false;
	}

  async function learnMath(_tokenId: int) {
    learning = true;
    await Moralis.enableWeb3();
		stats = await Moralis.executeFunction({
			contractAddress: '0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721',
			functionName: 'learnMath',
			abi: ABI,
			params: { tokenId: _tokenId == 0 ? '0' : _tokenId }
		});
		console.log(stats);
    learning = false;
	}

  async function learnScience(_tokenId: int) {
    learning = true;
    await Moralis.enableWeb3();
		stats = await Moralis.executeFunction({
			contractAddress: '0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721',
			functionName: 'learnScience',
			abi: ABI,
			params: { tokenId: _tokenId == 0 ? '0' : _tokenId }
		});
		console.log(stats);
    learning = false;
	}

  async function learnLiteracy(_tokenId: int) {
    learning = true;
    await Moralis.enableWeb3();
		stats = await Moralis.executeFunction({
			contractAddress: '0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721',
			functionName: 'learnLiteracy',
			abi: ABI,
			params: { tokenId: _tokenId == 0 ? '0' : _tokenId }
		});
		console.log(stats);
    learning = false;
	}

  async function learnWisdom(_tokenId: int) {
    learning = true;
    await Moralis.enableWeb3();
		stats = await Moralis.executeFunction({
			contractAddress: '0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721',
			functionName: 'learnWisdom',
			abi: ABI,
			params: { tokenId: _tokenId == 0 ? '0' : _tokenId }
		});
		console.log(stats);
    learning = false;
	}

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
	<h1 class="text-4xl font-extrabold">Welcome to the Academy</h1>
	<div class="text-center text-lg mt-10 font-bold mb-5">Select a Fellow</div>
	<div class="grid grid-cols-3 gap-4 max-w-2xl mb-10 mx-auto">
		{#each nfts as n, i}
			<div class={chosenFellow == i ? 'border-4 cursor-pointer' : 'border-0 cursor-pointer'}>
				<img
        
					on:click={() => choose(i)}
					width="400"
					height="400"
					src={n.metadata != null
						? JSON.parse(n.metadata).image
						: 'https://via.placeholder.com/400'}
					alt=""
				/>
				<p>{n.name + ' #' + n.token_id}</p>
			</div>
		{/each}
	</div>

	{#if stats}
		<div class="max-w-2xl text-lg bg-gray border-4 p-8 mb-10 flex mx-auto">
			<div class="flex flex-col">
				<p>Level</p>
				<ProgressBar
					style="semicircle"
					series={[stats[0]]}
					thickness={10}
					thresholds={[
						{
							till: 50, //Color stays red from 0% to 50%
							color: '#0099ff'
						},
						{
							till: 100, //Color goes green from 51% to 100%
							color: '#008000'
						}
					]}
				/>
			</div>
			<div class="flex flex-col">
				<p>Strength</p>
				<ProgressBar
					style="semicircle"
					series={[stats[1]]}
					thickness={10}
					thresholds={[
						{
							till: 50, //Color stays red from 0% to 50%
							color: '#0099ff'
						},
						{
							till: 100, //Color goes green from 51% to 100%
							color: '#008000'
						}
					]}
				/>
			</div>
			<div class="flex flex-col">
				<p>Math</p>
				<ProgressBar
					style="semicircle"
					series={[stats[2]]}
					thickness={10}
					thresholds={[
						{
							till: 50, //Color stays red from 0% to 50%
							color: '#0099ff'
						},
						{
							till: 100, //Color goes green from 51% to 100%
							color: '#008000'
						}
					]}
				/>
			</div>
			<div class="flex flex-col">
				<p>Literacy</p>
				<ProgressBar
					style="semicircle"
					series={[stats[3]]}
					thickness={10}
					thresholds={[
						{
							till: 50, //Color stays red from 0% to 50%
							color: '#0099ff'
						},
						{
							till: 100, //Color goes green from 51% to 100%
							color: '#008000'
						}
					]}
				/>
			</div>
			<div class="flex flex-col">
				<p>Wisdom</p>
				<ProgressBar
					style="semicircle"
					series={[stats[4]]}
					thickness={10}
					thresholds={[
						{
							till: 50, //Color stays red from 0% to 50%
							color: '#0099ff'
						},
						{
							till: 100, //Color goes green from 51% to 100%
							color: '#008000'
						}
					]}
				/>
			</div>
		</div>
	{/if}

	<h2 class="text-xl pb-10">Select the subjects you want to learn</h2>
  {#if !learning}
	<div class="flex cursor-pointer flex-wrap mx-4 overflow-hidden">
		<div class="my-4 px-4 w-1/3 overflow-hidden">
			<img on:click={() => learnStrength(chosenFellow)} src="/images/Sports.png" alt="" />
		</div>

		<div class="my-4 px-4 cursor-pointer w-1/3 overflow-hidden">
			<img on:click={() => learnScience(chosenFellow)} src="/images/Science.png" alt="" />
		</div>

		<div class="my-4 px-4 cursor-pointer w-1/3 overflow-hidden">
			<img on:click={() => learnMath(chosenFellow)} src="/images/Math.png" alt="" />
		</div>

		<div class="my-4 px-4 cursor-pointer w-1/3 overflow-hidden">
			<img on:click={() => learnLiteracy(chosenFellow)} src="/images/Literacy.png" alt="" />
		</div>

		<div class="my-4 px-4 cursor-pointer w-1/3 overflow-hidden">
			<img on:click={() => learnWisdom(chosenFellow)} src="/images/Wisdom.png" alt="" />
		</div>
	</div>
  {:else}
  <h1 class="mx-auto text-center text-4xl font-bold">Please wait, Fellow is learning :)</h1>
  {/if}
</div>

<img src="/grad.png" width="500" class="cursor-pointer mx-auto my-20" alt="graduate" on:click={() => graduate(chosenFellow)}>

<!-- <WalletAccess>
   
  </WalletAccess> -->
