package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.entities.Status;
import vn.edu.iuh.fit.repositories.RoleRepository;

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
        return roleRepository.findById(Role.class, id);
    }

    public List<Role> getRoleNotDeleted() {
        return roleRepository.getRoleNotDeleted();
    }

    public Optional<Boolean> softDelete(String roleId) {
        return roleRepository.updateStatus(roleId, Status.delete);
    }

    public boolean addRole(Role role) {
        return roleRepository.add(role);
    }

    public Optional<Boolean> update(Role role) {
        return roleRepository.updateById(role, role.getId());
    }

    public List<Role> getNewRoleForAccount(String accountId) {
        return roleRepository.getNewRoleForAccount(accountId);
    }
}
