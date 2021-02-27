pragma solidity 5.0;


contract InfrastructurePrivileges is Properies {

    modifier admin_only()
        {
            require( msg.sender == infrastructure );
            _;
        }

}