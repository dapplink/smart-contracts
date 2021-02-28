pragma solidity 0.5.0;


contract DapplinkInfrastructure
{

    
    constructor
        ()
        public
        {
            symbol   = "DDD";
            name     = "Dapplink Infrastructure Token";
            decimals = 18;
            price    = 1000;
        }


    function totalSupply
        ()
        public view returns ( uint )
        {
            return _totalSupply - balances[ address(0) ];
        }


    function balanceOf
        (
            address tokenOwner
        )
        public view returns ( uint balance )
        {
            return balances[ tokenOwner ];
        }


    function transfer
        (
            address to,
            uint    tokens
        )
        public returns (bool success)
        {
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], tokens  );
            balances[ to ] = safeAdd(  balances[ to ], tokens  );
            emit Transfer( msg.sender, to, tokens );
            return true;
        }


    function approve
        (
            address spender,
            uint    tokens
        )
        public returns ( bool success )
        {
            // returns true for compatibility
            return true;
        }


    function transferFrom
        (
            address from,
            address to,
            uint    tokens
        )
        public returns ( bool success )
        {
            // returns true for compatibility
            return true;
        }


    function allowance
        (
            address tokenOwner,
            address spender
        )
        public view returns ( uint remaining )
        {
            return allowed[ tokenOwner ][ spender ];
        }


    function approveAndCall
        (
            address        spender,
            uint           tokens,
            bytes   memory data
        )
        public returns (bool success)
        {
            // returns true for compatibility
            return true;
        }


    function transferAnyERC20Token
        (
            address tokenAddress,
            uint tokens
        )
        public onlyOwner returns ( bool success )
        {
            return ERC20Interface( tokenAddress ).transfer( owner, tokens );
        }


}
