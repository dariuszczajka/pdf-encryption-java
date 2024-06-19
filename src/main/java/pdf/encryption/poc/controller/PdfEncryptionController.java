package pdf.encryption.poc.controller;

import pdf.encryption.poc.service.PdfEncryptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Base64;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/encrypt")
public class PdfEncryptionController {

    @Autowired
    private PdfEncryptionService pdfEncryptionService;

    @PostMapping("/pdf")
    public ResponseEntity<String> encryptPdf(@RequestBody Map<String, String> request) {
        try {
            System.out.println("test");
            String base64Pdf = request.get("file");
            String password = request.get("password");
            byte[] pdfData = Base64.getDecoder().decode(base64Pdf);
            byte[] encryptedPdf = pdfEncryptionService.encryptPdf(pdfData, password);
            String base64EncryptedPdf = Base64.getEncoder().encodeToString(encryptedPdf);
            return ResponseEntity.ok(base64EncryptedPdf);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }
}
