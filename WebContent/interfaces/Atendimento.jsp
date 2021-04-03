<!-- Tela de atendimento de chamado -->
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
		<title>Xtreme Service Request - Atendimento de chamado</title>

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
					<%
						Ticket ticket = new Ticket();
						ticket = (Ticket) request.getAttribute("ticket");
						
						Report r = new Report();
						Vector vetRep = r.localizarPorTicket(ticket.getId());
						
						if (ticket != null) {
					%>
					<br /><p class="title">Tela de Atendimento<br /><br />
					<span class="emphasis"><strong>Ticket&nbsp;<span style="color:#FF0000;"><%=ticket.getId()%> <%
					String reaberto = "não";
					reaberto = (String) request.getAttribute("reaberto");
					if (reaberto != null) {
						if (reaberto.equalsIgnoreCase("sim")) {
						%> (Reaberto)
					<%}}%>
					</span></strong></span></p>
					<form action="<%=Config.getServletURL()%>ManterTickets" method="post" name="chamado">
						<input type="hidden" name="ticket" value="<%=ticket.getId()%>">
						<% if (u != null) { %>
						<input type="hidden" name="usuarioLogado" value="<%=u.getId()%>"/>
						<% } else { %>
						<input type="hidden" name="usuarioLogado" value=""/>
						<% } %>					
						<table class="tbl" border="0" cellpadding="0" cellspacing="5" align="center" width="90%">
						<tr><td colspan="4"><strong><span style="font-size:10px;">Data de abertura</span></strong>&nbsp;&nbsp;&nbsp;<input name="dt_abertura" type="text" class="fld" value="<%=ticket.getDataAbertura()%>" name="date" size="10" disabled= "disabled" /><br /></td></tr>
						<tr><td colspan="4"><strong><span style="font-size:10px;">Respons&aacute;vel</span></strong> &nbsp;<input name="responsavel" class="fld" type="text" value="<%Usuario usuario = new Usuario(); usuario = (Usuario) request.getAttribute("responsavel"); if (usuario != null) {%><%=usuario.getNome()%><%} else {%>Não Alocado<%}%>" disabled= "disabled" /></td></tr>
						<tr align="left">
							<td><strong><span style="font-size:10px;">Cliente</span></strong><br /><input name="cliente" type="text" class="fld" value="<%=ticket.getCliente().getNome() %>" size="37" disabled= "disabled" /></td>
							<td><strong><span style="font-size:10px;">Contato</span></strong><br /><input name="contato" type="text" class="fld" value="<%if (ticket.getCliente().getContato()!=null) { %><%=ticket.getCliente().getContato()%><% } else { %>-<% } %>" size="25" disabled= "disabled" /></td>
							<td><strong><span style="font-size:10px;">Telefone</span></strong><br /><input name="cli_tel"  type="text" class="fld" value="
							<%if (ticket.getCliente().getTelefone().getTipo() != null) { %>(0XX<%=ticket.getCliente().getTelefone().getDdd() %>)-<%=ticket.getCliente().getTelefone().getNum()%><% } else { %>Não informado	<%} %>" size="17" disabled /></td>
							<td rowspan="6" valign="top" width="200px" style="padding-left:3px;"><strong><span style="font-size:10px;">Hist&oacute;rico</span></strong><table class="tbl" style="border-style:solid;border-width:thin;border-color:#B0B0B0;" height="159" width="100%" align="left"><tr><td valign="top">
								<%
									for (int i = 0; i < vetRep.size(); i++) {
									%><%=((Report)vetRep.elementAt(i)).getDataHora()%> - <%=((Report)vetRep.elementAt(i)).getStatus().getNome()%>
									<br />
								<%} %>
							</td></tr></table></td>
						</tr>
						<tr><td colspan="3"><strong><span style="font-size:10px;">T&iacute;tulo<br /><input class="fld" type="text" value="<%=ticket.getTitulo() %>" name="titulo" size="88" /></span></strong></td></tr>
						<tr><td colspan="3"><strong><span style="font-size:10px;">Descri&ccedil;&atilde;o resumida<br /><textarea class="fld" cols="86" name="descricao"><%=ticket.getDescricao() %></textarea></span></strong></td></tr>
						<tr><td colspan="3">
						<span style="font-size:10px;">
							<%  Severidade sev = new Severidade();
								Vector vetorSev = new Vector();
								vetorSev = sev.listarTodos();
							%>	
							<strong>Severidade</strong>&nbsp;<select class="fld" name="severidade">
								<%for (int i=0;i < vetorSev.size(); i++) { %>
									<option value="<%=(((Severidade)vetorSev.get(i))).getId()%>"
									<%if ((((Severidade)vetorSev.get(i))).getId() == ticket.getSeveridade().getId()) {%> selected="yes" <%} %>><%=(((Severidade)vetorSev.get(i))).getNome()%></option>
								<%}%></select>&nbsp;&nbsp;
							<strong>Categoria</strong>&nbsp;&nbsp;<input class="fld" type="text" size="26" value="<%=ticket.getCategoria().getNome()%>" name="category" disabled= "disabled" />
							</span>
						</td></tr>
						<tr>
							<td colspan="4">
								<strong><span style="font-size:10px;"><br />Registros de atendimento</span></strong>
								<table class="tbl" border="0" cellpadding="0" cellspacing="0" align="left" style="border-style:solid;border-width:thin;border-color:#B0B0B0;" width="100%">
									<tr valign="top">
										<td>
											<table class="tbl" border="0" width="100%" cellpadding="0" cellspacing="0">
												<%	for (int i=0;i<vetRep.size();i++) { %>
													<tr><td><span class="small"><%=((Report)vetRep.elementAt(i)).getDataHora() %> - <%=((Report)vetRep.elementAt(i)).getResponsavel().getTipo().getNome() %> <%=((Report)vetRep.elementAt(i)).getResponsavel().getNome() %></span><br /><%=((Report)vetRep.elementAt(i)).getDescricao() %></span></strong>
													<br /><strong><span class="small">Status: <%=((Report)vetRep.elementAt(i)).getStatus().getNome() %></span></strong><br />
													</td></tr>
													<%if (i < vetRep.size() - 1) {
														%><tr><td><span class="small">--------------------------------------------------------------------------------------------------------------------------------------------</span></td></tr>
													<%} %>
												<%} %>
											</table>
										</td>
										<td align="right">
											<%if (usuario != null) {%>
												<a href="<%=Config.getPageURL()%>RegistrarReport.jsp?id=<%=r.getId()+1%>&ticket=<%=ticket.getId()%>" target="_blank" onclick="window.open('<%=Config.getPageURL()%>RegistrarReport.jsp?id=<%=r.getId()+1%>&ticket=<%=ticket.getId()%>','_blank','height=250,width=250,resizable=no,toolbar=no');return false;"><img src="<%=Config.getImagesURL()%>add.gif" border="0" alt="Adicionar report" vspace="4" hspace="4" /></a>
											<%}%>
										</td>
									</tr>
								</table><br />
							</td>
						</tr>
						<tr><td colspan="4">
							<%if (ticket.getStatus().equalsIgnoreCase("Aberto")) { %>
							<input name="action" type="submit" class="btn" value="Alocar" />&nbsp;
							<input name="action" type="submit" class="btn" value="Alterar" />&nbsp;
							<input name="action" type="submit" class="btn" value="Clonar" />
							<input name="action" type="submit" class="btn" value="Fechar" />
							<%} else if (ticket.getStatus().equalsIgnoreCase("Pendente")) { %>
							<input name="action" type="submit" class="btn" value="Reabrir Chamado" />&nbsp;
							<input name="action" type="submit" class="btn" value="Concluir Chamado" />
							<%}}%>
						</td></tr>
					</table>
					</form>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>