<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" CodeBehind="Accounts.aspx.vb" Inherits="EventManagerApplication.Accounts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="content">
    <div class="container-fluid">
    <div class="row">
						<div class="col-xs-12">

        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateEditColumn="True" DataSourceID="LinqDataSource1" AllowSorting="True">
            <MasterTableView EditFormSettings-EditColumn-ButtonType="PushButton" AutoGenerateColumns="False" DataKeyNames="accountID" DataSourceID="LinqDataSource1" AllowAutomaticUpdates="true">
                <Columns>

                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:Button ID="btnTryAgain" runat="server" Text="Try Again" CommandName="TryAgain" CommandArgument='<%# Eval("accountID")%>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="accountID" FilterControlAltText="Filter accountID column" HeaderText="accountID" ReadOnly="True" SortExpression="accountID" UniqueName="accountID">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                   <%-- <telerik:GridBoundColumn DataField="Vpid" DataType="System.Int32" FilterControlAltText="Filter Vpid column" HeaderText="Vpid" SortExpression="Vpid" UniqueName="Vpid">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="accountName" FilterControlAltText="Filter accountName column" HeaderText="accountName" SortExpression="accountName" UniqueName="accountName">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="streetAddress1" FilterControlAltText="Filter streetAddress1 column" HeaderText="streetAddress1" SortExpression="streetAddress1" UniqueName="streetAddress1">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="streetAddress2" FilterControlAltText="Filter streetAddress2 column" HeaderText="streetAddress2" SortExpression="streetAddress2" UniqueName="streetAddress2">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="city" FilterControlAltText="Filter city column" HeaderText="city" SortExpression="city" UniqueName="city">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="state" FilterControlAltText="Filter state column" HeaderText="state" SortExpression="state" UniqueName="state">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="zipCode" FilterControlAltText="Filter zipCode column" HeaderText="zipCode" SortExpression="zipCode" UniqueName="zipCode">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                   <%-- <telerik:GridBoundColumn DataField="phone" FilterControlAltText="Filter phone column" HeaderText="phone" SortExpression="phone" UniqueName="phone">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>--%>
                    <%--<telerik:GridBoundColumn DataField="accountTypeName" FilterControlAltText="Filter accountTypeName column" HeaderText="accountTypeName" SortExpression="accountTypeName" UniqueName="accountTypeName">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>--%>
                    <%--<telerik:GridBoundColumn DataField="marketName" FilterControlAltText="Filter marketName column" HeaderText="marketName" SortExpression="marketName" UniqueName="marketName">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="latitude" DataType="System.Double" FilterControlAltText="Filter latitude column" HeaderText="latitude" SortExpression="latitude" UniqueName="latitude">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="longitude" DataType="System.Double" FilterControlAltText="Filter longitude column" HeaderText="longitude" SortExpression="longitude" UniqueName="longitude">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>

        </telerik:RadGrid>

                            <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableUpdate="True" EntityTypeName="" OrderBy="state" TableName="tblAccounts">
                            </asp:LinqDataSource>

                            </div>
        </div>
        </div>
        </div>




</asp:Content>
