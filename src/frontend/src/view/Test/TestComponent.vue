<template>
<<<<<<< HEAD
   <div class="bg-gradient-to-r from-red-300 via-orange-500 to-yellow-100">
        <h2 class="text-xl font-bold mb-4">Quản Lý Máy Bay</h2>

        <!-- Thanh tìm kiếm và sắp xếp -->
        <div class="flex flex-col md:flex-row mb-4">
            <input v-model="searchTerm" placeholder="Tìm kiếm máy bay..." class="block md:flex-1 p-2 border rounded" />
            <select v-model="sortBy" class="p-2 border rounded">
                <option value="">Sắp xếp theo</option>
                <option value="id">Mã Máy Bay</option>
                <option value="model">Mô Hình</option>
                <option value="capacity">Sức Chứa</option>
                <option value="status">Trạng Thái</option>
            </select>
            <button @click="toggleSortOrder" class="p-2 border rounded">
                {{ sortOrder === 'asc' ? '▲' : '▼' }}
            </button>
            <button @click="startAddNew" class="p-2 border rounded bg-blue-500 hover:bg-green-500 text-white">
                Thêm máy bay
            </button>
        </div>

        <div class="mb-4">
            <select v-if="selectedAircraft.length > 0" v-model="bulkAction" @change="handleBulkAction" class="p-2 border rounded">
                <option value="" disabled>Chọn hành động cho máy bay đã chọn</option>
                <option value="edit">Chỉnh sửa</option>
                <option value="delete">Xóa</option>
            </select>
        </div>

        <!-- Modal chỉnh sửa (giữ nguyên) -->
        <div v-if="editingAircraft" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white p-6 rounded-lg w-1/2">
                <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Máy Bay</h3>
                <div class="space-y-4">
                    <label for="">Mã máy bay</label>
                    <input v-model="editingAircraft.id" placeholder="Mã Máy Bay" class="w-full p-2 border rounded" />
                    <label for="">Tên mẫu</label>
                    <input v-model="editingAircraft.model" placeholder="Mô Hình" class="w-full p-2 border rounded" />
                    <label for="">Sức chứa</label>
                    <input v-model.number="editingAircraft.capacity" type="number" placeholder="Sức Chứa" class="w-full p-2 border rounded" />
                    <label for="">Trạng thái</label>
                    <select v-model="editingAircraft.status" class="w-full p-2 border rounded">
                        <option>Active</option>
                        <option>Maintenance</option>
                        <option>Inactive</option>
                    </select>
                    <div class="flex justify-end space-x-2">
                        <button @click="cancelEdit" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
                        <button @click="saveAircraft" class="bg-blue-500 text-white p-2 rounded">Lưu</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal thêm máy bay -->
        <div v-if="newAircraft" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white p-6 rounded-lg w-1/2">
                <div class="block">
                        <button>hanh dong</button>
                        <button @click="startEdit(plane)" class="bg-blue-500 text-white h rounded">
                            Sửa
                        </button>
                        <button class="bg-red-500 hover:bg-red-700 text-white font-bold border border-red-500 rounded">Xóa</button>
                    </div>
                <h3 class="text-lg font-bold mb-4">Thêm Máy Bay Mới</h3>
                <div class="space-y-4">
                    <label for="">Mã máy bay</label>
                    <input v-model="newAircraft.id" placeholder="Mã Máy Bay" class="w-full p-2 border rounded" />
                    <label for="">Tên mẫu</label>
                    <input v-model="newAircraft.model" placeholder="Mô Hình" class="w-full p-2 border rounded" />
                    <label for="">Sức chứa</label>
                    <input v-model.number="newAircraft.capacity" type="number" placeholder="Sức Chứa" class="w-full p-2 border rounded" />
                    <label for="">Trạng thái</label>
                    <select v-model="newAircraft.status" class="w-full p-2 border rounded">
                        <option>Active</option>
                        <option>Maintenance</option>
                        <option>Inactive</option>
                    </select>
                    <div class="flex justify-end space-x-2">
                        <button @click="cancelAdd" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
                        <button @click="addAircraft" class="bg-green-500 text-white p-2 rounded">Thêm</button>
                    </div>
                    
                </div>
            </div>
        </div>


        <!-- Bảng máy bay -->
        <table id="data-tbl" class="w-full border">
            <thead>
                <tr>
                    <th class="border p-2">
                        <input type="checkbox" v-model="allSelected" @change="toggleSelectAll" />
                    </th>
                    <th v-for="col in columns" :key="col.key" @click="updateSort(col.key)" class="border p-2 cursor-pointer bg-blue-300 hover:bg-blue-500">
                        {{ col.label }}
                        <span v-if="sortBy === col.key">
                            {{ sortOrder === 'asc' ? '▲' : '▼' }}
                        </span>
                    </th>
                    
                </tr>
            </thead>
            <tbody>
                <tr v-for="plane in filteredAndSortedAircraft" :key="plane.id">
                    <td class="border p-2">
                        <input type="checkbox" v-model="selectedAircraft" :value="plane.id" />
                    </td>
                    <td class="border p-2">{{ plane.id }}</td>
                    <td class="border p-2">{{ plane.model }}</td>
                    <td class="border p-2">{{ plane.capacity }}</td>
                    <td class="border p-2 font-semibold leading-tight rounded-sm">
                        <span class="py-2 px-3" :class="{'text-green-700 bg-green-100 ': plane.status == 'Hoat dong'
                                        , 'text-amber-500 bg-amber-100 ' : plane.status == 'Bao duong'
                                        , 'text-red-500 bg-red-100' : plane.status == 'Sua chua'
                                                    }">{{ plane.status }}</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { aircraft } from '@/assets/data'

