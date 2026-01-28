package com.personal.website.servlet;

import com.personal.website.service.WeatherService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/weather")
public class WeatherServlet extends HttpServlet {
    private WeatherService weatherService = new WeatherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String city = request.getParameter("city");
        if (city == null || city.isEmpty()) {
            city = "cangzhou"; // 默认城市为沧州
        } else {
            try {
                // 解码可能被编码的城市名
                city = java.net.URLDecoder.decode(city, "UTF-8");
            } catch (Exception e) {
                city = "cangzhou"; // 回退到默认城市
            }
        }
        
        WeatherService.WeatherInfo weatherInfo = weatherService.getWeatherForCity(city);
        
        String jsonResponse;
        if (weatherInfo == null) {
            // 天气获取失败，返回空的成功响应
            jsonResponse = "{\n" +
                    "  \"success\": true,\n" +
                    "  \"weather\": null\n" +
                    "}";
        } else {
            // 构造JSON响应
            jsonResponse = "{\n" +
                    "  \"success\": true,\n" +
                    "  \"weather\": {\n" +
                    "    \"currentTemp\": \"" + escapeJson(weatherInfo.getCurrentTemp()) + "\",\n" +
                    "    \"condition\": \"" + escapeJson(weatherInfo.getCondition()) + "\",\n" +
                    "    \"tempRange\": \"" + escapeJson(weatherInfo.getTempRange()) + "\",\n" +
                    "    \"cityName\": \"" + escapeJson(weatherInfo.getCityName()) + "\",\n" +
                    "    \"fullDescription\": \"" + escapeJson(weatherInfo.getFullDescription()) + "\"\n" +
                    "  }\n" +
                    "}";
        }

        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
    
    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}