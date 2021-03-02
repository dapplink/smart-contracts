pragma solidity 0.5.0;


import "./dapplink-infrastructure-properties.sol";
import "./dapplink-site.sol";
import "./owned.sol";


contract DapplinkInfrastructureDeployment is
    DapplinkInfrastructureProperties,
    DapplinkSite,
    Owned
{


    function deploy
        (
            address _owner
        )
        private returns ( DapplinkSite site )
        {
            return new DapplinkSite( _owner );
        }


}
