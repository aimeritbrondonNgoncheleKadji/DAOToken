pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NKABToken is ERC20, Ownable {
    mapping(address => bool) public hasVoted;
    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;

    event ProposalCreated(uint256 proposalId, string proposal);
    event VoteCasted(address indexed voter, uint256 proposalId, bool support);

    struct Proposal {
        string proposal;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
    }

    constructor() ERC20("NKABToken", "NKAB") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function createProposal(string memory _proposal) external onlyOwner {
        uint256 proposalId = proposalCount;
        proposals[proposalId] = Proposal(_proposal, 0, 0, false);
        proposalCount++;

        emit ProposalCreated(proposalId, _proposal);
    }

    function vote(uint256 _proposalId, bool _support) external {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_proposalId < proposalCount, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        if (_support) {
            proposal.votesFor++;
        } else {
            proposal.votesAgainst++;
        }

        hasVoted[msg.sender] = true;

        emit VoteCasted(msg.sender, _proposalId, _support);
    }

    function executeProposal(uint256 _proposalId) external onlyOwner {
        require(_proposalId < proposalCount, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        require(!_isProposalExecuted(proposal), "Proposal already executed");
        require(_isVotePassed(proposal), "Proposal did not pass");

        // Execute the proposal's actions here
        proposal.executed = true;
    }

    function _isProposalExecuted(
        Proposal storage _proposal
    ) internal view returns (bool) {
        return _proposal.executed;
    }

    function _isVotePassed(
        Proposal storage _proposal
    ) internal view returns (bool) {
        uint256 totalVotes = _proposal.votesFor + _proposal.votesAgainst;
        require(totalVotes > 0, "No votes casted");
        uint256 voteThreshold = totalVotes / 2 + 1;
        return _proposal.votesFor >= voteThreshold;
    }
}
