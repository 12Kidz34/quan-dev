import static org.junit.jupiter.api.Assertions.*;

import com.java04.entity.Video;
import com.java04.service.VideoDAO;
import com.java04.service.VideoDAOImpl;
import org.junit.jupiter.api.*;

public class VideoDAOTest {

    private VideoDAO dao;

    @BeforeEach
    public void setUp() {
        dao = new VideoDAOImpl();
    }

    @Test
    public void testFindById_ExistingVideo() {
        Video v = dao.findById("video1");
        assertNotNull(v);
        assertEquals("video1", v.getId());
    }

    @Test
    public void testFindById_NotFound() {
        assertNull(dao.findById("xxx"));
    }

    @Test
    public void testFindAll() {
        assertFalse(dao.findAll().isEmpty());
    }

    @Test
    public void testCreateVideo() {
        Video v = new Video();
        v.setId("vid_test");
        v.setTitle("Demo Title");
        v.setDescription("Demo Desc");
        v.setViews(0);
        v.setActive(true);

        dao.create(v);
        Video found = dao.findById("vid_test");
        assertNotNull(found);

        dao.deleteById("vid_test");
    }

    @Test
    public void testUpdateVideo() {
        Video v = new Video();
        v.setId("vid_update");
        v.setTitle("Old");
        v.setDescription("Desc");
        v.setViews(0);
        v.setActive(true);
        dao.create(v);

        v.setTitle("New Title");
        dao.update(v);

        Video updated = dao.findById("vid_update");
        assertEquals("New Title", updated.getTitle());

        dao.deleteById("vid_update");
    }

    @Test
    public void testDeleteVideo() {
        Video v = new Video();
        v.setId("vid_delete");
        v.setTitle("To Delete");
        v.setDescription("...");
        v.setViews(0);
        v.setActive(true);
        dao.create(v);

        dao.deleteById("vid_delete");
        assertNull(dao.findById("vid_delete"));
    }
}
