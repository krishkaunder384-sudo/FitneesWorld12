package com.gym_website.helper;

import com.gym_website.config.EmailConfig;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class MailHelper {

    public static boolean sendEmail(String toEmail, String subject, String messageHtml) {
        try {
            EmailConfig.validate();

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EmailConfig.EMAIL_USER, EmailConfig.EMAIL_PASS);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EmailConfig.EMAIL_USER, "FitnessWorld"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // ✅ HTML support
            message.setContent(messageHtml, "text/html; charset=UTF-8");

            Transport.send(message);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
