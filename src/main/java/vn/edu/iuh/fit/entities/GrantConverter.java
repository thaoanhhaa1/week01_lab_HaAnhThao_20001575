package vn.edu.iuh.fit.entities;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class GrantConverter implements AttributeConverter<Boolean, String> {
    @Override
    public String convertToDatabaseColumn(Boolean attribute) {
        return attribute ? "1" : "0";
    }

    @Override
    public Boolean convertToEntityAttribute(String dbData) {
        return dbData.equals("1");
    }
}
