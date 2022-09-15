<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewRecaps.aspx.vb" Inherits="EventManagerApplication.NewRecaps" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recaps Submitted</title>

         <script src="/js/jquery.js"></script>
    <link href="overlay.css" rel="stylesheet" />

    <link href="/theme/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">


        <div>


            <telerik:RadGrid ID="CurrentUserList" runat="server" DataSourceID="getDataList" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" Skin="Bootstrap">

                <MasterTableView DataSourceID="getDataList">
                    <Columns>

                        <telerik:GridTemplateColumn HeaderText="Event Title" SortExpression="eventTitle" AllowFiltering="false" UniqueName="eventTitle">
                            <ItemTemplate>
                                <a onclick="handleLinks()" target="_parent" href='/Events/EventDetails?ID=<%# Eval("eventID")%>'><%# Eval("eventTitle")%></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="eventDate" HeaderText="Event Date" SortExpression="eventDate" UniqueName="eventDate"
                            FilterControlAltText="Filter eventDate column" DataFormatString="{0:MM/dd/yyyy}">
                        </telerik:GridBoundColumn>

                     <telerik:GridBoundColumn DataField="supplierName" HeaderText="Supplier Name" SortExpression="supplierName" UniqueName="supplierName"
                            FilterControlAltText="Filter supplierName column">
                        </telerik:GridBoundColumn>

                       <telerik:GridBoundColumn DataField="marketName" HeaderText="Market" SortExpression="marketName" UniqueName="marketName"
                            FilterControlAltText="Filter marketName column">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn HeaderText="Brand Ambassador" SortExpression="CreatedBy" AllowFiltering="false">
                            <ItemTemplate>

                                <%# Eval("CreatedBy")%>

                                <%--<a href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID")%>'><%# Eval("CreatedBy")%></a>--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>



                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getDataList" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                OrderBy="createdDate desc" TableName="qryGetRecapCreated_last24hours">
            </asp:LinqDataSource>
        </div>

            </telerik:RadAjaxPanel>

        <%--<i class="fa fa-refresh fa-spin fa-spin-2x fa-2x fa-fw" style="color:#0670cd;"></i>--%>

<div id="overlay-back"></div>
    <div id="overlay">
        <div id="dvLoading">
            <p>Please wait<br />while we are loading...</p>
            <%--<img id="loading-image" src="/img/loading7_navy_blue.gif" width="24" height="24" alt="Loading..." />--%>
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
