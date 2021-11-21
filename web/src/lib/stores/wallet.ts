
import Moralis from 'moralis/dist/moralis.min.js';
import {writable} from 'svelte/store';

const serverUrl = "https://y06sjd7bhdda.usemoralis.com:2053/server";
const appId = "ulPGn49LzEFO2XgofKG8pVihfNzUigu40sSmFVcc";
Moralis.start({ serverUrl, appId });

export let web3;

export async function login() {
  let user = Moralis.User.current();
  if (!user) {
    user = await Moralis.authenticate();
  }
  web3 = await Moralis.enableWeb3();
  console.log("logged in user:", user);
}
export async function logOut() {
  await Moralis.User.logOut();
  console.log("logged out");
}

export const walletStores = writable(Moralis.User.current());

