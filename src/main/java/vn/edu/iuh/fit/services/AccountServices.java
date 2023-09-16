package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Status;
import vn.edu.iuh.fit.repositories.AccountRepository;

import java.util.List;
import java.util.Optional;

public class AccountServices {
    private final AccountRepository accountRepository;

    public AccountServices() {
        accountRepository = new AccountRepository();
    }

    public Optional<Account> isLogin(String username, String password) {
        return accountRepository.isLogin(username, password);
    }

    public List<Account> getAccountMember() {
        return accountRepository.getAccountMember();
    }

    public boolean add(Account account) {
        return accountRepository.add(account);
    }

    public Optional<Boolean> softDelete(String id) {
        return accountRepository.updateStatus(id, Status.delete);
    }

    public Optional<Boolean> update(Account account) {
        return accountRepository.update(account);
    }

    public Optional<Account> findById(String id) {
        return accountRepository.findById(Account.class, id);
    }

    public List<Account> getAccountByRole(String roleId) {
        return  accountRepository.getAccountByRole(roleId);
    }
}
