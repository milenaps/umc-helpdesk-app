<!-- Fila de chamados -->
<%@ page import="java.util.*"%>
<%@ page import="com.xsr.negocio.*"%>
<%@ page import="com.xsr.controle.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is a page from the Xtreme Service Request system." />
		<meta name="Abstract" content="This is a page from the Xtreme Service Request system." />
		<title>Xtreme Service Request - Fila de chamados</title>
		
		<%@ include file="styles.css" %>
	</head>

	<body>
         <div align="center">
			<div id="escope">
				<div id="header">&nbsp;</div>
				<div id="mn">
					<table border="0" cellpadding="1" cellspacing="1" class="tbl"width="99%" style="padding:0;">
						<tr>
							<td align="right">
								<%
									Usuario u = (Usuario) session.getAttribute("login");
									if (u != null) { %>
									<%=u.getTipo().getNome()%>: <strong><%=u.getNome()%></strong>
									<input type="button" name="sair" value=" Sair " class="btn" onclick="if(confirm('Tem certeza de que deseja sair?')) { window.location.href='<%=Config.getPageURL()%>Autenticar.jsp'; } else { }" />&nbsp;&nbsp;
								<%	} if (u.getTipo().getTela9()!=1) { %>
								<script type="text/javascript">window.location.href="<%=Config.getPageURL()%>AcessoNaoAutorizado.jsp";</script>
								<% } %>
							</td>
						</tr>                                                 
					</table>
				</div>
				<div id="menu">
					<div id="spc">&nbsp;</div>
					<% if (u.getTipo().getTela1() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterTiposDeAcesso.jsp">&nbsp;N&iacute;veis de acesso</a></div>
					<% } %>
					<% if (u.getTipo().getTela4() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterSeveridades.jsp">&nbsp;Severidades</a></div>
					<% } %>
					<% if (u.getTipo().getTela5() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterStatus.jsp">&nbsp;Status</a></div>
					<% } %>
					<% if (u.getTipo().getTela3() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterCategorias.jsp">&nbsp;Categorias</a></div>
					<% } %>
					<% if (u.getTipo().getTela2() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterUsuarios.jsp">&nbsp;Usuários</a></div>
					<% } %>
					<% if (u.getTipo().getTela6() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>NovoChamado.jsp">&nbsp;Abrir chamado</a></div>
					<% } %>
					<% if (u.getTipo().getTela7() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>FilaDeChamados.jsp">&nbsp;Fila de chamados</a></div>
					<% } %>
					<% if (u.getTipo().getTela7() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>BaseDeSolucoes.jsp">&nbsp;Base de soluções</a></div>
					<% } %>
					<% if (u.getTipo().getTela9() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>RelatorioGeral.jsp">&nbsp;Relatório Geral</a></div>
					<% } %>
					<div id="mn_fim">&nbsp;</div>
					<div style="padding-bottom:220px;">&nbsp;</div>
				</div>
				
				<div id="content">
					<br /><p class="title">Relatório de chamados</p><br />
					<table border="0" class="tbl" cellpadding="2" width="96%" align="center">
						<tr><td style="font-size:3px" colspan="8">&nbsp;</td></tr>
						<tr style="background-color:#C7CA99;" align="center" valign="center">
							<td><strong>Ticket</strong></td>
							<td><strong>Sev</strong></td>
							<td><strong>Coment&aacute;rio</strong></td>
							<td><strong>Cliente</strong></td>
							<td><strong>Contato</strong></td>
							<td><strong>Respons&aacute;vel</strong></td>
							<td><strong>Status</strong></td>
							<td><strong>Visualizar</strong></td>
						</tr>
						<% List vetorTicket = new ArrayList();
						   vetorTicket = (List)request.getAttribute("vetorTicket");
						   if (vetorTicket == null) {
							Ticket ticket = new Ticket();
							Report rep;
							String status;
							vetorTicket = ticket.listarTodos();
							for (int i=0; i < vetorTicket.size(); i++) {
								rep = new Report();
								List vetorReport = new ArrayList();
								vetorReport = (List) rep.localizarPorTicket(((Ticket)vetorTicket.get(i)).getId());
								if (vetorReport == null || vetorReport.size() <= 0) {
									status = "Não atendido";
								}
								else {
									rep = (Report) vetorReport.get(vetorReport.size() - 1);
									status = rep.getStatus().getNome();
								}
							%>							
							<tr style="background-color:#F5F5F5;" align="center" valign="center">
								<form name="verTicket" action="<%=Config.getServletURL()%>ManterTickets" method="post" />
								<input type="hidden" name="ticket" value="<%=((Ticket)vetorTicket.get(i)).getId()%>" />
								<input type="hidden" name="action" value="exibir" />
								<td><%=((Ticket)vetorTicket.get(i)).getId() %></td>
								<td><%=((Ticket)vetorTicket.get(i)).getSeveridade().getNome() %></td>
								<td><%=((Ticket)vetorTicket.get(i)).getDescricao() %></td>
								<td><%=((Ticket)vetorTicket.get(i)).getCliente().getNome() %></td>
								<td><% if (((Ticket)vetorTicket.get(i)).getCliente().getContato()!=null) { %><%=((Ticket)vetorTicket.get(i)).getCliente().getContato() %><% } else { %>-<% } %></td>
								<td><%=((Ticket)vetorTicket.get(i)).getResponsavel().getNome() %></td>
								<td><%=status %></td>
								<td><a href="#"><input type="image" name="action" value="exibir" src="<%=Config.getImagesURL()%>view.gif" border="0" title="Exibir" /></a></td>
								</form>
							</tr>
							<%}
							}
						  else {
								Report rep;
								String status;
									for (int i=0; i < vetorTicket.size(); i++) {
										rep = new Report();
										List vetorReport = new ArrayList();
										vetorReport = (List) rep.localizarPorTicket(((Ticket)vetorTicket.get(i)).getId());
										if (vetorReport == null || vetorReport.size() <= 0) {
											status = "Não atendido";
										}
										else {
											rep = (Report) vetorReport.get(vetorReport.size() - 1);
											status = rep.getStatus().getNome();
										}
									%>	
										<tr style="background-color:#F5F5F5;" align="center" valign="center">
										<form name="verTicket" action="<%=Config.getServletURL()%>ManterTickets" method="post" />
										<input type="hidden" name="ticket" value="<%=((Ticket)vetorTicket.get(i)).getId()%>" />
										<input type="hidden" name="action" value="exibir" />
											<td><%=((Ticket)vetorTicket.get(i)).getId() %></td>
											<td><%=((Ticket)vetorTicket.get(i)).getSeveridade().getNome() %></td>
											<td><%=((Ticket)vetorTicket.get(i)).getDescricao() %></td>
											<td><%=((Ticket)vetorTicket.get(i)).getCliente().getNome() %></td>
											<td><% if (((Ticket)vetorTicket.get(i)).getCliente().getContato()!=null) { %><%=((Ticket)vetorTicket.get(i)).getCliente().getContato() %><% } else { %>-<% } %></td>
											<td><%=((Ticket)vetorTicket.get(i)).getResponsavel().getNome() %></td>
											<td><%=status %></td>
											<td><a href="#"><input type="image" name="action" value="exibir" src="<%=Config.getImagesURL()%>view.gif" border="0" title="Exibir" /></a></td>
										</tr>
									<%
									}
							}%>
						<tr><td colspan="7">&nbsp;</td></tr>
						<tr><td colspan="7" align="right"><input type="button" name="imprimir" value="Imprimir" onclick="print()" class="btn" /> <a href="<%=Config.getPageURL()%>RelatorioGeral.jsp"><input type="button" value="Gerar outro relatório" class="btn" /></a></td></tr>
					</table>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>