pragma solidity >=0.4.21 <0.6.0;

import "./RegistrationSc.sol";
contract AccessControl is Registration{
     uint public a;
     //uint public requiredlookupId=100;
   
    address datachain_address;
    struct details{
        uint _data_id;
        uint _owner_id;
        string _owner_name;
        string _owner_type;
    }
   
   Registration public dc;
   
    constructor(address data) public {
        //Just create a new auxiliary contract. We will use it to check if the part or product really exist
        datachain_address=data;
        dc = Registration(data);
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
   string reencryptedmsg;
    string empheralencryptedkey;
   
    function get_interactionId(uint lookup_id1) public returns (bytes32,uint,uint,uint,uint,uint){
         uint b_id;
        uint d_id;
        uint o_id;
        uint flag;
        //string smartcontract_name;
        //address datachain_address;
        bytes32 interactionId;
        uint _timeStamp;
        (b_id,d_id,o_id,interactionId,_timeStamp,flag) = dc.lookups(lookup_id1);
       
        return (interactionId,b_id,d_id,o_id,_timeStamp,flag);
    }
   
   
   
    function get_lookupId(uint buyerid,uint dataid,uint selectedownerid) public returns (uint){
        uint d_id;
        uint b_id;
        uint a;
        uint b;
        uint selected_id;
        uint currentlookupId;
        currentlookupId =  dc.get_lookupId();
        uint i;
        for(i=0 ;i<= currentlookupId ;i++)
        {
           (d_id,b_id,selected_id,a)= dc.verifylookups(i);
        
             if(buyerid == b_id){
                 if( dataid == d_id ){
                 if(selectedownerid ==selected_id){
                     return a;
                 }
             }
           }
           else 
           return b;
        }
    }
    function get_lookupdetails() public view returns (uint)
    {
        return(lookup_id);
    }
    function check_lookupId(uint currentlookupId) public view returns (uint,uint,uint,uint){
        uint d_id;
        uint b_id;
        uint selected_id;
    (d_id,b_id,selected_id,currentlookupId)= dc.verifylookups(currentlookupId);
     return (d_id,b_id,selected_id,currentlookupId);
    }
    function getdetails(uint dataid,uint owner_id, uint selectedOwnerid,uint buyerId) public returns (uint){
        //   return (datas[Data_id]._data_name,datas[Data_id]._data_cost,datas[Data_id]._data_specs,datas[Data_id]._data_hash,datas[Data_id]._owner_id,datas[Data_id]._manufacture_date);
       // bytes32    hash =  concatenateInfoAndHash(datas[dataid]._data_name,buyerId,datas[dataid]._data_hash,selectedOwnerid);
       //uint  dataid;
       //uint  _buyer_id;
       // uint  selectedOwnerid;
        bytes32  hash;
       
       // dataid =dataid;
       
       //selectedOwnerid = selectedOwnerid;

       // _buyer_id=buyerId;
       
       // bytes memory dataidB = new bytes(datas[dataid]._data_name);
        bytes memory selectedOwneridB = new bytes(selectedOwnerid);
        bytes memory _buyer_idaB = new bytes(buyerId);

        //bytes memory reversed = new bytes(dataid);

         hash =  concatenateInfoAndHash(datas[dataid]._data_name,selectedOwneridB,datas[dataid]._data_hash,_buyer_idaB);

        lookups[lookup_id].b_id=buyerId;
        lookups[lookup_id].d_id=dataid;
        lookups[lookup_id].o_id=owner_id;
        //lookups[lookup_id].smartcontract_name="Data";
        //lookups[lookup_id].datachain_address=datachain_address;
        lookups[lookup_id].interactionId=hash;
         lookups[lookup_id]._timeStamp=now;
         lookups[lookup_id].flag=1;
        verifylookups[lookup_id].d_id=dataid;
        verifylookups[lookup_id].b_id=buyerId;
        verifylookups[lookup_id].selected_id=selectedOwnerid;
        verifylookups[lookup_id].lookup_Id=lookup_id;

        
        lookup_id++;
        return lookup_id;
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
    function getDataReEncrpMsg() public view returns(string memory) {
        return reencryptedmsg;
    }
    
    function getDataEncryKey() public view returns(string memory) {
        return empheralencryptedkey;
    }
    
    
    function setData(string memory mreencryptedmsg,string memory mempheralencryptedkey) public {
        empheralencryptedkey = mempheralencryptedkey;
        reencryptedmsg = mreencryptedmsg;
    }
}

