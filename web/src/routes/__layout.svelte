<script lang="ts">
  import "../app.css";
  import "../global.css";
  import '../service-worker-handler';
  import {url} from '$lib/utils/url';
  import NavBar from '$lib/components/navigation/NavBar.svelte';
  import Blockie from '$lib/components/Blockie.svelte';
  import Notifications from '$lib/components/notification/Notifications.svelte';
  // import Install from './components/Install.svelte';
  import DarkSwitch from '$lib/components/DarkSwitch.svelte';

  import {appDescription, url as appUrl} from '../application.json';

  const title = 'Fellow Class';
  const description = appDescription;
  const host = appUrl.endsWith('/') ? appUrl : appUrl + '/';
  const previewImage = host + 'preview.png';
</script>

<svelte:head>
  <title>{title}</title>
  <meta name="title" content="{title}">
  <meta name="description" content="{description}">
  <meta property="og:type" content="website">
  <meta property="og:url" content="{host}">
  <meta property="og:title" content="{title}">
  <meta property="og:description" content="{description}">
  <meta property="og:image" content="{previewImage}">
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content="{host}">
  <meta property="twitter:title" content="{title}">
  <meta property="twitter:description" content="{description}">
  <meta property="twitter:image" content="{previewImage}">
</svelte:head>

<NavBar
  links={[
    {href: url(''), title: 'Home'},
    {href: url('fellows/'), title: 'Fellows'},
    {href: url('academy/'), title: 'Academy'},
    {href: url('trade/'), title: 'Trade'}
  ]}
><div class="flex-grow"></div><div class="flex flex-row"><Blockie address="093239aE0212993219"></Blockie><p>Wallet Address</p></div></NavBar>


<slot />
<Notifications />