package by.jwd.restaurant.controller.command.impl;

import by.jwd.restaurant.constant.SessionAttributes;
import by.jwd.restaurant.service.ServiceProvider;
import by.jwd.restaurant.service.UserService;
import by.jwd.restaurant.service.exception.ServiceException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LeftFeedbackCommand implements by.jwd.restaurant.controller.command.Command {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServiceException {
        HttpSession session = request.getSession();

        String feedback = request.getParameter("comment");
        String email = (String) session.getAttribute(SessionAttributes.ATTRIBUTE_USER_EMAIL);

        ServiceProvider provider = ServiceProvider.getInstance();
        UserService userService = provider.getUserService();

        userService.leftUserFeedback(email, feedback);

        response.sendRedirect("Controller?command=gotofeedbackpage");
    }
}
