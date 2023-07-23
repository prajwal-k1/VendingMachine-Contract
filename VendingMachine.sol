// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract VendingMachine {
    address public owner;
    mapping (uint => uint) quantityOfItems;
    mapping (uint => uint) priceOfItems;

    constructor(){
        owner = msg.sender;

        quantityOfItems[1] = 10;
        quantityOfItems[2] = 10;
        quantityOfItems[3] = 10;
        quantityOfItems[4] = 10;
        quantityOfItems[5] = 10;
        quantityOfItems[6] = 10;

        priceOfItems[1] = 1 ether;
        priceOfItems[2] = 2 ether;
        priceOfItems[3] = 3 ether;
        priceOfItems[4] = 4 ether;
        priceOfItems[5] = 5 ether;
        priceOfItems[6] = 6 ether;
    }

    event ItemAdded(uint item, uint count);
    event PrizeUpdated(uint item, uint prize);
    event ItemPurchased(uint item, uint quantity, address user);

    modifier _onlyOwner{
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function getCountOfItem(uint item) public view returns(uint){
        require(item > 0 && item <=6, "Please enter a valid item id");
        return quantityOfItems[item];
    }

    function getPrizeOfItem(uint item) public view returns(uint){
        require(item > 0 && item <=6, "Please enter a valid item id");
        return priceOfItems[item];
    }

    function addItem(uint count, uint item) public _onlyOwner{
        require(item > 0 && item <=6, "Please enter a valid item id");
        quantityOfItems[item] += count;
        emit ItemAdded(item, count);
    }

    function updatePrize(uint prize, uint item) public _onlyOwner{
        require(item > 0 && item <=6, "Please enter a valid item id");
        priceOfItems[item] = prize;
        emit PrizeUpdated(item, prize);
    }

    function purchaseItem(uint item, uint quantity) public payable {
        require(quantityOfItems[item] >= quantity, "The entered quantity is greater than available quantity");
        require(msg.value >= priceOfItems[item] * quantity, "Please enter proper amount for purchase");
        quantityOfItems[item] -= quantity;
        emit ItemPurchased(item, quantity, msg.sender);
    }
}