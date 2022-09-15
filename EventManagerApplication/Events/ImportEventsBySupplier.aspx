<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="ImportEventsBySupplier.aspx.vb" Inherits="EventManagerApplication.ImportEventsBySupplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <style>
        .form-control-padding {
            margin-top: -15px;
            display: inline-block;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .RadComboBox {
            text-align: left;
            display: block;
            vertical-align: middle;
            white-space: nowrap;
        }

    </style>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1" ClientEvents-OnRequestStart="requestEnd">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="MasterPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="MasterPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="MasterPanel" runat="server">



        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div id="messageHolder">
                        <asp:Literal ID="msgLabel" runat="server" />
                    </div>
                </div>
            </div>

            <div class="container min-height">
                <div class="row">
                    <div class="col-xs-12">

                        <h2>Import Events</h2>

                        <p>
                            <b>Import Events from Excel file.</b><br />
                            <span style="color: #ff0000">*<span style="color: #000000"> &nbsp;indicates a required field</span></span>
                        </p>

                        <br />

                        <div class="widget stacked">
                            <div class="widget-content">






                                <div class="col-md-7">

                                    <asp:Panel ID="Panel2" runat="server">



                                        <div class="">
                                            <div class="">

                                                <%-- <p class="bg-primary">--%>


                                                <div class="form-horizontal" role="form">

                                                    <div class="clear">&nbsp;</div>

                                                     <div class="form-group">
                                                        <label class="col-md-3">Supplier<span style="color: red"> *</span></label>

                                                        <div class="col-md-4">
                                                            <asp:Label ID="SupplierNameLabel" runat="server" />
                                                          
                                                        </div>
                                                    </div>

                                                     <div class="form-group">
                                                        <label class="col-md-3">Brands<span style="color: red"> *</span></label>

                                                        <div class="col-md-4">
                                                             <telerik:RadListBox RenderMode="Lightweight" ID="BrandListBox" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="400px"
                                                            Height="350px" DataTextField="brandName" DataValueField="brandID" >
                                                        </telerik:RadListBox>



                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-md-3">Match Location<span style="color: red"> *</span></label>

                                                        <div class="col-md-4">
                                                            <telerik:RadComboBox ID="MatchComboBox" runat="server" Width="400px"   MarkFirstMatch="True" Filter="StartsWith" AllowCustomText="true" AppendDataBoundItems="true">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="Address Fields and Location Name (Best Match)" Value="0" Selected="true" />
                                                                    <telerik:RadComboBoxItem Text="Location Name (Exact Match)" Value="1" />
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </div>
                                                    </div>


                                                     <div class="form-group">
                                                        <label class="col-md-3">Event Type<span style="color: red"> *</span></label>

                                                        <div class="col-md-4">
                                                            <telerik:RadComboBox ID="EventTypeIDComboBox" runat="server" Width="250px"  DataSourceID="GetEventTypeList" MarkFirstMatch="True" Filter="StartsWith" AllowCustomText="true" DataTextField="eventTypeName" DataValueField="eventTypeID"></telerik:RadComboBox>
                                                        </div>
                                                    </div>

                                                    <asp:LinqDataSource ID="GetEventTypeList" runat="server"
                                                        ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                        EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
                                                        <WhereParameters>
                                                            <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                                        </WhereParameters>
                                                    </asp:LinqDataSource>

                                                    
                                                     <div class="form-group">
                                                        <label class="col-md-3">Number of Positions<span style="color: red"> *</span></label>
                                                        <div class="col-md-4">
                                                            <telerik:RadNumericTextBox ID="PositionsTextBox" runat="server"></telerik:RadNumericTextBox>
                                                        </div>
                                                    </div>


                                                    <asp:PlaceHolder ID="SupplierBudgetPlaceHolder" runat="server"></asp:PlaceHolder>


                                                    <div class="form-group">
                                                        <label class="col-md-3">Team</label>

                                                        <div class="col-md-4">
                                                            <telerik:RadComboBox  ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" AutoPostBack="false"
                                                    DataTextField="teamName" Width="300px" AllowCustomText="true" EmptyMessage="Select a Team"
                                                    DataValueField="teamID" AppendDataBoundItems="false" MarkFirstMatch="true">
                                                </telerik:RadComboBox>
                                                            <span id="helpBlock3" class="help-block">Enter the name of the team.  Leave blank for none.</span>
                                                        </div>
                                                    </div>

                                                    <asp:LinqDataSource ID="GetTeamList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                            EntityTypeName="" OrderBy="teamName" TableName="tblTeams">
                                        </asp:LinqDataSource>

                                                    <div class="form-group">
                                                        <label class="col-md-3">Import File<span style="color: red"> *</span></label>

                                                        <div class="col-md-9">
                                                            <telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" MultipleFileSelection="Disabled" aria-describedby="helpBlock1" AllowedFileExtensions="xls" />
                                                            <span id="helpBlock1" class="help-block">Select the excel file to be imported</span>
                                                        </div>
                                                    </div>

                                                     <div class="form-group">
                                                        <label class="col-md-3">Import FileID<span style="color: red"> *</span></label>

                                                        <div class="col-md-4">
                                                           <asp:TextBox ID="FileIDTextBox" runat="server" CssClass="form-control" required  />
                                                            
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-md-3">Worksheet Name<span style="color: red"> *</span></label>

                                                        <div class="col-md-4">
                                                            <asp:TextBox ID="WorksheetNameTextBox" runat="server" CssClass="form-control" required aria-describedby="helpBlock2" />
                                                            <span id="helpBlock2" class="help-block">Enter the name of the worksheet.</span>
                                                        </div>
                                                    </div>

                                                    <%--<div class="form-group">
                                                    <label class="col-md-4">Number of events to preview</label>

                                                    <div class="col-md-8">
                                                        <asp:TextBox ID="EmailAddressTextBox" runat="server" CssClass="form-control" Width="70px" Text="10" required aria-describedby="helpBlock3" />
                                                        <span  id="helpBlock3" class="help-block">The number of students to preview before importing.</span>

                                                    </div>
                                                </div>--%>



                                                    <%--<div class="form-group">
                                                    <label class="col-md-4">Notify Students</label>

                                                    <div class="col-md-8">
                                                        <asp:CheckBox ID="CheckBox1" runat="server" aria-describedby="helpBlock4" />
                                                        <span  id="helpBlock4" class="help-block">If checked, each newly created student will receive a welcome email.</span>
                                                        </div>
                                                    </div>--%>


                                                    <div class="form-group">
                                                        <label class="col-md-3"></label>

                                                        <div class="col-md-9">
                                                            <asp:Button ID="btnImportExcel" runat="server" CssClass="btn btn-primary" CausesValidation="True" CommandName="Update" Text="Begin Import" />
                                                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-default" PostBackUrl="/Events/ViewEvents" CausesValidation="True" Text="Cancel" />
                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                    </asp:Panel>



                                </div>

                                <div class="col-md-5 col-sidebar-right">
                                    <div class="well primary">

                                        <h3>Import Events</h3>

                                        <p>
                                            By importing Events from a Excel file you may accomplish three tasks at the same time:<br />
                                            1. Add events in the system,<br />
                                            2. set the brands and<br />
                                            3. assign ambassador positions.
                                        </p>

                                        <hr />

                                        <p>The first row is always used as the header and is not processed.</p>
                                        <p>Please note that all columns must be included even if they are empty and the file extension .xls is required!</p>
                                        <hr />
                                        <p><a href="/Files/SampleImport.xls">Download a Template</a></p>
                                        <hr />



                                    </div>

                                </div>







                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>



    </asp:Panel>

    <style>
        .slidingDiv {
            display: none;
        }
    </style>


     <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="The events have been uploaded successfully!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        //$(document).ready(function(){

        //$(".slidingDiv").hide();
        //$(".show_hide").show();

        //$('.show_hide').click(function(){
        //$(".slidingDiv").slideToggle();
        //});

        //});

        function requestEnd(sender, args) {
            $(".slidingDiv").show();
        }

    </script>

</asp:Content>
