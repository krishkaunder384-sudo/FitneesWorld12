package com.gym_website.admin.dao;

import java.util.List;

public interface DashboardDAO {
    List<Double> getEarnings();
    int getMonthlyBookings();
    int getPendingPayments();
    int getCustomersEngaged();
}
