import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useTicketStore = defineStore('ticket', () => {
    // Function to save ticket to sessionStorage
    const saveTicketToStorage = (key, ticket) => {
        try {
            sessionStorage.setItem(key, JSON.stringify(ticket))

        } catch (error) {
            console.error('Error saving ticket to sessionStorage:', error)
        }
    }

    // Function to get ticket from sessionStorage
    const getTicketFromStorage = (key) => {
        try {
            const storedTicket = sessionStorage.getItem(key)
            return storedTicket ? JSON.parse(storedTicket) : {
                arrivalCode: '',
                arrivalName:'',
                arrivalDate: '',
                arrivalTime: '',
                price: '',
                departureCode: '',
                departureName: '',
                departureDate: '',
                departureTime: '',
                flightNumber: '',
                selectedClass: '',
                adults: 0,
                children: 0
            }
        } catch (error) {
            console.error('Error retrieving ticket from sessionStorage:', error)
            return {
                arrivalCode: '',
                arrivalName:'',
                arrivalDate: '',
                arrivalTime: '',
                price: '',
                departureCode: '',
                departureName: '',
                departureDate: '',
                departureTime: '',
                flightNumber: '',
                selectedClass: '',
                adults: 0,
                children: 0
            }
        }
    }

    // Reactive references for departure and arrival tickets
    const selectedDeparture = ref(getTicketFromStorage('departureTicket'))
    const selectedArrival = ref(getTicketFromStorage('arrivalTicket'))

    // Save departure ticket
    const saveDepartureTicket = (selectedTicket) => {
        selectedDeparture.value = {...selectedTicket}
        saveTicketToStorage('departureTicket', selectedTicket)
    }

    // Save arrival ticket
    const saveArrivalTicket = (selectedTicket) => {
        selectedArrival.value = {...selectedTicket}
        saveTicketToStorage('arrivalTicket', selectedTicket)
    }

    // Get selected arrival ticket
    const getSelectedArrival = () => {
        return selectedArrival.value
    }

    // Get selected departure ticket
    const getSelectedDeparture = () => {
        return selectedDeparture.value
    }

    const saveAdultInformation = (information) => {
        sessionStorage.setItem('adultInformation', JSON.stringify(information))
    }

    const saveChildInformation = (information) => {
        sessionStorage.setItem('childInformation', JSON.stringify(information))
    }

    const getAdultInformation = () => {
        return JSON.parse(sessionStorage.getItem('adultInformation'))
    }

    const getChildInformation = () => {
        return JSON.parse(sessionStorage.getItem('childInformation'))
    }

    const getPassengerInformation = (seatsSelectedDepart, seatsSelectedReturn) => {
        const adultInformation = getAdultInformation()
        const childInformation = getChildInformation()
        const passengerInfoList = []
        let j = 0, k = 0
        for(let i = 0; i < adultInformation.length; i++) {
            passengerInfoList.push({
                firstName: adultInformation[i].firstName,
                lastName: adultInformation[i].lastName,
                birthdate: adultInformation[i].birthDate,
                gender: adultInformation[i].gender,
                identification: adultInformation[i].cccd,
                phoneNumber: adultInformation[i].phone,
                email: adultInformation[i].email,
                outboundTicketClassCode: getSelectedDeparture().selectedClass.charAt(0).toUpperCase() + getSelectedDeparture().selectedClass.slice(1), //"economy" to "Economy"
                inboundTicketClassCode: getSelectedArrival().selectedClass ? getSelectedArrival().selectedClass.charAt(0).toUpperCase() + getSelectedArrival().selectedClass.slice(1) : '',
                outboundSeatCode: j < seatsSelectedDepart.length ? seatsSelectedDepart[j] : '',
                inboundSeatCode: seatsSelectedReturn && k < seatsSelectedReturn.length ? seatsSelectedReturn[k] : ''
            })
            j++
            k++
        }
        for(let i = 0; i < childInformation.length; i++) {
            passengerInfoList.push({
                firstName: childInformation[i].firstName,
                lastName: childInformation[i].lastName,
                birthdate: childInformation[i].birthDate,
                gender: childInformation[i].gender,
                identification: childInformation[i].cccd,
                outboundTicketClassCode: getSelectedDeparture().selectedClass.charAt(0).toUpperCase() + getSelectedDeparture().selectedClass.slice(1), //"economy" to "Economy"
                inboundTicketClassCode: getSelectedArrival().selectedClass ? getSelectedArrival().selectedClass.charAt(0).toUpperCase() + getSelectedArrival().selectedClass.slice(1) : '',
                outboundSeatCode: j < seatsSelectedDepart.length ? seatsSelectedDepart[j] : '',
                inboundSeatCode: seatsSelectedReturn && k < seatsSelectedReturn.length ? seatsSelectedReturn[k] : ''
            })
            j++
            k++
        }
        return passengerInfoList
    }

    const getTicketPrice = () => {
        let price = 0
        price += getSelectedDeparture().price * (getSelectedDeparture().adults + getSelectedDeparture().children)
        price += getSelectedArrival().price * (getSelectedArrival().adults + getSelectedArrival().children)
        return price
    }

    const clear = () => {
        try {
            sessionStorage.removeItem('departureTicket');
            sessionStorage.removeItem('arrivalTicket');
            sessionStorage.removeItem('adultInformation');
            sessionStorage.removeItem('childInformation');
            selectedDeparture.value = {
                arrivalCode: '',
                arrivalName: '',
                arrivalDate: '',
                arrivalTime: '',
                price: '',
                departureCode: '',
                departureName: '',
                departureDate: '',
                departureTime: '',
                flightNumber: '',
                selectedClass: '',
                adults: 0,
                children: 0
            };
            selectedArrival.value = {
                arrivalCode: '',
                arrivalName: '',
                arrivalDate: '',
                arrivalTime: '',
                price: '',
                departureCode: '',
                departureName: '',
                departureDate: '',
                departureTime: '',
                flightNumber: '',
                selectedClass: '',
                adults: 0,
                children: 0
            };
        } catch (error) {
            console.error('Error clearing sessionStorage and store:', error);
        }
    };

    const allBookings = ref([])
    const bookingsData = ref({
        daily: [],
        monthly: [],
        yearly: []
    })

    const fetchAllBookings = async () => {
        try {
            const response = await fetch('http://localhost:8080/api/booking/public/bookingList')
            if (!response.ok) {
                throw new Error('Failed to fetch bookings')
            }
            const data = await response.json()
            allBookings.value = data
            return formatBookingData(data)
        } catch (error) {
            console.error('Error fetching bookings:', error)
            return []
        }
    }

    const formatBookingData = (bookings) => {
        // Format data for different time periods
        const daily = {}
        const monthly = {}
        const yearly = {}

        bookings.forEach(booking => {
            const date = new Date(booking.bookingDate)
            const dayKey = date.toISOString().split('T')[0]
            const monthKey = `${date.getFullYear()}-${date.getMonth() + 1}`
            const yearKey = date.getFullYear()

            daily[dayKey] = (daily[dayKey] || 0) + 1
            monthly[monthKey] = (monthly[monthKey] || 0) + 1
            yearly[yearKey] = (yearly[yearKey] || 0) + 1
        })

        bookingsData.value = {
            daily: Object.entries(daily).map(([date, count]) => ({ date, count })),
            monthly: Object.entries(monthly).map(([month, count]) => ({ month, count })),
            yearly: Object.entries(yearly).map(([year, count]) => ({ year: parseInt(year), count }))
        }

        return bookingsData.value
    }

    return {
        saveDepartureTicket, 
        saveArrivalTicket, 
        getSelectedArrival, 
        getSelectedDeparture,
        saveAdultInformation,
        saveChildInformation,
        getAdultInformation,
        getChildInformation,
        getPassengerInformation,
        getTicketPrice, 
        clear,
        allBookings,
        bookingsData,
        fetchAllBookings
    }
})

