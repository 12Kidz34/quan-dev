import com.java04.entity.Users;
import com.java04.service.UsersDAO;
import com.java04.service.UsersDAOImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class UsersDAOTest {

    private UsersDAO dao;

    @BeforeEach
    public void setUp() {
        dao = new UsersDAOImpl();

        Users admin = dao.findById("admin");
        if (admin == null) {
            Users u = new Users();
            u.setId("admin");
            u.setPassword("123");
            u.setEmail("admin@gmail.com");
            u.setFullName("Administrator");
            u.setAdmin(true);
            dao.create(u);
        }
    }


    @Test
    public void testFindById_ExistingUser() {
        Users user = dao.findById("admin");
        assertNotNull(user, "User 'admin' phải tồn tại trong database để test này chạy");
        assertEquals("admin", user.getId());
    }

    @Test
    public void testFindById_NotFound() {
        Users user = dao.findById("abcxyz");
        assertNull(user, "Phải trả về null nếu user không tồn tại");
    }

    @Test
    public void testFindAll() {
        assertFalse(dao.findAll().isEmpty(), "Danh sách user không được rỗng");
    }

    @Test
    public void testCreateUser_Valid() {
        Users u = new Users();
        u.setId("test_user");
        u.setPassword("123");
        u.setAdmin(false);
        u.setEmail("test_user@gmail.com");
        u.setFullName("Test User");  // ✅ Thêm dòng này

        dao.create(u);

        Users found = dao.findById("test_user");
        assertNotNull(found, "User vừa tạo phải tồn tại trong DB");
        assertEquals("test_user", found.getId());

        dao.deleteById("test_user");
    }

    @Test
    public void testUpdateUser() {
        Users u = new Users();
        u.setId("test_user2");
        u.setPassword("123");
        u.setAdmin(false);
        u.setEmail("old@gmail.com");
        u.setFullName("Test User 2"); // ✅ Thêm fullname
        dao.create(u);

        u.setEmail("new@gmail.com");
        dao.update(u);

        Users updated = dao.findById("test_user2");
        assertNotNull(updated);
        assertEquals("new@gmail.com", updated.getEmail(), "Email sau khi update phải khớp");

        dao.deleteById("test_user2");
    }

    @Test
    public void testDeleteUser() {
        Users u = new Users();
        u.setId("test_user3");
        u.setPassword("123");
        u.setAdmin(false);
        u.setEmail("delete@gmail.com");
        u.setFullName("Test User 3"); // ✅ Thêm fullname
        dao.create(u);

        dao.deleteById("test_user3");
        assertNull(dao.findById("test_user3"), "User đã xóa không được tồn tại");
    }

}
