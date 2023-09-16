package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import vn.edu.iuh.fit.db.Connection;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Status;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AccountRepository extends CRUDRepository<Account, String> {
    private final EntityManager entityManager = Connection.getInstance().getEntityManager();

    public Optional<Account> isLogin(String username, String password) {
        try {
            Query nativeQuery = entityManager.createQuery("FROM Account a WHERE password = ?1 AND (email = ?2 OR phone = ?2) AND status = ?3", Account.class);

            nativeQuery.setParameter(1, password);
            nativeQuery.setParameter(2, username);
            nativeQuery.setParameter(3, Status.active);

            Account account = (Account) nativeQuery.getSingleResult();

            return Optional.of(account);
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return Optional.empty();
    }

    public List<Account> getAccountMember() {
        try {
            return entityManager.createQuery("FROM Account WHERE status <> ?1 AND id NOT IN (SELECT ga.account.id FROM GrantAccess ga JOIN ga.role r WHERE r.id='admin')", Account.class)
                    .setParameter(1, Status.delete)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    public Optional<Boolean> updateStatus(String id, Status status) {
        EntityTransaction transaction = null;

        try {
            Account account = entityManager.find(Account.class, id);

            if (account == null)
                return Optional.empty();

            account.setStatus(status);

            transaction = entityManager.getTransaction();
            transaction.begin();

            entityManager.merge(account);

            transaction.commit();
            return Optional.of(true);
        } catch (Exception e) {
            assert transaction != null;
            transaction.rollback();
            e.printStackTrace();
        }

        return Optional.of(false);
    }

    public Optional<Boolean> update(Account account) {
        return updateById(account, account.getId());
    }

    public List<Account> getAccountByRole(String roleId) {
        try {
            return entityManager.createQuery("FROM Account WHERE status <> ?1 AND id IN (SELECT DISTINCT ga.account.id FROM GrantAccess ga WHERE role.status <> ?2 AND role.id = ?3)", Account.class)
                    .setParameter(1, Status.delete)
                    .setParameter(2, Status.delete)
                    .setParameter(3, roleId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }
}
