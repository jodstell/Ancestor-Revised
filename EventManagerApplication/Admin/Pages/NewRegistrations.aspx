<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewRegistrations.aspx.vb" Inherits="EventManagerApplication.PagesNewRegistrations" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Registrations</title>
</head>
<body>
   <form id="form1" runat="server">
            <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">

            function bntViewEvent() {

                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= Panel1.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);

            }

            </script>
                </telerik:RadCodeBlock>


        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">

        </telerik:RadScriptManager>

             <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true" ClientEvents-OnRequestStart="requestStart">

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                 </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
                 </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>


            <asp:Panel ID="Panel1" runat="server">

        <div>


            <telerik:RadGrid ID="CurrentUserList" runat="server" DataSourceID="getDataList" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" Skin="Bootstrap">

                <MasterTableView DataSourceID="getDataList">
                    <Columns>

                        <telerik:GridBoundColumn DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" UniqueName="FirstName"
                            FilterControlAltText="Filter FirstName column">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="LastName" HeaderText="Last Name" SortExpression="LastName" UniqueName="LastName"
                            FilterControlAltText="Filter LastName column">
                        </telerik:GridBoundColumn>

                     <telerik:GridBoundColumn DataField="City" HeaderText="City" SortExpression="City" UniqueName="City"
                            FilterControlAltText="Filter City column">
                        </telerik:GridBoundColumn>

                       <telerik:GridBoundColumn DataField="State" HeaderText="State" SortExpression="State" UniqueName="State"
                            FilterControlAltText="Filter State column">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn HeaderText="Date Submitted" SortExpression="LastLoginDate" AllowFiltering="false">
                            <ItemTemplate>

                                <%#Common.GetTimeAdjustment(Eval("LastLoginDate"))%>

                                <%--<a href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID")%>'><%# Eval("CreatedBy")%></a>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>



                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getDataList" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                OrderBy="LastLoginDate desc" TableName="qryGetRegistrations_last24hrs">
            </asp:LinqDataSource>
        </div>


            </asp:Panel>
    </form>
</body>
</html>
