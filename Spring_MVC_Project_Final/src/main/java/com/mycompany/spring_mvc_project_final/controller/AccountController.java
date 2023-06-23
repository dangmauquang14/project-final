/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.UserEntity;
import com.mycompany.spring_mvc_project_final.entities.UserRoleEntity;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import static com.mycompany.spring_mvc_project_final.main.Main.encrytePassword;
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
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author nguye
 */
@Controller
public class AccountController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    public JavaMailSender emailSender;

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String signUp(Model model) {
        model.addAttribute("roles", userRoleService.getUserRole());
        return "user/signup";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String signUpAccount(Model model,
            @ModelAttribute("signup") UserEntity userEntity,
            HttpServletRequest request,
            @RequestParam(value = "type", required = false) String type,
            @RequestParam(value = "message", required = false) String message) throws MessagingException {

        List<UserEntity> users = userService.getUsers();
        for (UserEntity user : users) {
            if (userEntity.getEmail().equals(user.getEmail())) {
                model.addAttribute("type", "fail");
                model.addAttribute("message", "This email is already registered for an account!!!");
                return "user/signup";
            }
        }
        userEntity.setPassword(encrytePassword(userEntity.getPassword()));
        UUID uuid = UUID.randomUUID();
        userEntity.setUuid(uuid.toString());
        String[] roleIds = request.getParameterValues("role");
        if (roleIds != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleIds[i]));
                roles.add(userRole);
            }
            userEntity.setUserRoles(roles);
        }
        userService.save(userEntity);
//       send mail
        MimeMessage messagee = emailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(messagee, multipart, "utf-8");
        String htmlMsg = "";
        htmlMsg = "<h3>Registration Success</h3>" + "<br><br>" + "Complete Registration! " + "<br><br>" + "To confirm your account, please click here : "
                + "<a href=\"http://localhost:8080/Spring_MVC_Project_Final/active/" + userEntity.getUuid() + "\">" + "active" + "</a>";
        messagee.setContent(htmlMsg, "text/html");
        helper.setTo(userEntity.getEmail());
        helper.setSubject("Registration Success!!!");
        this.emailSender.send(messagee);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "login";
    }

    @RequestMapping(value = "/active/{uuid}")
    public String updateStatus(@PathVariable(value = "uuid") String uuid) {
        UserEntity userEntity = userService.findByUuid(uuid);
        userEntity.setStatus(UserStatus.ACTIVE);
        userService.save(userEntity);
        return "redirect:/login?type=success&message=Sign up success for account id: " + uuid;
    }

    @RequestMapping(value = "/change-password/{uuid}")
    public String changePassword(Model model,
            @PathVariable(value = "uuid") String uuid) {
        UserEntity userEntity = userService.findByUuid(uuid);
        model.addAttribute("userEntity", userEntity);
        model.addAttribute("roles", userRoleService.getUserRole());
        return "change-password";
    }

    @RequestMapping(value = "/change-password", method = RequestMethod.POST)
    public String changePasswordResult(Model model,
            HttpServletRequest request,
            @ModelAttribute("userEntity") UserEntity userEntity) {
        String[] roleIds = request.getParameterValues("role");
        if (roleIds != null) {
            Set<UserRoleEntity> roles = new HashSet<>();
            for (int i = 0; i < roleIds.length; i++) {
                UserRoleEntity userRole = userRoleService.getUserRoleById(Integer.valueOf(roleIds[i]));
                roles.add(userRole);
            }
            userEntity.setUserRoles(roles);
        }
        userEntity.setStatus(UserStatus.ACTIVE);
        userEntity.setPassword(encrytePassword(userEntity.getPassword()));
        userService.save(userEntity);
        return "redirect:/home";
    }

    @RequestMapping(value = "/changeAccount/{email}")
    public String viewInfoAccount(Model model,
            @RequestParam(value = "type", required = false) String type,
            @RequestParam(value = "message", required = false) String message,
            @PathVariable(value = "email") String email) {

        UserEntity userEntity = userService.findByEmail(email);
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        model.addAttribute("username", username);

        if (userEntity.getId() > 0) {
            model.addAttribute("userEntity", userEntity);
            model.addAttribute("type", type);
            model.addAttribute("action", "update");
            model.addAttribute("message", message);
            return "user/account";
        } else {
            model.addAttribute("type", "fail");
            model.addAttribute("message", "email already exist.!!");

            return "redirect:/user/account?type=error&message=Not found ";
        }

    }

    @RequestMapping("/result")
    public String home(@ModelAttribute("userEntity") UserEntity userEntity,
            HttpServletRequest request) {
        userService.save(userEntity);

        return "redirect:/changeAccount/" + userEntity.getEmail();
    }

}
