<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="EventManagerApplication.Login1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<link rel="stylesheet" href="/css/bootstrap.min.css" />
	    <link rel="stylesheet" href="/theme/css/Login.css" type="text/css" />
    	<link rel="stylesheet" href="/theme/css/custom.css" type="text/css" />
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />

    	<script type="text/javascript" src="/js/respond.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <div>
<%--    <script type="text/javascript" src="/js/respond.min.js"></script>--%>

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="LoginPanel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="LoginPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                     </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="ForgotPasswordPanel">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ForgotPasswordPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

     <div id="login-container">

	<%--<div id="logo">
		<a href="/login">
            <img src="ProofMarketing.png" />

		</a>
	</div>--%>



     <asp:Panel ID="LoginPanel" runat="server">

          <asp:Label ID="errLabel" ForeColor="Black" runat="server" />

	    <div id="login" style="height:630px">
            <div style="margin:25px 0 10px 0">

                <asp:Image ID="LogoImage" runat="server" ImageUrl="GigEngyn Logo.png" AlternateText="Powered by GigEngyn" Width="200px" />

                <%--<h2>Slicker Beverage Insights</h2>--%>
            </div>
		<h3 class="logintitle">Welcome to the <%: System.Configuration.ConfigurationManager.AppSettings("SiteTitle")%></h3>

		<h5 class="logintitle">Please sign in to get access.</h5>

            <asp:Label ID="msgLabel" runat="server"></asp:Label>

            <br />



			<div class="form-group">
                <div class="input-group">

                    <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
                <asp:TextBox ID="frmUserName" runat="server" placeholder="User Name" class="form-control" required></asp:TextBox>
			</div>
                </div>

			<div class="form-group">
                <div class="input-group">

                <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                <asp:TextBox ID="frmPassword" runat="server"  placeholder="Password" class="form-control" TextMode="Password" required></asp:TextBox>
			</div>
                </div>

            <div class="form-group">
                        <div class="col-md-10" style="text-align:left">
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>

            <br />

			<div class="form-group">

                <asp:Button ID="LoginButton" runat="server" Text="Sign In " CssClass="btn btn-primary btn-block btn-lg"  />
			</div>

           <asp:LinkButton ID="PassordLink" runat="server" CssClass="btn btn-default" Visible="true" OnClick="PassordLink_Click">Forgot Password?</asp:LinkButton>

            <asp:HyperLink ID="RegistrationLink" runat="server" CssClass="btn btn-success" NavigateUrl="/account/register" Visible="true">Register</asp:HyperLink>

            <div class="col-md-12" style="margin-bottom:25px;">

                    <hr />
                    <%--<asp:Image ID="FooterImage" runat="server" ImageUrl="GigEngyn Logo.png" ImageAlign="right" AlternateText="Powered by GigWerk" Width="160px" />--%><br /><br />

                </div>

            <p style="padding-top:15px;">Copyright © 2022, GigEngyn - <asp:Label ID="lblASPVersion" runat="server" /></p>

	    </div> <!-- /#login -->



     </asp:Panel>



         <asp:Panel ID="ForgotPasswordPanel" runat="server" Visible="false">

             <asp:Label ID="errorLabel" runat="server"></asp:Label>

             <div id="login2">

                <h3 class="logintitle">Welcome to <%: System.Configuration.ConfigurationManager.AppSettings("SiteTitle")%></h3>

		        <h5 class="logintitle">Please enter your user name to retrieve the password.</h5>




                  <br />



			<div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user fa-fw" aria-hidden="true"></i></span>
                    <asp:TextBox ID="UserNameTextBox" runat="server" placeholder="User Name" class="form-control" required="true" ></asp:TextBox>
			    </div>
            </div>


            <div class="form-group">
                <asp:Button ID="btnRequestPassword" runat="server" Text="Request Password" CssClass="btn btn-primary btn-block btn-lg" />
			</div>

                 <asp:LinkButton ID="btnGoBack" runat="server" CssClass="btn btn-default" ValidateRequestMode="Disabled"><i class="fa fa-arrow-left" aria-hidden="true"></i>
 Go Back Log In</asp:LinkButton>

             </div>

         </asp:Panel>


</div>

        <script src="/js/jquery.min.js"></script>
        <script src="/js/jquery-ui.custom.min.js"></script>


    </div>
    </form>
</body>
</html>
