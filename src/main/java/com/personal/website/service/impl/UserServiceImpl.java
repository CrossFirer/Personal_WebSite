package com.personal.website.service.impl;

import com.personal.website.service.UserService;
import com.personal.website.mapper.UserMapper;
import com.personal.website.pojo.User;
import org.apache.ibatis.session.SqlSession;
import com.personal.website.utils.MyBatisUtil;

/**
 * 功能描述：
 *
 * @author cross
 * @version 1.0
 * @date 2026 1月 26 12:39
 */
public class UserServiceImpl implements UserService {
    @Override
    public User login(String username, String password) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            User user = userMapper.findByUsername(username);

            if (user != null && user.getPassword().equals(password)) {
                return user;
            }
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean register(User user) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            // 检查用户名是否已存在
            User existingUser = userMapper.findByUsername(user.getUsername());
            if (existingUser != null) {
                return false; // 用户名已存在
            }

            int result = userMapper.insert(user);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public User findUserByUsername(String username) {
        SqlSession session = MyBatisUtil.getSession();
        try {
            UserMapper userMapper = session.getMapper(UserMapper.class);
            return userMapper.findByUsername(username);
        } finally {
            session.close();
        }
    }
}
