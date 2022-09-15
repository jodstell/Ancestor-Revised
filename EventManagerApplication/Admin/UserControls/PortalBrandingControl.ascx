<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PortalBrandingControl.ascx.vb" Inherits="EventManagerApplication.PortalBrandingControl" %>

<style>
    div.RadUpload .ruBrowse
{
    background-position: 0 -23px;
    width: 170px;
}
div.RadUpload_Default .ruFileWrap .ruButtonHover
{
    background-position: 100% -23px !important;
}   
</style>

<div class="row">

    <div class="col-sm-12">
        <div class="form-group">
            <label for="CountryTextBox">Logo</label>
            <div >
            <div class="thumbnail" style="background-color: black; width:132px; height:40px;">
            <asp:Image ID="ClientLogo" runat="server" Width="126px" Height="31px" />
                </div>



                </div> 
                <telerik:RadAsyncUpload ID="HeadShotUploader" runat="server" MultipleFileSelection="Disabled" MaxFileInputsCount="1" Skin="Bootstrap"
                    HideFileInput="true" >
                    <Localization Select="Change Logo" />
                </telerik:RadAsyncUpload>

            <div class="row">

                <div class="col-sm-12">
                  <asp:Button ID="btnUpdatePortalBranding" runat="server" CausesValidation="True" CommandName="Update" Text="Save Changes" CssClass="btn btn-md btn-primary" />
                                                                </div>
                                                            </div>

        </div>

         <%--<div class="form-group">
            <label for="CountryTextBox">Invoice Logo</label>

        </div>--%>

         <%--<div class="form-group">
            <label for="CountryTextBox">Email Header</label>

        </div>--%>

    </div>

</div>
