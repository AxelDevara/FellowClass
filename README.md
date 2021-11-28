## Fellow Class
Feel free to fork this project. Head to web folder to follow the start procedure.

## Kovan Deployments
FellowNFT Smart Contract: 0xBEf4d4dB1f857F16d7633FCb74F19F9d8A2c3a78 \
FellowBentoBox Smart Contract: 0x4a879Fd41EC08696985B79a4A01DFA4DC6DFEF90 \
GameContract: 0x4ae57700766b955bAa03bD455cdd3BDCB3Cd7721 

Make sure the LINK token is sufficient for gas. I have put about 4 LINKs on FellowNFT & GameContract I hope it's enough for you guys to try :)

## Inspiration
We have experience in contributing to charity activities. Axel is a donor to various orphanages in Indonesia while Eloise was a contributor to an Ecological Conservation group in South East Asia. We feel that there is the root of most problems is education inequality. Where you are born and to whom you were born has a domino effect on how you are educated and how you will contribute back to society. For example, even in a rich country like US, the probability of children born in the bottom fifth of income distribution reaching the top fifth is only around 7.2%. These numbers are due to many factors such as the quality of schools in poor states, low number of opportunities, and high crime rates. Could you imagine how worse it is in third-world countries?

We hope to bring educational opportunities to these children who have what it takes to survive outside of their society through managed crowdfund. We hope that Fellow class can sustainably fund thousands of children's education costs and provide them equal opportunities with those that are born privileged.

Fellow Class is highly inspired by the Wildcard conservation project. The idea to gamify a charity activity through NFT is something that would attract the attention of potential donors. For this project, we are aiming to create a similar experience for Children's education donation.

## What it does
Fellow Class is a collectible NFT which quantity will be based on real children that apply for each session. For example, in the spring season, if we plan to bring the educational fund to 100 children then there will be 100 Fellow NFTs.

Each fellow starts as a blue baby avatar that can be educated with various subjects and is able to graduate and grow into an adult fellow. Later on, we plan to add multiple games and functionalities to these fellows.

Every activity done with a fellow requires an AMPL token as a fee. These fees are then automatically wrapped and staked to earn more yields along the time.

## How we built it
The smart contract was built mostly using Openzeppelin abstract contracts to ensure maximum security. The smart contracts are split into 3 main parts:
 1.  The vault(FellowBentoBox.sol)
 2. The nft(FellowNFT.sol)
 3. The game(GameContract.sol)
 ~~ 4. Marketplace Contract not finished ~~

Every number generated for each fellow's traits are randomly generated using Chainlink VRF and modulated into 1 length integer for fairly random generation. The higher the number, the faster a fellow can grow. This is possible because we are storing everything including the tokenURI changes on-chain. 

Every fee is collected in AMPLs which are stored in the vault and automatically wrapped to store in Sushiswap's bento box since rebasing token is not supported. We plan to include more treasury assets to diversify risks and maximize yield.

Lastly, for the dApp, we use Moralis to deploy/interact with our smart contract and query IPFS metadata fast through their IPFS gateway.

## Challenges we ran into
We faced some bugs upon implementing Moralis as there are some issues with their metadata indexing. Luckily, it's not serious therefore we could continue on with the development. Although, we had to abandon some ideas such as the trading/marketplace platform as it takes too much time to build. Had there was enough time, we wanted to experiment with AMPL rebasing floor price idea. 

## Accomplishments that we're proud of
We are proud to be able to show what we have created on this hackathon. Although Axel & Eloise had only met on the hackathon, their teamwork is unmatched :D . We are glad to meet each other sharing big ideas and actually make it happen. we hope to continue on post-hackathon.

## What we learned
Honestly, we learned a lot that we can't count. As Eloise's first hackathon, the whole experience was a memorable experience for her. As For Axel, it was a good path for him to learn deeper and deeper into blockchain development. We hope to be able to contribute to big projects later on.

## What's next for Fellow Class
Although it's sad to abandon some ideas, we can always do it after the hackathon. We hope still have the burning spirit to keep learning and doing what is good for society.
