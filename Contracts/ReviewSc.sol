pragma solidity >=0.4.21 <0.6.0;
//import "./RegistrationSc.sol";
//import "./PaymentSc.sol";

contract Review {
    //Registration public r;
    uint public rating =0;
    uint r_id = 0;
   uint rid;
    struct reviewer {
        string _reviewerName;
        string _review;
        uint _rating;
        uint _bid;
        uint _did;
    }
    mapping(uint => reviewer) public reviewers;

 function setReview (string buyerName, uint bid, string review, uint rating, uint did) public returns (uint)
 {
      uint review_id = r_id++;
        reviewers[review_id]._reviewerName = buyerName ;
        reviewers[review_id]._review = review;
        reviewers[review_id]._rating = rating;
        reviewers[review_id]._bid = bid;
        reviewers[review_id]._did = bid;
        return review_id;
     
 }

/* 
function requestReview( uint did1) public returns (uint)
{
    //if(did)
    rid = setReview( , , , , did1);
     return  rid;
   // return (reviewers[review_id]._reviewerName, reviewers[review_id]._review, reviewers[review_id]._rating);
}
*/
//function reward()


function getReview(uint review_id) public returns (string, string, uint)
{
    return (reviewers[review_id]._reviewerName, reviewers[review_id]._review, reviewers[review_id]._rating);
}
//function reward()


function rewardclaim(address _receiver,uint amount) payable {
    //require(msg.value == amount);
    _receiver.call.value(msg.value).gas(20317)();
    
  }
    }
