/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.OrderDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.OrderEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.repository.OrderRepository;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    public PromotionService promotionService;
    
    public void save(OrderEntity orderEntity) {
        orderRepository.save(orderEntity);
    }
    
    @Transactional
    public List<OrderEntity> getOrders() {
        List<OrderEntity> orders = (List<OrderEntity>) orderRepository.findAll();
        for (OrderEntity order : orders) {
            Hibernate.initialize(order.getOrderDetails());
            Hibernate.initialize(order.getPayments());
        }
        return (List<OrderEntity>) orders;
    }
    
    @Transactional
    public OrderEntity findOrderById(int id) {
        Optional<OrderEntity> order = orderRepository.findById(id);
        if (order.isPresent()) {
            OrderEntity orderEntity = order.get();
            Hibernate.initialize(orderEntity.getOrderDetails());
            Hibernate.initialize(orderEntity.getPayments());
            return orderEntity;
        } else {
            return new OrderEntity();
        }
    }
    
    @Transactional
    public List<OrderEntity> getOrdersPage(Pageable pageable) {
        List<OrderEntity> orders = (List<OrderEntity>) orderRepository.findProducts(pageable);
        for (OrderEntity order : orders) {
            Hibernate.initialize(order.getOrderDetails());
            Hibernate.initialize(order.getPayments());
        }
        return (List<OrderEntity>) orders;
    }
    
    @Transactional
    public List<OrderEntity> searchOrdersByOrderNumber(String str) {
        List<OrderEntity> orders = (List<OrderEntity>) orderRepository.findByOrderNumberContaining(str);
        for (OrderEntity order : orders) {
            Hibernate.initialize(order.getOrderDetails());
            Hibernate.initialize(order.getPayments());
        }
        return (List<OrderEntity>) orders;
    }
// find order Account by Email

    @Transactional
    public List<OrderEntity> findOrdersByAccount(String email) {
        List<OrderEntity> orders = (List<OrderEntity>) orderRepository.findByEmailAccount(email);
        for (OrderEntity order : orders) {
            Hibernate.initialize(order.getOrderDetails());
            Hibernate.initialize(order.getPayments());
        }
        return (List<OrderEntity>) orders;
    }
    
    @Transactional
    public List<OrderEntity> searchOrdersByDate(Date date1, Date date2) {
        List<OrderEntity> orders = (List<OrderEntity>) orderRepository.findOrderByDate(date1, date2);
        for (OrderEntity order : orders) {
            Hibernate.initialize(order.getOrderDetails());
            Hibernate.initialize(order.getPayments());
        }
        return (List<OrderEntity>) orders;
    }
    
    public double totalPrice(HashMap<Integer, OrderDetailEntity> cartItems) {
        double total = 0;
        List<PromotionEntity> promotions = promotionService.getPromotionsToDay();
        for (Map.Entry<Integer, OrderDetailEntity> entry : cartItems.entrySet()) {
            for (PromotionEntity promotion : promotions) {
                if (!entry.getValue().getProduct().getPromotions().isEmpty()) {
                    for (PromotionEntity promotionProduct : entry.getValue().getProduct().getPromotions()) {
                        if (promotionProduct.getId() == promotion.getId()) {
                            total -= entry.getValue().getQuantity() * entry.getValue().getProduct().getPrice() * promotion.getPercent();
                        }
                    }
                }
            }
            total += entry.getValue().getQuantity() * entry.getValue().getProduct().getPrice();
        }
        return total;
    }
    
    public int countOrderInMonth(int month, int year) {
        return orderRepository.countOrderInMonth(month, year);
    }
    
    public int countOrderPending() {
        return orderRepository.countOrderPending();
    }
    
    public double sumRevenueInMonth(int month, int year) {
        return orderRepository.sumRevenueInMonth(month,year);
    }
    
    public int sumProductSoldInMonth (int month, int year){
        return orderRepository.sumProductSoldInMonth(month, year);
    }
}
