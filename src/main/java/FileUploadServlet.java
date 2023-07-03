import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

@MultipartConfig
@WebServlet("/FileUploadServlet")
public class FileUploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the uploaded file
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        // Validate the file extension
        if (!fileName.endsWith(".xlsx")) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h2>Error!</h2>");
            out.println("<p>Please upload a valid Excel (.xlsx) file.</p>");
            return;
        }

        // Specify the base directory for uploads
        String baseDirectory = "uploads" + File.separator;


        // Save the file to a temporary location
        String uploadPath = getServletContext().getRealPath(baseDirectory); // Specify your desired upload path
        File file = new File(uploadPath + fileName);
        try (InputStream inputStream = filePart.getInputStream();
             OutputStream outputStream = new FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            // Establish a database connection
            String jdbcUrl = "jdbc:mysql://localhost:3306/excels";
            String username = "root";
            String password = "admin";
            try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
                // Prepare the SQL statement
                String sql = "INSERT INTO uploads (id, document_name, upload_time, document_content) VALUES (?, ?, ?, ?)";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setString(1, fileName);
                    statement.setBinaryStream(2, new FileInputStream(file));
                    statement.setTimestamp(3, new Timestamp(System.currentTimeMillis()));

                // Execute the SQL statement
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<h2>File Uploaded and Saved Successfully!</h2>");
                } else {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<h2>Failed to Upload File!</h2>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h2>Error!</h2>");
                out.println("<p>An error occurred while establishing the database connection.</p>");
                return;
            } catch (IOException e) {
                e.printStackTrace();
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h2>Error!</h2>");
                out.println("<p>An error occurred while saving the uploaded file...</p>");
                return;
            }

            // Validate the uploaded Excel document
            try {
                Workbook workbook = WorkbookFactory.create(file);
                Sheet sheet = workbook.getSheetAt(0);
                // Perform your specific validation logic here
                // For example, check the number of columns
                int expectedColumns = 3;
                Row headerRow = sheet.getRow(0);
                int actualColumns = headerRow == null ? 0 : headerRow.getLastCellNum();
                boolean isValid = actualColumns == expectedColumns;

                // Display the validation result
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (isValid) {
                    out.println("<h2>Validation Successful!</h2>");
                    out.println("<p>The uploaded Excel document is valid.</p>");
                } else {
                    out.println("<h2>Validation Failed!</h2>");
                    out.println("<p>The uploaded Excel document is invalid.</p>");
                }
            } catch (Exception e) {
                if (e instanceof InvalidFormatException) {
                    e.printStackTrace();
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<h2>Error!</h2>");
                    out.println("<p>The uploaded file is not a valid Excel document.</p>");
                } else if (e instanceof IOException) {
                    e.printStackTrace();
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<h2>Error!</h2>");
                    out.println("<p>An error occurred while reading the uploaded file.</p>");
                } else {
                    e.printStackTrace();
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<h2>Error!</h2>");
                    out.println("<p>An error occurred while processing the uploaded file.</p>");
                }
            } finally {
                // Delete the temporary file
                file.delete();
            }
        }
    }
}
