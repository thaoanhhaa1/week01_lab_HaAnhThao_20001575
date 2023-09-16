package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.entities.Status;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class RoleRepository extends CRUDRepository<Role, String> {
    public List<Role> getRoleNotDeleted() {
        try {
            return entityManager.createQuery("FROM Role WHERE id <> 'admin' AND status <> ?1", Role.class)
                    .setParameter(1, Status.delete)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    public Optional<Boolean> updateStatus(String roleId, Status status) {
        EntityTransaction transaction = null;

        try {
            Optional<Role> role = findById(Role.class, roleId);

            if (role.isEmpty())
                return Optional.empty();

            transaction = entityManager.getTransaction();
            transaction.begin();

            role.get().setStatus(status);
            entityManager.merge(role.get());

            transaction.commit();
            return Optional.of(true);
        } catch (Exception e) {
            assert transaction != null;
            transaction.rollback();
            e.printStackTrace();
        }

        return Optional.of(false);
    }

    public List<Role> getNewRoleForAccount(String accountId) {
        try {
            return entityManager.createQuery("FROM Role WHERE status = ?2 AND id NOT IN (SELECT ga.role.id FROM GrantAccess ga WHERE ga.account.id = ?1)", Role.class)
                    .setParameter(1, accountId)
                    .setParameter(2, Status.active)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }
}
