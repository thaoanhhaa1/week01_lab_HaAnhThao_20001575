package vn.edu.iuh.vn.db;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;

public class Database {
    private static EntityManager em;

    static {
        em = Persistence.createEntityManagerFactory("week01_lab_HaAnhThao_20001575").createEntityManager();
    }

    public static EntityManager getEntityManager() {
        return em;
    }
}
