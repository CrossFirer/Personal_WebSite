package com.personal.website.service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class WeatherService {
    
    private static final String WEATHER_API_URL = "https://goweather.xyz/v2/weather/cangzhou";
    
    public WeatherInfo getWeatherForCity(String city) {
        try {
            // 由于新API只支持固定的沧州天气，所以直接使用固定URL
            URL url = new URL(WEATHER_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36");
            connection.setRequestProperty("Accept", "application/json");
            connection.setConnectTimeout(60000); // 设置超时时间为1分钟
            connection.setReadTimeout(60000);   // 设置读取超时时间为1分钟
            
            int responseCode = connection.getResponseCode();
            if (responseCode != HttpURLConnection.HTTP_OK) {
                return null;
            }
            
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            
            // 检查响应内容是否为空
            String responseStr = response.toString();
            if (responseStr == null || responseStr.trim().isEmpty()) {
                return null;
            }
            
            Gson gson = new Gson();
            JsonObject jsonResponse;
            try {
                jsonResponse = gson.fromJson(responseStr, JsonObject.class);
            } catch (JsonSyntaxException e) {
                return null;
            }
            
            // 解析新API返回的天气数据
            String temperature = jsonResponse.get("temperature").getAsString();
            String description = jsonResponse.get("description").getAsString();
            String windSpeed = jsonResponse.get("wind").getAsString();
            
            // 翻译天气描述为中文（如果是英文的话）
            String chineseDescription = translateToChinese(description);
            
            // 获取第一个预报作为温度范围参考
            JsonArray forecastArray = jsonResponse.getAsJsonArray("forecast");
            String minTemp = "N/A";
            String maxTemp = "N/A";
            if (forecastArray != null && forecastArray.size() > 0) {
                JsonObject firstForecast = forecastArray.get(0).getAsJsonObject();
                String firstTemp = firstForecast.get("temperature").getAsString();
                minTemp = firstTemp;
                maxTemp = firstTemp;
            }
            
            // 将英文城市名转换为中文
            String chineseCityName = "沧州";
            
            return new WeatherInfo(
                temperature,
                chineseDescription + ", " + windSpeed,
                minTemp + " ~ " + maxTemp,
                chineseCityName
            );
        } catch (IOException e) {
            return null;
        } catch (Exception e) {
            return null;
        }
    }
    
    private String getChineseCityName(String englishCityName) {
        // 城市名英译中的映射
        switch (englishCityName.toLowerCase()) {
            case "cangzhou":
                return "沧州";
            case "beijing":
                return "北京";
            case "shanghai":
                return "上海";
            case "guangzhou":
                return "广州";
            case "shenzhen":
                return "深圳";
            case "hangzhou":
                return "杭州";
            case "nanjing":
                return "南京";
            case "wuhan":
                return "武汉";
            case "chengdu":
                return "成都";
            case "xian":
                return "西安";
            case "chongqing":
                return "重庆";
            default:
                // 如果没有匹配项，首字母大写返回原名
                return Character.toUpperCase(englishCityName.charAt(0)) + englishCityName.substring(1);
        }
    }
    
    private double extractTemperatureValue(String tempStr) {
        // 从 "-1 C" 格式中提取数字部分
        String numStr = tempStr.replaceAll("[^\\d.-]", "");
        try {
            return Double.parseDouble(numStr);
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
    
    private String translateToChinese(String englishDescription) {
        // 简单的英文到中文翻译映射
        switch (englishDescription.toLowerCase()) {
            case "sunny":
                return "晴天";
            case "partly cloudy":
                return "多云";
            case "cloudy":
                return "多云";
            case "overcast":
                return "阴天";
            case "light rain":
                return "小雨";
            case "moderate rain":
                return "中雨";
            case "heavy rain":
                return "大雨";
            case "thunderstorm":
                return "雷雨";
            case "snow":
                return "雪";
            case "fog":
                return "雾";
            case "mist":
                return "薄雾";
            case "clear sky":
                return "晴朗";
            case "few clouds":
                return "少云";
            case "scattered clouds":
                return "疏云";
            case "broken clouds":
                return "碎云";
            case "shower rain":
                return "阵雨";
            case "rain":
                return "雨";
            case "light intensity shower rain":
                return "小强度阵雨";
            case "ragged shower rain":
                return "不规则阵雨";
            case "light snow":
                return "小雪";
            case "sleet":
                return "雨夹雪";
            case "light shower sleet":
                return "小冻雨";
            case "shower sleet":
                return "冻雨";
            case "light rain and snow":
                return "小雨夹雪";
            case "rain and snow":
                return "雨夹雪";
            case "light shower snow":
                return "小阵雪";
            case "shower snow":
                return "阵雪";
            case "heavy shower snow":
                return "大阵雪";
            case "smoke":
                return "烟雾";
            case "haze":
                return "霾";
            case "sand/dust whirls":
                return "沙尘旋风";
            case "sand":
                return "沙";
            case "dust":
                return "尘土";
            case "volcanic ash":
                return "火山灰";
            case "squalls":
                return "飑";
            case "tornado":
                return "龙卷风";
            case "clear":
                return "晴朗";
            case "calm":
                return "平静";
            case "light breeze":
                return "微风";
            case "gentle breeze":
                return "轻风";
            case "moderate breeze":
                return "和风";
            case "fresh breeze":
                return "清风";
            case "strong breeze":
                return "强风";
            case "high wind, near gale":
                return "疾风";
            case "gale":
                return "大风";
            case "severe gale":
                return "烈风";
            case "storm":
                return "风暴";
            case "violent storm":
                return "狂暴风暴";
            case "hurricane":
                return "飓风";
            default:
                return englishDescription; // 如果没有匹配项，返回原文
        }
    }
    
    public static class WeatherInfo {
        private String currentTemp;
        private String condition;
        private String tempRange;
        private String cityName;
        
        public WeatherInfo(String currentTemp, String condition, String tempRange, String cityName) {
            this.currentTemp = currentTemp;
            this.condition = condition;
            this.tempRange = tempRange;
            this.cityName = cityName;
        }
        
        public String getCurrentTemp() {
            return currentTemp;
        }
        
        public String getCondition() {
            return condition;
        }
        
        public String getTempRange() {
            return tempRange;
        }
        
        public String getCityName() {
            return cityName;
        }
        
        public String getFullDescription() {
            return "📍 " + cityName + " " + condition + ", " + currentTemp;
        }
    }
}