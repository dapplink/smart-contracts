pragma solidity 0.5.0;


import "./dapplink-infrastructure-properties.sol";
import "./owned.sol";


contract DapplinkInfrastructureWithdrawingControl is
    DapplinkInfrastructureProperties
    Owned
{


    function withdraw
        ()
        public onlyOwner returns (bool success)
        {
            owner.send(address(this).balance);
        }


}
