export const aircraft = [
    { id: 'AB001', model: 'Boeing 737', capacity: 180, status: 'Hoat dong' },
    { id: 'AB002', model: 'Airbus A320', capacity: 220, status: 'Bao duong' }, 
    { id: 'AB003', model: 'Boeing MH370', capacity: 220, status: 'Hoat dong' }, 
    { id: 'AB004', model: 'Airbus B240', capacity: 220, status: 'Hoat dong' }, 
    { id: 'AB005', model: 'Airbus C320', capacity: 220, status: 'Hoat dong' }, 
    { id: 'AB006', model: 'Boeing M300', capacity: 220, status: 'Sua chua' },
    { id: 'AB007', model: 'Boeing M300', capacity: 220, status: 'Sua chua' },
    { id: 'AB008', model: 'Boeing M300', capacity: 220, status: 'Sua chua' }
  ]
  
  export const flights = [
    { 
        id: 'FL001', 
        origin: 'Hà Nội', 
        destination: 'Hồ Chí Minh', 
        aircraft: 'AB001', 
        departureTime: '2024-06-15T10:00:00',
        status: 'Scheduled' 
    }, 
    { 
        id: 'FL002', 
        origin: 'Hà Nội', 
        destination: 'Hồ Chí Minh', 
        aircraft: 'AB001', 
        departureTime: '2024-06-15T10:00:00',
        status: 'Scheduled' 
    }, 
    { 
        id: 'FL003', 
        origin: 'Hà Nội', 
        destination: 'Hồ Chí Minh', 
        aircraft: 'AB001', 
        departureTime: '2024-06-15T10:00:00',
        status: 'Scheduled' 
    }
  ]
  
  export const passengers = [
    { 
      id: 'P001', 
      name: 'Nguyễn Văn A', 
      flightId: 'FL001', 
      seatNumber: '12A', 
      ticketClass: 'Economy' 
    },
    { 
        id: 'P001', 
        name: 'Nguyễn Văn A', 
        flightId: 'FL001', 
        seatNumber: '12A', 
        ticketClass: 'Economy' 
    },
    { 
        id: 'P001', 
        name: 'Nguyễn Văn A', 
        flightId: 'FL001', 
        seatNumber: '12A', 
        ticketClass: 'Economy' 
    },
    { 
        id: 'P001', 
        name: 'Nguyễn Văn A', 
        flightId: 'FL001', 
        seatNumber: '12A', 
        ticketClass: 'Economy' 
    }
  ]