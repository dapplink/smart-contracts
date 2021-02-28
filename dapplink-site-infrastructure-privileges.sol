pragma solidity 5.0;


import "./dapplink-site-properties.sol";


contract InfrastructurePrivileges is Properies {


    modifier infrastructure_only()
        {
            require( msg.sender == infrastructure );
            _;
        }


    function change_admin
        (
            address _new_admin
        )
        public infrastructure_only
        {
            admin = _new_admin;
        }


    function change_title
        (
            string memory _new_title
        )
        public infrastructure_only
        {
            title = _new_title;
        }


    function change_description
        (
            string memory _new_description
        )
        public infrastructure_only
        {
            description = _new_description;
        }


    function change_meta
        (
            string memory _new_meta
        )
        public admin_only
        {
            meta = _new_meta;
        }


    function change_infrastructure
        (
            address _new_infrastructure
        )
        public infrastructure_only
        {
            infrastructure = _new_infrastructure;
        }


}