export default {
  state: {
    chartPeriod: 'month', // 'week', 'month', 'year'
    chartData: {
      weekly: [],
      monthly: [],
      yearly: []
    }
  },

  mutations: {
    SET_CHART_PERIOD(state, period) {
      state.chartPeriod = period;
    },
    SET_CHART_DATA(state, { period, data }) {
      state.chartData[period] = data;
    }
  },

  actions: {
    async getChartData({ commit }, period) {
      try {
        const tickets = await this.getTickets(); // Assuming this gets ticket data
        let formattedData;

        switch(period) {
          case 'week':
            formattedData = formatWeeklyData(tickets);
            break;
          case 'month':
            formattedData = formatMonthlyData(tickets);
            break;
          case 'year':
            formattedData = formatYearlyData(tickets);
            break;
        }

        commit('SET_CHART_DATA', { period, data: formattedData });
        commit('SET_CHART_PERIOD', period);
      } catch (error) {
        console.error('Error getting chart data:', error);
      }
    }
  },

  getters: {
    getCurrentChartData: (state) => state.chartData[state.chartPeriod],
    getChartPeriod: (state) => state.chartPeriod
  }
}

// Helper functions for data formatting
function formatWeeklyData(tickets) {
  const weeks = {};
  tickets.forEach(ticket => {
    const date = new Date(ticket.departureDate);
    const weekNumber = getWeekNumber(date);
    weeks[weekNumber] = (weeks[weekNumber] || 0) + 1;
  });
  return Object.entries(weeks).map(([week, count]) => ({ week, count }));
}

function formatMonthlyData(tickets) {
  const months = {};
  tickets.forEach(ticket => {
    const date = new Date(ticket.departureDate);
    const month = date.getMonth();
    months[month] = (months[month] || 0) + 1;
  });
  return Object.entries(months).map(([month, count]) => ({ month, count }));
}

function formatYearlyData(tickets) {
  const years = {};
  tickets.forEach(ticket => {
    const date = new Date(ticket.departureDate);
    const year = date.getFullYear();
    years[year] = (years[year] || 0) + 1;
  });
  return Object.entries(years).map(([year, count]) => ({ year, count }));
}

function getWeekNumber(date) {
  const firstDayOfYear = new Date(date.getFullYear(), 0, 1);
  const pastDaysOfYear = (date - firstDayOfYear) / 86400000;
  return Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7);
}