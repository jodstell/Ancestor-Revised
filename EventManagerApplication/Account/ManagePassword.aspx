<%@ Page Title="Manage Password" Language="vb" MasterPageFile="~/Dashboard.Master" AutoEventWireup="false" CodeBehind="ManagePassword.aspx.vb" Inherits="EventManagerApplication.ManagePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
         @media (min-width: 320px) and (max-width: 1024px) {                
                .main
                {
                    padding: 10px !important;
                }

            }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
     <div class="container min-height">

         <div class="col-sm-6">

    <h2><%: Title %></h2>
         <hr />

          <div class="widget stacked">
                            <div class="widget-content sm-height">

    <div class="form-horizontal">
        <section id="passwordForm">


            <asp:PlaceHolder runat="server" ID="changePasswordHolder" Visible="false">
                <div class="form-horizontal">
                    <h4>Change Password Form</h4>
                    <hr />
                    <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />

                    <div class="form-group">
                        <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword" CssClass="col-md-4 control-label">Current password</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                CssClass="text-danger" ErrorMessage="The current password field is required."
                                ValidationGroup="ChangePassword" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword" CssClass="col-md-4 control-label">New password</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                CssClass="text-danger" ErrorMessage="The new password is required."
                                ValidationGroup="ChangePassword" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword" CssClass="col-md-4 control-label">Confirm new password</asp:Label>
                        <div class="col-md-6">
                            <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                ValidationGroup="ChangePassword" />
                            <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
                                ValidationGroup="ChangePassword" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <asp:Button runat="server" Text="Change Password" ValidationGroup="ChangePassword" OnClick="ChangePassword_Click" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
        </section>
    </div>

                                </div>
              </div>

</div>
         </div>
</asp:Content>
