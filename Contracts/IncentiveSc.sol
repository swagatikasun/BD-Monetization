pragma solidity >=0.4.21 <0.6.0;
contract IncentiveSc {
    
  
function reward(address _receiver,uint amount) payable {
    //require(msg.value == amount);
    _receiver.call.value(msg.value).gas(20317)();
    
  }
  function penaltyclaim(address _receiver) payable {
    _receiver.call.value(msg.value).gas(20317)();
    msg.sender.transfer(address(this).balance);
  }

}
