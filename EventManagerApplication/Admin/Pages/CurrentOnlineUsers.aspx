<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CurrentOnlineUsers.aspx.vb" Inherits="EventManagerApplication.CurrentOnlineUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Current Users Online</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <div>


            <telerik:RadGrid ID="CurrentUserList" runat="server" DataSourceID="getCurrentUserList" GroupPanelPosition="Top" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" Skin="Bootstrap">

                <MasterTableView DataSourceID="getCurrentUserList">
                    <Columns>

                        <telerik:GridBoundColumn DataField="firstName" HeaderText="First Name" SortExpression="firstName" UniqueName="firstName"
                            FilterControlAltText="Filter firstName column">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="lastName" HeaderText="Last Name" SortExpression="lastName" UniqueName="lastName"
                            FilterControlAltText="Filter lastName column">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn HeaderText="Roles">
                            <ItemTemplate>
                                <%# getRoles(Eval("UserID")) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Login" SortExpression="LastLoginDate" AllowFiltering="false">
                            <ItemTemplate>

                                <asp:Label ID="LastLoginDateLabel" runat="server" Text='<%# Common.GetTimeAdjustment(Eval("LastLoginDate"))%>' />

                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Last Activity" SortExpression="lastActivityDate" AllowFiltering="false">
                            <ItemTemplate>

                                <asp:Label ID="lastActivityDateLabel" runat="server" Text='<%#Common.GetTimeAdjustment(Eval("lastActivityDate"))%>' />

                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridBoundColumn DataField="lastPageLanding" HeaderText="Last Page" SortExpression="lastPageLanding" UniqueName="lastPageLanding"
                            FilterControlAltText="Filter lastPageLanding column">
                        </telerik:GridBoundColumn>

                        <telerik:GridCheckBoxColumn DataField="IsMobileDevice" HeaderText="Mobile" SortExpression="IsMobileDevice" UniqueName="IsMobileDevice"
                            FilterControlAltText="Filter IsMobileDevice column">

                        </telerik:GridCheckBoxColumn>



                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>

            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getCurrentUserList" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                OrderBy="lastLoginDate" TableName="qryGetLoggedInUsers">
            </asp:LinqDataSource>
        </div>
    </form>
</body>
</html>
