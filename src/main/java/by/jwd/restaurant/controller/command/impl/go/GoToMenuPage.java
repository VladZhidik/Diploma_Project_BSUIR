package by.jwd.restaurant.controller.command.impl.go;

import by.jwd.restaurant.constant.SessionAttributes;
import by.jwd.restaurant.controller.command.Command;
import by.jwd.restaurant.entity.Dish;
import by.jwd.restaurant.service.DishService;
import by.jwd.restaurant.service.OrderService;
import by.jwd.restaurant.service.ServiceProvider;
import by.jwd.restaurant.service.exception.ServiceException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class GoToMenuPage implements Command {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServiceException {
        ServiceProvider provider = ServiceProvider.getInstance();
        DishService dishService = provider.getDishService();

        HttpSession session = request.getSession();

        try {
            List<Dish> dishes = dishService.getDishes();
            request.setAttribute(SessionAttributes.ATTRIBUTE_DISHES, dishes);

        }catch (ServiceException e){
            response.sendRedirect("Controller?command=gotohomepage&message=wrong in catch");
        }

        session.setAttribute(SessionAttributes.PAGE, "Controller?command=gotomenupage");

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/menu.jsp");
        requestDispatcher.forward(request, response);

    }
}
