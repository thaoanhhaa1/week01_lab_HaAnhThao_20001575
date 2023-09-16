package vn.edu.iuh.fit.entities;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class StatusConverter implements AttributeConverter<Status, Short> {
    @Override
    public Short convertToDatabaseColumn(Status attribute) {
        if (Status.active.equals(attribute))
            return 1;
        if (Status.deactive.equals(attribute))
            return 0;
        return -1;
    }

    @Override
    public Status convertToEntityAttribute(Short dbData) {
        if (dbData == 1)
            return Status.active;
        if (dbData == 0)
            return Status.deactive;
        return Status.delete;
    }
}
