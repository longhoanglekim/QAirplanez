let news = [];
const fetchNewsData = async () => {
    try {
        const  response = await fetch('http://localhost:8080/api/news/public/newsList', {
            method : 'Get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
            }
        });
        if (response.ok) {
            news = await response.json();
        }
    } catch(error) {
        console.log(error);
    }
}
fetchNewsData().then(() => console.log('news'));
export {news};
let airports = [];
const fetchAirportData = async () => {
    try {
        const  response = await fetch('http://localhost:8080/api/airport/public/airportList', {
            method : 'Get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
            }
        });
        if (response.ok) {
            airports = await response.json();
        }
    } catch(error) {
        console.log(error);
    }
}
fetchAirportData().then(() => console.log(airports.at(0)));
export {airports};
let aircraft = [];
const fetchAircraftData = async () => {
    try {
        const  response = await fetch('http://localhost:8080/api/aircraft/admin_aircraft/aircraftList', {
            method : 'Get',
            headers: {
                'Content-Type': 'application/json',
                Authorization:localStorage.getItem('adminToken'),
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
                Authorization:localStorage.getItem('adminToken'),
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
let passengers = [];
const fetchPassengerData = async () => {
    try {
        const response = await fetch('http://localhost:8080/api/passenger/admin_passenger/allPassengers', {

            method: 'GET', // hoặc 'POST' tùy vào loại yêu cầu
            headers: {
                'Content-Type': 'application/json',
                Authorization:localStorage.getItem('adminToken'),
                'Accept': 'application/json',
            }
        });

        if (response.ok) {
            passengers = await response.json();
            console.log(passengers);
        } else {
            console.error('Lỗi khi lấy dữ liệu khách hàng từ API');
        }
    } catch (error) {
        console.error('Có lỗi xảy ra khi fetch dữ liệu:', error);
    }
};

// Gọi hàm fetchFlightsData để lấy dữ liệu chuyến bay từ API
fetchPassengerData().then(() => console.log('passenger'));
export {passengers};