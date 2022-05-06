package by.jwd.restaurant.service.impl;

import by.jwd.restaurant.entity.Order;
import by.jwd.restaurant.service.CsvWriter;
import by.jwd.restaurant.service.OrderService;
import by.jwd.restaurant.service.ServiceProvider;
import by.jwd.restaurant.service.exception.ServiceException;
import com.opencsv.CSVWriter;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class CsvWriterImpl implements CsvWriter {

    @Override
    public void writeCsv() throws ServiceException {
        List<String[]> csvDate = createCsvData();

        try (CSVWriter writer = new CSVWriter(new FileWriter("/Users/artsiom/IdeaProjects/Kursovay/src/main/resources/ordersreports/orders-reports.csv"))) {
            writer.writeAll(csvDate);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private List<String[]> createCsvData() throws ServiceException {

        ServiceProvider provider = ServiceProvider.getInstance();
        OrderService orderService = provider.getOrderService();
        List<Order> orders = orderService.getAllOrders();
        List<String[]> records = new ArrayList<>();
        records.add(new String[] { "userId", "status", "Dishes", "Price" });
        for (Order order : orders) {
            records.add( new String[] {String.valueOf(order.getId()), String.valueOf(order.getStatus()),
                    String.valueOf(order.getDishes()), String.valueOf(order.getTotalPrice())});
        }

        List<String[]> list = new ArrayList<>();
        list.addAll(records);
        return list;
    }


}
