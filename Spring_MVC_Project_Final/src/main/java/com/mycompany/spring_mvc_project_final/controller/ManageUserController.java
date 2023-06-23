/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.service.UserRoleService;
import com.mycompany.spring_mvc_project_final.service.UserService;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class ManageUserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    public JavaMailSender emailSender;

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String viewUsers(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message,
            @RequestParam(name = "page", required = false, defaultValue = "0") Integer page,
            @RequestParam(name = "size", required = false, defaultValue = "3") Integer size,
            @RequestParam(name = "start", required = false, defaultValue = "0") Integer start,
            @RequestParam(name = "sortBy", required = false, defaultValue = "id") String sortBy) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy).descending());
        int n = userService.getUsers().size();
        //setting number page
        if (n % size != 0) {
            model.addAttribute("numberPages", (n / size) + 1);
        } else {
            model.addAttribute("numberPages", (n / size));
        }
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("users", userService.getUsersPage(pageable));
        model.addAttribute("roles", userRoleService.getUserRole());
        model.addAttribute("userStatus", UserStatus.values());
        model.addAttribute("page", page);
        model.addAttribute("start", start);
        model.addAttribute("size", 3);
        model.addAttribute("n", n);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/users";
    }

    @RequestMapping("/user/update-user")
    public String updateUser(Model model,
            HttpServletRequest request,
            @RequestParam("id") int id,
            @RequestParam("status") UserStatus status) {
        String url = request.getHeader("referer");
        UserEntity user = userService.findById(id);
        String[] roleIds = request.getParameterValues("role");
        if (roleIds != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleIds[i]));
                roles.add(userRole);
            }
            user.setUserRoles(roles);
        }
        user.setStatus(status);
        userService.save(user);

        return "redirect:" + url;
    }

    @RequestMapping(value = "/search-user", method = RequestMethod.GET)
    public String searchUser(Model model,
            @ModelAttribute("strSearch") String strSearch) {
        if (strSearch.equals("")) {
            return "redirect:/admin/users";
        }
        //setting number page
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("users", userService.findByUsersByEmailOrFullName(strSearch, strSearch));
        model.addAttribute("username", username);
        model.addAttribute("strSearch", strSearch);
        model.addAttribute("roles", userRoleService.getUserRole());
        model.addAttribute("userStatus", UserStatus.values());
        return "admin/users";
    }

    @RequestMapping(value = "/add-user", method = RequestMethod.GET)
    public String addUser(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        model.addAttribute("roles", userRoleService.getUserRole());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "admin/user";
    }

    @RequestMapping(value = "/add-user", method = RequestMethod.POST)
    public String addUserResult(Model model,
            HttpServletRequest request,
            @ModelAttribute("user") UserEntity user) throws MessagingException {
        List<UserEntity> users = userService.getUsers();
        for (UserEntity userEntity : users) {
            if (user.getEmail().equals(userEntity.getEmail())) {
                model.addAttribute("type", "error");
                model.addAttribute("message", "This email is already registered for an account!!!");
                return "redirect:/admin/add-user";
            }
        }
        String[] roleIds = request.getParameterValues("role");
        if (roleIds != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleIds[i]));
                roles.add(userRole);
            }
            user.setUserRoles(roles);
        }
        UUID uuid = UUID.randomUUID();
        user.setUuid(uuid.toString());
        userService.save(user);

        //send mail change password
        MimeMessage messagee = emailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(messagee, multipart, "utf-8");
        String htmlMsg = "";
        htmlMsg = "<h3>Registration Success!!</h3>" + "<br><br>" + "Complete Registration! " + "<br><br>" + "<b>To Confirm your account and Change password, please click here : </b>"
                + "<a href=\"http://localhost:8080/Spring_MVC_Project_Final/change-password/" + user.getUuid() + "\">" + "Confirm and ChangePassword" + "</a>";
        messagee.setContent(htmlMsg, "text/html");
        helper.setTo(user.getEmail());
        helper.setSubject("Hshop (Registration Success!!!)");
        this.emailSender.send(messagee);
        model.addAttribute("type", "success");
        model.addAttribute("message", "Create User success!!");
        return "redirect:/admin/users";
    }

    @RequestMapping(value = "/add-user-role", method = RequestMethod.GET)
    public String addRole(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);
        return "admin/user-role";
    }

    @RequestMapping(value = "/add-user-role", method = RequestMethod.POST)
    public String addRoleResult(Model model,
            @ModelAttribute("userRole") UserRoleEntity userRole) {
        userRoleService.save(userRole);
        model.addAttribute("type", "success");
        model.addAttribute("message", "Create UserRole success!!");
        return "redirect:/admin/users";
    }
}
