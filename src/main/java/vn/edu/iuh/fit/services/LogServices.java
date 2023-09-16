package vn.edu.iuh.fit.services;

import vn.edu.iuh.fit.entities.Log;
import vn.edu.iuh.fit.repositories.LogRepository;

import java.util.Optional;

public class LogServices {
    private final LogRepository logRepository;

    public LogServices() {
        logRepository = new LogRepository();
    }

    public boolean add(Log log) {
        return logRepository.add(log);
    }

    public Optional<Boolean> update(Log log) {
        return logRepository.update(log);
    }
}
