pragma solidity 0.5.0;


import "./dapplink-site.sol";
import "./dapplink-infrastructure-deployment.sol";
import "./owned.sol";
import "./safe-math.sol";


contract DapplinkInfrastructureDeploymentWWW is
    DapplinkSite,
    DapplinkInfrastructureDeployment,
    Owned,
    SafeMath
{

    uint public deployment_www_fee;
    uint public deployment_www_bonus;

    address[] public deployedWWWSites;


    event DeployWWW
        (
            address _contract,
            address _owner
        );


    function deployWWW
        ()
        public returns ( address siteAddress )
        {
            require
                (
                    balances[ msg.sender ] >= deployment_www_fee,
                    "no enough tokens for deployment"
                );
            Dapplink site = deploy( msg.sender );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], deployment_www_fee    );
            balances[ msg.sender ] = safeAdd(  balances[ msg.sender ], deployment_www_bonus  );
	    deployedWWWSites.push(  address( site )  );
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


    // getDeployedWWWSites length
    // getDeployedWWWSites item

}
