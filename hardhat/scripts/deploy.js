(async () => {
    try {
        const Spacebear = await hre.ethers.getContractFactory("SpaceBear");
        const spaceBearInstance = await Spacebear.deploy();
        console.log(
            `Deploy contract at ${await spaceBearInstance.getAddress()}`
        );
    } catch (error) {
        console.error(error);
        process.exitCode = 1;
    }
})();
