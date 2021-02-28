pragma solidity 5.0;


contract DapplinkSiteAccessControl is DapplinkSiteProperties {


    modifier admin_only()
        {
            require( msg.sender == admin );
            _;
        }


}