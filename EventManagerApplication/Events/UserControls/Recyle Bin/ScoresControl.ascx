<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ScoresControl.ascx.vb" Inherits="EventManagerApplication.ScoresControl" %>


<div class="alert alert-info" role="alert">This control has not been created.</div>

<asp:Label ID="msgLabel" runat="server" />

<div>

    <asp:Repeater ID="AmbassadorTestResultsList" runat="server" >
        <HeaderTemplate>
            <table>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Eval("assignedUserName") %></td>
            
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>

     <asp:SqlDataSource ID="GetEventStaff2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                        SelectCommand="SELECT * FROM [qryEventStaffingStatus] WHERE ([eventID] = @eventID)">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>


</div>