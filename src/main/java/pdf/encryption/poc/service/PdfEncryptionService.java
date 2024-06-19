package pdf.encryption.poc.service;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.encryption.StandardProtectionPolicy;
import org.apache.pdfbox.pdmodel.encryption.AccessPermission;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

@Service
public class PdfEncryptionService {

    public byte[] encryptPdf(byte[] pdfData, String password) throws IOException {
        try (PDDocument document = Loader.loadPDF(pdfData)) {
            AccessPermission accessPermission = new AccessPermission();
            StandardProtectionPolicy spp = new StandardProtectionPolicy(password, password, accessPermission);
            spp.setEncryptionKeyLength(128); // Or 256 for stronger encryption
            spp.setPermissions(accessPermission);

            document.protect(spp);
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            document.save(outputStream);
            return outputStream.toByteArray();
        }
    }
}