  pragma solidity >=0.4.21 <0.6.0;
 import "./RegistrationSc.sol";
 import "./Token.sol";
 contract TransferOwnership is Registration, Token
 {
     Registration public r1;
     Token public r2;
      constructor(Registration addr,Token addr1) public {
        r1 = addr;
        r2 = addr1;
    }
     string ciphertext;
    string data_id;
  struct track_data {
        uint _previous_owner_id;
        string _previous_owner_name;
        uint _data_id;
        uint _token_id;
        uint _owner_id;
        string _owner_name;
        uint _timeStamp;
        string _owner_type;
    }
    mapping(uint => track_data) public tracks;
 
 function transfer(uint user1, uint user2, uint[] dataid, uint[] tokenid) public returns(uint,uint)
 {
     uint tokenidew = r2.createto(user1,dataid,tokenid);
      uint transfer_id = _t_id;
        uint token1_id=1;
        uint i=1;
     
        User  p1 =  Users[user1];
        User  p2 = Users[user2];
        if((keccak256(p1._userType) == keccak256("Owner") && keccak256(p2._userType)==keccak256("CurrentOwner")) ||
        (keccak256(p1._userType) == keccak256("CurrentOwner") && keccak256(p2._userType)==keccak256("CurrentOwner"))
        ){
            //tracks[transfer_id]._data_id =data_id[i];
            tracks[transfer_id]._token_id =tokenidew;
            tracks[transfer_id]._owner_id = user2;
            //tracks[transfer_id]._owner_name=Users[user2_id]._userName;
            tracks[transfer_id]._timeStamp = now;
            tracks[transfer_id]._previous_owner_id = user1;
            //tracks[transfer_id]._previous_owner_name=Users[user1_id[i]]._userName;
            datas[dataid[i]]._owner_id = user2;
            datas[dataid[i]].trace_ids.push(transfer_id);
            datas[dataid[i]]._owner_ids.push(user2);
            transfer_id = _t_id++;
            token1_id = token1_id+1;
            return (transfer_id,token1_id);
        }
        else{
            return (0,0);
        }
    }

  

    function getdata_tracking_ids(uint data_id)  public  returns (uint [] memory) 
    {
       
        //product memory p = products[p_id];
        return datas[data_id].trace_ids;
    }
   
    function getdata_trackindes(uint t_id)  public  returns (uint,string,uint,string,uint) {
        
         return (tracks[t_id]._previous_owner_id,tracks[t_id]._previous_owner_name,tracks[t_id]._owner_id,tracks[t_id]._owner_name,tracks[t_id]._timeStamp);
    }
   
  
   function get_datahash(uint did) public returns (string)
   {
       datas[did]._data_hash;
   }
    
    function getDataCipher() public view returns(string memory) {
        return ciphertext;
    }
   
    
    function setCypherData(string memory mciphertext) public {
        ciphertext = mciphertext;
    }
   
}
