package com.chartjs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
public class DataAccessObject {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/REPORTS_DB";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Thatchaini2002*@";
 
    public List<Map<String, Object>> getChartData() throws ClassNotFoundException {
        List<Map<String, Object>> chartData = new ArrayList<>();
 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
//                System.out.println("DB is Connected");
                String sql = "SELECT VENDOR FROM DVC_SUMMARY_DATA";
                try (PreparedStatement statement = connection.prepareStatement(sql);
                     ResultSet resultSet = statement.executeQuery()) {
//                    System.out.println("ResultSet is Executed");
 
                    Map<String, Integer> vendorCounts = new HashMap<>();
 
                    while (resultSet.next()) {
                        String vendor = resultSet.getString("VENDOR");
 
                        // Update the count in the map
                        vendorCounts.put(vendor, vendorCounts.getOrDefault(vendor, 0) + 1);
                    }
 
                    // Convert vendor counts to a list of maps
                    for (Map.Entry<String, Integer> entry : vendorCounts.entrySet()) {
                        Map<String, Object> dataPoint = new HashMap<>();
                        dataPoint.put("vendor", entry.getKey());
                        dataPoint.put("count", entry.getValue());
 
                        chartData.add(dataPoint);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
 
        return chartData;
    }
}
 