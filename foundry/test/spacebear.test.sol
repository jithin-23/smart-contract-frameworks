pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/Spacebear.sol";

contract SpacebearTest is Test {

    SpaceBear spacebear;

    function setUp() public {
        spacebear = new SpaceBear();
    }

    function testNameIsSpaceBear() public view{
        assertEq(spacebear.name(),"SpaceBear");
    }

    function testMintNFTs() public {
        spacebear.safeMint(msg.sender,"spacebear_1.json");
        assertEq(spacebear.ownerOf(0),msg.sender);
        assertEq(spacebear.tokenURI(0),"https://jithin-23.github.io/nft-project/spacebear_1.json");
    }

    function testMintNFTWrongOwner() public {
        address purchaser = address(0x1);
        vm.startPrank(purchaser);
        vm.expectRevert("OwnableUnauthorizedAccount(0x0000000000000000000000000000000000000001)");
        spacebear.safeMint(purchaser,"spacebear_1.json");
        vm.stopPrank();
    }

    // function testNFTButToken() public {
    //     address purchaser = address(0x2);
    //     vm.prank(purchaser);
    //     spacebear.buyToken();
    //     assertEq(spacebear.ownerOf(0), purchaser);
    // }
}