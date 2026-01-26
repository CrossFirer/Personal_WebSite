package com.personal.website.mapper;

import com.personal.website.pojo.User;

/**
 * 功能描述：
 *
 * @author cross
 * @version 1.0
 * @date 2026 1月 26 12:42
 */
public interface UserMapper {
    User findByUsername(String username);
    int insert(User user);
}
