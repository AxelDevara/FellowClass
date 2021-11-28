<script lang="ts">
	//@ts-nocheck
	import '../app.css';
	import '../global.css';
	import '../service-worker-handler';
	import { url } from '$lib/utils/url';
	import { walletStores } from '$lib/stores/wallet';
	import NavBar from '$lib/components/navigation/NavBar.svelte';
	import Blockie from '$lib/components/Blockie.svelte';
	import Notifications from '$lib/components/notification/Notifications.svelte';
	// import Install from './components/Install.svelte';
	import DarkSwitch from '$lib/components/DarkSwitch.svelte';

	import { appDescription, url as appUrl } from '../application.json';
	import { onMount } from 'svelte';

	const title = 'Fellow Class';
	const description = appDescription;
	const host = appUrl.endsWith('/') ? appUrl : appUrl + '/';
	const previewImage = host + 'preview.png';

	const serverUrl = 'https://y06sjd7bhdda.usemoralis.com:2053/server';
	const appId = 'ulPGn49LzEFO2XgofKG8pVihfNzUigu40sSmFVcc';

	async function login() {
		let user = Moralis.User.current();
    console.log(user);
		if (!user) {
      console.log("trying");
			user = await Moralis.authenticate({ signingMessage: 'Log in using Moralis' })
				.then(function (user) {
					console.log('logged in user:', user);
					console.log(user.get('ethAddress'));
          walletStores.set(user);
				})
				.catch(function (error) {
					console.log(error);
				});
		}
	}
	async function logOut() {
		await Moralis.User.logOut();
		console.log('logged out');
	}

	onMount(() => {
		//@ts-ignore
		Moralis.start({ serverUrl, appId });
    walletStores.set(Moralis.User.current());
	});
</script>

<svelte:head>
	<title>{title}</title>
	<meta name="title" content={title} />
	<meta name="description" content={description} />
	<meta property="og:type" content="website" />
	<meta property="og:url" content={host} />
	<meta property="og:title" content={title} />
	<meta property="og:description" content={description} />
	<meta property="og:image" content={previewImage} />
	<meta property="twitter:card" content="summary_large_image" />
	<meta property="twitter:url" content={host} />
	<meta property="twitter:title" content={title} />
	<meta property="twitter:description" content={description} />
	<meta property="twitter:image" content={previewImage} />
</svelte:head>

<NavBar
	links={[
		{ href: url(''), title: 'Home' },
		{ href: url('fellows/'), title: 'Fellows' },
		{ href: url('academy/'), title: 'Academy' },
		{ href: url('trade/'), title: 'Trade' }
	]}
>
	<div class="flex-grow" />
	<div class="flex flex-row">
		{#if $walletStores != null}
			<div class="flex flex-row bg-gray-100 mb-2 px-5 py-2 rounded">
        <Blockie address={$walletStores.attributes.ethAddress} />
			<p class="ml-3" on:click={logOut}>Disconnect</p>
      </div>
		{:else}
			<button on:click={login}>Login</button>
		{/if}
	</div>
</NavBar>

<slot />
<Notifications />
