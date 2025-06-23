// src/main/java/servlet/BookRegisterServlet.java
package servlet;

import dao.BookDAO;
import model.Book;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/bookRegister")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class BookRegisterServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    
    private static final String UPLOAD_DIR = "image";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 로그인 체크
        HttpSession session = request.getSession();
        String sellerId = (String) session.getAttribute("userId");
        
        if (sellerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("desc");
        String bookCondition = request.getParameter("state");  // 이미 정의됨
        String category = request.getParameter("category");
        
     // 파일 업로드 처리
        String imagePath = "image/book1.jpg"; // 기본 이미지
        
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // 파일명에 타임스탬프 추가로 중복 방지
                    String fileExtension = "";
                    int dotIndex = fileName.lastIndexOf('.');
                    if (dotIndex > 0) {
                        fileExtension = fileName.substring(dotIndex);
                        fileName = fileName.substring(0, dotIndex);
                    }
                    String uniqueFileName = fileName + "_" + System.currentTimeMillis() + fileExtension;
                    
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs(); // mkdir() 대신 mkdirs() 사용
                    }
                    
                    String filePath = uploadPath + File.separator + uniqueFileName;
                    filePart.write(filePath);
                    imagePath = UPLOAD_DIR + "/" + uniqueFileName;
                    
                    System.out.println("파일 업로드 성공: " + imagePath);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("파일 업로드 실패, 기본 이미지 사용: " + e.getMessage());
            // 파일 업로드 실패시 기본 이미지 사용
        }
        
        // ✅ 수정된 부분: condition → bookCondition, userId → sellerId
        Book book = new Book(title, author, publisher, price, bookCondition, category, description, sellerId);
        if (imagePath != null && !imagePath.isEmpty()) {
            book.setImagePath(imagePath);
        }
        
        if (bookDAO.addBook(book)) {
            response.sendRedirect("index.jsp?success=book_added");
        } else {
            response.sendRedirect("bookRegister.jsp?error=1");
        }
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}