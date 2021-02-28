pragma solidity 0.5.0;


import "./dapplink-infrastructure-properties.sol";


contract DapplinkInfrastructureTokenPriceControl {


    function getPrice
        ()
        public onlyOwner view returns ( uint balance )
        {
            return price;
        }
   

    function setPrice
        (
            uint _newPrice
	)
	public onlyOwner returns ( bool success )
	{
            price = _newPrice;
            return true;
        }


}