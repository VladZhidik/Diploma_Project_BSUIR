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

public class SetRatingCommand implements Command {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Double rating = Double.parseDouble(request.getParameter("rating"));
        String email = (String) session.getAttribute(SessionAttributes.ATTRIBUTE_USER_EMAIL);

        ServiceProvider provider = ServiceProvider.getInstance();
        UserService userService = provider.getUserService();

        userService.setRating(rating, email);
        try {
            Double recalculatedRating = userService.recalculateRating();
            session.setAttribute(SessionAttributes.ESTIMATED_RATING, recalculatedRating);
        } catch (ServiceException e) {
            e.printStackTrace();
        }

        session.setAttribute(SessionAttributes.PAGE, "Controller?command=gotomainpage");

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/main.jsp");
        requestDispatcher.forward(request, response);
    }
}

