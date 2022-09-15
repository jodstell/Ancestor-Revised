<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PaidControl.ascx.vb" Inherits="EventManagerApplication.PaidControl" %>


<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" >

    <telerik:RadGrid ID="ActiveCourseList" runat="server" AutoGenerateColumns="False"
        DataSourceID="getScheduledPayments" AllowPaging="true" AllowSorting="true">

        <MasterTableView DataKeyNames="RequirementID" DataSourceID="getScheduledPayments" AutoGenerateColumns="False" CommandItemDisplay="None" AllowSorting="true" AllowPaging="false" ShowFooter="True">

            <Columns>            
                
                <telerik:GridTemplateColumn HeaderText="Event">
                    <ItemTemplate>
                        <a href='/Events/EventDetails?ID=<%# Eval("eventID") %>'onclick="ShowLoadingPanel()"><%# Eval("supplierName") %></a><br />
                            <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("accountName") %>'></asp:Label>
                    </ItemTemplate>
                    <%--<ItemStyle Width="160px" />--%>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="paymentDate" HeaderText="Date" SortExpression="paymentDate" UniqueName="paymentDate" DataType="System.DateTime" FilterControlAltText="Filter paymentDate column" DataFormatString="{0:d}" Aggregate="Count"></telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="hours" ReadOnly="True" HeaderText="Hours" SortExpression="hours" UniqueName="hours" DataType="System.Double" FilterControlAltText="Filter hours column" Aggregate="Sum"></telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="labor" ReadOnly="True" HeaderText="Labor" SortExpression="labor" UniqueName="labor" DataType="System.Double" FilterControlAltText="Filter labor column" DataFormatString="{0:c}" Aggregate="Sum"></telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="expenses" ReadOnly="True" HeaderText="expenses" SortExpression="expenses" UniqueName="expenses" DataType="System.Decimal" FilterControlAltText="Filter expenses column" DataFormatString="{0:c}" Aggregate="Sum"></telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="Total" ReadOnly="True" HeaderText="Total" SortExpression="Total" UniqueName="Total" DataType="System.Double" FilterControlAltText="Filter Total column" DataFormatString="{0:c}" Aggregate="Sum"></telerik:GridBoundColumn>

            </Columns>


            <NoRecordsTemplate>
                <br />
                <div class="col-md-12">
                    <div class="alert alert-warning" role="alert">There are no paid payments to display.</div>
                </div>
            </NoRecordsTemplate>

            <RowIndicatorColumn>
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

        </MasterTableView>
    </telerik:RadGrid>


<asp:SqlDataSource runat="server" ID="getScheduledPayments" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPaidPaymentsByAmbassador" SelectCommandType="StoredProcedure">
    <SelectParameters>
       <asp:SessionParameter Name="userID" SessionField="CurrentUserID" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>




    <%--<telerik:RadListView ID="SechedulesPaymantList" runat="server" PageSize="2" DataSourceID="" DataKeyNames="RequirementID" AllowPaging="True" Skin="Bootstrap">

    <LayoutTemplate>

        <table class="table table-striped">
            <tbody>
                <tr>
                    <th>Event</th>
                    <th>Date</th>
                    <th>Hours</th>
                    <th>Labor</th>
                    <th>Expenses</th>
                    <th>Total</th>
                    <th>Payment #</th>
                </tr>

                <tr runat="server" id="itemPlaceholder"></tr>

            </tbody>
        </table>
        <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPagerProducts" runat="server" PagedControlID="SechedulesPaymantList" PageSize="10">
            <Fields>
                <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
            </Fields>
        </telerik:RadDataPager>
    </LayoutTemplate>

    <ItemTemplate>

        <tr>
            <td><a href='/Events/EventDetails?ID=<%# Eval("eventID") %>'onclick="ShowLoadingPanel()"><%# Eval("supplierName") %> <br />
                    <a class="text-success" href='/Accounts/AccountDetails?AccountID=<%# Eval("locationID") %>'><%# Eval("accountName") %></a>
            </td>
            <td>
                <asp:Label ID="paymentDateLabel" runat="server" Text='<%# Eval("paymentDate", "{0:d}") %>'></asp:Label>
                </td>
            <td>
                <asp:Label Text='<%# Eval("hours") %>' runat="server" ID="hoursLabel" /></td>
            <td>
                <asp:Label Text='<%# Eval("Labor", "{0:c}") %>' runat="server" ID="LaborLabel" /></td>
            <td>
                <asp:Label Text='<%# Eval("expenses", "{0:c}") %>' runat="server" ID="expensesLabel" /></td>
            <td><asp:Label Text='<%# Eval("Total", "{0:c}") %>' runat="server" ID="TotalLabel" /></td>
            <td>
                <asp:Label ID="paymentIDLabel" runat="server" Text='<%# Eval("paymentID") %>' /></td>
        </tr>

    </ItemTemplate>

    <EmptyDataTemplate>

<div class="alert alert-warning" role="alert">
    There are no paid payments to display.
</div>

    </EmptyDataTemplate>

</telerik:RadListView>--%>

</telerik:RadAjaxPanel>