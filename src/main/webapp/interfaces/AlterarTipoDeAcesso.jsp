<!-- Alterar Tipo de Acesso -->
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

		<% 	Usuario u = (Usuario) session.getAttribute("login");
			if (u.getTipo().getTela1()!=1) { %>
				<script type="text/javascript">window.close();window.location.href="<%=Config.getPageURL()%>AcessoNaoAutorizado.jsp";</script>
			<% } %>
		
		<script type="text/javascript">
			function validar() {
				doc = document.form_alterar;
				if (doc.nome.value == "") {
					alert('Você não digitou um nome válido para o nível de acesso');
					return false;
				} else if ((doc.cktela1.checked)||(doc.cktela2.checked)||(doc.cktela3.checked)||(doc.cktela4.checked)||(doc.cktela5.checked)||(doc.cktela6.checked)||(doc.cktela7.checked)||(doc.cktela8.checked)||(doc.cktela9.checked)) {
						return true;
					} else {
						alert('Ao menos uma tela deve ser selecionada');
						return false;
					}
			}

			function chamarAlterar() {
				document.form_alterar.action="<%=Config.getServletURL()%>ManterTiposDeAcesso";
				document.form_alterar.submit();
				window.opener.location.reload();
				window.close();
			}
		</script>
		<%@ include file="styles.css" %>
	</head>
	<body style="background-color:#FFFFFF">
	<div align="center">
			<p style="font-family:Verdana;font-size:12px;"><b>Alterar Tipo de Acesso</b></p>
			<table border="0" class="tbl" cellpadding="2">
				<%
					TipoDeAcesso ta = new TipoDeAcesso();
					ta.setId(Integer.parseInt(request.getParameter("id")));
					ta.findTipo();
				%>
				<form name="form_alterar" method="post" action="<%=Config.getPageURL()%>AlterarTipoDeAcesso">
					<tr style="background-color:#C7CA99;" align="center">
						<td width="120"><strong>Tipo</strong></td>
						<td><strong>1</strong></td><td><strong>2</strong></td><td><strong>3</strong></td>
						<td><strong>4</strong></td><td><strong>5</strong></td><td><strong>6</strong></td>
						<td><strong>7</strong></td><td><strong>8</strong></td><td><strong>9</strong></td>
					</tr>
					<tr style="background-color:#F5F5F5;" align="center">
						<td align="left"><input type="text" name="nome" value="<%=ta.getNome()%>" /></td>
						<td><input type="checkbox" name="cktela1" value="" <%if (ta.getTela1() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="cktela2" value="" <%if (ta.getTela2() == 1) {%>checked<%}%> /></td>
						<td><input type="checkbox" name="cktela3" value="" <%if (ta.getTela3() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="cktela4" value="" <%if (ta.getTela4() == 1) {%>checked<%}%> /></td>
						<td><input type="checkbox" name="cktela5" value="" <%if (ta.getTela5() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="cktela6" value="" <%if (ta.getTela6() == 1) {%>checked<%}%> /></td>
						<td><input type="checkbox" name="cktela7" value="" <%if (ta.getTela7() == 1) {%>checked<%}%> /></td><td><input type="checkbox" name="cktela8" value="" <%if (ta.getTela8() == 1) {%>checked<%}%> /></td>
						<td><input type="checkbox" name="cktela9" value="" <%if (ta.getTela9() == 1) {%>checked<%}%> /></td>
					</tr>
					<input type="hidden" name="id" value="<%=ta.getId()%>" />
					<script type="text/javascript">
						doc = document.form_alterar;
						if (doc.cktela1.checked) {
							doc.tela1.value=1;
						}
						if (doc.cktela2.checked) {
							doc.tela2.value="";
						}
						if (doc.cktela3.checked) {
							doc.tela3.value="";
						}
						if (doc.cktela4.checked) {
							doc.tela4.value="";
						}
						if (doc.cktela5.checked) {
							doc.tela5.value="";
						}
						if (doc.cktela6.checked) {
							doc.tela6.value="";
						}
						if (doc.cktela7.checked) {
							doc.tela7.value="";
						}
						if (doc.cktela8.checked) {
							doc.tela8.value="";
						}
						if (doc.cktela9.checked) {
							doc.tela9.value="";
						}
					</script>
					<input type="hidden" name="tela1" />
					<input type="hidden" name="tela2" />
					<input type="hidden" name="tela3" />
					<input type="hidden" name="tela4" />
					<input type="hidden" name="tela5" />
					<input type="hidden" name="tela6" />
					<input type="hidden" name="tela7" />
					<input type="hidden" name="tela8" />
					<input type="hidden" name="tela9" />
					<input type="hidden" name="action" value="Alterar" />
					<tr><td colspan="10" align="center"><table border="0" class="btn"><tr>
						<td align="right"><input type="button" value="Salvar" class="btn" onclick="if (validar()) {chamarAlterar()}" /></td>
						<td align="left"><input type="button" value="Cancelar" class="btn" onclick="window.close();" /></td>
					</tr></table></td></tr>
				</form>
			</table>
		</div>
	</body>
</html>