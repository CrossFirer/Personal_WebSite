package com.personal.website.service;

import com.personal.website.pojo.User;

/**
 * 功能描述：
 *
 * @author cross
 * @version 1.0
 * @date 2026 1月 26 12:38
 */
public interface UserService {
    User login(String username, String password);
    boolean register(User user);
    User findUserByUsername(String username);
}
