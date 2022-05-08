package by.jwd.restaurant.controller.command.impl;

import by.jwd.restaurant.constant.SessionAttributes;
import by.jwd.restaurant.controller.command.Command;
import by.jwd.restaurant.service.ServiceProvider;
import by.jwd.restaurant.service.UserService;
import by.jwd.restaurant.service.exception.ServiceException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class BanUser implements Command {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServiceException {
        HttpSession session = request.getSession();

        ServiceProvider provider = ServiceProvider.getInstance();
        UserService userService = provider.getUserService();

        String userEmail = request.getParameter("login");

        try {
            userService.banUser(userEmail);
        } catch (ServiceException e) {
            response.sendRedirect("Controller?command=goToMainPage");
        }
        session.setAttribute(SessionAttributes.PAGE, "Controller?command=gotToUsersPage");

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/main.jsp");
        requestDispatcher.forward(request, response);
    }
}
