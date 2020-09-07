pragma solidity >=0.4.21 <0.6.0;

contract Registration {
    uint public lookup_id=0;
    uint public _d_id =0;
    uint public _u_id =0;
    uint public _t_id=1;

    
  
   
    struct data {
        string _data_name;
        uint _data_cost;
        string _data_specs;
        string _data_hash;
        uint _owner_id;
        uint _manufacture_date;
        address _data_owner_address;
        uint [] _owner_ids;
        uint [] trace_ids;
     
    }
   
    mapping(uint => data) public datas;
    
   
    struct User {
        string _userName;
        string _passWord;
        address _address;
        string _userType;
        //uint rating =0;
    }
    mapping(uint => User) public Users;
   
    function createUser(string name ,string pass ,address u_add ,string utype) returns (uint){
        uint user_id = _u_id++;
        Users[user_id]._userName = name ;
        Users[user_id]._passWord = pass;
        Users[user_id]._address = u_add;
        Users[user_id]._userType = utype;
        return user_id;
    }
   
    struct lookup{
        uint b_id;
        uint d_id;
        uint o_id;
        //string smartcontract_name;
        //address datachain_address;
        bytes32 interactionId;
        uint _timeStamp;
        uint flag;
        }
       
    mapping(uint => lookup) public lookups;
    
    struct verifylookup{
        uint d_id;
        uint b_id;
        uint selected_id;
        uint lookup_Id;
    }

    mapping(uint => verifylookup) public verifylookups;

   
    function newData(uint own_id, string name ,uint d_cost ,string d_specs ,string d_hash) returns (uint) {
        if(keccak256(Users[own_id]._userType) == keccak256("Owner") || keccak256(Users[own_id]._userType) == keccak256("CurrentOwner")) {
            uint data_id = _d_id++;
            datas[data_id]._data_name = name;
            datas[data_id]._data_cost = d_cost;
            datas[data_id]._data_specs =d_specs;
            datas[data_id]._data_hash =d_hash;
            datas[data_id]._owner_id = own_id;
            datas[data_id]._data_owner_address=Users[own_id]._address;
            datas[data_id]._manufacture_date = now;
            datas[data_id]._owner_ids.push(own_id);
            return data_id;
        }
       
       return 0;
    }
    function getUser(uint User_id) public view returns (string,address,string) {
        return (Users[User_id]._userName,Users[User_id]._address,Users[User_id]._userType);
    }
    function get_Data_details(uint Data_id) public view returns (string,uint,string,string,uint,uint){
        return (datas[Data_id]._data_name,datas[Data_id]._data_cost,datas[Data_id]._data_specs,datas[Data_id]._data_hash,datas[Data_id]._owner_id,datas[Data_id]._manufacture_date);
    }
    function get_details() public view returns (uint,uint,uint)
    {
        return(_d_id,_u_id,_t_id);
    }
    function get_lookupdetails() public view returns (uint)
    {
        return(lookup_id);
    }
    /*
    modifier onlyOwner(uint user1_id,uint pid) {
         if(Users[user1_id]._address != Users[products[pid]._owner_id]._address ) throw;
         _;
       
     }*/
    modifier onlyOwner(uint did) {
         if(msg.sender != datas[did]._data_owner_address) throw;
        _;
         
     }
   
function get_data_owners(uint data_id) public returns (uint[] memory){
        return datas[data_id]._owner_ids;
    }
    function userLogin(uint uid ,string uname ,string pass ,string utype) public returns (bool){
        if(keccak256(Users[uid]._userType) == keccak256(utype)) {
            if(keccak256(Users[uid]._userName) == keccak256(uname)) {
                if(keccak256(Users[uid]._passWord)==keccak256(pass)) {
                    return (true);
                }
            }
        }
       
        return (false);
    }

    function get_hash(uint lookup_id) public view returns(bytes32){
        return lookups[lookup_id].interactionId;
    }
  
    function concatenateInfoAndHash(string memory s1,bytes memory s2,string memory s3,bytes memory s4) public returns (bytes32){
        //First, get all values as bytes
        bytes memory b_a1 = bytes(s1);
        bytes memory b_s1 = bytes(s2);
                bytes memory b_s2 = bytes(s3);

        //bytes20 b_s2 = bytes20(s3);
        bytes memory b_s3 = bytes(s4);

        /*
        bytes32 b = bytes32(_buyer_id);
        bytes memory b_s1 = new bytes(32);
        for (uint iii=0; iii < 32; iii++) {
        b_s1[iii] = b[iii];
        }
        bytes memory b_s2 = bytes(datas[dataid]._data_hash);
        bytes32 bb = bytes32(selectedOwnerid);
        bytes memory b_s3 = new bytes(32);
        for (uint ii=0; ii < 32; ii++) {
        b_s3[ii] = bb[ii];
        }
        */
        //Then calculate and reserve a space for the full string
        string memory s_full = new string(b_a1.length + b_s1.length + b_s2.length + b_s3.length);
        bytes memory b_full = bytes(s_full);
        uint j = 0;
        uint i;
        for(i = 0; i  < b_a1.length; i++){
            b_full[j++] = b_a1[i];
        }
        for(i = 0; i < b_s1.length; i++){
            b_full[j++] = b_s1[i];
        }
        for(i = 0; i < b_s2.length; i++){
            b_full[j++] = b_s2[i];
        }
        for(i = 0; i < b_s3.length; i++){
            b_full[j++] = b_s3[i];
        }
        //Hash the result and return
        return keccak256(b_full);
    }
  
     function checkdetails(uint dataid, uint selectedOwnerid,uint buyerId,bytes32 interaction_id) view public returns (string memory){
        // bytes32    hash =  concatenateInfoAndHash(datas[dataid]._data_name,buyerId,datas[dataid]._data_hash,selectedOwnerid);
        bytes32  hash;
 
        //bytes memory dataidB = new bytes(datas[dataid]._data_name);
        bytes memory selectedOwneridB = new bytes(selectedOwnerid);
        bytes memory _buyer_idaB = new bytes(buyerId);
       
         hash =  concatenateInfoAndHash(datas[dataid]._data_name,selectedOwneridB,datas[dataid]._data_hash,_buyer_idaB);
         
         //lookups[lookup_id].flag=1;
       
        if(hash == interaction_id )
        {
             return datas[dataid]._data_hash;
        }
        else
        return "Invalid interactionId";
    }
    
     function get_lookupId() public view  returns(uint){
        return lookup_id;
    }
}
