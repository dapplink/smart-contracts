pragma solidity 0.5.0;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/access/roles/MinterRole.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/math/SafeMath.sol";


contract DapplinkSiteProperties {


    address public  admin;
    string  public  title;
    string  public  description;
    string  public  meta;

    address public  infrastructure;


}


contract DapplinkSiteAccessControl is
    DapplinkSiteProperties {


    modifier admin_only()
        {
            require( msg.sender == admin );
            _;
        }


}


contract DapplinkSiteFilesystem is
    DapplinkSiteProperties,
    DapplinkSiteAccessControl {


    struct filesystem
        {
            address file_sha;   
            string  file_mime;
            uint    n_chunks;
        }


    mapping( address => filesystem ) public files;


    event Chunk
        (
            address indexed file_sha,
            uint    indexed chunk_index,
            bytes           chunk_data
        );


    function upload_chunk
        (
            address        file_sha,
            uint           chunk_index,
            bytes   memory chunk_data
        ) 
        public admin_only
        {
            emit Chunk (
                file_sha, 
                chunk_index,
                chunk_data
            );
        }


    function link
        (
            address         pathname_sha,
            address         file_sha,
            string   memory file_mime,
            uint            n_chunks
        ) 
        public admin_only
        {
            files[ pathname_sha ].file_sha   = file_sha;
            files[ pathname_sha ].file_mime  = file_mime;
            files[ pathname_sha ].n_chunks   = n_chunks;
        }


    function unlink
        (
            address pathname_sha
        )
        public admin_only
        {
            delete files[ pathname_sha ];
        }
        

}


