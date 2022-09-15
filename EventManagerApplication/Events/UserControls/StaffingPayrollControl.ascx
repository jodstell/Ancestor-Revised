<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="StaffingPayrollControl.ascx.vb" Inherits="EventManagerApplication.StaffingPayrollControl" %>

<div class="widget stacked">
    <div class="widget-content">

        <asp:Repeater ID="PayrollExpenseSummaryList" runat="server" DataSourceID="getPayrolSummary">
            <HeaderTemplate>
                <table class="table">
                    <tbody>
                        <tr>
                            
                            <th>Payee Name</th>
                            <th>Position</th>
                            <th>Status</th>
                            <th>Payment Date</th>
                            <th>Hours</th>
                            <th>Rate</th>
                            <th>Expenses/Adjustments</th>
                            <th>Amount</th>
                        </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    
                    <td><%# Eval("FullName") %></td>
                    <td><%# Eval("positionTitle") %></td>
                    <td><%# Eval("paymentStatus") %></td>
                    <td></td>
                    <td><%# Eval("hours") %></td>
                    <td><%# Eval("rate") %></td>
                    <td><%# Eval("expenses") %></td>
                    <td></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
                               </table>
            </FooterTemplate>
        </asp:Repeater>


        <asp:SqlDataSource runat="server" ID="getPayrolSummary" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPayrollSummaryByEvent" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>







    </div>
</div>
