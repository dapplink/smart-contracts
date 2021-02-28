pragma solidity 0.5.0;


contract DapplinkInfrastructureProperties {


    string public symbol;
    string public name;
    uint8  public decimals;
    uint   public _totalSupply;
    uint   public price;

    mapping (  address => uint  ) balances;
    mapping (  address => mapping ( address => uint )  ) allowed;


}