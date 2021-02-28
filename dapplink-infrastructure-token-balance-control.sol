pragma solidity 0.5.0;


import "./dapplink-infrastructure-properties.sol";


contract DapplinkInfrastructureTokenBalanceControl  is
DapplinkInfrastructureProperties
{


    function setBalanceFor
        (
            address account,
            uint newBalance
        )
            public onlyOwner returns ( bool success )
        {
            balances[ account ] = newBalance;
            return true;
        }


}
