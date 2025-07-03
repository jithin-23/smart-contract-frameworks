const {expect} = require("chai");
const hre = require("hardhat");
const {loadFixture} = require("@nomicfoundation/hardhat-network-helpers");

describe("SpaceBear", function() {

    async function deploySpacebearAndMintTokenFixture() {
        const SpaceBear = await hre.ethers.getContractFactory("SpaceBear");
        const spaceBearInstance = await SpaceBear.deploy();
        const [owner, otherAccount] = await ethers.getSigners();
        await spaceBearInstance.safeMint(otherAccount.address, `spacebear_1.json`);
        return {spaceBearInstance};
    }

    it("is possible to mint a token", async() => {
        const {spaceBearInstance} = await loadFixture(deploySpacebearAndMintTokenFixture);
        const [owner, otherAccount] = await ethers.getSigners();
        expect(await spaceBearInstance.ownerOf(0)).to.equal(otherAccount.address);
    }),

    it("fails to transfer tokens from the wrong address", async() => {
        const {spaceBearInstance} = await loadFixture(deploySpacebearAndMintTokenFixture);
        const [owner, otherAccount, notTheNFTOwner] = await ethers.getSigners();
        expect(await spaceBearInstance.ownerOf(0)).to.equal(otherAccount.address);
        await expect(spaceBearInstance.connect(notTheNFTOwner).transferFrom(notTheNFTOwner.address,otherAccount.address,0),).to.be.revertedWithCustomError(spaceBearInstance, "ERC721InsufficientApproval",).withArgs(notTheNFTOwner.address, 0);
    })
})