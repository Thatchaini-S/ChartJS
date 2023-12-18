<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.chartjs.DataAccessObject" %>
 
<html>
<head>
    <title>Bar Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
 
<%
    DataAccessObject dao = new DataAccessObject();
    List<Map<String, Object>> chartData = dao.getChartData();
%>
 
<canvas id="myChart" width="400" height="400"></canvas>
 
<script>
    // Convert Java List to JavaScript array for vendor data and counts
    var chartData = [
        <% for (int i = 0; i < chartData.size(); i++) { %>
            { "vendor": "<%= chartData.get(i).get("vendor") %>", "count": <%= chartData.get(i).get("count") %> }<%= i < chartData.size() - 1 ? "," : "" %>
        <% } %>
    ];
 
    var labels = chartData.map(function (item) { return item.vendor; });
    var data = chartData.map(function (item) { return item.count; });
 
    console.log("Vendor Data:", chartData);
 
    // Function to generate dynamically changing bright colors in the RGBA format
    function generateBrightColors(count) {
        var colors = [];
        for (var i = 0; i < count; i++) {
            var r = Math.floor(Math.random() * 150 + 100); // Red channel (100-250)
            var g = Math.floor(Math.random() * 150 + 100); // Green channel (100-250)
            var b = Math.floor(Math.random() * 150 + 100); // Blue channel (100-250)
            colors.push('rgba(' + r + ',' + g + ',' + b + ', 2)');
        }
        return colors;
    }
 
    var backgroundColors = generateBrightColors(chartData.length);
    var borderColors = backgroundColors.map(color => color.replace("0.2", "1"));
 
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'Vendor Count',
                    data: data,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
 
</body>
</html>