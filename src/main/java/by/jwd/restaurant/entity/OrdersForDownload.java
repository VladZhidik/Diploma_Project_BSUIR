package by.jwd.restaurant.entity;

import java.util.Date;
import java.util.List;
import java.util.Objects;

public class OrdersForDownload {

    private List<Integer> id;
    private List<OrderStatus> status;
    private List<Date> time;
    private List<Integer> orderPaymentMethodId;
    private List<Double> totalPrice;
    private List<String> review;
    private List<Integer> userId;
    private List<Integer> tableReservationId;

    private List<Dish> dish;
    private List<Drink> drink;

    private List<Dish> dishes;

    public OrdersForDownload() {
    }

    public OrdersForDownload(List<Integer> id,
                             List<OrderStatus> status,
                             List<Date> time,
                             List<Integer> orderPaymentMethodId,
                             List<Double> totalPrice,
                             List<String> review,
                             List<Integer> userId,
                             List<Integer> tableReservationId,
                             List<Dish> dish,
                             List<Drink> drink,
                             List<Dish> dishes) {
        this.id = id;
        this.status = status;
        this.time = time;
        this.orderPaymentMethodId = orderPaymentMethodId;
        this.totalPrice = totalPrice;
        this.review = review;
        this.userId = userId;
        this.tableReservationId = tableReservationId;
        this.dish = dish;
        this.drink = drink;
        this.dishes = dishes;
    }

    public List<Integer> getId() {
        return id;
    }

    public void setId(List<Integer> id) {
        this.id = id;
    }

    public List<OrderStatus> getStatus() {
        return status;
    }

    public void setStatus(List<OrderStatus> status) {
        this.status = status;
    }

    public List<Date> getTime() {
        return time;
    }

    public void setTime(List<Date> time) {
        this.time = time;
    }

    public List<Integer> getOrderPaymentMethodId() {
        return orderPaymentMethodId;
    }

    public void setOrderPaymentMethodId(List<Integer> orderPaymentMethodId) {
        this.orderPaymentMethodId = orderPaymentMethodId;
    }

    public List<Double> getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(List<Double> totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<String> getReview() {
        return review;
    }

    public void setReview(List<String> review) {
        this.review = review;
    }

    public List<Integer> getUserId() {
        return userId;
    }

    public void setUserId(List<Integer> userId) {
        this.userId = userId;
    }

    public List<Integer> getTableReservationId() {
        return tableReservationId;
    }

    public void setTableReservationId(List<Integer> tableReservationId) {
        this.tableReservationId = tableReservationId;
    }

    public List<Dish> getDish() {
        return dish;
    }

    public void setDish(List<Dish> dish) {
        this.dish = dish;
    }

    public List<Drink> getDrink() {
        return drink;
    }

    public void setDrink(List<Drink> drink) {
        this.drink = drink;
    }

    public List<Dish> getDishes() {
        return dishes;
    }

    public void setDishes(List<Dish> dishes) {
        this.dishes = dishes;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrdersForDownload that = (OrdersForDownload) o;
        return Objects.equals(id, that.id)
                && Objects.equals(status, that.status)
                && Objects.equals(time, that.time)
                && Objects.equals(orderPaymentMethodId, that.orderPaymentMethodId)
                && Objects.equals(totalPrice, that.totalPrice)
                && Objects.equals(review, that.review)
                && Objects.equals(userId, that.userId)
                && Objects.equals(tableReservationId, that.tableReservationId)
                && Objects.equals(dish, that.dish)
                && Objects.equals(drink, that.drink)
                && Objects.equals(dishes, that.dishes);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, status,
                time, orderPaymentMethodId,
                totalPrice, review, userId,
                tableReservationId, dish, drink, dishes);
    }

    @Override
    public String toString() {
        return "OrdersForDownload{" +
                "id=" + id +
                ", status=" + status +
                ", time=" + time +
                ", orderPaymentMethodId=" + orderPaymentMethodId +
                ", totalPrice=" + totalPrice +
                ", review=" + review +
                ", userId=" + userId +
                ", tableReservationId=" + tableReservationId +
                ", dish=" + dish +
                ", drink=" + drink +
                ", dishes=" + dishes +
                '}';
    }
}
