const Koch = artifacts.require("Koch");
const truffleAssert = require('truffle-assertions');

contract("Koch",(accounts) => {
    it("should credit NFT to a specific account", async() => {
        const spacebearInstance = await Koch.deployed();
        let txResult = await spacebearInstance.safeMint(accounts[1],"spacebear_1.json");
 
        truffleAssert.eventEmitted(txResult, 'Transfer', {from: '0x0000000000000000000000000000000000000000', to: accounts[1], tokenId: web3.utils.toBN("0")});
 
        assert.equal(await spacebearInstance.ownerOf(0), accounts[1], "Owner of Token is the wrong address");
    })
})