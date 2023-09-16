package vn.edu.iuh.fit.repositories;

import vn.edu.iuh.fit.entities.Log;

import java.util.Optional;

public class LogRepository extends CRUDRepository<Log, Long> {
    public Optional<Boolean> update(Log log) {
        return super.updateById(log, log.getId());
    }
}
