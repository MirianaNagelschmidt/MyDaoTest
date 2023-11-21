// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAO {
    address public admin;
    uint256 public totalShares;
    mapping(address => uint256) public shares;
    mapping(address => mapping(address => uint256)) public votes;

    event SharesBought(address indexed buyer, uint256 amount);
    event ProposalVoted(address indexed voter, address indexed proposal, bool inSupport);
    event ProposalExecuted(address indexed executor, address indexed proposal);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can call this function");
        _;
    }

    modifier onlyShareholders() {
        require(shares[msg.sender] > 0, "Only shareholders can call this function");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function buyShares(uint256 _amount) external payable {
        require(_amount > 0, "Amount must be greater than 0");

        totalShares += _amount;
        shares[msg.sender] += _amount;

        emit SharesBought(msg.sender, _amount);
    }

}
