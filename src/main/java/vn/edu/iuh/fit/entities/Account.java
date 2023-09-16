package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "account")
public class Account {
    @Id
    @Column(name = "account_id", columnDefinition = "varchar(50)")
    private String id;
    @Column(name = "full_name", columnDefinition = "varchar(50)", nullable = false)
    private String fullName;
    @Column(columnDefinition = "varchar(50)", nullable = false)
    private String password;
    @Column(columnDefinition = "varchar(50)")
    private String email;
    @Column(columnDefinition = "varchar(50)")
    private String phone;
    @Column(columnDefinition = "tinyint(4)", nullable = false)
    @ColumnDefault("1")
    @Convert(converter = StatusConverter.class)
    private Status status;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "account")
    private List<GrantAccess> grantAccesses;

    public Account() {
    }

    public Account(String id) {
        this.id = id;
    }

    public Account(String id, String fullName, String password, Status status) {
        this.id = id;
        this.fullName = fullName;
        this.password = password;
        this.status = status;
    }

    public Account(String id, String fullName, String password, String email, String phone, Status status) {
        this.id = id;
        this.fullName = fullName;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    private void setId(String id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public List<GrantAccess> getGrantAccesses() {
        return grantAccesses;
    }

    @Override
    public String toString() {
        return "Account{" +
                "id='" + id + '\'' +
                ", fullName='" + fullName + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", status=" + status +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return Objects.equals(id, account.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
