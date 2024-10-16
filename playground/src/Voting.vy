#pragma version >0.3.0

voted: public(HashMap[address, bool])
candidate: public(HashMap[address, uint256])

@external
def vote(candidate: address) -> bool:
    assert not self.voted[msg.sender], "You have already voted."

    self.voted[msg.sender] = True
    self.candidate[candidate] += 1

    return True

