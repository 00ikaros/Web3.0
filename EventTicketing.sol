// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventTicketing {
    struct Ticket {
        uint eventId;
        uint price;
        address owner;
    }

    Ticket[] public tickets;
    mapping(uint => bool) public ticketSold;
    uint public nextTicketId;

    event TicketCreated(uint ticketId, uint eventId, uint price);
    event TicketPurchased(uint ticketId, address buyer);
    event TicketTransferred(uint ticketId, address from, address to);

    // Create a new ticket
    function createTicket(uint eventId, uint price) public {
        tickets.push(Ticket({
            eventId: eventId,
            price: price,
            owner: msg.sender
        }));
        emit TicketCreated(nextTicketId, eventId, price);
        nextTicketId++;
    }

    // Purchase a ticket
    function purchaseTicket(uint ticketId) public payable {
        require(ticketId < tickets.length, "Ticket does not exist");
        require(!ticketSold[ticketId], "Ticket already sold");
        require(msg.value >= tickets[ticketId].price, "Not enough Ether provided");

        tickets[ticketId].owner = msg.sender;
        ticketSold[ticketId] = true;
        emit TicketPurchased(ticketId, msg.sender);
    }

    // Transfer ticket to another user
    function transferTicket(uint ticketId, address to) public {
        require(ticketId < tickets.length, "Ticket does not exist");
        require(ticketSold[ticketId], "Ticket not yet sold");
        require(tickets[ticketId].owner == msg.sender, "Only ticket owner can transfer");

        tickets[ticketId].owner = to;
        emit TicketTransferred(ticketId, msg.sender, to);
    }

    // Get the total number of tickets
    function totalTickets() public view returns (uint) {
        return tickets.length;
    }
}
