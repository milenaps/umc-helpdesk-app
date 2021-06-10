package com.xsr.controle;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xsr.negocio.TipoDeAcesso;

public class ManterTiposDeAcesso extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=iso-8859-1");
        PrintWriter out = res.getWriter();
        
		TipoDeAcesso ta = new TipoDeAcesso();
        String btn = req.getParameter("action");
        
        int id = Integer.parseInt(req.getParameter("id"));
        String nome = "Default";
		int tela1 = 0;
		int tela2 = 0;
		int tela3 = 0;
		int tela4 = 0;
		int tela5 = 0;
		int tela6 = 0;
		int tela7 = 0;
		int tela8 = 0;
		int tela9 = 0;
		
		if (req.getParameter("nome")!="") {
			nome = req.getParameter("nome");
		}
		if (req.getParameter("tela1")=="") {
			tela1 = 1;
		}
		if (req.getParameter("tela2")=="") {
			tela2 = 1;
		}
		if (req.getParameter("tela3")=="") {
			tela3 = 1;
		}
		if (req.getParameter("tela4")=="") {
			tela4 = 1;
		}
		if (req.getParameter("tela5")=="") {
			tela5 = 1;
		}
		if (req.getParameter("tela6")=="") {
			tela6 = 1;
		}
		if (req.getParameter("tela7")=="") {
			tela7 = 1;
		}
		if (req.getParameter("tela8")=="") {
			tela8 = 1;
		}
		if (req.getParameter("tela9")=="") {
			tela9 = 1;
		}
		ta.setId(id);
		ta.setNome(nome);
		ta.setTela1(tela1);
		ta.setTela2(tela2);
		ta.setTela3(tela3);
		ta.setTela4(tela4);
		ta.setTela5(tela5);
		ta.setTela6(tela6);
		ta.setTela7(tela7);
		ta.setTela8(tela8);
		ta.setTela9(tela9);
		
        if (btn.equals("Adicionar")) {
            try {
            	ta.addTipo();
			}
            catch (Exception ex) {
                Logger.getLogger(ManterTiposDeAcesso.class.getName()).log(Level.SEVERE, null, ex); 
            }
		}
        
        if (btn.equals("Alterar")) {
			try {
				if (req.getParameter("nome")!="") {
        			nome = req.getParameter("nome");
        		}
				if (req.getParameter("tela1")!="") {
        			tela1 = 1;
        		}
        		if (req.getParameter("tela2")!="") {
        			tela2 = 1;
        		}
        		if (req.getParameter("tela3")!="") {
        			tela3 = 1;
        		}
        		if (req.getParameter("tela4")!="") {
        			tela4 = 1;
        		}
        		if (req.getParameter("tela5")!="") {
        			tela5 = 1;
        		}
        		if (req.getParameter("tela6")!="") {
        			tela6 = 1;
        		}
        		if (req.getParameter("tela7")!="") {
        			tela7 = 1;
        		}
        		if (req.getParameter("tela8")!="") {
        			tela8 = 1;
        		}
        		if (req.getParameter("tela9")!="") {
        			tela9 = 1;
        		}
				ta.alterTipo(id, nome, tela1, tela2, tela3, tela4, tela5, tela6, tela7, tela8, tela9);
			}
			catch (Exception ex) {
		        Logger.getLogger(ManterTiposDeAcesso.class.getName()).log(Level.SEVERE, null, ex);
			}
		}
        
        else if (btn.equals("Excluir")) {
			try {
				ta.excTipo(id);
			}
			catch (Exception ex) {
                Logger.getLogger(ManterTiposDeAcesso.class.getName()).log(Level.SEVERE, null, ex);
            }
		}
        
		getServletContext().getRequestDispatcher("/interfaces/ManterTiposDeAcesso.jsp").forward(req, res);
		
		try {
            /* TODO output your page here
              out.println("<html>");
              out.println("<head>");
              out.println("<title>Servlet ManterTiposDeAcesso</title>");  
              out.println("</head>");
              out.println("<body>");
              out.println("<h1>Servlet ManterTiposDeAcesso at " + req.getContextPath () + "</h1>");
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
           this.processRequest(req, res);
       } catch (Exception ex) {
           Logger.getLogger(ManterTiposDeAcesso.class.getName()).log(Level.SEVERE, null, ex);
       }
   }

   public String getServletInfo() {
       return "Short description";
   }
   // </editor-fold>
}