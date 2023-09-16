package vn.edu.iuh.fit.entities;

import jakarta.persistence.*;

import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "role")
public class Role {
    @Id
    @Column(name = "role_id", columnDefinition = "varchar(50)")
    private String id;
    @Column(name = "role_name", columnDefinition = "varchar(50)", nullable = false)
    private String name;
    @Column(columnDefinition = "varchar(50)")
    private String description;
    @Column(columnDefinition = "tinyint(4)", nullable = false)
    @Convert(converter = StatusConverter.class)
    private Status status;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "role")
    private List<GrantAccess> grantAccesses;

    public Role() {
    }

    public Role(String id) {
        this.id = id;
    }

    public Role(String id, String name, String description, Status status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    private void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public void setGrantAccesses(List<GrantAccess> grantAccesses) {
        this.grantAccesses = grantAccesses;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", status=" + status +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Role role = (Role) o;
        return Objects.equals(id, role.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
