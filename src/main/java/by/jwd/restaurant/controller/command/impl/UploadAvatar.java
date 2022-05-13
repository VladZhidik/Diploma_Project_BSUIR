package by.jwd.restaurant.controller.command.impl;

import by.jwd.restaurant.constant.SessionAttributes;
import by.jwd.restaurant.controller.command.Command;
import by.jwd.restaurant.entity.User;
import by.jwd.restaurant.service.ServiceProvider;
import by.jwd.restaurant.service.UserService;
import by.jwd.restaurant.service.exception.ServiceException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

@MultipartConfig
public class UploadAvatar implements Command {

    public static final String PATH_AVATAR_IMG = "/Users/artsiom/IdeaProjects/Kursovay/src/main/webapp/static/avatars/"; //todo: заменить на свой путь до аватарок

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServiceException {
        HttpSession session = request.getSession();
        ServiceProvider provider = ServiceProvider.getInstance();
        UserService userService = provider.getUserService();

        String email = (String) session.getAttribute(SessionAttributes.ATTRIBUTE_USER_EMAIL);


        try{
            User user = userService.getPersonalAccount(email);
            Part filePart = request.getPart("photo");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            InputStream inputStream = filePart.getInputStream();
            writeFile(PATH_AVATAR_IMG + fileName, inputStream);
         //   File newFile = new File(request.getContextPath() + File.separator + fileName);
         //   newFile.getParentFile().mkdirs();
          //  writeFile(request.getContextPath() + fileName, inputStream);
           userService.setAvatarPath(user.getEmail(), fileName);
            inputStream.close();
            user.setAvatarPath(fileName);
            request.setAttribute(SessionAttributes.ATTRIBUTE_USER, user);
        } catch (ServiceException e) {
            e.printStackTrace();
        }


        session.setAttribute(SessionAttributes.PAGE, "Controller?command=gotopersonalaccountpage");


        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/personalAccount.jsp");
        requestDispatcher.forward(request, response);
    }

    private void writeFile(String _path, InputStream _input) {
        try (FileOutputStream fileOutputStream = new FileOutputStream(_path)) {
            int read = 0;
            byte[] bytes = new byte[1024];
            while ((read = _input.read(bytes)) != -1) {
                fileOutputStream.write(bytes, 0, read);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
