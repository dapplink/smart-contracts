pragma solidity 0.5.0;


import "./dapplink-infrastructure-properties.sol";
import "./owned.sol";


contract DapplinkInfrastructureDeployment is
DapplinkSite
{


    function deploy
        (
            address _owner
        )
        private returns ( DapplinkSite site )
        {
            return new DapplinkSite( _owner )
        }


}
