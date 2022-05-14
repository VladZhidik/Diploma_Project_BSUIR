package by.jwd.restaurant.dao.impl;

import by.jwd.restaurant.entity.RegistrationInfo;
import by.jwd.restaurant.dao.UserDAO;
import by.jwd.restaurant.dao.connection.ConnectionPool;
import by.jwd.restaurant.dao.exception.ConnectionPoolException;
import by.jwd.restaurant.entity.Role;
import by.jwd.restaurant.entity.User;
import by.jwd.restaurant.dao.exception.DAOException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SQLUserDAO implements UserDAO {
    private static final String COLUMN_LABEL_USER_ID = "user_id";
    private static final String COLUMN_LABEL_USER_PASSWORD = "user_password";
    private static final String COLUMN_LABEL_USER_ROLE = "role_name";
    private static final String COLUMN_LABEL_USER_NAME = "user_name";
    private static final String COLUMN_LABEL_USER_SURNAME = "user_surname";
    private static final String COLUMN_LABEL_USER_PHONE = "user_phone";
    private static final String COLUMN_LABEL_USER_EMAIL = "user_email";
    private static final String COLUMN_LABEL_USER_RATING = "restoran_rating";
    private static final String COLUMN_LABEL_USER_FEEDBACK = "user_feedback";

    private static final String SELECT_USER_EMAIL_PASSWORD = "SELECT users.user_id, role_name FROM users JOIN roles ON users.role_id=roles.role_id WHERE user_email = ? AND user_password = ?";
    private static final String SELECT_USER_ID = "SELECT user_id FROM users WHERE user_email = ? ";
    private static final String INSERT_REGISTRATION_USER = "INSERT INTO users (user_name, user_surname, user_phone, user_email, user_password, role_id) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_PASSWORD = "SELECT user_password FROM users WHERE user_email = ?";
    private static final String SELECT_USER = "SELECT users.user_id, users.user_name, users.user_surname, users.user_phone, users.user_email, users.user_password, users.user_picture_path, role_name, users.user_feedback, users.restoran_rating FROM users JOIN roles ON users.role_id=roles.role_id WHERE user_email = ?";
    private static final String SELECT_ALL_USER = "SELECT users.user_id, users.user_name, users.user_surname, users.user_phone, users.user_email, users.user_password, role_name, users.user_picture_path, users.restoran_rating, users.user_feedback FROM users JOIN roles ON users.role_id=roles.role_id ";
    private static final String SELECT_ALL_RATING = "SELECT users.restoran_rating FROM users";
    private static final String DELETE_USER = "DELETE from users WHERE user_email = ?";
    private static final String UPDATE_USER_ROLE = "UPDATE users SET role_id=? WHERE user_email=?";
    public static final String USER_PICTURE_PATH = "user_picture_path";
    public static final String UPDATE_USERS_SET_USER_PICTURE_PATH_WHERE_USER_EMAIL = "UPDATE users SET user_picture_path=? WHERE user_email=?";
    public static final String UPDATE_USERS_SET_USER_FEEDBACK_WHERE_USER_EMAIL = "UPDATE users SET user_feedback=? WHERE user_email=?";


    static {
        MySQLDriverLoader.getInstance();
    }

    @Override
    public User authorization(String login, String password) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;

        Integer id;
        String roleName;
        User user = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(SELECT_USER_EMAIL_PASSWORD);
            prSt.setString(1, login);
            prSt.setString(2, password);
            resSet = prSt.executeQuery();

            if(resSet.next()){
                id = resSet.getInt(COLUMN_LABEL_USER_ID);

                roleName = resSet.getString(COLUMN_LABEL_USER_ROLE);
                Role role = Role.valueOf(roleName);

                user = new User(id, login, password, role);

            }
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
               connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
        return user;
    }

    @Override
    public boolean registration(RegistrationInfo user) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(INSERT_REGISTRATION_USER);
            prSt.setString(1, user.getName());
            prSt.setString(2, user.getSurname());
            prSt.setString(3, user.getPhone());
            prSt.setString(4, user.getEmail());
            prSt.setString(5, user.getPassword());
            prSt.setInt(6, user.getRoleId());
            prSt.executeUpdate();

        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }

        return true;
    }

    @Override
    public Integer findId(String email) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;

        Integer id = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(SELECT_USER_ID);
            prSt.setString(1, email);

            resSet = prSt.executeQuery();
            if (resSet.next()) {
                id = resSet.getInt(COLUMN_LABEL_USER_ID);
            }
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
        return id;
    }

    @Override
    public String getPassword(String email) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;

        String password = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(SELECT_USER_PASSWORD);
            prSt.setString(1, email);

            resSet = prSt.executeQuery();
            if (resSet.next()) {
                password = resSet.getString(COLUMN_LABEL_USER_PASSWORD);
            }
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }

        return password;
    }

    @Override
    public User getUser(String email) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;

        User user = new User();

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(SELECT_USER);
            prSt.setString(1, email);

            resSet = prSt.executeQuery();
            while (resSet.next()) {
                user.setId(resSet.getInt(COLUMN_LABEL_USER_ID));
                user.setName(resSet.getString(COLUMN_LABEL_USER_NAME));
                user.setSurname(resSet.getString(COLUMN_LABEL_USER_SURNAME));
                user.setPhone(resSet.getString(COLUMN_LABEL_USER_PHONE));
                user.setEmail(resSet.getString(COLUMN_LABEL_USER_EMAIL));
                user.setPassword(resSet.getString(COLUMN_LABEL_USER_PASSWORD));
                user.setRole(Role.valueOf(resSet.getString(COLUMN_LABEL_USER_ROLE)));
                String avatarPath = resSet.getString(USER_PICTURE_PATH);
                if(avatarPath == null) {
                    user.setAvatarPath("DefaultAvatar.jpg");
                } else {
                    user.setAvatarPath(avatarPath);
                }
                user.setRating(resSet.getDouble(COLUMN_LABEL_USER_RATING));
                user.setFeedback(resSet.getString(COLUMN_LABEL_USER_FEEDBACK));
            }
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }

        return user;
    }

    @Override
    public List<User> findAll() throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;

        PreparedStatement prSt = null;
        ResultSet resSet;

        List<User> users = new ArrayList<>();

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(SELECT_ALL_USER);

            resSet = prSt.executeQuery();
            while (resSet.next()) {
                String userPicturePath = resSet.getString(USER_PICTURE_PATH);
                if(userPicturePath == null) {
                    userPicturePath = "DefaultAvatar.jpg";
                }
                users.add(new User(resSet.getInt(COLUMN_LABEL_USER_ID),
                resSet.getString(COLUMN_LABEL_USER_NAME),
                resSet.getString(COLUMN_LABEL_USER_SURNAME),
                resSet.getString(COLUMN_LABEL_USER_PHONE),
                resSet.getString(COLUMN_LABEL_USER_EMAIL),
                resSet.getString(COLUMN_LABEL_USER_PASSWORD),
                Role.valueOf(resSet.getString(COLUMN_LABEL_USER_ROLE)),
                        userPicturePath,
                        resSet.getString(COLUMN_LABEL_USER_FEEDBACK),
                        resSet.getDouble(COLUMN_LABEL_USER_RATING)));
            }
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
        return users;
    }

    @Override
    public boolean banUser(String userEmail) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;
        boolean result = false;
        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(DELETE_USER);
            prSt.setString(1, userEmail);

            prSt.executeUpdate();
            connection.commit();
            result = true;
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
                return result;
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
    }

    @Override
    public boolean banAdmin(String userEmail) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;
        boolean result = false;
        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(UPDATE_USER_ROLE);
            prSt.setInt(1, 2);
            prSt.setString(2, userEmail);

            prSt.executeUpdate();
            connection.commit();
            result = true;
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
                return result;
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
    }

    @Override
    public boolean appointToAdmin(String userEmail) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;
        ResultSet resSet;
        boolean result = false;
        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(UPDATE_USER_ROLE);
            prSt.setInt(1, 1);
            prSt.setString(2, userEmail);

            prSt.executeUpdate();
            connection.commit();
            result = true;
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
                return result;
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
    }

    @Override
    public void uploadAvatarPath(String email, String fileName) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(UPDATE_USERS_SET_USER_PICTURE_PATH_WHERE_USER_EMAIL);
            prSt.setString(1, fileName);
            prSt.setString(2, email);
            prSt.executeUpdate();
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            } catch (ConnectionPoolException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void setRating(Double rating, String email) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement("UPDATE users SET restoran_rating=? WHERE user_email=?");
            prSt.setDouble(1, rating);
            prSt.setString(2, email);
            prSt.executeUpdate();
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            } catch (ConnectionPoolException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<Double> getAllUsersRating() throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;

        PreparedStatement prSt = null;
        ResultSet resSet;

        List<Double> ratingList = new ArrayList<>();

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(SELECT_ALL_RATING);

            resSet = prSt.executeQuery();
            while (resSet.next()) {
                ratingList.add(resSet.getDouble(COLUMN_LABEL_USER_RATING));
            }
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            }catch (ConnectionPoolException e){
                throw new DAOException(e);
            }
        }
        return ratingList;
    }

    @Override
    public void setUserFeedback(String userEmail, String feedback) throws DAOException {
        ConnectionPool connectionPool = ConnectionPool.getInstance();
        Connection connection = null;
        PreparedStatement prSt = null;

        try {
            connection = connectionPool.takeConnection();
            prSt = connection.prepareStatement(UPDATE_USERS_SET_USER_FEEDBACK_WHERE_USER_EMAIL);
            prSt.setString(1, feedback);
            prSt.setString(2, userEmail);
            prSt.executeUpdate();
        } catch (SQLException | ConnectionPoolException e) {
            throw new DAOException(e);
        } finally {
            try {
                connectionPool.closeConnection(connection, prSt);
            } catch (ConnectionPoolException e) {
                e.printStackTrace();
            }
        }
    }
}
