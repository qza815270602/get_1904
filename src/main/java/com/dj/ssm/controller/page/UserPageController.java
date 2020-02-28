package com.dj.ssm.controller.page;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dj.ssm.pojo.User;
import com.dj.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @ProjectName: pms
 * @Package: com.dj.pms.web.page
 * @ClassName: UserPageController
 * @Author: Administrator
 * @Description:
 * @Date: 2020/1/31 16:09
 * @Version: 1.0
 */
@Controller
@RequestMapping("/user/")
public class UserPageController {

    @Autowired
    private UserService userService;


    @RequestMapping("toShow")
    public String toLogin() {
        return "user/show";
    }

    @RequestMapping("toAdd")
    public String toAdd() {
        return "user/add";
    }

    @RequestMapping("toUpdate/{id}")
    public String toUpdate(@PathVariable("id") Integer id, Model model) {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("id", id);
        User user = userService.getOne(wrapper);
        model.addAttribute("user", user);
        return "user/update";
    }


}
