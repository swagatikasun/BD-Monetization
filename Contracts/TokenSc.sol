pragma solidity >=0.4.21 <0.6.0;
//import "./TransferOwnershipSc.sol";
contract Token  {
    uint public lookup_id=0;
    uint public _d_id =0;
    uint public _u_id =0;
    uint public _token_id =1;
    uint public _t_id=1;
    uint public tokenidd=0;
    
    struct token1 {
        string username;
        uint[] userid;
        address owner1;
        uint [] _data_ids;
        uint [] _token_ids;
    }
 
   mapping(uint => token1) public tokens;
 
      function createToken(uint[]  userid, uint [] _data_ids ,uint [] _token_ids) public returns (uint){
       // uint user_id = _u_id;
       // tokens[user_id].username = username ;
       for(uint u=0;u<userid.length;u++)
       {
        tokens[u].userid.push(userid[u]);
       }
        for(uint i=0;i<_data_ids.length;i++){
            tokens[i]._data_ids.push(_data_ids[i]);
        }
        for(uint j=0;j<_token_ids.length;j++){
            tokens[j]._token_ids.push(_token_ids[j]);
        }

        _token_id++;
        return _token_id;
    }
 
    function getsplit(uint token2_id)public view returns(uint [], uint []){
        return (tokens[token2_id]._data_ids, tokens[token2_id]._token_ids);
    }
    }
