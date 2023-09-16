package vn.edu.iuh.fit.db;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Connection {
    private final EntityManager em;
    private static Connection connection;

    private Connection() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("week01_lab_HaAnhThao_20001575");
        em = emf.createEntityManager();
    }

    public EntityManager getEntityManager() {
        return em;
    }

    public static Connection getInstance() {
        if (connection == null)
            connection = new Connection();
        return connection;
    }
}
