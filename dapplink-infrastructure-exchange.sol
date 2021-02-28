pragma solidity 0.5.0;


contract DapplinkInfrastructureExchange is
    DapplinkInfrastructureProperties,
    ERC20Interface
{


    function
        ()
	external payable
	{
            uint tokens;
    
            tokens = safeMul( msg.value, price );
            balances[ msg.sender ] = safeAdd(  balances[ msg.sender ], tokens  );
            _totalSupply = safeAdd( _totalSupply, tokens );
    
            emit Transfer(address(0), msg.sender, tokens);
        }


}