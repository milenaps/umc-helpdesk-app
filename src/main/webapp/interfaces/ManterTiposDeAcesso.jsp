<!-- Tipos de acesso -->
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
		<title>Xtreme Service Request - N&iacute;veis de acesso</title>
		
		<%@ include file="styles.css" %>
		
		<script type="text/javascript">
			function validar() {
				doc = document.form_adicionar;
				if (doc.nome.value == "") {
					alert('Você não digitou um nome válido para o nível de acesso');
					return false;
				} else if ((doc.tela1.checked)||(doc.tela2.checked)||(doc.tela3.checked)||(doc.tela4.checked)||(doc.tela5.checked)||(doc.tela6.checked)||(doc.tela7.checked)||(doc.tela8.checked)||(doc.tela9.checked)) {
						return true;
					} else {
						alert('Ao menos uma tela deve ser selecionada');
						return false;
					}
			}
		</script>
	</head>

	<body>
         <div align="center">
			<div id="escope">
				<div id="header">&nbsp;</div>
				<div id="mn">
					<table border="0" cellpadding="1" cellspacing="1" class="tbl" width="99%" style="padding:0;">
						<tr>
							<td align="right">
								<%
									Usuario u = (Usuario) session.getAttribute("login");
									if (u != null) { %>
									<%=u.getTipo().getNome()%>: <strong><%=u.getNome()%></strong>
									<input type="button" name="sair" value=" Sair " class="btn" onclick="if(confirm('Tem certeza de que deseja sair?')) { window.location.href='<%=Config.getPageURL()%>Autenticar.jsp'; } else { }" />&nbsp;&nbsp;
								<%	} if (u.getTipo().getTela1()!=1) { %>
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
					<br /><p class="title">N&iacute;veis de acesso</p><br />
					<table border="0" class="tbl" width="65%" cellpadding="2" align="center">
						<%
							TipoDeAcesso ta = new TipoDeAcesso();
							List vetTipo = ta.listarTodos();
							int rep = 0;
							
							for(int i=1;i<vetTipo.size();i++) {
							
								if (rep == 0) {
						%>
						<tr style="background-color:#C7CA99;" align="center">
							<td width="50"><strong>ID</strong></td>
							<td width="90"><strong>Tipo</strong></td>
							<td><strong>1</strong></td><td><strong>2</strong></td><td><strong>3</strong></td>
							<td><strong>4</strong></td><td><strong>5</strong></td><td><strong>6</strong></td>
							<td><strong>7</strong></td><td><strong>8</strong></td><td><strong>9</strong></td>
							<td width="50"><strong>Alterar</strong></td>
							<td width="30"><strong>Excluir</strong></td>
						</tr>
						<% } rep=1; ta = (TipoDeAcesso)vetTipo.get(i); %>						
						<tr style="background-color:#F5F5F5;" align="center">
							<td><strong><%=ta.getId()%></strong></td>
							<td align="left"><%=ta.getNome()%></td>
							<td><input type="checkbox" name="tela1" value="<%=ta.getTela1()%>" disabled <%if (ta.getTela1() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="tela2" value="<%=ta.getTela2()%>" disabled <%if (ta.getTela2() == 1) {%>checked<%}%> /></td>
							<td><input type="checkbox" name="tela3" value="<%=ta.getTela3()%>" disabled <%if (ta.getTela3() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="tela4" value="<%=ta.getTela4()%>" disabled <%if (ta.getTela4() == 1) {%>checked<%}%> /></td>
							<td><input type="checkbox" name="tela5" value="<%=ta.getTela5()%>" disabled <%if (ta.getTela5() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="tela6" value="<%=ta.getTela6()%>" disabled <%if (ta.getTela6() == 1) {%>checked<%}%> /></td>
							<td><input type="checkbox" name="tela7" value="<%=ta.getTela7()%>" disabled <%if (ta.getTela7() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="tela8" value="<%=ta.getTela8()%>" disabled <%if (ta.getTela8() == 1) {%>checked<%}%> /></td>
							<td><input type="checkbox" name="tela9" value="<%=ta.getTela9()%>" disabled <%if (ta.getTela9() == 1) {%>checked<%}%> /></td>
							<td>
								<a href="<%=Config.getPageURL()%>AlterarTipoDeAcesso.jsp?id=<%=ta.getId()%>" target="_blank" onclick="window.open('<%=Config.getPageURL()%>AlterarTipoDeAcesso.jsp?id=<%=ta.getId()%>','_blank','height=150,width=400,resizable=no,toolbar=no'); return false;">
									<input type="image" src="<%=Config.getImagesURL()%>alt.gif" border="0" />
								</a>
							</td>
							<td>
								<form name="form_excluir" method="post" action="<%=Config.getServletURL()%>ManterTiposDeAcesso?id=<%=ta.getId()%>">
									<input type="hidden" name="id" value="<%=ta.getId()%>" />
									<input type="hidden" name="nome" value="<%=ta.getNome()%>" />
									<input type="hidden" name="tela1" value="<%=ta.getTela1()%>" />
									<input type="hidden" name="tela2" value="<%=ta.getTela2()%>" />
									<input type="hidden" name="tela3" value="<%=ta.getTela3()%>" />
									<input type="hidden" name="tela4" value="<%=ta.getTela4()%>" />
									<input type="hidden" name="tela5" value="<%=ta.getTela5()%>" />
									<input type="hidden" name="tela6" value="<%=ta.getTela6()%>" />
									<input type="hidden" name="tela7" value="<%=ta.getTela7()%>" />
									<input type="hidden" name="tela8" value="<%=ta.getTela8()%>" />
									<input type="hidden" name="tela9" value="<%=ta.getTela9()%>" />
									<input type="hidden" name="action" value="Excluir" />
									<input type="image" src="<%=Config.getImagesURL()%>trash.gif" border="0" />
								</form>
							</td>
						</tr>
						<% } %>
						<tr><td colspan="14">&nbsp;</td></tr>
						<tr align="center">
							<form name="form_adicionar" method="post" action="<%=Config.getServletURL()%>ManterTiposDeAcesso?id=<%=ta.getId()+1%>" onsubmit="return(validar())">
								<td><strong>&nbsp;</strong></td>
								<td align="left"><input type="text" size="40" name="nome" value="" class="fld" /></td>
								<td><input type="checkbox" name="tela1" value="" /></td><td><input type="checkbox" name="tela2" value="" /></td>
								<td><input type="checkbox" name="tela3" value="" /></td><td><input type="checkbox" name="tela4" value="" /></td>
								<td><input type="checkbox" name="tela5" value="" /></td><td><input type="checkbox" name="tela6" value="" /></td>
								<td><input type="checkbox" name="tela7" value="" /></td><td><input type="checkbox" name="tela8" value="" /></td>
								<td><input type="checkbox" name="tela9" value="" /></td>
								<td><input type="submit" name="action" value="Adicionar" class="btn" /></td>
							</form>
						</tr>
						<tr>
							<td align="left" colspan="14">
								<p class="normal">
									1- Gerenciar n&iacute;veis de acesso<br />
									2- Gerenciar usu&aacute;rios<br />
									3- Gerenciar categorias<br />
									4- Gerenciar severidades<br />
									5- Gerenciar status<br />
									6- Abrir chamados<br />
									7- Atender chamados<br />
									8- Consultar base de conhecimentos<br />
									9- Gerar relat&oacute;rios de chamados
								</p>
							</td>
						</tr>
					</table>
					<br />
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>