// Columns định nghĩa
const columns = [
    { key: 'id', label: 'Mã Máy Bay' },
    { key: 'model', label: 'Mô Hình' },
    { key: 'capacity', label: 'Sức Chứa' },
    { key: 'status', label: 'Trạng Thái' }
]

// State quản lý
const searchTerm = ref('')
const sortBy = ref('')
const sortOrder = ref('asc')
const editingAircraft = ref(null)
const newAircraft = ref(null)
const selectedAircraft = ref([]) // List of selected aircraft ids
const allSelected = ref(false) // To manage the "Select All" checkbox
const bulkAction = ref('') // Track bulk action selected (edit or delete)

// Hàm tìm kiếm
const filteredAndSortedAircraft = computed(() => {
    let result = aircraft.filter(plane =>
        Object.values(plane).some(val =>
            val.toString().toLowerCase().includes(searchTerm.value.toLowerCase())
        )
    )

    // Sắp xếp
    if (sortBy.value) {
        result.sort((a, b) => {
            let modifier = sortOrder.value === 'asc' ? 1 : -1
            return a[sortBy.value] > b[sortBy.value] ? modifier : -modifier
        })
    }

    return result
})

// Hàm hỗ trợ
const updateSort = (key) => {
    if (sortBy.value === key) {
        toggleSortOrder()
    } else {
        sortBy.value = key
        sortOrder.value = 'asc'
    }
}

const toggleSortOrder = () => {
    sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc'
}

const toggleSelectAll = () => {
    if (allSelected.value) {
        selectedAircraft.value = filteredAndSortedAircraft.value.map(plane => plane.id)
    } else {
        selectedAircraft.value = []
    }
}

// Các hàm chỉnh sửa
const startEdit = (plane) => {
    editingAircraft.value = { ...plane }
}

const cancelEdit = () => {
    editingAircraft.value = null
}

const saveAircraft = () => {
    const index = aircraft.findIndex(a => a.id === editingAircraft.value.id)
    if (index !== -1) {
        aircraft[index] = { ...editingAircraft.value }
    }
    editingAircraft.value = null
}

// Các hàm thêm mới
const startAddNew = () => {
    newAircraft.value = {
        id: '',
        model: '',
        capacity: 0,
        status: 'Active'
    }
}

const cancelAdd = () => {
    newAircraft.value = null
}

const addAircraftToServer = () => {
  // eslint-disable-next-line
  var res = fetch("http://localhost:8080/api/")
}

const addAircraft = () => {
    if (newAircraft.value) {
        addAircraftToServer();
        
        var tbl = document.getElementById("data-tbl").getElementsByTagName('tbody')[0];
          // Tạo một hàng mới
        const newRow = tbl.insertRow();

        // Thêm các ô (cột) vào hàng mới
        const idCell = newRow.insertCell(0);
        const modelCell = newRow.insertCell(1);
        const capacityCell = newRow.insertCell(2);
        const statusCell = newRow.insertCell(3);

        // Gán giá trị cho các ô
        idCell.innerHTML = newAircraft.value.id;           // Thay giá trị tùy ý
        modelCell.innerHTML = newAircraft.value.model; // Thay giá trị tùy ý
        capacityCell.innerHTML = newAircraft.value.capacity;
        statusCell.innerHTML = newAircraft.value.status;
        
        newAircraft.value = null;
    }
}

const handleBulkAction = () => {
    if (bulkAction.value === 'edit') {
        console.log('abc')
    } else if (bulkAction.value === 'delete') {
        console.log('def')
    }
}

