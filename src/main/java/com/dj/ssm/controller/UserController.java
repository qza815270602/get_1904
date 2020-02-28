package com.dj.ssm.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.ssm.common.ResultModel;
import com.dj.ssm.pojo.User;
import com.dj.ssm.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserService userService;



    @PutMapping
    public ResultModel<Object> update(User user) {
        userService.updateById(user);
        return new ResultModel<>().success();
    }

    @PostMapping
    public ResultModel<Object> save(User user) {
        userService.save(user);
        return new ResultModel<>().success();
    }


    @RequestMapping("findByName")
    public boolean findByName(String userName) {
        try {
            QueryWrapper<User> wrapper = new QueryWrapper<User>();
            wrapper.eq("user_name", userName);
            User user = userService.getOne(wrapper);
            return null == user ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @RequestMapping("findByPhone")
    public boolean findByPhone(String phone) {
        try {
            QueryWrapper<User> wrapper = new QueryWrapper<User>();
            wrapper.eq("phone", phone);
            User user = userService.getOne(wrapper);
            return null == user ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    @DeleteMapping
    public ResultModel<Object> del(User user){
        userService.updateById(user);
        return new ResultModel<>().success();
    }

    @PostMapping("/list")
    public ResultModel<Object> show(User user, Integer age1, Integer pageNo) {
        HashMap<String, Object> map = new HashMap<>();
        try {
            PageHelper.startPage(pageNo, 2);
            QueryWrapper<User> wrapper = new QueryWrapper<>();
            if (!StringUtils.isEmpty(user.getUserName())) {
                wrapper.like("user_name", user.getUserName());
            }
            if (null != user.getSex()) {
                wrapper.eq("sex", user.getSex());
            }
            if (null != user.getAge() && null != age1) {
                wrapper.between("age", user.getAge(), age1);
            }
            wrapper.eq("is_del", user.getIsDel());
            List<User> userList = userService.list(wrapper);
            PageInfo<User> pageInfo = new PageInfo<User>(userList);
            map.put("totalNum", pageInfo.getPages());
            map.put("userList", userList);
            return new ResultModel<>().success(map);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel<>().error("服务器异常");
        }

    }





}
