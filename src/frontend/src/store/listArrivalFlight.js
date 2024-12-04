const useListArrivalFlightStore = () => {
    const getFlights = () => {
        return JSON.parse(sessionStorage.getItem('arrival-flights') || '[]');
    };

    const saveFlights = (flights) => {
        sessionStorage.setItem('arrival-flights', JSON.stringify(flights));
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
        sessionStorage.removeItem('arrival-flights');
    };

    return {
        getFlights,
        addFlight,
        removeFlight,
        clearFlights,
        saveFlights
    };
};

export default useListArrivalFlightStore;