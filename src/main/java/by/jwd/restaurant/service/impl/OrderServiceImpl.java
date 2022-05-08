package by.jwd.restaurant.service.impl;

import by.jwd.restaurant.dao.DAOProvider;
import by.jwd.restaurant.dao.OrderDAO;
import by.jwd.restaurant.dao.connection.DBResourceManager;
import by.jwd.restaurant.dao.exception.DAOException;
import by.jwd.restaurant.entity.Dish;
import by.jwd.restaurant.entity.Order;
import by.jwd.restaurant.service.CsvWriter;
import by.jwd.restaurant.service.OrderService;
import by.jwd.restaurant.service.exception.ServiceException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    private final CsvWriter csvWriter = new CsvWriterImpl();

    @Override
    public boolean makeOrder(Order order) throws ServiceException {
        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try {
            orderDAO.createOrder(order);
        } catch (DAOException e) {
            throw new ServiceException("make order exception", e);
        }
        return true;
    }

    @Override
    public List<Order> getAllOrders() throws ServiceException {
        List<Order> allOrders = null;

        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try {
            allOrders = orderDAO.getAll();
        } catch (DAOException e) {
            throw new ServiceException("get all orders exception", e);
        }

        return allOrders;
    }

    @Override
    public boolean addDishToOrder(Integer dishId, Integer orderId) throws ServiceException {
        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try {
            orderDAO.createOrderDish(dishId, orderId);
        } catch (DAOException e) {
            throw new ServiceException("make order exception", e);
        }

        return true;
    }

    @Override
    public void deleteDishInOrder(Integer dishId, Integer orderId) throws ServiceException {
        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try{
            orderDAO.deleteOrderedDish(dishId, orderId);
        } catch (DAOException e){
            throw new ServiceException("delete ordered dish exception", e);
        }
    }

    @Override
    public void makeNewOrder(Integer userId) throws ServiceException {
        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try{
            orderDAO.makeNewOrder(userId);
        } catch (DAOException e){
            throw new ServiceException("make new order exception", e);
        }
    }

    @Override
    public Integer getOrderId(Integer userId) throws ServiceException {
        Integer id;

        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try {
            id = orderDAO.getOrderId(userId);
        } catch (DAOException e) {
            throw new ServiceException("get order id exception", e);
        }

        return id;
    }

    @Override
    public void checkOrderStatus() throws ServiceException {
        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        try {
            orderDAO.updateOrderStatus();
        } catch (DAOException e) {
            throw new ServiceException("update order status exception", e);
        }
    }

    @Override
    public Double getTotalPrice(List<Dish> dishList) throws ServiceException {
        double totalPrice = 0;

        for(Dish dish : dishList){
            totalPrice+=dish.getPrice();
        }

        return totalPrice;
    }

    @Override
    public List<Order> getUserOrders(Integer userId) throws ServiceException {
        DAOProvider provider = DAOProvider.getInstance();
        OrderDAO orderDAO = provider.getOrderDAO();

        List<Order> orders = null;
        try {
            orders = orderDAO.getUserOrders(userId);
        } catch (DAOException e) {
            throw new ServiceException("get user orders exception", e);
        }

        return orders;
    }

    @Override
    public void createCSVFile(HttpServletResponse response, HttpSession session) {
        DBResourceManager dbResourceManager = DBResourceManager.getInstance();
        String filePath = dbResourceManager.getValue("file.location");
        File downloadFile = new File(filePath);
        ServletContext context = session.getServletContext();
        try (FileInputStream inStream = new FileInputStream(downloadFile);
             OutputStream outputStream = response.getOutputStream()){
            csvWriter.writeCsv(filePath);

            String mimeType = context.getMimeType(filePath);
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }

            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            //force download
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", downloadFile.getName());
            response.setHeader(headerKey, headerValue);

            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            while ((bytesRead = inStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

        } catch (ServiceException e) {
            System.out.println("Error writing csv file");
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            System.out.println("Error sending file");
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
