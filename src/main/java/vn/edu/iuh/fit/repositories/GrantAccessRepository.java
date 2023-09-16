package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import vn.edu.iuh.fit.db.Connection;
import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.entities.Status;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class GrantAccessRepository {
    private EntityManager em;

    public GrantAccessRepository() {
        em = Connection.getInstance().getEntityManager();
    }

    public boolean add(GrantAccess grantAccess) {
        EntityTransaction transaction = null;

        try {
             transaction = em.getTransaction();
             transaction.begin();

             em.persist(grantAccess);

             transaction.commit();
             return true;
        } catch (Exception e) {
            assert transaction != null;
            transaction.rollback();
            e.printStackTrace();
        }

        return false;
    }

    public List<GrantAccess> getGrantAccessByAccount(String accountId) {
        List<GrantAccess> grantAccesses = new ArrayList<>();

        try {
            return em.createQuery("FROM GrantAccess WHERE account.id = ?1 AND grant = true AND role.status = ?2", GrantAccess.class)
                    .setParameter(1, accountId)
                    .setParameter(2, Status.active)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return grantAccesses;
    }

    public List<GrantAccess> getAllGrantAccessByAccount(String accountId) {
        try {
            return em.createQuery("FROM GrantAccess WHERE account.id = ?1 AND role.status = ?2", GrantAccess.class)
                    .setParameter(1, accountId)
                    .setParameter(2, Status.active)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    public Optional<GrantAccess> getGrantAccess(String accountId, String roleId) {
        try {
            GrantAccess grantAccess = em.createQuery("FROM GrantAccess WHERE account.id = ?1 AND role.id = ?2", GrantAccess.class)
                    .setParameter(1, accountId)
                    .setParameter(2, roleId)
                    .getSingleResult();

            return Optional.of(grantAccess);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    public Optional<Boolean> updateGrant(String accountId, String roleId, boolean isGrant) {
        EntityTransaction transaction = null;

        try {
            GrantAccess grantAccess = em.createQuery("FROM GrantAccess WHERE role.id = ?1 AND account.id = ?2", GrantAccess.class)
                    .setParameter(1, roleId)
                    .setParameter(2, accountId)
                    .getSingleResult();

            transaction = em.getTransaction();
            transaction.begin();

            grantAccess.setGrant(isGrant);
            em.merge(grantAccess);

            transaction.commit();
            return Optional.of(true);
        } catch (NoResultException ignored) {
            ignored.printStackTrace();
            return Optional.empty();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Optional.of(false);
    }

    public Optional<Boolean> update(GrantAccess grantAccess) {
        EntityTransaction transaction = null;

        try {
            em.createQuery("FROM GrantAccess WHERE role.id = ?1 AND account.id = ?2", GrantAccess.class)
                    .setParameter(1, grantAccess.getRole().getId())
                    .setParameter(2, grantAccess.getAccount().getId())
                    .getSingleResult();

             transaction = em.getTransaction();
             transaction.begin();

             em.merge(grantAccess);

             transaction.commit();
             return Optional.of(true);
        } catch (NoResultException e) {
            e.printStackTrace();
            return Optional.empty();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return Optional.of(false);
    }
}
