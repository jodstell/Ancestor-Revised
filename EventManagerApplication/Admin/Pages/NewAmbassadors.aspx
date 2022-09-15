<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewAmbassadors.aspx.vb" Inherits="EventManagerApplication.NewAmbassadors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Ambassadors</title>

    <script src="/js/jquery.js"></script>
    <link href="overlay.css" rel="stylesheet" />

    <link href="/theme/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />


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

                         <telerik:GridTemplateColumn HeaderText="User Name" SortExpression="userName" AllowFiltering="false">
                            <ItemTemplate>

                                <a onclick="handleLinks()" href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID")%>' target="_parent"><%# Eval("userName")%></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

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

                       <telerik:GridBoundColumn DataField="CreatedBy" HeaderText="Created By" SortExpression="CreatedBy" UniqueName="CreatedBy"
                            FilterControlAltText="Filter CreatedBy column">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn HeaderText="Date Submitted" SortExpression="LastLoginDate" AllowFiltering="false">
                            <ItemTemplate>

                                <%#Common.GetTimeAdjustment(Eval("CreatedDate"))%>

                                <%--<a href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID")%>'><%# Eval("CreatedBy")%></a>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>



                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>


            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getDataList" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                OrderBy="CreatedDate desc" TableName="qryGetNewAmbassadors_last24hrs">
            </asp:LinqDataSource>
        </div>


            </asp:Panel>

    <%--<i class="fa fa-refresh fa-spin fa-spin-2x fa-2x fa-fw" style="color:#0670cd;"></i>--%>
 
   <div id="overlay-back"></div>
    <div id="overlay">
        <div id="dvLoading">
            <p>Please wait<br />while we are loading...</p>
            <%--<img id="loading-image" src="/img/spinner.gif" alt="Loading..." />--%>
            <i id="loading-image" class="fa fa-refresh fa-spin fa-spin-2x fa-2x fa-fw" style="color:#0670cd;"></i>
        </div>
    </div>

    <script>

        function handleLinks() {
            $('#dvLoading, #overlay, #overlay-back').fadeIn(500);
            }

        $(function () {
            $('#submit').on('click', function (evt) {
                evt.preventDefault();
                $('#dvLoading, #overlay, #overlay-back').fadeIn(500);
            });
        });    
</script> 
    
    </form>
</body>
</html>
