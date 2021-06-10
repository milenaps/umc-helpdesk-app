<!-- Fila de chamados -->
<%@ page import="java.util.*"%>
<%@ page import="com.xsr.negocio.*"%>
<%@ page import="com.xsr.controle.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="doc, documentation, xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is the documentation of Xtreme Service Request system." />
		<meta name="Abstract" content="This is the documentation of Xtreme Service Request system." />
		<title>Xtreme Service Request - Fila de chamados</title>
		
		<%@ include file="styles.css"%>
		<script type="text/javascript">
			function validarEnvio() {
				if (document.pesquisa.caixaPesquisa.value == "" && document.pesquisa.responsavel.value == "") {
					alert("Digitar um termo de pesquisa ou selecione um responsável");
					return false;
				} else { return true; }
			}
		</script>
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
								<%	} if (u.getTipo().getTela7()!=1) { %>
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
					<br /><p class="title">Fila de chamados</p><br />
					<table border="0" class="tbl" cellpadding="2" width="96%" align="center">
						<form name="pesquisa" method=post action="<%=Config.getServletURL()%>ManterTickets" onsubmit="return(validarEnvio())">
							<tr>
								<td style="font-size:10px;" rowspan="2"><strong>Pesquisar por:</strong></td>
								<td style="font-size:9px;" colspan="2">Palavras-chave</td>
								<td style="font-size:9px;">Respons&aacute;vel</td>
								<td rowspan="2" valign="bottom" align="right"><input value="Pesquisar" type="submit" name="" class="btn" /></td>
							</tr>
							<tr>
								<input type="hidden" name="action" value="pesquisar" />
								<td colspan="2"><input type="text" class="fld" value="" size="60" name="caixaPesquisa" /></td>
								<td>
									<select name="responsavel" class="fld">
										<option value="">Todos</option>
										 <%	Usuario usu = new Usuario();
									  		Vector vetorUsuario = new Vector();
									  		vetorUsuario = usu.listarTodos();
									  		for (int i = 0; i < vetorUsuario.size(); i++) {
									  			if (((Usuario)vetorUsuario.elementAt(i)).getTipo().getNome().equalsIgnoreCase("Analista")) {
										%>
										<option value="<%=(((Usuario)vetorUsuario.elementAt(i))).getNome()%>"> <%=(((Usuario)vetorUsuario.elementAt(i))).getNome()%></option>
										<%}} %>
									</select>
								</td>
								<td align="right" colspan="3">
									<a href="<%=Config.getPageURL()%>BaseDeSolucoes.jsp">
										<input type="button" name="pendentes" value="Mostrar soluções" class="btn" />
									</a>
								</td>
							</tr>
						</form>
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
						<%
							Vector vetorTicket = new Vector();
						  	vetorTicket = (Vector)request.getAttribute("vetorTicket");
						  	if (vetorTicket == null) {
								Ticket ticket1 = new Ticket();
								Report report1;
								String status;
								vetorTicket = ticket1.listarTodos();
							
								for (int i=0; i < vetorTicket.size(); i++) { %>
							<% if (((Ticket)vetorTicket.elementAt(i)).getStatus().equalsIgnoreCase("Aberto")) {
								report1 = new Report();
								Vector vetorReport = new Vector();
								vetorReport = (Vector) report1.localizarPorTicket(((Ticket)vetorTicket.elementAt(i)).getId());
								if (vetorReport == null || vetorReport.size() <= 0) {
									status = "Não atendido";
								}
								else {
									report1 = (Report) vetorReport.elementAt(vetorReport.size() - 1);
									status = report1.getStatus().getNome();
								}
							%>						
							<tr style="background-color:#F5F5F5;" align="center" valign="center">
								<form name="verTicket" action="<%=Config.getServletURL()%>ManterTickets" method="post" />
									<input type="hidden" name="id" value="<%=((Ticket)vetorTicket.elementAt(i)).getId()%>" />
									<input type="hidden" name="action" value="exibir" />
									<td><%=((Ticket)vetorTicket.elementAt(i)).getId() %></td>
									<td><%=((Ticket)vetorTicket.elementAt(i)).getSeveridade().getNome() %></td>
									<td><%=((Ticket)vetorTicket.elementAt(i)).getDescricao() %></td>
									<td><%=((Ticket)vetorTicket.elementAt(i)).getCliente().getNome() %></td>
									<td><% if (((Ticket)vetorTicket.elementAt(i)).getCliente().getContato()!=null) { %><%=((Ticket)vetorTicket.elementAt(i)).getCliente().getContato() %><% } else { %>-<% } %></td>
									<td><%=((Ticket)vetorTicket.elementAt(i)).getResponsavel().getNome() %></td>
									<td><%=status %></td>
									<td><a href="#"><input type="image" src="<%=Config.getImagesURL()%>view.gif" border="0" /></a></td>
								</form>
							</tr>
							<%}
							}
						  }
						  else {
								for (int i=0; i < vetorTicket.size(); i++) {
									if (((Ticket)vetorTicket.elementAt(i)).getStatus().equalsIgnoreCase("Aberto")) {  %>						
										<tr style="background-color:#F5F5F5;" align="center" valign="center">
										<form name="verTicket" action="<%=Config.getServletURL()%>ManterTickets" method="post" />
											<input type="hidden" name="id" value="<%=((Ticket)vetorTicket.elementAt(i)).getId()%>" />
											<input type="hidden" name="action" value="exibir" />
											<td><%=((Ticket)vetorTicket.elementAt(i)).getId() %></td>
											<td><%=((Ticket)vetorTicket.elementAt(i)).getSeveridade().getNome() %></td>
											<td><%=((Ticket)vetorTicket.elementAt(i)).getDescricao() %></td>
											<td><%=((Ticket)vetorTicket.elementAt(i)).getCliente().getNome() %></td>
											<td><% if (((Ticket)vetorTicket.elementAt(i)).getCliente().getContato()!=null) { %><%=((Ticket)vetorTicket.elementAt(i)).getCliente().getContato() %><% } else { %>-<% } %></td>
											<td><%=((Ticket)vetorTicket.elementAt(i)).getResponsavel().getNome() %></td>
											<td><%=((Ticket)vetorTicket.elementAt(i)).getStatus() %></td>
											<td><a href="#"><input type="image" src="<%=Config.getImagesURL()%>view.gif" border="0" /></a></td>
										</form>
										</tr>
									<%
									}
							}
						}%>
					</table>
					<br />
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>