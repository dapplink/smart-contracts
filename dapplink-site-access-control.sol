pragma solidity 0.5.0;


import "./dapplink-site-properties.sol";


contract DapplinkSiteAccessControl is DapplinkSiteProperties {


    modifier admin_only()
        {
            require( msg.sender == admin );
            _;
        }


}