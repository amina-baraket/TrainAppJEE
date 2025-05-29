/*
import com.trainapp.dao.PaiementDAO;
import com.trainapp.model.Paiement;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/gererPaiements")
public class GererPaiementsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Paiement> paiements = PaiementDAO.listerPaiements();
        request.setAttribute("paiements", paiements);
        request.getRequestDispatcher("listePaiements.jsp").forward(request, response);
    }
}
*/