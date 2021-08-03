import UIKit


/// 초대장: 이벤트 당첨자에게 발송되는 초대장
class Invitation {
    private var when: Date?
}

/// 티켓: 공연을 관람하기 원하는 모든 사람들은 티켓을 소지해야함.
class Ticket {
    private var fee: Double?
    
    func getFee() -> Double {
        return fee ?? 0
    }
}

/// 가방: 관람객이 소지품을 보관할 수 있는 가방, 초대장, 티켓, 현금을 가질 수 있다.
class Bag {
    private var amount: Double
    private var invitaion: Invitation?
    private var ticket: Ticket?
    
    // MARK: 현금만 가지고 있는 경우
    init(amount: Double) {
        self.amount = amount
    }
    
    // MARK: 현금과 초대장을 가지고 있는 경우
    init(invitation: Invitation, amount: Double) {
        self.invitaion = invitation
        self.amount = amount
    }
    
    
    func hasInvitation() -> Bool {
        return invitaion != nil
    }
    
    func hasTicket() -> Bool {
        return ticket != nil
    }

    func setTicket(ticket: Ticket) {
        self.ticket = ticket
    }
    
    func minusAmount(amount: Double) {
        self.amount -= amount
    }
    
    func plusAmount(amount: Double) {
        self.amount += amount
    }
}

/// 관람객: 소지품을 보관하는 가방을 가지고 있다.
class Audience {
    private var bag: Bag
    
    init(bag: Bag) {
        self.bag = bag
    }
    
    func buy(ticket: Ticket) -> Double {
        if bag.hasInvitation() {
            bag.setTicket(ticket: ticket)
            return 0
        } else {
            bag.setTicket(ticket: ticket)
            bag.minusAmount(amount: ticket.getFee())
            return ticket.getFee()
        }
    }
}

/// 매표소: 초대장을 티켓으로 교환하거나, 티켓을 구매할수 있다.
class TiketOffice {
    private var amount: Double
    private var tickets = [Ticket]()
    
    init(amount: Double, tickets: Ticket ...) {
        self.amount = amount
        self.tickets.append(contentsOf: tickets)
    }
    
    func getTicket() -> Ticket {
        return tickets.remove(at: 0)
    }
    
    func minusAmount(amount: Double) {
        self.amount -= amount
    }
    
    func plusAmount(amount: Double) {
        self.amount += amount
    }
}

/// 판매원: 초대장을 티켓으로 교환해 주거나 테켓을 판매하는 역할.
class TicketSeller {
    private ticketOfficce: TiketOffice
    
    init(ticketOfiice: TiketOffice) {
        self.ticketOfficce = ticketOfficce
    }
    
    // MARK: TicketOffice에 접근하는 코드를 TicketSeller로 이동
    func sellTo(audience: Audience) {
        ticketOfficce.plusAmount(amount: audience.buy(ticket: ticketOfficce.getTicket()))
    }
}

/// 소극장을 구현을 구현하는 클래스
class Theater {
    private var ticketSeller: TicketSeller
    
    init(ticketSeller: TicketSeller) {
        self.ticketSeller = ticketSeller
    }
    
    func enter(audience: Audience) {
        
    }
}

