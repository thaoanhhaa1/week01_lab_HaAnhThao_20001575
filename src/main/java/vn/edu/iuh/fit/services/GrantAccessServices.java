package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.repositories.GrantAccessRepository;

import java.util.List;
import java.util.Optional;

public class GrantAccessServices {
    private final GrantAccessRepository grantAccessRepository;

    public GrantAccessServices() {
        grantAccessRepository = new GrantAccessRepository();
    }

    public List<GrantAccess> getGrantAccessByAccount(String accountId) {
        return grantAccessRepository.getGrantAccessByAccount(accountId);
    }

    public List<GrantAccess> getAllGrantAccessByAccount(String accountId) {
        return grantAccessRepository.getAllGrantAccessByAccount(accountId);
    }

    public Optional<Boolean> updateGrant(String accountId, String roleId, boolean isGrant) {
        return grantAccessRepository.updateGrant(accountId, roleId, isGrant);
    }

    public Optional<GrantAccess> getGrantAccess(String accountId, String roleId) {
        return grantAccessRepository.getGrantAccess(accountId, roleId);
    }

    public Optional<Boolean> update(GrantAccess grantAccess) {
        return grantAccessRepository.update(grantAccess);
    }

    public boolean add(GrantAccess grantAccess) {
        return grantAccessRepository.add(grantAccess);
    }
}
