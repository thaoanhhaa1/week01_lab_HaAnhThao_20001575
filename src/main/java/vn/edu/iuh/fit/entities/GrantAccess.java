package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.util.Objects;

@Entity
@Table(name = "grant_access")
public class GrantAccess {
    @Id
    @ManyToOne(cascade = {CascadeType.REMOVE, CascadeType.MERGE}, fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id")
    private Role role;
    @Id
    @ManyToOne(cascade = {CascadeType.REMOVE, CascadeType.MERGE}, fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id")
    private Account account;
    @Column(name = "is_grant", columnDefinition = "ENUM('1', '0', '-1')", nullable = false)
    @ColumnDefault("'1'")
    @Convert(converter = GrantConverter.class)
    private Boolean grant;
    @Column(columnDefinition = "varchar(250)")
    @ColumnDefault("''")
    private String note;

    public GrantAccess() {
    }

    public GrantAccess(Role role, Account account) {
        this.role = role;
        this.account = account;
    }

    public GrantAccess(Role role, Account account, Boolean grant, String note) {
        this.role = role;
        this.account = account;
        this.grant = grant;
        this.note = note;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public boolean isGrant() {
        return grant;
    }

    public void setGrant(boolean grant) {
        this.grant = grant;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        GrantAccess that = (GrantAccess) o;
        return Objects.equals(role, that.role) && Objects.equals(account, that.account);
    }

    @Override
    public int hashCode() {
        return Objects.hash(role, account);
    }

    @Override
    public String toString() {
        return "GrantAccess{" +
                "role=" + role +
                ", account=" + account +
                ", grant=" + grant +
                ", note='" + note + '\'' +
                '}';
    }
}
