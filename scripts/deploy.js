// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Fellow = await hre.ethers.getContractFactory("FellowNFT");
  const fellow = await Fellow.deploy();

  await fellow.deployed();

  // const gameContract = await hre.ethers.getContractFactory("GameContract");
  // const game = await gameContract.deploy("0xd9602f556E8dC2bdf0fB02cFcb7A81E1762A855F", fellow.address);

  // await game.deployed();

  // const marketplaceContract = await hre.ethers.getContractFactory("Marketplace");
  // const marketplace = await marketplaceContract.deploy(fellow.address, "0xd9602f556E8dC2bdf0fB02cFcb7A81E1762A855F");

  // await marketplace.deployed();

  console.log("Fellow deployed to:", fellow.address);
  // console.log("Game deployed to:", game.address);
  // console.log("Marketplace deployed to:", marketplace.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
