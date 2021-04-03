package com.xsr.controle;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.*;
import javax.servlet.http.*;

import com.xsr.negocio.Usuario;

public class ManterUsuarios extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        res.setContentType("text/html;charset=iso-8859-1");
        PrintWriter out = res.getWriter();
        
		Usuario usu = new Usuario(); 
        String btn = req.getParameter("action");
        Collection<Usuario> vetorUsu = new ArrayList<Usuario>();
        
        int id = Integer.parseInt(req.getParameter("id"));
		String nome = req.getParameter("nome");
		String login = req.getParameter("login");
		
        if(btn.equals("adicionar")) {
            try {				
				usu.setId(id);
				usu.setNome(nome);
				usu.addUsuario();				
			}
			catch (Exception ex) {
		        Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
			}
        }
        
        if(btn.equals("alterar")) {
            try {
                usu.alterUsuario();
            }
			catch (Exception ex) {
                Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if(btn.equals("excluir")) {
			try {
				usu.excUsuario(id);
			}
			catch (Exception ex) {
                Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
		if (btn.equalsIgnoreCase("Buscar")) {
			try {
				if (login != null) {
					usu.setLogin(login);
				}
				if (nome != null) {
					usu.setNome(nome);
				}
				
				vetorUsu = usu.listarPorFiltro();
				req.setAttribute("vetorUsu", vetorUsu);
				
				getServletContext().getRequestDispatcher("/interfaces/ManterUsuarios.jsp").forward(req, res);
			}
			catch(Exception e) {
				e.printStackTrace();
				System.out.println("Erro: " + e.getMessage());
			}
    	}
		
		try {
            /* TODO output your page here
              out.println("<html>");
              out.println("<head>");
              out.println("<title>Servlet ManterStatus</title>");  
              out.println("</head>");
              out.println("<body>");
              out.println("<h1>Servlet ManterStatus at " + req.getContextPath () + "</h1>");
              out.println("</body>");
              out.println("</html>");
            */
        }
		finally { 
            out.close();
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
        try {
            processRequest(req, res);
        } catch (SQLException ex) {
            Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String getServletInfo() {
        return "Short description";
    }
}