<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="AddressValidation.aspx.vb" Inherits="EventManagerApplication.AddressValidation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div>


                                                            <div class="form-horizontal" role="form">

                                                    <div class="clear">&nbsp;</div>

                                                                <div class="form-group">
                                                        <label class="col-md-3">Account Name</label>

                                                        <div class="col-md-4">
                                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>
                                                     <div class="form-group">
                                                        <label class="col-md-3">Address</label>

                                                        <div class="col-md-4">
                                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                                            
                                                        </div>
                                                    </div>

                                                                </div>




         <asp:Button ID="btnLookup" runat="server" Text="FindLocation" CssClass="btn btn-primary" />
</div>

        <div>
            Latitude:<asp:Label ID="LatitudeLabel" runat="server" /><br />
            Longitude: <asp:Label ID="LongitudeLabel" runat="server" />

            <br />
            <br />
            Matched Location: <asp:Label ID="MatchedLocationIDLabel" runat="server" />


            <telerik:RadGrid ID="RadGrid1" runat="server"></telerik:RadGrid>

        </div>

    </div>
</asp:Content>
