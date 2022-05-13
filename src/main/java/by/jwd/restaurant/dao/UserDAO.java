package by.jwd.restaurant.dao;

import by.jwd.restaurant.entity.RegistrationInfo;
import by.jwd.restaurant.entity.User;
import by.jwd.restaurant.dao.exception.DAOException;

import java.util.List;

public interface UserDAO {
    User authorization(String login, String password) throws DAOException;
    boolean registration(RegistrationInfo user) throws DAOException;
    Integer findId(String email) throws DAOException;
    String getPassword(String email) throws DAOException;
    User getUser(String email) throws DAOException;
    List<User> findAll() throws DAOException;
    boolean banUser(String userEmail) throws DAOException;
    boolean banAdmin(String userEmail) throws DAOException;
    boolean appointToAdmin(String userEmail) throws DAOException;

    void uploadAvatarPath(String email, String fileName) throws DAOException;
}
