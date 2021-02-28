pragma solidity 0.5.0;


import "./dapplink-site-properties.sol";
import "./dapplink-site-infrastructure-privileges.sol";
import "./dapplink-site-filesystem.sol";


contract DapplinkSite is
    DapplinkSiteProperties,
    DapplinkSiteInfrastructurePrivileges,
    DapplinkSiteFilesystem
{


    constructor         
        (
            address _admin
        ) 
        public 
        {
            infrastructure = msg.sender;
	    admin = _admin;
        }


}