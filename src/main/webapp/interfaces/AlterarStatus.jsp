<!-- Alterar Status -->
<%@ page import="com.xsr.negocio.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is a page from the Xtreme Service Request system." />
		<meta name="Abstract" content="This is a page from the Xtreme Service Request system." />
		<title>Xtreme Service Request - Categorias</title>
		
		<%
			Status s = new Status();
			s.setId(Integer.parseInt(request.getParameter("id")));
			s.findStatus();
			
			Usuario u = (Usuario) session.getAttribute("login");
		   	if (u.getTipo().getTela5()!=1) { %>
		<script type="text/javascript">window.close();window.location.href="<%=Config.getPageURL()%>AcessoNaoAutorizado.jsp";</script>
		<% } %>
		<script type="text/javascript">
			function validar() {
				if (document.form_alterar.nome.value=="") {
					alert('Digite o nome do status');
					return false;
				} else { return true; }
			}
	
			function chamarAlterar() {
				document.form_alterar.action="<%=Config.getServletURL()%>ManterStatus?id=<%=s.getId()%>";
				document.form_alterar.submit();
				window.opener.location.reload();
				window.close();
			}
		</script>
		<%@ include file="styles.css" %>
	</head>
	<body style="background-color:#FFFFFF">
         <div align="center">
			<p style="font-family:Verdana;font-size:12px;"><b>Alterar Status</b></p>
			<table border="0" class="tbl" cellpadding="2">
				<form name="form_alterar" method="post" action="<%=Config.getPageURL()%>ManterStatus.jsp">
					<input type="hidden" name="action" value="alterar" />					
					<tr align="center">
						<td colspan="2"><input type="text" name="nome" class="fld" value="<%=s.getNome()%>" size="30" /></td>
					</tr>
					<tr><td colspan="10" align="center"><table border="0" class="btn"><tr>
						<td align="right"><input type="button" name="acao" value="Salvar" class="btn" onclick="if (validar()) {chamarAlterar()}" /></td>
						<td align="left"><input type="button" name="cancelar" value="Cancelar" class="btn" onclick="window.close();" /></td>
					</table></td></tr>
				</form>
			</table>
		</div>
	</body>
</html>