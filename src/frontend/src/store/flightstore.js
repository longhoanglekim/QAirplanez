import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useFlightStore = defineStore('flight', () => {
    const flights = ref([])
    const reloadFlights = async () => {
        const response = await fetch('http://localhost:8080/api/flight/admin_flight/flightList', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': localStorage.getItem('adminToken'),
                'Accept': 'application/json'
            }
        })
        if (response.ok) {
            flights.value = await response.json()
        }
    }

    const getFlights = () => {
        return flights.value
    }

    const addFlight = async (flight) => {
        try {
            const response = await fetch('http://localhost:8080/api/flight/admin_flight/addFlight', {
                method: 'POST',
                headers: {
                'Content-Type': 'application/json',
                'Authorization': localStorage.getItem('adminToken'),
                'Accept': 'application/json'
            },
            body: JSON.stringify(flight)
        })

        
        if (response.ok) {
            await reloadFlights();
            return { success: true };
          } else {
            // Handle different types of error responses
            const errorText = await response.text();
            const errorStatus = response.status;
            
            return {
              success: false,
              status: errorStatus,
              message: errorText
            };
          }
        } catch (error) {
          console.error('Error adding aircraft:', error);
          return {
            success: false,
            message: error.message || 'Network error occurred'
          };
        }
    }

    const editFlight = async (flight) => {
        try {
            const response = await fetch('http://localhost:8080/api/flight/admin_flight/editFlight', {
                method: 'PUT',
                headers: {
                'Content-Type': 'application/json',
                'Authorization': localStorage.getItem('adminToken'),
                'Accept': 'application/json'
            },
            body: JSON.stringify(flight)
        })
        if (response.ok) {
            await reloadFlights();
            return { success: true };
          } else {
            return { success: false };
          }
        } catch (error) {
            console.error('Error editing flight:', error);
            return { success: false, message: error.message || 'Network error occurred' };
        }
    }

    const deleteFlight = async (flight) => {
        try {
            const response = await fetch(`http://localhost:8080/api/flight/admin_flight/deleteFlight?flight_number=${flight.flightNumber}`, {
                method: 'DELETE',
                headers: {
                'Content-Type': 'application/json',
                'Authorization': localStorage.getItem('adminToken'),
                'Accept': 'application/json'
            }
        })
        if (response.ok) {
            await reloadFlights();
            return { success: true };
          } else {
            return { success: false };
          }
        } catch (error) {
            console.error('Error deleting flight:', error);
            return { success: false, message: error.message || 'Network error occurred' };
        }
    }

    return { reloadFlights, getFlights, addFlight, editFlight, deleteFlight }
})