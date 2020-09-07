pragma solidity >=0.4.21 <0.6.0;
contract Vcontrol {
    uint uidd=0;
    event notification(address owner, uint _did, string _bm);
    struct update1
    {
        uint _dataid;
        string _content;
        string _bookmark;
    }
    mapping(uint => update1 ) public updates;
    function update(uint _did, string content, string bookmark)
    {
        uint uuid=uidd++;
        updates[uuid]._dataid = _did;
        updates[uuid]._content = content;
        updates[uuid]._bookmark = bookmark;
        
        emit notification(msg.sender, _did, bookmark );
    }
    
        
      

}
