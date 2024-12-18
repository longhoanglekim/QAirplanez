import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAircraftStore = defineStore('aircraft', () => {
  const aircraft = ref([])
  const reloadAircraft = async () => {
    const response = await fetch('http://localhost:8080/api/aircraft/admin_aircraft/aircraftList', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': localStorage.getItem('adminToken'),
        'Accept': 'application/json'
      }
    })
    aircraft.value = await response.json()
  }

  const getAircraft = () => {
    return aircraft.value
  }

  const addAircraft = async (aircraft) => {
    try {
      const response = await fetch('http://localhost:8080/api/aircraft/admin_aircraft/addAircraft', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': localStorage.getItem('adminToken'),
          'Accept': 'application/json'
        },
        body: JSON.stringify(aircraft)
      });
  
      if (response.ok) {
        await reloadAircraft();
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
  };

  const editAircraft = async (aircraft) => {
    try {
        const response = await fetch('http://localhost:8080/api/aircraft/admin_aircraft/editAircraft', {
            method: 'PUT',
            headers: {
            'Content-Type': 'application/json',
            'Authorization': localStorage.getItem('adminToken'),
            'Accept': 'application/json'
        },
        body: JSON.stringify(aircraft)
    })
    if (response.ok) {
        await reloadAircraft();
        return { success: true };
      } else {
        return { success: false };
      }
    } catch (error) {
        console.error('Error editing aircraft:', error);
        return { success: false, message: error.message || 'Network error occurred' };
    }
  }

  const deleteAircraft = async (aircraft) => {
    try {
        const response = await 
        fetch(`http://localhost:8080/api/aircraft/admin_aircraft/delete_aircraft?serial_number=${aircraft.serialNumber}`, {
            method: 'DELETE',
            headers: {
            'Content-Type': 'application/json',
            'Authorization': localStorage.getItem('adminToken'),
            'Accept': 'application/json'
        }
    })
    if (response.ok) {
        await reloadAircraft();
        return { success: true };
      } else {
        return { success: false };
      }
    } catch (error) {
        console.error('Error deleting aircraft:', error);
        return { success: false, message: error.message || 'Network error occurred' };
    }
  }

  const getAircraftByCode = (code) => {
    return aircraft.value.find(aircraft => aircraft.serialNumber === code)
  }

  const getActiveAircraft = () => {
    return aircraft.value.filter(aircraft => aircraft.status === 'Active')
  }

  const getInactiveAircraft = () => {
    return aircraft.value.filter(aircraft => aircraft.status === 'Inactive')
  }

  return { getAircraft, reloadAircraft, 
    addAircraft, editAircraft, deleteAircraft, 
    getAircraftByCode, getActiveAircraft, getInactiveAircraft }
})