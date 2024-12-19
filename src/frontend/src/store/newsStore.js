export const newsStore = () => {
    // Hàm xóa tin tức
    const deleteNews = async (index) => {
        try {
            const response = await fetch(`http://localhost:8080/api/news/admin_news/delete?index=` + index, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': localStorage.getItem('adminToken'),
                }
            });

            if (!response.ok) {
                throw new Error(`Failed to delete news with index ${index}: ${response.statusText}`);
            }

            console.log(`News with index ${index} deleted successfully.`);
            alert('Tin tức đã được xóa thành công!');
        } catch (error) {
            console.error('Error deleting news:', error);
            alert(`Có lỗi xảy ra: ${error.message}`);
        }
    };

    // Hàm chỉnh sửa tin tức
    const editNews = async (index, updatedNews) => {
        try {
            const response = await fetch(`http://localhost:8080/api/news/admin_news/edit?index=` + index, {
                method: 'PUT', // Sử dụng PUT hoặc PATCH tùy thuộc vào API
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': localStorage.getItem('adminToken'),
                },
                body: JSON.stringify(updatedNews) // Gửi dữ liệu chỉnh sửa
            });

            if (!response.ok) {
                throw new Error(`Failed to edit news with index ${index}: ${response.statusText}`);
            }

            const result = await response.json();
            console.log(`News with index ${index} updated successfully:`, result);
            alert('Tin tức đã được chỉnh sửa thành công!');
            return result; // Trả về dữ liệu cập nhật nếu cần
        } catch (error) {
            console.error('Error editing news:', error);
            alert(`Có lỗi xảy ra: ${error.message}`);
        }
    };

    return {
        deleteNews,
        editNews
    };
};

export default newsStore();
