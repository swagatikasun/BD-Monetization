pragma solidity >=0.4.21 <0.6.0;

import "./RegistrationSc.sol";
import "github.com/provable-things/ethereum-api/provableAPI.sol";
contract AccessControl is Registration, usingProvable {
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
        
         //
        //d_id;
        //uint b_id;
        //uint selected_id;
        //uint lookup_Id;
        verifylookups[lookup_id].d_id=dataid;
        verifylookups[lookup_id].b_id=buyerId;
        verifylookups[lookup_id].selected_id=selectedOwnerid;
        verifylookups[lookup_id].lookup_Id=lookup_id;

        
        lookup_id++;
        return lookup_id;
    }
    /*
     function get_data_hash(uint hhi,bytes32 interactionId ) public view returns (string){
     string data_hash;
     uint d_id;
    (data_hash)= dc.datas[d_id]._data_hash;
     return (data_hash);
    }
    */
    function update()
        public
        payable
    {
        //emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
        provable_query("URL", "xml(http://ec2-13-232-39-95.ap-south-1.compute.amazonaws.com:5000/alice).result");
    }
}

