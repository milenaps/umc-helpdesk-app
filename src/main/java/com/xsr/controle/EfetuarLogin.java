package com.xsr.controle;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;

import com.xsr.config.Config;
import com.xsr.negocio.Usuario;

public class EfetuarLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		try {
			Usuario usu = new Usuario();
			usu.setLogin(request.getParameter("login"));
			usu.setSenha(request.getParameter("senha"));
			usu = usu.validarLogon();
			if (usu != null) {
				HttpSession sessao = request.getSession(true);
				sessao.setAttribute("login", usu);
				getServletContext().getRequestDispatcher("/interfaces/BoasVindas.jsp").forward(request, response);
			}
			else {
				response.sendRedirect("/interfaces/Autenticar2.jsp");
			}
		}
		catch (Exception erro1)	{
			response.sendRedirect("/interfaces/ErroGeral.jsp");
			System.out.println("Ocorreu um erro: " + erro1.getMessage());
		}
	}
}