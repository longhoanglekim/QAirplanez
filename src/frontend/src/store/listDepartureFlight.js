const useListDepartureFlightStore = () => {
    const getFlights = () => {
        return JSON.parse(sessionStorage.getItem('departure-flights') || '[]');
    };

    const saveFlights = (flights) => {
        sessionStorage.setItem('departure-flights', JSON.stringify(flights));
    };

    const addFlight = (flight) => {
        const flights = getFlights();
        flights.push(flight);
        saveFlights(flights);
    };

    const removeFlight = (flightNumber) => {
        const flights = getFlights();
        const updatedFlights = flights.filter(f => f.flightNumber !== flightNumber);
        saveFlights(updatedFlights);
    };

    const clearFlights = () => {
        sessionStorage.removeItem('departure-flights');
    };

    return {
        getFlights,
        addFlight,
        removeFlight,
        clearFlights,
        saveFlights
    };
};

export default useListDepartureFlightStore;