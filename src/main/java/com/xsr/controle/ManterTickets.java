package com.xsr.controle;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xsr.config.Config;
import com.xsr.negocio.Categoria;
import com.xsr.negocio.Report;
import com.xsr.negocio.Severidade;
import com.xsr.negocio.Ticket;
import com.xsr.negocio.Usuario;

public class ManterTickets extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html;charset=iso-8859-1");
        PrintWriter out = res.getWriter();
        
        Ticket tic = new Ticket();
        String acao, responsavel, valorPesquisa;
    	Vector<Ticket> vetorTicket = new Vector<Ticket>();
    	
    	acao = req.getParameter("action");

    	if (acao.equalsIgnoreCase("pesquisar")) {
			try {
				responsavel = req.getParameter("responsavel");
				valorPesquisa = req.getParameter("caixaPesquisa");
				tic.setDescricao(valorPesquisa);
				tic.getCategoria().setNome(valorPesquisa);
				tic.getCliente().setNome(valorPesquisa);
				tic.getSeveridade().setNome(valorPesquisa);
				tic.setStatus(valorPesquisa);
				if (responsavel.equals("")) {
					tic.getResponsavel().setNome(valorPesquisa);
					vetorTicket = tic.listarPorTexto();
				}
				else {
					tic.getResponsavel().setNome(responsavel);
					vetorTicket = tic.listarPorResponsavel();
				}
					req.setAttribute("vetorTicket", vetorTicket);
					getServletContext().getRequestDispatcher("/interfaces/FilaDeChamados.jsp").forward(req, res);
			}
			catch(Exception e) {
			System.out.println("Erro: " + e.getMessage());
			}
    	}
    	
    	if (acao.equalsIgnoreCase("exibir")) {
			try {
				tic.setId(Integer.parseInt(req.getParameter("id")));
				tic.findTicket();
				if (tic != null) {
					req.setAttribute("ticket", tic);
					getServletContext().getRequestDispatcher("/interfaces/Atendimento.jsp").forward(req, res);
				}
				else {
					getServletContext().getRequestDispatcher("/interfaces/ErroGeral.jsp").forward(req, res);
				}
			}
			catch(Exception e) {
				System.out.println("Erro: " + e.getMessage());
			}
		}
    	
    	if (acao.equalsIgnoreCase("abrirChamado")) {
			try {
				tic.setId(Integer.parseInt(req.getParameter("id")));
				tic.setTitulo(req.getParameter("titulo"));
				tic.setDescricao(req.getParameter("descricao"));
				tic.setStatus(req.getParameter("status"));
				
				Categoria c = new Categoria();
				c.setId(Integer.parseInt(req.getParameter("categoria")));
				c.findCateg();
				tic.setCategoria(c);
				
				Severidade s = new Severidade();
				s.setId(Integer.parseInt(req.getParameter("severidade")));
				s.findSev();
				tic.setSeveridade(s);

				Usuario usuResp = new Usuario();
				usuResp.setId(0);
				tic.setResponsavel(usuResp);
				
				Usuario usuCli = new Usuario();
				usuCli.setId(Integer.parseInt(req.getParameter("cliente")));
				usuCli.findUsuario();
				tic.setCliente(usuCli);
							
				tic.setDataAbertura(req.getParameter("data"));
				
				tic.openTicket();
				
				req.setAttribute("protocolo", tic.getId());
				getServletContext().getRequestDispatcher("/interfaces/NumeroDeProtocolo.jsp").forward(req, res);
			}
			catch (NullPointerException np) {
				np.printStackTrace();
				getServletContext().getRequestDispatcher("/interfaces/NumeroDeProtocolo.jsp").forward(req, res);
			}
			catch(Exception e) {
				e.printStackTrace();
				getServletContext().getRequestDispatcher("/interfaces/ErroGeral.jsp").forward(req, res);
			}
		}
    	if (acao.equalsIgnoreCase("Registrar")) {
    		try {
    			int ticket = Integer.parseInt(req.getParameter("ticket")); //recupera o numero do ticket da pagina
   				tic.setId(ticket);
    			tic.findTicket();// recupera o ticket do  banco de dados
    			Report rep = new Report();
    			
    			Calendar cal = Calendar.getInstance();
    			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy - HH:mm ");// obter data e hora atual
    			
    			rep.setDataHora(sdf.format(cal.getTime()));
    			rep.setDescricao(req.getParameter("descricao"));
    			//aciona o metodo add report da classe de negocio report
    			
    			Vector<Report> vetRep = rep.listAll();
    			Report report = new Report();
    			for (int i=0;i<vetRep.size();i++) { report = (Report)vetRep.elementAt(i); }
    			rep.regReport(report.getId()+1, ticket, Integer.parseInt(req.getParameter("status")), tic.getResponsavel().getId());
    		}
    		catch(Exception e) {
				e.printStackTrace();
				getServletContext().getRequestDispatcher("/interfaces/ErroGeral.jsp").forward(req, res);
    		}
    	}
    	
    	if (acao.equalsIgnoreCase("alterar")) {
    		try {
    			int ticket = Integer.parseInt(req.getParameter("ticket"));
    			Usuario usu = new Usuario();
    			usu = (Usuario) req.getAttribute("resp");
    			tic.setId(ticket);
    			tic.findTicket();
    			tic.setTitulo(req.getParameter("titulo"));
    			tic.setDescricao(req.getParameter("descricao"));
    			tic.getSeveridade().setId(Integer.parseInt(req.getParameter("severidade")));
    			tic.alterTicket();
    			req.setAttribute("ticket", tic);
    			req.setAttribute("responsavel", usu);
    			getServletContext().getRequestDispatcher("/interfaces/Atendimento.jsp").forward(req, res);
    		}
    		catch(Exception e) {
				e.printStackTrace();
				getServletContext().getRequestDispatcher("/interfaces/ErroGeral.jsp").forward(req, res);
    		}
    	}
    	
    	if (acao.equalsIgnoreCase("fechar")) {
    		try {
    			int ticket = Integer.parseInt(req.getParameter("ticket"));
    			tic.setId(ticket);
    			tic.findTicket();
    			tic.setStatus("Pendente");
    			tic.alterTicket();
    			req.setAttribute("ticket", tic);
    			getServletContext().getRequestDispatcher("/interfaces/NovaSolucao.jsp").forward(req, res);
    		}
    		catch(Exception e) {
				e.printStackTrace();
				getServletContext().getRequestDispatcher("/interfaces/ErroGeral.jsp").forward(req, res);
    		}
    	}
    	
    	if (acao.equalsIgnoreCase("concluir chamado")) {
    		try {
    			int ticket = Integer.parseInt(req.getParameter("ticket"));
    			tic.setId(ticket);
    			tic.findTicket();
    			tic.setStatus("Fechado");
    			tic.alterTicket();
    			req.setAttribute("ticket", tic);
    			getServletContext().getRequestDispatcher("/interfaces/FilaDeChamados.jsp").forward(req, res);
    		}
    		catch(Exception e) {
    			System.out.println("Erro: " + e.getMessage());
    		}
    	}
    	
    	if (acao.equalsIgnoreCase("clonar")) {
    		try {
    			int ticket = Integer.parseInt(req.getParameter("ticket"));
    			tic.setId(ticket);
    			tic.findTicket();
    			req.setAttribute("ticket", tic);
    			getServletContext().getRequestDispatcher("/interfaces/NovoChamado.jsp").forward(req, res);
    		}
    		catch(Exception e) {
    			System.out.println("Erro: " + e.getMessage());
    		}
    	}
    	
    	if (acao.equalsIgnoreCase("relatorio")) {
    		try {
				valorPesquisa = req.getParameter("pl_chave");
				if (valorPesquisa != "") {
					tic.setTitulo(valorPesquisa);
					tic.setDescricao(valorPesquisa);
					tic.getCategoria().setNome(valorPesquisa);
					tic.getCliente().setNome(valorPesquisa);
					tic.getSeveridade().setNome(valorPesquisa);
					tic.getResponsavel().setNome(valorPesquisa);
					tic.setStatus(valorPesquisa);
					vetorTicket = tic.listarPorTexto();
				}
				else {
					vetorTicket = tic.listarTodos();
				}
				req.setAttribute("vetorTicket", vetorTicket);
				getServletContext().getRequestDispatcher("/interfaces/ResultadoRelatorio.jsp").forward(req, res);
			}
			catch(Exception e) {
			System.out.println("Erro: " + e.getMessage());
			}
    	}
    	
    	if (acao.equalsIgnoreCase("alocar")) {
    		if (req.getParameter("responsavel") == null) {
    			try {
    			Integer.parseInt(req.getParameter("usuarioLogado"));
    			tic.setId(Integer.parseInt(req.getParameter("ticket")));
    			tic.findTicket();
    			tic.getResponsavel().setId(Integer.parseInt(req.getParameter("usuarioLogado")));
    			tic.getResponsavel().findUsuario();
    			tic.alterTicket();
    			req.setAttribute("responsavel", tic.getResponsavel());
    			req.setAttribute("ticket", tic);
    			getServletContext().getRequestDispatcher("/interfaces/Atendimento.jsp").forward(req, res);
    			}
    			catch(Exception e) {
    				res.sendRedirect(Config.getPageURL() + "ErroGeral.jsp");
    				System.out.println("Erro: " + e.getMessage());
    			}
    		}
    	}
    	
    	if (acao.equalsIgnoreCase("reabrir")) {
    		try {
    			int ticket = Integer.parseInt(req.getParameter("ticket"));
    			tic.setId(ticket);
    			tic.findTicket();
    			tic.setStatus("Aberto");
    			tic.alterTicket();
    			req.setAttribute("ticket", tic);
    			req.setAttribute("reaberto", "sim");
    			getServletContext().getRequestDispatcher("/interfaces/Atendimento.jsp").forward(req, res);
    		}
    		catch(Exception e) {
    			System.out.println("Erro: " + e.getMessage());
    		}
    	}

    	try {
            /* TODO output your page here
              out.println("<html>");
              out.println("<head>");
              out.println("<title>Servlet ManterTickets</title>");  
              out.println("</head>");
              out.println("<body>");
              out.println("<h1>Servlet ManterTickets at " + req.getContextPath () + "</h1>");
              out.println("</body>");
              out.println("</html>");
            */
        }
		finally { 
            out.close();
        }
    } 

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            processRequest(req, res);
            
        } catch (Exception ex) {
            Logger.getLogger(ManterTickets.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}