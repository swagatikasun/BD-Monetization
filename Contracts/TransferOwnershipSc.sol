 pragma solidity >=0.4.21 <0.6.0;
 
import "github.com/provable-things/ethereum-api/provableAPI.sol";
 import "./RegistrationSc.sol";
 import "./Token.sol";
 contract TransferOwnership is Registration, Tokenis, usingProvable
 {
     Registration public r1;
     Token public r2;
      constructor(Registration addr,Token addr1) public {
        r1 = addr;
        r2 = addr1;
        update();
        //calculateResult = 0;
    }
     //uint public dieselPriceUSD;

    event LogNewalice(string result);
    event LogNewProvableQuery(string description);

    

    function __callback(
        bytes32 _myid,
       string memory _result,
        bytes memory _proof
    )
        public
    {
        require(msg.sender == provable_cbAddress());
      emit LogNewalice(_result);
      
    }

    function update()
        public
        payable
    {
        emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
        provable_query("URL", "json(http://ec2-13-232-39-95.ap-south-1.compute.amazonaws.com:5000/alice).result");
    }
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
 
 
 function transferOwnership_data(uint[] user1_id ,uint user2_id, uint[] data_id,uint[] token_id)  public returns(uint,uint) {
     uint tokenide = r2.createToken(user1_id, data_id,token_id);
     
    
        //require(msg.sender == products[prod_id]._product_owner);
       
        //track_product  trk;
        uint transfer_id = _t_id;
        uint token1_id=1;
        //event test_value(uint256 indexed value1);
        //test_value(p1._userType);
        for(uint i=0;i<user1_id.length;i++)
        {
        User  p1 =  Users[user1_id[i]];
        User  p2 = Users[user2_id];
        if((keccak256(p1._userType) == keccak256("Owner") && keccak256(p2._userType)==keccak256("CurrentOwner")) ||
        (keccak256(p1._userType) == keccak256("CurrentOwner") && keccak256(p2._userType)==keccak256("CurrentOwner"))
        ){
            //tracks[transfer_id]._data_id =data_id[i];
            tracks[transfer_id]._token_id =tokenide;
            tracks[transfer_id]._owner_id = user2_id;
            //tracks[transfer_id]._owner_name=Users[user2_id]._userName;
            tracks[transfer_id]._timeStamp = now;
            tracks[transfer_id]._previous_owner_id = user1_id[i];
            //tracks[transfer_id]._previous_owner_name=Users[user1_id[i]]._userName;
            datas[data_id[i]]._owner_id = user2_id;
            datas[data_id[i]].trace_ids.push(transfer_id);
            datas[data_id[i]]._owner_ids.push(user2_id);
            transfer_id = _t_id++;
            token1_id = token1_id+1;
            return (transfer_id,token1_id);
        }
        else{
            return (0,0);
        }
    }
 }
   /* function getProduct_track(uint prod_id)  public  returns (track_product[]) {
       
        uint track_len = tracks[prod_id].length;
       string[] memory trcks = new string[](track_len);
       for(uint i=0;i<track_len;i++){
           track_product t = tracks[prod_id][i];
           
           trcks.push(t._product_id+""+t._owner_id+""+t._product_owner+""+t._timeStamp);
       }
       // track_product tk =tracks[prod_id];
         return trcks;
    }*/
    

    function getdata_tracking_ids(uint data_id)  public  returns (uint [] memory) {
       
        //product memory p = products[p_id];
        return datas[data_id].trace_ids;
    }
   
    function getdata_trackindes(uint t_id)  public  returns (uint,string,uint,string,uint) {
        //track_product memory t = tracks[t_id];
        //p.trace_ids;
         return (tracks[t_id]._previous_owner_id,tracks[t_id]._previous_owner_name,tracks[t_id]._owner_id,tracks[t_id]._owner_name,tracks[t_id]._timeStamp);
    }
   
   /* function getProduct_chainLength(uint prod_id) public returns (uint) {
        return tracks.length();
    }*/
   
    
   
}
