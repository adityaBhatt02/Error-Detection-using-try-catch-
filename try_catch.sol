// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Foo {
  address owner;
  constructor(address _owner) {
    require(_owner != address(0) , "Invalid address!");
    assert(owner != 0x0000000000000000000000000000000000000001);
    owner = _owner;
  }

  function myFunc(uint x) public pure returns(string memory) {
    require(x != 0 , "Invalid number!");
    return "myFunc was called";
  }
}

contract Bar {
  event Log(string message);
  event LogBytes(bytes data);
  Foo public foo;

  constructor() {
    foo = new Foo(msg.sender);
  }
 // try-catch with external call ->
  function tryCatchExternalCall(uint x) public {
    try foo.myFunc(x) returns(string memory result) {
      emit Log(result);
    }catch {
      emit Log("external call falied!");
    }
  }
 // try-catch with contract creation ->
 function tryCatchNewContract(address _owner) public {
   try new Foo(_owner) returns(Foo foo) {
     emit Log("foo created");
   }catch Error(string memory reason){
     emit Log(reason);
   }catch (bytes memory reason) {
     emit LogBytes(reason);
   }
 }
}
