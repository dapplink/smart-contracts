pragma solidity 0.5.0;


import "./dapplink-infrastructure-properties.sol";
import "./owned.sol";


contract DapplinkInfrastructureDeployment is
DapplinkSite
{


    function deploy
        ()
        public returns ( DapplinkSite site )
        {
            return new DapplinkSite( msg.sender )
        }


}
