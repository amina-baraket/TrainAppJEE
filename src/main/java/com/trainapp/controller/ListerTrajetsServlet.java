package com.trainapp.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainapp.dao.TrajetDAO;
import com.trainapp.model.Trajet;

/**
 * Servlet implementation class ListerTrajetsServlet
 */
@WebServlet("/listerTrajets")
public class ListerTrajetsServlet extends HttpServlet {

    private TrajetDAO trajetDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        trajetDAO = new TrajetDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Trajet> trajets = null;
		try {
			trajets = trajetDAO.getAllTrajets();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.setAttribute("trajets", trajets);
        request.getRequestDispatcher("listeTrajets.jsp").forward(request, response);
    }
}
