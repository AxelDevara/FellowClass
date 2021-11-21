import preprocess from 'svelte-preprocess';
const adapter = require('@sveltejs/adapter-static');

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://github.com/sveltejs/svelte-preprocess
	// for more information about preprocessors
	preprocess: [
		preprocess({
			postcss: true
		})
	],

	kit: {
		target: '#svelte',
		adapter: adapter({
			fallback: '200.html'
		})		
	}
};

export default config;