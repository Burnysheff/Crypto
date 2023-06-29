// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Inter {
    address adr = address(0x536919113679F9A6e184C61469657B7d03C53134);

    uint public result;
    bool public code;

    function callExternal() public {
        (bool success, bytes memory returnData) = adr.call{gas: 
100000}(abi.encodeWithSignature("random()"));
        code = success;
        if (success) {
            result = bytesToUint(returnData);
        }
    }

    function bytesToUint(bytes memory b) internal pure returns (uint256) {
        uint256 number;
        for(uint i = 0;i<b.length;i++){
            number = number + uint(uint8(b[i]))*(2**(8*(b.length-(i+1))));
        }
        return number;
    }
}
