package com.xsr.controle;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xsr.negocio.Categoria;

public class ManterCategorias extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        res.setContentType("text/html;charset=iso-8859-1");
        PrintWriter out = res.getWriter();
        
		Categoria c = new Categoria(); 
        String btn = req.getParameter("action");
        
		int id = Integer.parseInt(req.getParameter("id"));
		String nome = req.getParameter("nome");
		
        if(btn.equals("Adicionar")) {
            try {				
				c.setId(id);
            	c.setNome(nome);
            	c.addCateg();             
			}
			catch (Exception ex) {
		        Logger.getLogger(ManterCategorias.class.getName()).log(Level.SEVERE, null, ex);
			}
        }
        
        if(btn.equals("Alterar")) {
            try {
            	c.alterCateg(id, nome);
            }
			catch (Exception ex) {
                Logger.getLogger(ManterCategorias.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
		
		if(btn.equals("AddSub")) {
            try {
            	int pai = Integer.parseInt(req.getParameter("pai"));
            	
            	c.setId(id);
            	c.setNome(nome);
            	c.setPai(pai);
				c.addCateg();
            }
			catch (Exception ex) {
                Logger.getLogger(ManterCategorias.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if(btn.equals("Excluir")) {
			try {
				c.excCateg(id);
			}
			catch (Exception ex) {
                Logger.getLogger(ManterCategorias.class.getName()).log(Level.SEVERE, null, ex);
            }
		}
        
		getServletContext().getRequestDispatcher("/interfaces/ManterCategorias.jsp").forward(req, res);
		
		try {
            /* TODO output your page here
              out.println("<html>");
              out.println("<head>");
              out.println("<title>Servlet ManterCategoria</title>");  
              out.println("</head>");
              out.println("<body>");
              out.println("<h1>Servlet ManterCategoria at " + req.getContextPath () + "</h1>");
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
            Logger.getLogger(ManterCategorias.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}