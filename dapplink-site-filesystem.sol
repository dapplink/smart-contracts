pragma solidity 0.5.0;


import "./dapplink-site-properties.sol";
import "./dapplink-site-access-control.sol";


contract DapplinkSiteFilesystem is DapplinkSiteProperties, DapplinkSiteAccessControl {

    struct filesystem {
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