</script>
=======
<div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-red-500/50">
    <!-- Header -->
    <div class="p-4 bg-red-600 text-white flex justify-between items-center">
        <div class="flex items-center">
            <span class="text-xl font-bold mr-2">{{ ticket.departureCode }}</span>
            <MoveRight class="" />
            <span class="text-xl font-bold ml-2">{{ ticket.arrivalCode }}</span>
        </div>
        <div class="text-sm">{{ ticket.flightNumber }}</div>
    </div>

    <div class="p-4">
        <!-- Flight Time -->
        <div class="flex justify-between mb-4">
            <div>
                <p class="text-orange-600 text-sm">Khởi hành</p>
                <p class="font-semibold">{{ ticket.departureTime }}</p>
                <p class="text-xs text-gray-500">{{ ticket.departureDate }}</p>
            </div>
            <MoveRight class="text-red-600" />
            <div class="text-right">
                <p class="text-orange-600 text-sm">Đến nơi</p>
                <p class="font-semibold">{{ ticket.arrivalTime }}</p>
                <p class="text-xs text-gray-500">{{ ticket.arrivalDate }}</p>
            </div>
        </div>

        <!-- Ticket Class Selection -->
        <div class="mb-4">
            <p class="text-orange-600 text-sm mb-2">Chọn hạng vé</p>
            <div class="flex space-x-2">
                <button v-for="(ticketClass, index) in ticketClasses" :key="index" @click="ticket.selectedClass = (ticket.selectedClass === ticketClass.value ? null: ticketClass.value)" :class="[
                    'px-3 py-1 rounded-full text-sm transition-colors duration-200 border',
                    ticket.selectedClass === ticketClass.value 
                        ? 'bg-orange-500 text-white border-orange-500' 
                        : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-100'
                ]">
                    {{ ticketClass.label }}
                </button>
            </div>
        </div>

        <!-- Baggage Information -->
        <div v-if="ticket.selectedClass" class="bg-pink-50 p-3 rounded-lg mb-4">
            <div class="flex justify-between">
                <div>
                    <p class="text-orange-600 text-xs">Hành lý xách tay</p>
                    <p class="font-medium text-sm">
                        {{ getBaggageInfo(ticket.selectedClass).carryon }} kg
                    </p>
                </div>
                <div>
                    <p class="text-orange-600 text-xs">Hành lý ký gửi</p>
                    <p class="font-medium text-sm">
                        {{ getBaggageInfo(ticket.selectedClass).checkedbaggage }} kg
                    </p>
                </div>
            </div>
        </div>

        <!-- Price and Flight Duration -->
        <div class="bg-pink-50 p-3 rounded-lg mb-4">
            <div class="flex justify-between items-center">
                <div>
                    <p class="text-orange-600 text-xs">Giá</p>
                    <p class="font-bold text-lg text-red-600">
                        {{ calculateTicketPrice(ticket) }}
                    </p>
                </div>
                <div class="text-right">
                    <p class="text-orange-600 text-xs">Thời gian bay</p>
                    <p class="font-medium text-sm text-rose-700">
                        {{ calculateFlightDuration(ticket) }} phút
                    </p>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex space-x-2">
            <button :disabled="!ticket.selectedClass" class="flex-1 px-4 py-2 rounded-lg transition-colors 
                text-white font-semibold
                disabled:bg-gray-400 
                bg-orange-500 hover:bg-orange-600">
                Chọn chuyến
            </button>
        </div>
    </div>
</div>
</template>

<script>
export default {
    props: {
        seatCode: {
            type: String,
            default: 'ABCD123'
        },
        classType: {
            type: String,
            default: 'Hạng Phổ Thông'
        },
        ticketType: {
            type: String,
            default: 'Người Lớn'
        },
        departureCode: {
            type: String,
            default: 'HAN'
        },
        departureName: {
            type: String,
            default: 'Hà Nội'
        },
        arrivalCode: {
            type: String,
            default: 'SGN'
        },
        arrivalName: {
            type: String,
            default: 'Hồ Chí Minh'
        },
        departureTime: {
            type: String,
            default: '07:30 AM, 15/12/2024'
        },
        arrivalTime: {
            type: String,
            default: '09:00 AM, 15/12/2024'
        },
        flightNumber: {
            type: String,
            default: 'VN-245'
        },
        airline: {
            type: String,
            default: 'Vietnam Airlines'
        },
        passengerName: {
            type: String,
            default: 'Nguyễn Văn A'
        },
        passengerIdentity: {
            type: String,
            default: '001234567890'
        },
        price: {
            type: [Number, String],
            default: '0,000,000'
        },
        seatPosition: {
            type: String,
            default: 'A49'
        }
    },
    name: 'BookedTicket',

}
</script>

<style scoped>
@keyframes pulse {

    0%,
    100% {
        transform: scale(1);
    }

    50% {
        transform: scale(1.02);
    }
}

.hover\:animate-pulse:hover {
    animation: pulse 1s infinite;
}
</style>
>>>>>>> be6e331d7d7252cad70538c5d7b9b4c30e001290
