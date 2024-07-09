// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol"; // solhint-disable-line
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

import {Megamis} from "../src/Megamis.sol";

contract DeployV1 is Script {
    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.envAddress("DEPLOYER");
        uint256 coppies = vm.envUint("NUMBER_OF_COPPIES");
        string memory name = vm.envString("CONTRACT_NAME");
        string memory symbol = vm.envString("CONTRACT_SYMBOL");

        vm.startBroadcast(privateKey);
        
        for(uint256 i = 0; i < coppies; i++) {
            Upgrades.deployTransparentProxy(
                "Megamis.sol",
                deployer,
                abi.encodeCall(Megamis.initialize, (deployer,string.concat(name, vm.toString(i)),string.concat(symbol,vm.toString(i))))
            );
        }

        vm.stopBroadcast();
    }
}