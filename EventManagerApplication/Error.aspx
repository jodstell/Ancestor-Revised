<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Error.aspx.vb" Inherits="EventManagerApplication.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="MainPanel">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="MainPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                <telerik:AjaxUpdatedControl ControlID="SuccessPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <div class="row">

         <asp:Panel ID="MainPanel" runat="server">
				<div class="col-md-12" style="margin-top:60px">

					<div class="error-container">

						<div class="error-code">
							Oops!
						</div> <!-- /.error-code -->

						<div class="error-details">
							<h3>There was a problem serving the requested page.</h3>
							<br />
							<p style="font-size: 16px;"><strong>Care to help us fix this?</strong> <br /> Any information you can provide will help our technical team get to the bottom of this issue.</p>
							
							
							<%--<ul class="icons-list">
								<li>
									<i class="icon-li fa fa-check-square-o"></i>
									
								</li>
								<li>
									<i class="icon-li fa fa-check-square-o"></i>
									if you entered the url by hand, double check that it is correct
								</li>
								<li>
									<i class="icon-li fa fa-check-square-o"></i>
									Nothing! we've been notified of the problem and will do our best to make sure it doesn't happen again!
								</li>
							</ul>--%>

                            <div style="">
                                <p style="font-size: 16px;text-align:center;"><strong>Comment</strong></p>

                                <telerik:RadTextBox ID="commentTextBox" runat="server" TextMode="MultiLine" Width="470px" Height="150px"></telerik:RadTextBox>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="errorlabel" Display="Dynamic" 
                                ValidationGroup="comment" ControlToValidate="commentTextBox" ErrorMessage="Comment text box is empty."></asp:RequiredFieldValidator>    
                                                                
                            </div>

                            <div style="text-align:center;margin-top: 10px;">
                                <asp:Button ID="btnSendReport" runat="server" Text="Send" CssClass="btn btn-primary" ValidationGroup="comment" />
                            </div>
                            
						</div> <!-- /.error-details -->

					</div> <!-- /.error -->

				</div> <!-- /.col-md-12 -->
         </asp:Panel>


        <asp:Panel ID="SuccessPanel" runat="server" Visible="false">

            <div class="container min-height">
                <div class="col-md-6" style="margin-top:80px; margin-left:310px">

                    <div class="widget stacked">
                        <div class="widget-content" style="padding:30px;">
                            
                        <div class="alert alert-success" style="padding: 30px;font-size: 15px;">
                            <strong>Success!</strong> Thanks for help. Your details has been send.
                        </div>

                        </div>
                    </div>

                </div>
            </div>

        </asp:Panel>
	</div>

</asp:Content>
