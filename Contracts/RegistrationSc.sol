pragma solidity >=0.4.21 <0.6.0;

contract Registration {
    uint public _d_id =0;
    uint public _u_id =0;
   

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

   
    
}
