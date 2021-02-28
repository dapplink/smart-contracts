pragma solidity 0.5.0;


import "./dapplink-site.sol";
import "./dapplink-infrastructure-deployment-www.sol";
import "./owned.sol";
import "./safe-math.sol";


contract DapplinkInfrastructureDeploymentWWW is
    DapplinkSite,
    DapplinkInfrastructureDeployment,
    Owner,
    SafeMath
{

    uint public deployment_www_fee;
    uint public deployment_www_bonus;

    address[] public deployedWWWSites;


    event DeployWWW
        (
	    address contract,
	    address owner
	);


    function deployWWW
        ()
        public returns ( address site )
        {
            require
                (
                    balances[ msg.sender ] >= deployment_www_fee,
                    "no enough tokens for deployment"
                );
            Dapplink site = deploy( msg.sender );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], deployment_www_fee    );
            balances[ msg.sender ] = safeAdd(  balances[ msg.sender ], deployment_www_bonus  );
	    emit DeployWWW(  address( site ), msg.sender );
	    return address( site );
        }


    function setDeploymentWWWFee
        (
            uint _fee
        )
        public onlyOwner returns ( bool success )
        {
            deployment_www_fee = _fee;
            return true;
        }


    function setDeploymentWWWBonus
        (
            uint _bonus
        )
        public onlyOwner returns ( bool success )
        {
            deployment_www_bonus = _bonus;
            return true;
        } 


}