contract DapplinkSiteInfrastructurePrivileges is
    DapplinkSiteProperties {


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
        public infrastructure_only
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


contract DapplinkSite is
    DapplinkSiteProperties,
    DapplinkSiteInfrastructurePrivileges,
    DapplinkSiteFilesystem {


    constructor         
        (
            address _admin
        ) 
        public 
        {
            infrastructure = msg.sender;
            admin = _admin;
        }


}


contract mySafeMath {


    function safeAdd
        (
            uint a,
            uint b
        )
        internal pure returns ( uint c )
        {
            c = a + b;
            require( c >= a );
        }


    function safeSub
        (
            uint a,
            uint b
        )
        internal pure returns ( uint c )
        {
            require( b <= a );
            c = a - b;
        }


    function safeMul
        (
            uint a,
            uint b
        )
        internal pure returns ( uint c )
        {
            c = a * b;
            require( a == 0 || c / a == b );
        }


    function safeDiv
        (
            uint a,
            uint b
        )
        internal pure returns ( uint c )
        {
            require( b > 0 );
            c = a / b;
        }


}


contract ERC20Interface {


    function totalSupply ()
        public view returns ( uint );


    function balanceOf ( address tokenOwner )
        public view returns ( uint balance );


    function allowance ( address tokenOwner, address spender )
        public view returns ( uint remaining );


    function transfer ( address to, uint tokens )
        public returns ( bool success );


    function approve ( address spender, uint tokens )
        public returns ( bool success );


    function transferFrom ( address from, address to, uint tokens )
        public returns ( bool success );


    event Transfer ( address indexed from, address indexed to, uint tokens );
    event Approval ( address indexed tokenOwner, address indexed spender, uint tokens );


}


contract ApproveAndCallFallBack {


    function receiveApproval ( address from, uint256 tokens, address token, bytes memory data ) public;


}


contract Owned {


    address payable public owner;
    address payable public newOwner;


    event OwnershipTransferred
        (
            address indexed _from,
            address indexed _to
        );


    constructor
        ()
        public
        {
            owner = msg.sender;
        }
        

    modifier onlyOwner
        {
            require( msg.sender == owner );
            _;
        }


    function transferOwnership
        (
            address payable _newOwner
        )
        public onlyOwner
        {
            newOwner = _newOwner;
        }


    function acceptOwnership
        ()
        public
        {
            require ( msg.sender == newOwner );
            emit OwnershipTransferred ( owner, newOwner );
            owner = newOwner;
            newOwner = address( 0 );
        }


}


contract DapplinkInfrastructureProperties {


    string public symbol;
    string public name;
    uint8  public decimals;
    uint   public _totalSupply;
    uint   public price;

    mapping (  address => uint  ) balances;
    mapping (  address => mapping ( address => uint )  ) allowed;


}


contract DapplinkInfrastructureDeployment {


    uint public deployment_www_fee;
    uint public deployment_www_bonus;

    uint public deployment_nft_fee;
    uint public deployment_nft_bonus;

    address[] public WWWSites;
    address[] public NFTSites;


    event DeployWWW
        (
            address _contract,
            address _owner
        );

    event DeployNFT
        (
            address _contract,
            address _owner
        );
        
}


contract DapplinkInfrastructureListing {
    
    
    uint public request_listing_www_fee;
    mapping( address => bool ) public listingWWW;
    event ListingRequestWWW   ( address _contract );
    event DelistingRequestWWW ( address _contract );

    uint public request_listing_nft_fee;
    mapping( address => bool ) public listingNFT;
    event ListingRequestNFT   ( address _contract );
    event DelistingRequestNFT ( address _contract );
    
    
}


contract DapplinkInfrastructureNotary {

    uint public notary_change_title_fee;
    uint public notary_change_description_fee;
    uint public notary_change_admin_fee;
    
}


contract DapplinkInfrastructureBroker {
    
    uint public broker_put_for_sale_fee;
    uint public broker_sale_tax;
    
    mapping( address => uint ) public brokerOffers;
    
    event BrokerPutForSale( address _site, uint tokens );
    event BrokerCancelForSale( address _site );
    event BrokerSoldEvent( address _site );
    
}


contract DapplinkInfrastructure is
    DapplinkInfrastructureProperties,
    ERC20Interface,
    Owned,
    mySafeMath,
    DapplinkInfrastructureDeployment,
    DapplinkInfrastructureListing,
    DapplinkInfrastructureNotary,
    DapplinkInfrastructureBroker {

    
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


    function
        ()
        external payable
        {
            uint tokens;
    
            tokens = safeMul( msg.value, price );
            balances[ msg.sender ] = safeAdd(  balances[ msg.sender ], tokens  );
            _totalSupply = safeAdd( _totalSupply, tokens );
    
            emit Transfer( address(0), msg.sender, tokens );
        }
        
        
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
        
        
    function withdraw
        ()
        public onlyOwner returns ( bool success )
        {
            owner.send(  address( this ).balance  );
        }
        
    
    function deploy
        (
            address _owner
        )
        private returns ( DapplinkSite site )
        {
            return new DapplinkSite( _owner );
        }
        
        
    function deployWWW
        ()
        public returns ( address )
        {
            require
                (
                    balances[ msg.sender ] >= deployment_www_fee,
                    "no enough tokens for deployment"
                );
            DapplinkSite site = deploy( msg.sender );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], deployment_www_fee    );
            balances[ msg.sender ] = safeAdd(  balances[ msg.sender ], deployment_www_bonus  );
            WWWSites.push(  address( site )  );
            listingWWW[ address(site) ] = false;
            emit DeployWWW
                    (
                            address( site ),
                            msg.sender
                    );
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


    function getNumberOfWWW
        ()
        public view returns ( uint count)
        {
            return WWWSites.length;
        }
    
    
    function getWWWItem
        (
            uint _n     
        )
        public view returns ( address site )
        {
            return WWWSites[ _n ];
        }
        
        
    function requestForListingWWW
        (
                address _site
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            require( msg.sender == site.admin() );
            require
                    (
                        balances[ msg.sender ] >= request_listing_www_fee,
                        "no enough tokens for listing request"
                    );
            emit ListingRequestWWW( _site );
        }
    
    
    function requestForDelistingWWW
        (
            address _site
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            listingWWW[ _site ] = false;
            emit DelistingRequestWWW( _site );
        }
        
    
    function listWWW
        (
            address _site
        )
        public onlyOwner
        {
            listingWWW[ _site ] = true;
        }
    
    
    function delistWWW
        (
            address _site
        )
        public onlyOwner
        {
            listingWWW[ _site ] = false;
        }


    function getListingStatusWWW
        (
            address _site
        )
        public returns ( bool )
        {
            return listingWWW[ _site ];
        }
    
    
    function setRequestListingWWWFee
        (
            uint _fee
        )
        public onlyOwner
        {
            request_listing_www_fee = _fee;
        }
	

    function deployNFT
        (
            string  memory _token_name,
            string  memory _token_symbol
        )
        public returns ( address )
        {
            require
                (
                    balances[ msg.sender ] >= deployment_nft_fee,
                    "no enough tokens for deployment"
                );
            DapplinkNFTSite site = new DapplinkNFTSite( msg.sender, _token_name, _token_symbol );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], deployment_nft_fee    );
            balances[ msg.sender ] = safeAdd(  balances[ msg.sender ], deployment_nft_bonus  );
            NFTSites.push(  address( site )  );
            listingNFT[ address(site) ] = false;
            emit DeployNFT
                    (
                        address( site ),
                        msg.sender
                    );
            return address( site );
        }


    function notaryChangeTitle
        (
            address       _site,
            string memory _new_title
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            require( msg.sender == site.admin() );
            require
                (
                    balances[ msg.sender ] >= notary_change_title_fee,
                    "no enough tokens for notary service"
                );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], notary_change_title_fee  );
            site.change_title( _new_title );
        }
    
    
    function notaryChangeDescription
        (
            address        _site,
            string  memory _new_description
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            require( msg.sender == site.admin() );
            require
                (
                    balances[ msg.sender ] >= notary_change_description_fee,
                    "no enough tokens for notary service"
                );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], notary_change_description_fee );
            site.change_description( _new_description );
        }
    
    
    function notaryChangeAdmin
        (
            address _site,
            address _new_admin
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            require( msg.sender == site.admin() );
            require
                (
                    balances[ msg.sender ] >= notary_change_admin_fee,
                    "no enough tokens for notary service"
                );
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], notary_change_admin_fee  );
            site.change_admin( _new_admin );
        }
    
    
    function notarySetChangeTitleFee
        (
            uint _fee
        )
        public onlyOwner
        {
        notary_change_title_fee = _fee;
        }
    
    
    function notarySetChangeDescriptionFee
        (
            uint _fee
        )
        public onlyOwner
        {
            notary_change_description_fee = _fee;
        }
    
    
    function notarySetChangeAdminFee
        (
            uint _fee
        )
        public onlyOwner
        {
            notary_change_admin_fee = _fee;
        }


    function brokerPutForSale
        (
            address _site,
            uint _tokens
        )
        public
        {
        DapplinkSite site;
        site = DapplinkSite( _site );
        require( msg.sender == site.admin() );
        require
            (
                balances[ msg.sender ] >= broker_put_for_sale_fee,
                "no enough tokens for broker service"
            );
        balances[ msg.sender ] = safeSub(  balances[ msg.sender ], broker_put_for_sale_fee  );
        brokerOffers[ _site ] = _tokens;
        emit BrokerPutForSale( _site, _tokens );
        }


    function brokerCancelForSale
        (
            address _site
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            require( msg.sender == site.admin() );
            delete brokerOffers[ _site ];
            emit BrokerCancelForSale( _site );
        }


    function brokerBuy
        (
            address _site
        )
        public
        {
            DapplinkSite site;
            site = DapplinkSite( _site );
            require( brokerOffers[ _site ] > 0 );
            uint tax = safeDiv( safeMul( brokerOffers[_site], broker_sale_tax ), 100 );
            uint price = safeAdd( brokerOffers[_site], tax );
            require
                (
                    balances[ msg.sender ] >= price,
                    "no enough tokens for broker service"
                );
            address saler = site.admin();
            balances[ msg.sender ] = safeSub(  balances[ msg.sender ], brokerOffers[ _site ]  );
            balances[ saler ] = safeAdd( balances[ saler ], brokerOffers[ _site ] );
            balances[ address(this) ] = safeAdd( balances[ address(this) ], tax );
            delete brokerOffers[ _site ];
            emit BrokerSoldEvent( _site );
        }


        function brokerSetPutForSaleFee
            (
                uint _fee
            )
            public onlyOwner
            {
                broker_put_for_sale_fee = _fee;
            }


        function brokerSetSaleTax
            (
                uint _percent
            )
            public onlyOwner
            {
                broker_sale_tax = _percent;
            }


        function brokerGetOffer
            (
                address _site
            )
            public returns (uint tokens)
            {
                return brokerOffers[ _site ];
            }
    
}


contract DapplinkNFTSite is Ownable, MinterRole, ERC721Full,
    DapplinkSiteProperties,
    DapplinkSiteInfrastructurePrivileges,
    DapplinkSiteFilesystem {
    
    using SafeMath for uint;


    constructor         
        (
            address _admin,
            string  memory _token_name,
            string  memory _token_symbol
        ) 
        ERC721Full( _token_name, _token_symbol ) public 
        {
            infrastructure = msg.sender;
            admin = _admin;
        }


    function mint
        (
            address       _to,
            string memory _tokenURI
        )
        public onlyMinter returns (bool)
        {
            _mintWithTokenURI(_to, _tokenURI);
            return true;
        }


    function _mintWithTokenURI
        (
            address       _to,
            string memory _tokenURI
        )
        internal
        {
            uint _tokenId = totalSupply().add(1);
            _mint( _to, _tokenId );
            _setTokenURI( _tokenId, _tokenURI );
        }


}