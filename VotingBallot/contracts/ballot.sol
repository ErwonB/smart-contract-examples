pragma solidity >=0.4.22 <0.9.0;

contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairPerson;

    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) public {
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;

        for(uint i = 0; i < proposalNames.length; i++) {
           proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }
    
    function giveRightToVote(address voter) public {
        require(msg.sender == chairPerson);
        require(!voters[voter].voted);

        voters[voter].weight = 1;
    }

    function createProposal(bytes32 newProposal) public {
        
       proposals.push(Proposal({name: newProposal, voteCount: 0}));

    }

    function delegate(address to) public {
        require(!voters[msg.sender].voted);
        require(to != msg.sender);
        Voter storage sender = voters[msg.sender];

        while ( voters[to].delegate != address(0) && voters[to].delegate != msg.sender) {
            to = voters[to].delegate;
        }

        if(to == msg.sender) {
            revert();
        }

        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal) public {
        require(!voters[msg.sender].voted);
        Voter storage sender = voters[msg.sender];
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint winningProposal_) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if(proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winnerName() public view returns(bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }

    function getProposalName(uint index) public view returns (bytes32) {
        require(index < proposals.length);
        require(index >= 0);
        return proposals[index].name;
    }

    function getProposalVoteCount(uint index) public view returns (uint) {
        require(index < proposals.length);
        require(index >= 0);
        return proposals[index].voteCount;
    }
        
        
}

