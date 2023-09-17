package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.entities.Status;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class RoleServices {
    private final RoleRepository roleRepository;

    public RoleServices() {
        roleRepository = new RoleRepository();
    }

    public List<Role> getAll() {
        return roleRepository.getAll(Role.class);
    }

    public Optional<Role> findById(String id) {
        if (id == null || id.isEmpty() || id.length() > 50)
            return Optional.empty();

        return roleRepository.findById(Role.class, id);
    }

    public List<Role> getRoleNotDeleted() {
        return roleRepository.getRoleNotDeleted();
    }

    public Optional<Boolean> softDelete(String roleId) {
        if (roleId == null || roleId.isEmpty() || roleId.length() > 50)
            return Optional.empty();

        return roleRepository.updateStatus(roleId, Status.delete);
    }

    public boolean addRole(Role role) {
        if (isInvalidRole(role))
            return false;

        return roleRepository.add(role);
    }

    public Optional<Boolean> update(Role role) {
        if (isInvalidRole(role))
            return Optional.empty();

        return roleRepository.updateById(role, role.getId());
    }

    public List<Role> getNewRoleForAccount(String accountId) {
        if (accountId == null || accountId.isEmpty() || accountId.length() > 50)
            return new ArrayList<>();

        return roleRepository.getNewRoleForAccount(accountId);
    }

    private boolean isInvalidRole(Role role) {
        String roleId = role.getId();
        if (roleId == null || roleId.isEmpty() || roleId.length() > 50)
            return true;

        String name = role.getName();
        if (name == null || name.isEmpty() || name.length() > 50)
            return true;

        String description = role.getDescription();
        return description != null && description.length() > 50;
    }
}
