// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

import "Paper_scissors_stone.sol";
import "Connector.sol";

import "@openzeppelin/contracts/utils/Strings.sol";

contract testSuite {
    address game = address(0x536919113679F9A6e184C61469657B7d03C53134);
    address connector = 
address(0xB2A5E32Bb823ae18cdE80021C34d5D2d960461C9);

    
    function beforeAll() public {
        Assert.equal(uint(1), uint(1), "1 should be equal to 1");
    }

    function checkSuccess() public {
        (bool success, bytes memory returnData) = connector.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        Assert.equal(true, success, "Not connected");
    }

    function checkSuccessConnection() public {
        (bool success, bytes memory returnData) = connector.call{gas: 
100000}(abi.encodeWithSignature("callExternal()"));
        Assert.equal(true, success, "Not connected");
    }

    function checkMoreZero() public {
        (bool success, bytes memory returnData) = connector.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        Assert.equal("", string(returnData), "Not found method");
    }


    function checkSuccessGame() public {
        (bool success, bytes memory returnData) = game.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        Assert.equal(true, success, "Not connected");
    }

    function checkMoreZeroGame() public {
        (bool success, bytes memory returnData) = game.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        Assert.equal("", string(returnData), "Not found method");
    }

    function checkLessThreeGame() public {
        (bool success, bytes memory returnData) = game.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        Assert.equal(true, bytesToUint(returnData) < 3, "Not connected");
    }

    function checkToUint() public {
        (bool success, bytes memory returnData) = game.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        (bool scs, bytes memory dt) = connector.call{gas: 
100000}(abi.encodeWithSignature("bytesToUint(bytes memory b)", 
returnData));
        Assert.equal(bytesToUint(dt), bytesToUint(returnData), "Not 
connected");
    }

    function bytesToUint(bytes memory b) internal pure returns (uint256) {
        uint256 number;
        for(uint i = 0;i<b.length;i++){
            number = number + uint(uint8(b[i]))*(2**(8*(b.length-(i+1))));
        }
        return number;
    }
}

