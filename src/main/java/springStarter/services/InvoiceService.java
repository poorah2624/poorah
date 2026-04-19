package springStarter.services;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import springStarter.models.Order_item;

@Service
@Transactional
public class InvoiceService {

    public void generateInvoice(Order_item item, HttpServletResponse response) throws Exception {

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        // TITLE
        document.add(new Paragraph("INVOICE"));
        document.add(new Paragraph(" "));

        // ORDER INFO
        document.add(new Paragraph("Order ID: " + item.getOrder().getOrderNumber()));
        document.add(new Paragraph("Date: " + item.getOrder().getOrderDate()));
        document.add(new Paragraph(" "));

        // USER INFO
        document.add(new Paragraph("Customer: " + item.getOrder().getUser().getUserName()));
        document.add(new Paragraph("Email: " + item.getOrder().getUser().getUserEmail()));
        document.add(new Paragraph(" "));

        // PRODUCT INFO
        if(item.getIsCustom()){
            document.add(new Paragraph("Product: Custom T-Shirt"));
            document.add(new Paragraph("Size: " + item.getSize()));
            document.add(new Paragraph("Color: " + item.getColor()));
        } else {
            document.add(new Paragraph("Product: " + item.getItem().getItemName()));
        }

        document.add(new Paragraph("Quantity: " + item.getQuantity()));
        document.add(new Paragraph("Price: ₹" + item.getFinalPrice()));
        document.add(new Paragraph(" "));

        // PAYMENT
        document.add(new Paragraph("Payment Method: " + item.getOrder().getPaymentMethod()));
        document.add(new Paragraph("Payment Status: " + item.getOrder().getPaymentStatus()));

        document.close();
    }
}