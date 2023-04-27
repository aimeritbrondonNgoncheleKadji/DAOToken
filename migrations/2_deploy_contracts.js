//const NKABToken = artifacts.require("GouvernanceToken");
const NKABGovernor = artifacts.require("NKABGovernor");


module.exports = async function (deployer) {


    // Déployez NKABToken
    await deployer.deploy(NKABGovernor);
    const nkabTokenInstance = await NKABToken.deployed();


};