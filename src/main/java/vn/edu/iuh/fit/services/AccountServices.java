package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Status;
import vn.edu.iuh.fit.repositories.AccountRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

public class AccountServices {
    private final AccountRepository accountRepository;

    public AccountServices() {
        accountRepository = new AccountRepository();
    }

    public Optional<Account> isLogin(String username, String password) {
        if (username == null || password == null || username.isEmpty() || password.isEmpty())
            return Optional.empty();

        return accountRepository.isLogin(username, password);
    }

    public List<Account> getAccountMember() {
        return accountRepository.getAccountMember();
    }

    public boolean add(Account account) {
        if (isInvalidAccount(account))
            return false;

        return accountRepository.add(account);
    }

    public Optional<Boolean> softDelete(String id) {
        if (id == null || id.isEmpty())
            return Optional.empty();

        return accountRepository.updateStatus(id, Status.delete);
    }

    public Optional<Boolean> update(Account account) {
        if (isInvalidAccount(account))
            return Optional.empty();

        return accountRepository.update(account);
    }

    public Optional<Account> findById(String id) {
        if (id == null || id.isEmpty())
            return Optional.empty();

        return accountRepository.findById(Account.class, id);
    }

    public List<Account> getAccountByRole(String roleId) {
        if (roleId == null || roleId.isEmpty())
            return new ArrayList<>();

        return  accountRepository.getAccountByRole(roleId);
    }

    private boolean isInvalidAccount(Account account) {
        String id = account.getId();

        if (id == null || id.isEmpty() || id.length() > 50)
            return true;

        String fullName = account.getFullName();

        if (fullName == null || fullName.isEmpty() || fullName.length() > 50)
            return true;

        String password = account.getPassword();

        if (password == null || password.isEmpty() || password.length() > 50)
            return true;

        String email = account.getEmail();

        if (email != null) {
            if (email.isEmpty())
                account.setEmail(null);
            else if (!Pattern.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$", email))
                return true;
        }

        String phone = account.getPhone();

        if (phone != null) {
            if (phone.isEmpty())
                account.setPhone(null);
            else return !Pattern.matches("^(0|\\+[0-9]{2})[0-9]{9}$", phone);
        }

        return false;
    }
}
