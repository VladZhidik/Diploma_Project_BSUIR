package by.jwd.restaurant.service;

import by.jwd.restaurant.service.exception.ServiceException;

public interface CsvWriter {

    void writeCsv(String filePath) throws ServiceException;

}
