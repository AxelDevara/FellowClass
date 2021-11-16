
import Moralis from 'moralis/dist/moralis.min.js';
import {writable} from 'svelte/store';

const serverUrl = "https://xxxxx/server";
const appId = "YOUR_APP_ID";
Moralis.start({ serverUrl, appId });

export async function login() {
  let user = Moralis.User.current();
  if (!user) {
    user = await Moralis.authenticate();
  }
  console.log("logged in user:", user);
}
export async function logOut() {
  await Moralis.User.logOut();
  console.log("logged out");
}

export const walletStores = writable(Moralis.User.current());


