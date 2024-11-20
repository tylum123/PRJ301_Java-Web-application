package sample.controllers;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "SendEmailController", urlPatterns = {"/SendEmailController"})
@MultipartConfig
public class SendEmailController extends HttpServlet {

    static final String FROM = "minhfptse183899@gmail.com"; // Change to your email
    static final String PASSWORD = "juhoevednprdaqyw"; // Change to your email password
    static final String REPLY_TO = "tylum123@gmail.com"; // Change to your reply-to email

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Set UTF-8 encoding for request parameters
        String url = "sendEmail.jsp";
        String errorMessage = "";

        // Properties: khai báo các thuộc tính
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.mime.charset", "UTF-8");

        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };

        // Phiên làm việc
        Session session = Session.getInstance(props, auth);

        try {
            // Kiểm tra các tham số email
            String to = request.getParameter("to");
            String cc = request.getParameter("cc");
            String bcc = request.getParameter("bcc");
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            // Nếu bất kỳ tham số nào bị thiếu, hiển thị lỗi
            if (to == null || to.isEmpty() || title == null || title.isEmpty() || content == null || content.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng nhập đầy đủ thông tin email.");
            }

            // Tạo một tin nhắn
            MimeMessage msg = new MimeMessage(session);

            // Kiểu nội dung
            msg.addHeader("Content-type", "text/html; charset=UTF-8");

            // Người gửi
            msg.setFrom(new InternetAddress(FROM));

            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            if (cc != null && !cc.isEmpty()) {
                msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
            }
            if (bcc != null && !bcc.isEmpty()) {
                msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));
            }

            // Địa chỉ nhận phản hồi
            msg.setReplyTo(InternetAddress.parse(REPLY_TO, false));

            // Tiêu đề email
            msg.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));

            // Quy định ngày gửi
            msg.setSentDate(new Date());

            // Tạo phần đa phần (multipart)
            MimeMultipart multipart = new MimeMultipart();

            // Phần nội dung văn bản
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setContent(content, "text/html; charset=UTF-8");
            multipart.addBodyPart(textPart);

            // Phần tệp đính kèm
            Part filePart = request.getPart("file");
            if (filePart != null && filePart.getSize() > 0) {
                MimeBodyPart attachmentPart = new MimeBodyPart();
                DataSource source = new FileDataSource(getFileFromPart(filePart));
                attachmentPart.setDataHandler(new DataHandler(source));
                attachmentPart.setFileName(filePart.getSubmittedFileName());
                multipart.addBodyPart(attachmentPart);
            }

            // Đặt phần đa phần (multipart) vào tin nhắn
            msg.setContent(multipart);

            // Gửi email
            Transport.send(msg);
            System.out.println("Gửi email thành công");
        } catch (Exception e) {
            System.out.println("Gặp lỗi trong quá trình gửi email");
            e.printStackTrace();
            errorMessage = "Lỗi khi gửi email: " + e.getMessage();
            request.setAttribute("errorMessage", errorMessage);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private File getFileFromPart(Part part) throws IOException {
        String fileName = part.getSubmittedFileName();
        File file = new File(System.getProperty("java.io.tmpdir") + "/" + fileName);
        part.write(file.getAbsolutePath());
        return file;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
