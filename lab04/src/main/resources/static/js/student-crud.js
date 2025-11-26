const host = "https://java06-78626-default-rtdb.asia-southeast1.firebasedatabase.app/";

const $api = {
    key: null,

    // Lấy dữ liệu từ form
    get student() {
        return {
            id: $("#id").val(),
            name: $("#name").val(),
            mark: $("#mark").val(),
            gender: $("#male").prop("checked")
        };
    },

    // Đổ dữ liệu lên form
    set student(e) {
        $("#id").val(e.id || "");
        $("#name").val(e.name || "");
        $("#mark").val(e.mark || "");
        $("#male").prop("checked", e.gender ?? false);
        $("#female").prop("checked", !(e.gender ?? false));
    },

    // Load danh sách sinh viên vào table
    fillToTable() {
        var url = `${host}/student.json`;
        axios.get(url).then(resp => {
            $("tbody").empty();
            Object.keys(resp.data || {}).forEach(key => {
                var e = resp.data[key];
                var tr = `
                    <tr>
                        <td>${e.id}</td>
                        <td>${e.name}</td>
                        <td>${e.mark}</td>
                        <td>${e.gender ? 'Male' : 'Female'}</td>
                        <td>
                            <a href="#" onclick="$api.edit('${key}')">Edit</a> |
                            <a href="#" onclick="$api.delete('${key}')">Delete</a>
                        </td>
                    </tr>`;
                $("tbody").append(tr);
            });
        }).catch(error => {
            alert("Lỗi tải danh sách sinh viên!");
        });
    },

    // Edit 1 sinh viên
    edit(key) {
        this.key = key.trim();
        var url = `${host}/student/${key}.json`;
        axios.get(url).then(resp => {
            this.student = resp.data;
        }).catch(error => {
            alert("Lỗi tải sinh viên!");
        });
    },

    // Create sinh viên mới
    create() {
        var url = `${host}/student.json`;
        axios.post(url, this.student).then(resp => {
            this.fillToTable();
            this.reset();
        }).catch(error => {
            alert("Lỗi thêm sinh viên mới!");
        });
    },

    // Update sinh viên
    update() {
        if (!this.key) return alert("Bạn phải chọn Edit trước!");
        var url = `${host}/student/${this.key}.json`;
        axios.put(url, this.student).then(resp => {
            this.fillToTable();
        }).catch(error => {
            alert("Lỗi cập nhật sinh viên!");
        });
    },

    // Delete sinh viên
    delete(key) {
        key = key || this.key;
        if (!key) return alert("Bạn phải chọn Edit hoặc nhấn Delete tại bảng!");
        var url = `${host}/student/${key}.json`;
        axios.delete(url).then(resp => {
            this.fillToTable();
            this.reset();
        }).catch(error => {
            alert("Lỗi xóa sinh viên!");
        });
    },

    // Reset form
    reset() {
        this.student = {};
        this.key = null;
    }
};

// Load dữ liệu khi mở trang
$api.fillToTable();
