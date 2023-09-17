package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.repositories.GrantAccessRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class GrantAccessServices {
    private final GrantAccessRepository grantAccessRepository;

    public GrantAccessServices() {
        grantAccessRepository = new GrantAccessRepository();
    }

    public List<GrantAccess> getGrantAccessByAccount(String accountId) {
        if (accountId == null || accountId.isEmpty() || accountId.length() > 50)
            return new ArrayList<>();

        return grantAccessRepository.getGrantAccessByAccount(accountId);
    }

    public List<GrantAccess> getAllGrantAccessByAccount(String accountId) {
        if (accountId == null || accountId.isEmpty() || accountId.length() > 50)
            return new ArrayList<>();

        return grantAccessRepository.getAllGrantAccessByAccount(accountId);
    }

    public Optional<Boolean> updateGrant(String accountId, String roleId, boolean isGrant) {
        if (isInvalidGrantAccess(new GrantAccess(new Role(roleId), new Account(accountId))))
            return Optional.empty();

        return grantAccessRepository.updateGrant(accountId, roleId, isGrant);
    }

    public Optional<GrantAccess> getGrantAccess(String accountId, String roleId) {
        if (isInvalidGrantAccess(new GrantAccess(new Role(roleId), new Account(accountId))))
            return Optional.empty();

        return grantAccessRepository.getGrantAccess(accountId, roleId);
    }

    public Optional<Boolean> update(GrantAccess grantAccess) {
        if (isInvalidGrantAccess(grantAccess))
            return Optional.empty();

        return grantAccessRepository.update(grantAccess);
    }

    public boolean add(GrantAccess grantAccess) {
        if (isInvalidGrantAccess(grantAccess))
            return false;

        return grantAccessRepository.add(grantAccess);
    }

    private boolean isInvalidGrantAccess(GrantAccess grantAccess) {
        String accountId = grantAccess.getAccount().getId();
        if (accountId == null || accountId.isEmpty() || accountId.length() > 50)
            return true;

        String roleId = grantAccess.getRole().getId();
        if (roleId == null || roleId.isEmpty() || roleId.length() > 50)
            return true;

        String note = grantAccess.getNote();
        return note != null && note.length() > 250;
    }
}
