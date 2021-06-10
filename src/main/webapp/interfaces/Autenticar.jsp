<!-- P&aacute;gina principal - Autentica&ccedil;&atilde;o -->
<%@ page import="java.util.*"%>
<%@ page import="com.xsr.controle.*"%>
<%@ page import="com.xsr.config.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="Keywords" content="xtreme service request, umc, pfc, tcc" />
		<meta name="Description" content="This is a page from the Xtreme Service Request system." />
		<meta name="Abstract" content="This is a page from the Xtreme Service Request system." />
		<title>Xtreme Service Request - Autentica&ccedil;&atilde;o</title>
		
		<%@ include file="styles.css" %>
		<script type="text/javascript">
			function validar() {
				if ((document.form_auth.login.value<1)&&(document.form_auth.senha.value<1)) {
					alert('Digite um login de usuário e senha para autenticar');
					return false;
				} else if (document.form_auth.login.value<1) {
					alert('Digite o login de usuário para autenticar');
					return false;
				} else if (document.form_auth.senha.value<1) {
					alert('Digite a senha para autenticar');
					return false;
				} else { return true; }
			}
		</script>
	</head>

	<body>
         <div align="center">
			<div id="escope">
				<div id="header">&nbsp;</div>
				<div width="90%" style="margin-top:120px;margin-bottom:190px;">
					<p class="emphasis">
						<strong>Acesso restrito</strong><br />
						<span class="small">Digite o seu usu&aacute;rio e senha para acessar o sistema</span>
					</p><br />
					<form method="post" name="form_auth" action="<%=Config.getServletURL()%>EfetuarLogin" onsubmit="return(validar())">
						<input type="hidden" name="action" value="validar" />
						<table border="0" cellpadding="1" cellspacing="1" align="center" class="tbl">
							<tr>
								<td>Usu&aacute;rio:</td>
								<td colspan="2"><input type="text" value="" name="login" size="25" class="fld" /></td>
							</tr>
							<tr>
								<td>Senha:</td>
								<td><input type="password" value="" name="senha" size="15" class="fld" /></td>
								<td align="right"><input type="submit" value="Entrar" name="Submit" class="btn" /></td>
							</tr>
						</table>
					</form>
				</div>
				<div id="footer">&copy;2MR Solutions 2008. Todos os direitos reservados.</div>
			</div>
		</div>
	</body>
</html>