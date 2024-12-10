let aircraft = [];
const fetchAircraftData = async () => {
    try {
        const  response = await fetch('http://localhost:8080/api/aircraft/admin/aircraftList', {
            method : 'Get',
            headers: {
                'Content-Type': 'application/json',
                Authorization:localStorage.getItem('token'),
                'Accept': 'application/json',
            }
        });
        if (response.ok) {
            aircraft = await response.json();
        }
    } catch(error) {
        console.log(error);
    }
}
fetchAircraftData().then(r => console.log(r));
export {aircraft};

let flights = [];

const fetchFlightsData = async () => {
    try {

        const response = await fetch('http://localhost:8080/api/flight/admin_flight/flightList', {
            method: 'GET', // hoặc 'POST' tùy vào loại yêu cầu
            headers: {
                'Content-Type': 'application/json',
                Authorization:localStorage.getItem('token'),
                'Accept': 'application/json',
            }
        });

        if (response.ok) {
            flights = await response.json();
        } else {
            console.error('Lỗi khi lấy dữ liệu chuyến bay từ API');
        }
    } catch (error) {
        console.error('Có lỗi xảy ra khi fetch dữ liệu:', error);
    }
};

// Gọi hàm fetchFlightsData để lấy dữ liệu chuyến bay từ API
fetchFlightsData().then(r => console.log(r));

// Export flights để sử dụng ở các module khác
export { flights };
  
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