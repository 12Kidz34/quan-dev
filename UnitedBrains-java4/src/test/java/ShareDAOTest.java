import static org.junit.jupiter.api.Assertions.*;

import com.java04.entity.Share;
import com.java04.entity.Users;
import com.java04.entity.Video;
import com.java04.service.ShareDAO;
import com.java04.service.ShareDAOImpl;
import com.java04.utils.XJPA;
import org.junit.jupiter.api.*;

import javax.persistence.EntityManager;
import java.util.Date;
import java.util.List;

public class ShareDAOTest {

    private ShareDAO dao;

    @BeforeEach
    public void setUp() {
        dao = new ShareDAOImpl();
    }

    @Test
    void testCreateShare() {
        Share share = new Share();
        share.setEmails("test@example.com");
        share.setShareDate(new Date());

        EntityManager em = XJPA.getEntityManager();
        Users user = em.find(Users.class, "admin");
        Video video = em.find(Video.class, "VID001");

        share.setUser(user);
        share.setVideo(video);

        ShareDAO dao = new ShareDAOImpl();
        dao.create(share);

        // Kiểm tra xem share có được lưu thành công không
        List<Share> list = dao.findAll();
        boolean exists = list.stream().anyMatch(s -> "test@example.com".equals(s.getEmails()));
        assertTrue(exists);   // ✅ expected: true
    }


    @Test
    public void testFindAll() {
        List<Share> list = dao.findAll();
        assertNotNull(list);
    }

    @Test
    public void testFindById() {
        // Giả sử trong DB đã có share có ID = 1
        Share share = dao.findById(1L);
        assertNotNull(share);
    }

    @Test
    public void testUpdateShare() {
        Share share = dao.findById(1L);
        assertNotNull(share);
        share.setEmails("updated@gmail.com");
        dao.update(share);

        Share updated = dao.findById(1L);
        assertEquals("updated@gmail.com", updated.getEmails());
    }

    @Test
    public void testDeleteShare() {
        Share s = new Share();
        s.setUser(new Users("admin"));
        s.setVideo(new Video("video1"));
        s.setEmails("delete_test@gmail.com");
        s.setShareDate(new java.util.Date());

        dao.create(s);
        Long id = s.getId();

        dao.deleteById(id);

        Share deleted = dao.findById(id);
        assertNull(deleted);
    }

    @Test
    public void testGetUsersByVideoId() {
        List<Share> list = dao.getUsersByVideoId("video1");
        assertNotNull(list);
    }

    @Test
    public void testGetShareVideoInfo() {
        List<Object[]> info = dao.getShareVideoInfo();
        assertNotNull(info);
    }
}
