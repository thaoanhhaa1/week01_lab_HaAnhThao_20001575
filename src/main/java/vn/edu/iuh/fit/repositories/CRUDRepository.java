package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.db.Connection;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public abstract class CRUDRepository<T, K> {
    protected final EntityManager entityManager;

    public CRUDRepository() {
        entityManager = Connection.getInstance().getEntityManager();
    }

    public Optional<T> findById(Class<T> clazz, K id) {
        T t = entityManager.find(clazz, id);

        if (t == null)
            return Optional.empty();

        return Optional.of(t);
    }

    public boolean add(T t) {
        EntityTransaction transaction = null;

        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            entityManager.persist(t);

            transaction.commit();
            return true;
        } catch (Exception e) {
            assert transaction != null;
            transaction.rollback();
            e.printStackTrace();
        }

        return false;
    }

    public Optional<Boolean> updateById(T t, K id) {
        EntityTransaction transaction = null;
        try {
            T tFind = (T) entityManager.find(t.getClass(), id);

            if (tFind == null)
                return Optional.empty();

            transaction = entityManager.getTransaction();
            transaction.begin();

            entityManager.merge(t);

            transaction.commit();
            return Optional.of(true);
        } catch (IllegalStateException e) {
            assert transaction != null;
            transaction.rollback();
            e.printStackTrace();
        }

        return Optional.of(false);
    }

    public List<T> getAll(Class<T> clazz) {
        try {
            return entityManager.createQuery("FROM " + clazz.getName(), clazz).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }
}
