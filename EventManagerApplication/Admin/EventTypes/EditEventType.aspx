<%@ Page Title="Edit Event Type" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditEventType.aspx.vb" Inherits="EventManagerApplication.EditEventType" %>

<%@ Register Src="~/Admin/UserControls/EventTypeRecapQuestionsControl.ascx" TagPrefix="uc1" TagName="EventTypeRecapQuestionsControl" %>
<%@ Register Src="~/Admin/UserControls/EventTypeTaskControl.ascx" TagPrefix="uc1" TagName="EventTypeTaskControl" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        // close the div in 5 secs    
        window.setTimeout("closeDiv();", 3000);

        function closeDiv() {
            // jQuery version        
            $("#messageHolder").fadeOut("slow", null);
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../../Theme/css/custom1.css" rel="stylesheet" />
    <link href="../../Theme/css/custom.css" rel="stylesheet" />


     <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnRequestStart="requestStart">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


    <div class="container">

        <div class="row">

            <div class="row">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>


            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                <div style="margin: 0 0 15px 0">
                    <h2>Client Details: 
                        <asp:Label ID="ClientNameLabel" runat="server" Font-Bold="true" />
                    </h2>
                    <h3>Event Type: 
                        <asp:Label ID="EventTypeNameLabel" Font-Bold="true" runat="server" /></h3>
                </div>
            </telerik:RadScriptBlock>
        </div>

       

        
<asp:Panel runat="server" ID="Panel1">

            <div class="row">
            <!-- Tabs -->
            <div class="pull-right">
            <a href="/admin/ClientDetails?ClientID=<%= Common.GetCurrentClientID()%>#eventtab/eventtype" class="btn btn-default"><i class="fa fa-angle-double-left"></i>&nbsp;Client Overview</a>
            </div>

            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="false" MultiPageID="RadMultiPage1" SelectedIndex="0">
                <Tabs>
                    <telerik:RadTab Text="Details"></telerik:RadTab>
                    <telerik:RadTab Text="Default Tasks"></telerik:RadTab>
                    <telerik:RadTab Text="Default Recap Questions"></telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
 
            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">

                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <div class="widget stacked">
                            <div class="widget-content min-height">


                                <div class="contentbox">

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <h2>Details</h2>
                                            <hr />
                                        </div>
                                    </div>


                                    <div class="row">

                                        <div class="col-sm-4">
                                            <div id="clientNameText" class="form-group has-feedback">
                                                <label for="EventTypeNameTextBox">Name</label>
                                                <asp:TextBox ID="EventTypeNameTextBox" runat="server"
                                                    CssClass="form-control" aria-describedby="helpBlock" />
                                                <span id="helpBlock" class="help-block">Warning:  Changing the name will affect all clients.</span>

                                            </div>
                                        </div>

                                        <div class="col-sm-2">
                                            <div class="form-group">
                                                <label for="ActiveTextBox">Active</label>
                                                <asp:DropDownList ID="ActiveTextBox" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-sm-2">
                                            <div class="form-group">
                                                <label for="Profile">Show in Profile Options</label>
                                                <asp:DropDownList ID="Profileddl" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row">

                                        <div class="col-sm-12">
                                            <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn btn-md btn-primary" />
                                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-md btn-danger" OnClientClick="javascript:if(!confirm('This action will delete the selected event type and remove it from the clients. Are you sure?')){return false;}"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <div class="widget stacked">
                        <div class="widget-content min-height">
                            <h2>Default Tasks</h2>
                            <hr />

                            <uc1:EventTypeTaskControl runat="server" id="EventTypeTaskControl" />
                        </div>

                    </div>

                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView3" runat="server">

                    <div class="widget stacked">
                        <div class="widget-content min-height">
                            <h2>Default Recap Questions</h2>
                            <p>Event Type Recap Question for this client.</p>
                            <hr />

                            <uc1:EventTypeRecapQuestionsControl runat="server" id="EventTypeRecapQuestionsControl" />
                        </div>

                    </div>


                </telerik:RadPageView>

            </telerik:RadMultiPage>
                            

        </div>

       </asp:Panel>

        </div>

    <script type="text/javascript">
    function requestStart(sender, args) {
        if (args.get_eventTarget().indexOf("btnUpdate") >= 0) {
            args.set_enableAjax(false);
        }
    }


</script>

    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Your changes were updated successfully!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

</asp:Content>

