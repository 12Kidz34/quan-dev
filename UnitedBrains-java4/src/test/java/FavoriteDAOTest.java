
import com.java04.entity.Favorite;
import com.java04.entity.Users;
import com.java04.entity.Video;
import com.java04.service.FavoriteDAO;
import com.java04.service.FavoriteDAOImpl;
import org.junit.jupiter.api.*;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class FavoriteDAOTest {

    private FavoriteDAO dao;

    @BeforeEach
    public void setUp() {
        dao = new FavoriteDAOImpl(); // thay bằng class implement thật
    }

    @Test
    public void testFindAll() {
        List<Favorite> list = dao.findAll();
        assertNotNull(list);
    }

    @Test
    public void testCreateAndFindById() {
        Favorite f = new Favorite();

        Users user = new Users();
        user.setId("admin");
        f.setUser(user);

        Video video = new Video();
        video.setId("video1");
        f.setVideo(video);

        f.setLikeDate(new Date());
        dao.create(f);

        List<Favorite> all = dao.findAll();
        Favorite created = all.get(all.size() - 1);

        Favorite found = dao.findById(created.getId());
        assertNotNull(found);
        assertEquals(created.getId(), found.getId());
    }

    @Test
    public void testUpdate() {
        Favorite f = new Favorite();
        Users user = new Users();
        user.setId("admin");
        f.setUser(user);

        Video video = new Video();
        video.setId("video1");
        f.setVideo(video);

        f.setLikeDate(new Date());
        dao.create(f);

        List<Favorite> all = dao.findAll();
        Favorite created = all.get(all.size() - 1);

        Date newDate = new Date(System.currentTimeMillis() - 100000);
        created.setLikeDate(newDate);
        dao.update(created);

        Favorite updated = dao.findById(created.getId());
        assertEquals(newDate, updated.getLikeDate());
    }

    @Test
    public void testDeleteById() {
        Favorite f = new Favorite();
        Users user = new Users();
        user.setId("admin");
        f.setUser(user);

        Video video = new Video();
        video.setId("video1");
        f.setVideo(video);

        f.setLikeDate(new Date());
        dao.create(f);

        List<Favorite> all = dao.findAll();
        Favorite created = all.get(all.size() - 1);

        dao.deleteById(created.getId());
        assertNull(dao.findById(created.getId()));
    }

    @Test
    public void testFindByUserId() {
        List<Favorite> list = dao.findByUserId("admin");
        assertNotNull(list);
    }

    @Test
    public void testGetVideoFavoritesSummary() {
        List<Object[]> summary = dao.getVideoFavoritesSummary();
        assertNotNull(summary);
        if (!summary.isEmpty()) {
            assertTrue(summary.get(0).length >= 2);
        }
    }

    @Test
    public void testGetUsersByVideoId() {
        List<Favorite> list = dao.getUsersByVideoId("video1");
        assertNotNull(list);
    }
}
