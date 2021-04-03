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

import com.xsr.negocio.Status;

public class ManterStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException {
        res.setContentType("text/html;charset=iso-8859-1");
        PrintWriter out = res.getWriter();
        
		Status s = new Status(); 
        String btn = req.getParameter("action");
        
		int id = Integer.parseInt(req.getParameter("id"));
		String nome = req.getParameter("nome");
		
        if(btn.equals("adicionar")) {
            try {				
				s.setId(id);
				s.setNome(nome);
				s.addStatus();				
			}
			catch (Exception ex) {
		        Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
			}
        }
        
        if(btn.equals("alterar")) {
            try {
                s.alterStatus(id, nome);
            }
			catch (Exception ex) {
                Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if(btn.equals("excluir")) {
			try {
				s.excStatus(id);
			}
			catch (Exception ex) {
                Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
            }
		}
		
        if(btn.equals("buscar")) {
			try {
				s.excStatus(id);
			}
			catch (Exception ex) {
                Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
            }
		}
        
		getServletContext().getRequestDispatcher("/interfaces/ManterStatus.jsp").forward(req, res);
		
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
        } catch (Exception ex) {
            Logger.getLogger(ManterStatus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}