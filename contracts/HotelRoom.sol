// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HotelRoom {

    enum Statueses {Vacant, Occupied}
    Statueses currentStatus;

    event Occupy(address _occupant, uint _value);

    address public owner;

    constructor()  {
        owner = msg.sender;
        currentStatus = Statueses.Vacant;
        // priceFeed = AggregatorV3Interface(oracleAddress);
    }
    modifier onlyWhileVacant() {
        require(currentStatus == Statueses.Vacant, "Currently Occupied");
        _;
    }
    modifier cost(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided");
        _;
    }
    receive() external payable onlyWhileVacant cost(2 ether){
        //function Book() public payable onlyWhileVacant cost(2 ether){
        // Chaed Status
        //require(currentStats == statuses.Vacant, "Currently Occupied");
        // Check Price
        //require(msg.value >= 2 ether, "Currently Occupied");

        currentStatus = Statueses.Occupied;
        payable(owner).transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

}
