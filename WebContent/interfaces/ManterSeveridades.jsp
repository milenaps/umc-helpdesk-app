<!-- Manter Severidades -->
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
		<title>Xtreme Service Request - Severidades</title>
		
		<%@ include file="styles.css" %>
		
		<script type="text/javascript">
			function validar() {
				if (document.form_adicionar.nome.value.length <1 && document.form_adicionar.tempo.value.length <1) {
					alert("Para adicionar, digite um nome e tempo para atendimento à severidade");
					return false;
				} else if (document.form_adicionar.nome.value.length <1) {
					alert("Digite um nome para a nova severidade");
					return false;
				} else  if (document.form_adicionar.tempo.value.length <1) {
					alert("Digite o tempo para atendimento à nova severidade");
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
								<%	} if (u.getTipo().getTela4()!=1) { %>
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
					<br /><p class="title">Severidades</p><br />
					<table border="0" class="tbl" width="65%" cellpadding="2" align="center">
						<%
							Severidade s = new Severidade();
							Vector vet = s.listarTodos();
							int rep = 0;
							
							for(int i=0; i<vet.size();i++)
							{ if (rep == 0) {
						%>
						<tr style="background-color:#C7CA99;" align="center">
							<td width="15"><strong>ID</strong></td>
							<td><strong>Prioridade</strong></td>
							<td width="90"><strong>Tempo para<br />atender (horas)</strong></td>
							<td width="25"><strong>Alterar</strong></td>
							<td width="20"><strong>Excluir</strong></td>
						</tr>
						<% } rep=1; s = (Severidade)vet.elementAt(i); %>
						<tr style="background-color:#F5F5F5;" align="center">
							<td><strong><%=s.getId()%></strong></td>
							<td align="left"><%=s.getNome()%></td>
							<td align="center"><%=s.getTempo()%></td>
							<td>
								<a href="<%=Config.getPageURL()%>AlterarSeveridade.jsp?id=<%=s.getId()%>" target="_blank" onclick="window.open('<%=Config.getPageURL()%>AlterarSeveridade.jsp?id=<%=s.getId()%>','_blank','height=100,width=300,resizable=no,toolbar=no');return false;">
								<input type="image" src="<%=Config.getImagesURL()%>alt.gif" border="0" /></a>
							</td>
							<td>
								<form name="form_excluir" method="post" action="<%=Config.getServletURL()%>ManterSeveridades?id=<%=s.getId()%>">
									<input type="hidden" name="id" value="<%=s.getId()%>" />
									<input type="hidden" name="nome" value="<%=s.getNome()%>" />
									<input type="hidden" name="tempo" value="<%=s.getTempo()%>" />
									<input type="hidden" name="action" value="excluir" />
									<input type="image" src="<%=Config.getImagesURL()%>trash.gif" border="0" />
								</form>
							</td>
						</tr>
						<%}%>
					</table>
					<br />
					<table border="0" class="tbl" width="25%" cellpadding="2" align="center">
						<tr align="center">
							<form name="form_adicionar" method="post" action="<%=Config.getServletURL()%>ManterSeveridades?id=<%=s.getId()+1%>" onsubmit="return(validar())">
								<input type="hidden" name="action" value="adicionar" />
								<td>&nbsp;</td><td align="left"><input type="text" name="nome" class="fld" value="" size="30" /></td>
								<td> <input type="text" name="tempo" class="fld" value="" size="3" onkeypress="if (!isNaN(String.fromCharCode(window.event.keyCode))) {return true;} else {return false;}"/></td>
								<td><input type="submit" name="Submit" value="Adicionar" class="btn" /></td>
							</form>
						</tr>
					</table>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>