const Spacebear = artifacts.require("Koch");

module.exports = function(deployer, network, accounts) {
    console.log(network, accounts);
    deployer.deploy(Spacebear);
}