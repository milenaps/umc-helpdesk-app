<!-- Gera��o de relat�rios -->
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
		<title>Xtreme Service Request - Relat&oacute;rio XSR</title>

		<%@ include file="styles.css" %>
		<script type="text/javascript">
			function mudarBotao() {
				if (document.gerarRelatorio.pl_chave.value == "") {
					document.gerarRelatorio.btn_gerar.value="Gerar Relat�rio Completo";
				}
				else {
					document.gerarRelatorio.btn_gerar.value="Gerar Relat�rio Espec�fico";
				}
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
					<div id="menu_"><a href="<%=Config.getPageURL()%>ManterUsuarios.jsp">&nbsp;Usu�rios</a></div>
					<% } %>
					<% if (u.getTipo().getTela6() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>NovoChamado.jsp">&nbsp;Abrir chamado</a></div>
					<% } %>
					<% if (u.getTipo().getTela7() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>FilaDeChamados.jsp">&nbsp;Fila de chamados</a></div>
					<% } %>
					<% if (u.getTipo().getTela7() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>BaseDeSolucoes.jsp">&nbsp;Base de solu��es</a></div>
					<% } %>
					<% if (u.getTipo().getTela9() == 1) { %>
					<div id="menu_"><a href="<%=Config.getPageURL()%>RelatorioGeral.jsp">&nbsp;Relat�rio Geral</a></div>
					<% } %>
					<div id="mn_fim">&nbsp;</div>
					<div style="padding-bottom:220px;">&nbsp;</div>
				</div>
				
				<div id="content">
					<br /><p class="title">Relat&oacute;rios</p><br />
					<table border="0">
						<form name="gerarRelatorio" method="post" action="<%=Config.getServletURL() %>ManterTickets">
							<input type="hidden" name="action" value="relatorio" />
							<tr>
								<td width="50">&nbsp;</td>
								<td>
									<table border="0" class="tbl" cellpadding="1">
										<tr>
											<td colspan="2"><strong>Palavras-chave&nbsp;</strong>
												<input type="text" name="pl_chave" value="" class="fld" size="50" onchange="mudarBotao()" />&nbsp;
												<input type="submit" name="btn_gerar" value="Gerar Relat�rio Completo" class="btn" />
											</td>
										</tr>
										<tr>
											<td colspan="3">
												<p><img src="<%=Config.getImagesURL()%>mark.gif" />&nbsp;Para gerar um relat�rio completo, clique no bot�o <b>Gerar Relat�rio Completo</b>.</p>
												<p><img src="<%=Config.getImagesURL()%>mark.gif" />&nbsp;Para relat�rios espec�ficos, digite palavras-chave identificando status, categoria, severidade, cliente, respons�vel<br />&nbsp;&nbsp;&nbsp;&nbsp;ou descri��o do(s) chamado(s), e em seguida clique no bot�o <b>Gerar Relat�rio Espec�fico</b>.</p>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</form>
					</table>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>