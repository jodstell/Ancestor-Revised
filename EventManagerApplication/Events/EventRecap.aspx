<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="EventRecap.aspx.vb" Inherits="EventManagerApplication.EventRecap1" %>


<%@ Register Src="~/Events/UserControls/ShippingLocationControl.ascx" TagPrefix="uc1" TagName="ShippingLocationControl" %>
<%@ Register Src="~/Events/UserControls/POSCostControl.ascx" TagPrefix="uc1" TagName="POSCostControl" %>
<%@ Register Src="~/Events/UserControls/QuestionaireControl.ascx" TagPrefix="uc1" TagName="QuestionaireControl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

 <%--    <link href="/Theme/css/bootstrap.css" rel="stylesheet" />
   <link href="/Theme/css/base-admin-3.css" rel="stylesheet" />
    <link href="/Theme/css/custom.css" rel="stylesheet" />--%>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

    <style>
        .col-md-2, .col-xs-2 {
            position: relative;
            min-height: 1px;
            padding-right: 0px;
            padding-left: 5px;
        }

        .bin {
            border: 2px solid;
            padding: 2px;
            color: white;
            background-color: #428BCA;
        }

        .delete {
             border: 2px solid;
            padding: 2px;
            color: white;
            background-color: red;
        }

        /*Photo Galery Styles*/
        .galery {
            background-color: grey;
        }

        .btnbox {
            padding-top: 25px;
            text-align: right;
        }

        .imageContainer {
            float: left;
            margin: 5px;
            padding: 2px;
            position: relative;
            background: #eeeeee;
        }

            .imageContainer:hover {
                background-color: #a1da29 !important;
            }

        .buttonsWrapper {
            display: inline-block;
            vertical-align: middle;
        }

        .image {
            cursor: pointer;
            display: block;
        }

        .txt {
            border: 0 !important;
            background: #eeeeee !important;
            color: Black !important;
            margin-left: 25%;
            margin-right: auto;
            width: 100%;
            filter: alpha(opacity=50); /* IE's opacity*/
            opacity: 0.50;
            text-align: center;
        }

        #list {
            max-width: 900px;
        }

        .clearFix {
            clear: both;
        }

        .demo-container {
            max-width: 856px;
        }

        .sliderWrapper {
            float: left;
            display: inline-block;
            margin-bottom: 15px;
        }
        /*End Photo Gallery Styles*/

        /*showHidenDiv*/
        .showDiv {
            display: none;
        }
    </style>


    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnResponseEnd="triggerShowDiv()">

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="GalleryPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GalleryPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="UploadPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UploadPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RecapPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnApproveRecap" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="StaffingPnel1">
                <UpdatedControls>

                    <telerik:AjaxUpdatedControl ControlID="StaffingPnel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="scores" />
                    <telerik:AjaxUpdatedControl ControlID="ProductTrainingPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="NotesPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="NotesPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="ProductTrainingPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ProductTrainingPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnUpdateStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnUpdateStatus" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="StatusPanel" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="POSPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="POSPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="DirectionsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DirectionsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManager>--%>


    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"
        Style="position: absolute; top: 0; left: 0; width: 100%; height: 100%">
    </telerik:RadAjaxLoadingPanel>


    <%--<telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="EventDataGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>--%>


    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/EventDetails.css" rel="stylesheet" />

    <style>
        .dirSDK .directionsPanel {
            width: 100%;
        }

        #ctl00_MainContent_ctl00_MainContent_btnUpdateStatusPanel {
            display: inline !important;
        }

        @media (min-width: 320px) and (max-width: 1024px) {

            .main {
                padding: 10px !important;
            }
        }

        .overflow {
            height: 675px;
            overflow: auto;
        }


        /*Photo Gallery Styles*/
        .galery {
            background-color: grey;
        }

        .DropZone1 {
            width: 100%;
            height: 90px;
            background-color: #357A2B;
            border-color: #CCCCCC;
            float: left;
            text-align: center;
            font-size: 24px;
            color: white;
            margin-bottom: 25px;
        }

        .demo-container .RadAsyncUpload {
            margin-left: 250px;
            margin-bottom: 28px;
        }

        .demo-container .RadUpload .ruUploadProgress {
            width: 230px;
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .demo-container .ruFakeInput {
            width: 200px;
        }

        .btnbox {
            padding-top: 25px;
            text-align: right;
        }

        .imageContainer {
            float: left;
            margin: 5px;
            padding: 2px;
            position: relative;
            background: #eeeeee;
        }

            .imageContainer:hover {
                background-color: #a1da29 !important;
            }

        .buttonsWrapper {
            display: inline-block;
            vertical-align: middle;
        }

        .image {
            cursor: pointer;
            display: block;
        }

        .txt {
            border: 0 !important;
            background: #eeeeee !important;
            color: Black !important;
            margin-left: 25%;
            margin-right: auto;
            width: 100%;
            filter: alpha(opacity=50); /* IE's opacity*/
            opacity: 0.50;
            text-align: center;
        }

        #list {
            max-width: 900px;
        }

        .clearFix {
            clear: both;
        }

        .demo-container {
            max-width: 856px;
        }

        .sliderWrapper {
            float: left;
            display: inline-block;
            margin-bottom: 15px;
        }
        /*End Photo Galery Styles*/

        /*showHidenDiv*/
        .showDiv {
            display: none;
        }
    </style>

    <!-- Hidden values for map -->
    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />
    <asp:HiddenField ID="LocationTextBox" runat="server" />
    <asp:HiddenField ID="LocationNameMap" runat="server" />

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <telerik:RadButton ID="btnDownLoad" RenderMode="Lightweight" runat="server" Skin="Bootstrap" OnClientClicked="exportPDF" Text="Download PDF"
                                    AutoPostBack="false" UseSubmitBehavior="false">
                                </telerik:RadButton>
            </div>
        </div>

        </div>

    <asp:Panel runat="server" ID="containerPage">
    <div class="container MyRecapView" style="width:600px">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
        <!--End Row-->

        <!-- Header Row -->
        <div class="row">
            <div class="col-xs-12 eventDetails">
                <h2>Event Details</h2>

                <%--<ol class="breadcrumb">
                  <li><i class="fa fa-home" aria-hidden="true"></i><a href="/"> Dashboard</a></li>
                  <li><asp:HyperLink ID="ReturnLink1" runat="server" NavigateUrl="/Events/ViewEvents.aspx">Events</asp:HyperLink></li>
                  <li class="active">Event Details</li>
                </ol>--%>

                <%--<a href="/Events/ViewEvents?LoadState=Yes" class="btn btn-default pull-right"><i class="fa fa-chevron-left" aria-hidden="true"></i> Go Back to Events</a>--%>

                <div class="detail">
                    Event Name:
                    <asp:Label ID="EventNameLabel" runat="server" Font-Bold="true" /><br />
                    Date:
                    <asp:Label ID="EventDateLabel" runat="server" Font-Bold="true" /><br />
                    Event ID:
                    <asp:Label ID="EventIDLabel" runat="server" Font-Bold="true" /><br />
                </div>
                <hr />
            </div>
        </div>
        <!-- /row -->

        <!--Event Details Section -->
        <div class="row">
            <div class="col-md-6">
                <h4>Event Details</h4>

                <div class="bs-example">
                    <%--<ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active" runat="server" id="informationTab"><a href="#information" data-toggle="tab">Information</a></li>
                        <li class="" runat="server" id="budgetTab"><a href="#budget" data-toggle="tab">Budget</a></li>
                        <li class="" runat="server" id="notesTab"><a href="#notes" data-toggle="tab">Notes <span class="badge">
                            <asp:Label ID="NoteCountLabel" runat="server" /></span></a></li>
                        <li class="" runat="server" id="logTab"><a href="#log" data-toggle="tab">Log</a></li>

                        <li runat="server" id="EditButtonPanel1" class="danger pull-right"><a href="/Events/EditEvent?EventID=<%= Request.QueryString("ID") %>"><i class="fa fa-pencil"></i>Edit Event</a></li>

                    </ul>--%>


                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="information">
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <!-- Update Status Panel -->
                                    <asp:Panel ID="StatusPanel" runat="server" Visible="false">
                                        <div class="col-md-12">
                                            <div class="alert alert-warning" role="alert">
                                                All positions have been assigned.
                                                <br />
                                                Would you like to update the event status to "Booked"?

                                                    <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CssClass="btn btn-success btn-sm pull-right" />

                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <!-- End Update Status Panel -->

                                    <!-- Event Details -->
                                    <div class="col-md-6">
                                        <div>
                                            <label>Current Status:</label>
                                            <asp:Label ID="StatusLabel" runat="server" Font-Bold="true" />
                                        </div>

                                        <div>
                                            <label>Event Type:</label>
                                            <asp:Label ID="EventTypeLabel" runat="server" />
                                        </div>

                                        <div>
                                            <label>Market:</label>
                                            <asp:Label ID="MarketLabel" runat="server" />
                                        </div>


                                        <div>
                                            <label>Supplier:</label>
                                            <asp:Label ID="SupplierLabel" runat="server" />
                                        </div>


                                    </div>

                                    <div class="col-md-6">

                                        <div>
                                            <label>Event Date:</label>
                                            <asp:Label ID="DateLabel" runat="server" />
                                        </div>

                                        <div>
                                            <label>Start Time:</label>
                                            <asp:Label ID="StartTimeLabel" runat="server" />
                                        </div>

                                        <div>
                                            <label>End Time:</label>
                                            <asp:Label ID="EndTimeLabel" runat="server" />
                                        </div>

                                        <div>
                                            <label>Hours:</label>
                                            <asp:Label ID="HoursLabel" runat="server" />
                                        </div>

                                    </div>

                                    <div class="col-md-12">
                                        <div style="font-weight:bold;">
                                            <label style="font-weight:bold;">Brands:</label>
                                            <asp:Label ID="BrandsLabel" runat="server" />
                                        </div>

                                        <hr />
                                        <div>
                                            <label class="tightlabel">Attire:</label>
                                            <asp:Literal ID="AttireLabel" runat="server"></asp:Literal>

                                        </div>
                                        <br />
                                        <div>
                                            <label>POS:</label>
                                            <asp:Label ID="POSLabel" runat="server" />
                                        </div>
                                        <br />
                                        <div>
                                            <label>Sampling Notes:</label>
                                            <asp:Label ID="SamplingLabel" runat="server" />
                                        </div>
                                        <br />
                                        <div>
                                            <label>Event Description:</label>
                                            <asp:Label ID="DescriptionLabel" runat="server" />
                                        </div>
                                    </div>

                                    <!-- End Event Details -->

                                </div>
                            </div>
                        </div>

                        <%--<div class="tab-pane fade" id="budget">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 300px;">
                                    The budget section is not ready.

                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="tab-pane fade" id="notes">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 300px;">




                                    <asp:Panel runat="server" ID="NotesPanel">

                                        <telerik:RadListView ID="NoteList" runat="server"
                                            DataKeyNames="eventID" DataSourceID="getNotes" InsertItemPosition="FirstItem">
                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr></tr>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr class="rlvI">
                                                    <td>
                                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" CssClass="btn btn-xs btn-default" ToolTip="Edit" OnClick="EditButton_Click"><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="noteLabel" runat="server" Text='<%# Eval("note")%>' />

                                                        <div class="notefooter">
                                                            Created by:
                                                            <asp:Label ID="dateLabel" runat="server" Text='<%# getFullName2(Eval("createdBy"))%>' />
                                                            on
                                                            <asp:Label ID="byLabel" runat="server" Text='<%# Eval("dateCreated", "{0:f}")%>' />
                                                        </div>

                                                    </td>
                                                    <td>
                                                        <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass="btn btn-xs btn-danger" Text="Delete" ToolTip="Delete" OnClick="DeleteButton_Click" OnClientClick="javascript:if(!confirm('This action will delete the note. Are you sure?')){return false;}" /></td>
                                                </tr>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                                <tr class="rlvIEdit">
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("note")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                                                    <td>
                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Update" ToolTip="Update" OnClick="UpdateButton_Click" />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" OnClick="CancelButton_Click" />
                                                    </td>
                                            </EditItemTemplate>

                                            <InsertItemTemplate>
                                                <tr class="rlvIEdit">
                                                    <td></td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("note")%>' CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
                                                    <td>
                                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" OnClick="UpdateButton_Click"  />
                                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" OnClick="CancelButton_Click" />
                                                    </td>
                                            </InsertItemTemplate>


                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr>
                                                                <td colspan="7">
                                                                    <div class="alert alert-warning" role="alert">There are no items to be displayed.  To add a new item click on the <strong>Add New Note</strong> button above.</div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </EmptyDataTemplate>

                                        </telerik:RadListView>


                                        <asp:LinqDataSource ID="getNotes" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                            EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="dateCreated"
                                            TableName="tblEventNotes" Where="eventID == @eventID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                    </asp:Panel>

                                </div>
                            </div>
                        </div>--%>

                        <%--<div class="tab-pane fade" id="log">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 300px;">

                                    <telerik:RadGrid ID="LogList" runat="server" DataSourceID="getEventLog" CellSpacing="-1" GroupPanelPosition="Top" AllowSorting="True" ShowHeader="false">

                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                                        </ClientSettings>

                                        <MasterTableView DataKeyNames="eventLogID" DataSourceID="getEventLog" AutoGenerateColumns="False">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Activity">
                                                    <ItemTemplate>
                                                        <b><%#Eval("activity")%></b><br />
                                                        <%# Eval("detail")%><br />
                                                        By  <%#Common.GetFullName(Eval("createdBy"))%> on <%# Eval("createdDate", "{0:g}")%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>





                                    <asp:LinqDataSource ID="getEventLog" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" OrderBy="createdDate desc" TableName="tblEventLogs" Where="eventID == @eventID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
                                        </WhereParameters>
                                    </asp:LinqDataSource>

                                </div>
                            </div>
                        </div>--%>

                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <h4>Account/Location</h4>

                <div class="bs-example">

                    <%--<ul id="accountTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li id="tab1" class="active"><a href="#address" data-toggle="tab">Address</a></li>
                        <li id="tab2" class=""><a href="#address" data-toggle="tab">Directions</a></li>
                        <li class=""><a href="#weather" data-toggle="tab">Weather</a></li>
                    </ul>--%>



                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="address">
                            <div class="widget stacked">
                                <div class="widget-content">
                                    <div style="margin-bottom: 10px;">
                                        <div>
                                            <asp:HyperLink ID="AccountHyperLink1" runat="server">
                                                <asp:Label ID="AccountNameLabel1" Font-Bold="true" Font-Size="Large" runat="server" />
                                            </asp:HyperLink>
                                        </div>
                                        <div>
                                            <asp:Label ID="AccountAddressLabel1" runat="server" />
                                        </div>
                                    </div>

                                    <%--<asp:Panel ID="DirectionsPanel" runat="server">
                                        <div id="direct" style="margin-bottom: 10px; display: none;">
                                            <div class="panel panel-default">
                                                <div class="panel-body">


                                                    <asp:Panel ID="SelectedAmbassadorPanel" runat="server">
                                                        Select an Ambassador
                                             <div class="row">
                                                 <div class="col-md-6">
                                                     <asp:DropDownList ID="SelectedDirectionsName" runat="server" CssClass="form-control" DataSourceID="getAmbassadorList" DataTextField="fullName" DataValueField="fullAddress" Width="300px">
                                                     </asp:DropDownList>
                                                 </div>
                                                 <div class="col-md-6 pull-right">
                                                     <input type="button" value="Get Directions" onclick="createDirections();" class="btn btn-default btn-sm" />

                                                 </div>

                                             </div>
                                                    </asp:Panel>




                                                    <asp:Panel ID="EnterAddressPanel" runat="server">
                                                        enter a starting address:
                                             <asp:TextBox ID="txtFromAddress" runat="server" CssClass="form-control input-sm" />
                                                        <div style="margin-top: 5px;">
                                                            <input type="button" value="Get Directions" onclick="createDirectionsByAddress();" class="btn btn-default btn-sm" />

                                                        </div>

                                                    </asp:Panel>

                                                </div>
                                            </div>

                                        </div>
                                    </asp:Panel>--%>

                                    <%--<div style="margin-bottom: 10px;">
                                        <input type="button" id="showTraffic" value="Show Traffic" onclick="MapTraffic()" class="btn btn-xs btn-secondary" /><input type="button" id="hideTraffic" value="Hide Traffic" onclick="    hideTrafficLayer()" class="btn btn-xs btn-secondary" style="display: none" />
                                    </div>--%>


                                    <div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>
                                   <%-- <div style="width: 100%" id="printoutPanel"></div>
                                    <div id="printoutPanelGas"></div>
                                    <div id="printoutPanelGrocery"></div>
                                    <div id="printoutPanelConvenience"></div>
                                    <div id='sdsPageResultsHeader' style="display: none;">
                                        <div id='pageResultsButtons'>
                                            <input type='button' value='<' onclick='pageBackwards();' />
                                            <input type='button' value='>' onclick='pageForward();' />
                                        </div>
                                        <div id='pageInfo' style="display: none;"></div>
                                    </div>--%>


                                    <%--<div style="margin-top: 5px;">

                                        <label>Show Helpful Locations:</label><br />
                                        <div class="btn-group pull-left gridbuttons" role="group" aria-label="...">

                                            <input type="button" id="btnFindGroceryStoresLink" value="Grocery Stores" onclick="GetGroceryStores()" class="btn btn-default" />
                                            <input type="button" id="btnFindConvienienceStoresLink" value="Convenience Stores" onclick="GetConvenienceStores()" class="btn btn-default" />
                                            <input type="button" id="btnFindGasStationsLink" value="Gas Stations" onclick="GetGasStations()" class="btn btn-default" />

                                        </div>


                                        <div class="btn-group pull-right gridbuttons" role="group" aria-label="...">
                                            <input type="button" id="btnFindPartyStoresLink" value="Clear Locations" onclick="ClearMap()" class="btn btn-default" />
                                        </div>



                                    </div>--%>



                                </div>
                            </div>


                        </div>


                        <%--<div class="tab-pane fade" id="weather">
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div style="margin-bottom: 5px;">
                                        <div>
                                            <asp:Label ID="CityLabel" Font-Bold="true" Font-Size="X-Large" runat="server" />
                                        </div>

                                    </div>

                                    <asp:Panel ID="WeatherForcastPanel" runat="server">

                                        <!-- Today -->
                                        <div class="row weatherwrapper">
                                            <div class="col-xs-2 datebox">
                                                <asp:Label ID="lblDay0" runat="server" />
                                                <div class="monthlabel">
                                                    <asp:Label ID="lblMonth0" runat="server" />
                                                </div>

                                            </div>
                                            <div class="col-xs-4 col2">
                                                <div class="daylabel">Today</div>
                                                <div class="templabel">
                                                    Low:
                                                <asp:Label ID="lblTempMin0" runat="server" />
                                                </div>
                                                <div class="templabel">
                                                    High:
                                                <asp:Label ID="lblTempMax0" runat="server" />
                                                </div>

                                            </div>
                                            <div class="col-xs-4 col3">
                                                <asp:Image ID="imgWeatherIcon0" runat="server" Width="60px" />
                                                <div>
                                                    <asp:Label ID="lblMain0" runat="server" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Tomorrow -->
                                        <div class="row weatherwrapper">
                                            <div class="col-xs-2 datebox">
                                                <asp:Label ID="lblDay1" runat="server" />
                                                <div class="monthlabel">
                                                    <asp:Label ID="lblMonth1" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-xs-4 col2">
                                                <div class="daylabel">Tomorrow</div>
                                                <div class="templabel">
                                                    Low:
                                                <asp:Label ID="lblTempMin1" runat="server" />
                                                </div>
                                                <div class="templabel">
                                                    High:
                                                <asp:Label ID="lblTempMax1" runat="server" />
                                                </div>

                                            </div>
                                            <div class="col-xs-4 col3">
                                                <asp:Image ID="imgWeatherIcon1" runat="server" Width="60px" />
                                                <div>
                                                    <asp:Label ID="lblMain1" runat="server" />
                                                </div>
                                            </div>
                                        </div>


                                        <!-- Next Day -->
                                        <div class="row weatherwrapper">
                                            <div class="col-xs-2 datebox">
                                                <asp:Label ID="lblDay2" runat="server" />
                                                <div class="monthlabel">
                                                    <asp:Label ID="lblMonth2" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-xs-4 col2">
                                                <div class="daylabel">
                                                    <asp:Label ID="lblDayName2" runat="server" />
                                                </div>
                                                <div class="templabel">
                                                    Low:
                                                <asp:Label ID="lblTempMin2" runat="server" />
                                                </div>
                                                <div class="templabel">
                                                    High:
                                                <asp:Label ID="lblTempMax2" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-xs-4 col3">
                                                <asp:Image ID="imgWeatherIcon2" runat="server" Width="60px" />
                                                <div>
                                                    <asp:Label ID="lblMain2" runat="server" />
                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>

                                    <asp:Panel ID="WeatherHistoryPanel" runat="server">

                                        <div>

                                            <div class="row weatherwrapper">
                                                <div class="col-xs-2 datebox">
                                                    <asp:Label ID="Label3" runat="server" />
                                                    <div class="monthlabel">
                                                        <asp:Label ID="Label4" runat="server" />
                                                    </div>

                                                </div>
                                                <div class="col-xs-4 col2">
                                                    <div class="daylabel">Today</div>
                                                    <div class="templabel">
                                                        Low:
                                                <asp:Label ID="lblTempMin3" runat="server" />
                                                    </div>
                                                    <div class="templabel">
                                                        High:
                                                <asp:Label ID="lblTempMax3" runat="server" />
                                                    </div>

                                                </div>
                                                <div class="col-xs-4 col3">
                                                    <asp:Image ID="Image1" runat="server" Width="60px" />
                                                    <div>
                                                        <asp:Label ID="Condition9" runat="server" />
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </asp:Panel>

                                    <asp:Panel ID="InsertWeatherPanel" runat="server" Visible="false">


                                        <div class="form-horizontal">



                                            <div class="form-group">
                                                <label for="lowTempTextBox" class="col-sm-2 control-label">Low Temp</label>
                                                <div class="col-sm-5">
                                                    <asp:TextBox ID="lowTempTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="highTempTextBox" class="col-sm-2 control-label">High Temp</label>
                                                <div class="col-sm-5">
                                                    <asp:TextBox ID="highTempTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="conditionTextBox" class="col-sm-2 control-label">Condition</label>
                                                <div class="col-sm-5">
                                                    <asp:DropDownList ID="conditionList" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Clouds" Value="04d.png"></asp:ListItem>
                                                        <asp:ListItem Text="Rain" Value="10d.png"></asp:ListItem>
                                                        <asp:ListItem Text="Clear" Value="01d.png"></asp:ListItem>
                                                    </asp:DropDownList>


                                                </div>
                                            </div>



                                            <div class="form-group">
                                                <div class="col-sm-offset-2 col-sm-10">
                                                    <asp:Button ID="btnSubmitWeather" runat="server" Text="Submit" CssClass="btn btn-success" />
                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>


                                </div>
                            </div>
                        </div>--%>

                    </div>
                </div>
            </div>

        </div>


        <!-- Staffing Section -->
        <div id="staffingPanel" runat="server" class="row pageBreak">
            <div class="col-md-12">
                <h4>Staffing</h4>


                <asp:Panel runat="server" ID="StaffingPnel1">
                    <%--<telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="false" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="Status" runat="server" ID="statusTab"></telerik:RadTab>
                            <telerik:RadTab Text="Assign BA" runat="server" ID="assignTab"></telerik:RadTab>
                            <telerik:RadTab Text="Requirements" runat="server" ID="requirementsTab"></telerik:RadTab>
                            <telerik:RadTab Text="Payroll/Expenses" runat="server" ID="payrollTab"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>--%>

                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" RenderSelectedPageOnly="false">
                        <telerik:RadPageView runat="server" ID="RadPageView1">
                            <!-- Status Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div class="col-md-12">
                                        <label class="greenlabel pull-right">
                                            Positions Staffed:
                                <asp:Label ID="positionsStaffedCountLabel" runat="server" /></label>
                                        <label class="redlabel pull-right">
                                            Positions Available:
                                <asp:Label ID="positionsAvailableCountLabel" runat="server" /></label>
                                    </div>

                                    <asp:Repeater ID="StaffingList" runat="server" DataSourceID="GetEventStaff2">
                                        <HeaderTemplate>
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <th class="hidden-xs"></th>
                                                        <th>Name</th>
                                                        <th>Position</th>
                                                        <th>Start Time</th>
                                                        <th>End Time</th>
                                                        <th class="hidden-xs">Check-in Time</th>
                                                        <th class="hidden-xs">Check-in Confirmed</th>
                                                    </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td class="hidden-xs">
                                                    <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" GenerateEmptyAlternateText="true" AlternateText="Click to view larger image"
                                                        DataValue='<%# IIf(Eval("headShot") IsNot DBNull.Value, Eval("headShot"), New System.Byte(-1) {})%>'
                                                        AutoAdjustImageControlSize="false" Width="80px" ToolTip='<%#getFullName(Eval("assignedUserName")) %>'
                                                        CssClass="thumbnail" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' Visible='<%# setImage(Eval("userID")) %>' />
                                                </td>

                                                <td>
                                                    <asp:Label ID="HiddenUserID" runat="server" Text='<%# getUserID(Eval("assignedUserName")) %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="AssignedNameLabel" runat="server" Text='<%# getFullName(Eval("assignedUserName")) %>'></asp:Label>
                                                    <asp:HyperLink ID="AssignedNameLink" runat="server"><%# getFullName(Eval("assignedUserName")) %></asp:HyperLink>
                                                </td>
                                                <td><%# Eval("positionTitle") %></td>
                                                <td><%# Eval("startTime", "{0:t}") %></td>
                                                <td><%# Eval("endTime", "{0:t}") %></td>
                                                <td class="hidden-xs"><%# Eval("checkInTime", "{0:t}") %></td>
                                                <td class="hidden-xs"></td>

                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </tbody>
            </table>

                             <asp:Label ID="lblEmptyData"
                                 Text='<%# Common.ShowAlertNoClose("warning", "<strong>No Staffing Requirements Entered.</strong> Click on the Requirements tab above to begin entering staffing requirements for this event.")%>' runat="server" Visible="false">
                             </asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>

                                    <asp:SqlDataSource ID="GetEventStaff2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="pr_qryEventStaffingStatus" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </div>
                        </telerik:RadPageView>

                        <%--<telerik:RadPageView runat="server" ID="RadPageView2">
                            <!-- Assign BA Selection Tab -->

                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div class="col-md-12">
                                        <label class="greenlabel pull-right">
                                            Positions Staffed:
                                <asp:Label ID="positionsStaffedCountLabel2" runat="server" /></label>
                                        <label class="redlabel pull-right">
                                            Positions Available:
                                <asp:Label ID="positionsAvailableCountLabel2" runat="server" /></label>
                                    </div>

                                    <link href="/events/css/RequiredPositions1.css" rel="stylesheet" />

                                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

                                        <script type="text/javascript">
                                            var resultsPanel;
                                            Sys.Application.add_load(function myfunction() {
                                                resultsPanel = $get("<%= ResultsPanel.ClientID %>");
                            })

                                        </script>
                                    </telerik:RadCodeBlock>

                                    <style>
                                        .marginbottom5 {
                                            margin-bottom: 5px;
                                        }
                                    </style>

                                    <script src="/events/js/RequiredPositions.js"></script>


                                    <h4>Event Date:
                            <asp:Label ID="Label2" runat="server" />
                        - Event Start:
                            <asp:Label ID="Label3" runat="server" />
                        - Event End:
                            <asp:Label ID="Label4" runat="server" /></h4>

                                    <p>
                                        Total Staffing Spend:
                        <asp:Label ID="TotalSpendLabel" runat="server" Font-Bold="true" />
                                    </p>
                                    <p>
                                        Total Staff Results:
                        <asp:Label ID="StaffCountLabel" runat="server" />
                                    </p>





                                    <div class="col-md-6">

                                        <div class="row">
                                            <div class="col-md-12" style="margin-bottom: 10px;">

                                                <div class="filterWrapper">
                                                    <div class="filterDropDown">

                                                        <asp:Panel ID="LookupPanel" runat="server" Width="400px">
                                                            <div class="input-group">
                                                                <asp:TextBox ID="txtSearchBox" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>

                                                                <telerik:RadComboBox ID="LookupAmbassadorText" runat="server" DataSourceID="getAvailableAmbassadorNameList" DataTextField="FullName" AllowCustomText="true" MarkFirstMatch="true"
                                                                    DataValueField="userName" Height="200px" Width="280px" LoadingMessage="Searching..." EmptyMessage="Ambassador Name" AutoPostBack="true">
                                                                </telerik:RadComboBox>

                                                                <asp:SqlDataSource runat="server"></asp:SqlDataSource>

                                                                 <span class="input-group-btn">






              <asp:LinkButton ID="btnSearchAmbassador" runat="server" CssClass="btn btn-success">Lookup</asp:LinkButton>
          </span>
                                                                <span class="pull-right">
                                                                    <asp:LinkButton ID="btnClearFiltersAmbassador" runat="server" CssClass="btn btn-default"><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</asp:LinkButton>
                                                                </span>
                                                            </div>
                                                            <!-- /input-group -->
                                                        </asp:Panel>

                                                    </div>

                                                </div>

                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">

                                                <div id="trackContainer">

                                                    <asp:Label ID="trackErrorLabel" runat="server" ForeColor="Red" />

                                                    <telerik:RadListView ID="AvailableAmbassadorList" runat="server" Skin="Silk" DataSourceID="getAvailableAmbassadorList" DataKeyNames="userName,FirstName,LastName"
                                                        ClientDataKeyNames="userName,FirstName,LastName" OnItemDrop="AvailableAmbassadorList_ItemDrop" ItemPlaceholderID="TrackContainer" AllowPaging="True" PageSize="25">

                                                        <ClientSettings AllowItemsDragDrop="true">

                                                            <ClientEvents OnItemDragStarted="itemDragStarted" OnItemDragging="itemDragging" OnItemDropping="trackDropping"></ClientEvents>

                                                        </ClientSettings>



                                                        <LayoutTemplate>
                                                            <div class="RadListView RadListView_Silk overflow" style="padding-right: 15px;">
                                                                <asp:PlaceHolder ID="TrackContainer" runat="server"></asp:PlaceHolder>
                                                            </div>

                                                            <div class="pagerWrapper" id="studentsPager">

                                                                <div class="demoPager">

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnFirst"
                                                                        CommandName="Page" CommandArgument="First" Text="First"
                                                                        Enabled="<%#Container.CurrentPageIndex > 0 %>" OnClick="btnFirst_Click">
                                                                    </telerik:RadButton>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnPrev" CommandName="Page" CommandArgument="Prev"
                                                                        Text="Prev" Enabled="<%#Container.CurrentPageIndex > 0 %>" OnClick="btnPrev_Click">
                                                                    </telerik:RadButton>

                                                                    <span class="numericPageSize">Page

                                        <%#Container.CurrentPageIndex + 1 %>

                                        of

                                        <%#Container.PageCount %></span>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnNext" CommandName="Page" CommandArgument="Next"
                                                                        Text="Next" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>" OnClick="btnNext_Click">
                                                                    </telerik:RadButton>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnLast" CommandName="Page" CommandArgument="Last"
                                                                        Text="Last" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>" OnClick="btnLast_Click">
                                                                    </telerik:RadButton>

                                                                </div>

                                                                <div>

                                                                    <span class="pageSize">Page Size:</span>

                                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cmbPageSize" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" AutoPostBack="true" Width="60px"
                                                                        SelectedValue="<%#Container.PageSize %>">

                                                                        <Items>

                                                                            <telerik:RadComboBoxItem Text="10" Value="10"></telerik:RadComboBoxItem>

                                                                            <telerik:RadComboBoxItem Text="25" Value="25"></telerik:RadComboBoxItem>

                                                                            <telerik:RadComboBoxItem Text="50" Value="50"></telerik:RadComboBoxItem>

                                                                            <telerik:RadComboBoxItem Text="100" Value="100"></telerik:RadComboBoxItem>

                                                                        </Items>

                                                                    </telerik:RadComboBox>

                                                                </div>
                                                            </div>


                                                        </LayoutTemplate>

                                                        <ItemTemplate>

                                                            <div class="track rlvI">
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <div class="col-md-2">
                                                                            <div class="row">
                                                                                <div class="col-md-12" draggable="true">
                                                                                    <div class="col-md-5">
                                                                                        <telerik:RadListViewItemDragHandle ID="RadListViewItemDragHandle1" runat="server" ToolTip="Drag to schedule"></telerik:RadListViewItemDragHandle>
                                                                                    </div>

                                                                                    <div class="col-md-7" draggable="false">
                                                                                        <telerik:RadBinaryImage ID="RadBinaryImage2" runat="server" draggable="false"
                                                                                            GenerateEmptyAlternateText="true" AlternateText="Click to view larger image"
                                                                                            DataValue='<%# IIf(Eval("headshot") IsNot DBNull.Value, Eval("headshot"), New System.Byte(-1) {})%>'
                                                                                            AutoAdjustImageControlSize="false" Width="70px" Height="80px" CssClass="thumbnail" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <!-- end row -->

                                                                        </div>

                                                                        <div class="col-md-10">

                                                                            <div class="col-md-6">
                                                                                <a id="ambassadorlink" draggable="false" target="_blank" href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID") %>'><span style="font-size: medium; font-weight: 400; color: black">
                                                                                    <header><%# Eval("FirstName") %>  <%# Eval("LastName") %></header>
                                                                                </span>
                                                                                </a>
                                                                                <i class="fa fa-envelope" aria-hidden="true"></i><a href='mailto:<%# Eval("EmailAddress") %> '><%# Eval("EmailAddress") %></a><br />

                                                                                <i class="fa fa-phone-square" aria-hidden="true"></i><%# Common.FormatPhoneNumber(Eval("Phone").ToString()) %>
                                                                            </div>
                                                                            <div class="col-md-2"><%# Eval("City")%></div>
                                                                            <div class="col-md-2"><%# Eval("State") %></div>
                                                                            <div class="col-md-2" style="padding: 5px;">
                                                                                <a href="#" class="trigger btn btn-sm btn-default">More Details</a>


                                                                            </div>



                                                                            <div class="col-md-12" style="padding-top: 10px;">
                                                                                <asp:Label ID="milesLabel" runat="server" />
                                                                                <%# Eval("miles") %> miles from Event Location <a href='/Events/BrandAmbassadorsDetails.aspx?userID=<%# Eval("UserID") %>&ID=<%=Request.QueryString("ID") %>' onclick="window.open(this.href, '', 'width=600,height=600,toolbar=0,resizable=0'); return false;">(View Map)</a>
                                                                            </div>

                                                                            <div class="col-md-12">
                                                                                <asp:Label ID="ConflictLabel" runat="server" Text='<%# checkSchedule(Eval("UserID")) %>' />
                                                                            </div>

                                                                            <div class="col-md-12">
                                                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Requested") %>' />
                                                                            </div>


                                                                        </div>



                                                                        <table style="width: 100%">

                                                                            <tr>
                                                                                <td>
                                                                                    <div class="showDiv" style="padding-left: 0px; padding-top: 10px;">

                                                                                          <hr />

                                                                                        <div class="col-md-4" style="padding-top: 0px;">
                                                                                            <h4><span class="label label-success"><i class="fa fa-trophy" aria-hidden="true"></i>BARetc Ambassador</span></h4>

                                                                                            <div class="panel panel-default">
                                                                                                <div class="panel-body">
                                                                                                    Events Participated <span class="badge pull-right">0</span><br />
                                                                                                    Total Hours TYD <span class="badge pull-right">0</span><br />
                                                                                                     Total Pay YTD  <span class="badge pull-right">$0.00</span><br />
                                                                                                </div>
                                                                                            </div>





                                                                                        </div>
                                                                                        <div class="col-md-8" style="padding-top: 0px;">

                                                                                            <div class="panel panel-default">
                                                                                                <div class="panel-body">

                                                                                                    <div class="row">
                                                                                                        <div class="form-group">
                                                                                                            <label for="TrainingTextBox" class="col-sm-2">Training:</label>
                                                                                                            <div class="col-sm-10">
                                                                                                                <asp:Label ID="Label8" runat="server" Text='<%# getTrainingResults(Eval("UserID")) %>' />
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div class="row">
                                                                                                        <div class="form-group">
                                                                                                            <label for="MarketsTextBox" class="col-sm-2">Markets:</label>
                                                                                                            <div class="col-sm-10">
                                                                                                                <asp:Label ID="marketNameLabel" runat="server" Text='<%# Eval("Markets") %>'></asp:Label>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="row">
                                                                                                        <div class="form-group">
                                                                                                            <label for="PositionsTextBox" class="col-sm-2">Positions:</label>
                                                                                                            <div class="col-sm-10">
                                                                                                                <asp:Label ID="AmabassadorPositionLabel" runat="server" Text='<%# Eval("Positions") %>'></asp:Label>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                        </div>

                                                                                    </div>
                                                                                </td>
                                                                            </tr>

                                                                        </table>

                                                                    </div>
                                                                </div>




                                                            </div>


                                                        </ItemTemplate>


                                                        <EmptyDataTemplate>

                                                            <div class="noTracks">
                                                                There are no results to show

                                                            </div>

                                                        </EmptyDataTemplate>

                                                    </telerik:RadListView>



                                                </div>


                                            </div>
                                        </div>

                                        <asp:HiddenField ID="HF_ClientID" runat="server" />
                                        <asp:HiddenField ID="HF_MarketID" runat="server" />
                                        <asp:HiddenField ID="HF_PositionID" runat="server" />
                                        <asp:HiddenField ID="HF_Latitude" runat="server" />
                                        <asp:HiddenField ID="HF_Longtitude" runat="server" />


                                        <asp:SqlDataSource ID="getAvailableAmbassadorList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableAmbassador" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="HF_Latitude" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_Longtitude" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <asp:SqlDataSource ID="getAvailableAmbassadorNameList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getAvailableAmbassadorNameList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="HF_Latitude" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_Longtitude" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <br />
                                    </div>

                                    <div class="col-md-6">
                                        <div class="row">
                                            <div class="col-md-12" style="margin-bottom: 10px;">
                                                <asp:Label ID="msgLabel1" runat="server" Text=""></asp:Label>
                                                <div class="btn-group pull-right" role="group" aria-label="...">
                                                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-sm btn-primary" />
                                                    <asp:Button ID="btnCancelChanges" runat="server" Text="Cancel" CssClass="btn btn-sm btn-default" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row overflow">

                                            <div id="" class="col-md-12">

                                                <asp:Repeater ID="PositionList" runat="server" DataSourceID="getEventPositions">
                                                    <HeaderTemplate>
                                                        <div id="div1">
                                                    </HeaderTemplate>

                                                    <ItemTemplate>

                                                        <!-- Item Template with the drop ambassador feature  -->

                                                        <div class="widget stacked ">
                                                            <div class="widget-content">

                                                                <div id="" class="bag">
                                                                    <h4>
                                                                        <asp:Label ID="TitleLabel" runat="server" Text='<%# getPositionName(Eval("positionID"))%>'></asp:Label></h4>

                                                                    <!-- assigned panel -->
                                                                    <asp:Panel ID="AssignedPanel" runat="server" Visible='<%# getAssigned(Eval("assigned")) %>'>



                                                                        <h4><span class="label label-success pull-left" style="margin-right: 15px;"><%# getFullName(Eval("assignedUserName")) %></span></h4>

                                                                        <asp:LinkButton ID="btnRemoveAssigned" runat="server"
                                                                            CommandName="Remove" CommandArgument='<%# Eval("RequirementID") %>' CssClass="btn btn-xs btn-warning marginbottom5"
                                                                            OnClientClick="javascript:if(!confirm('This action will delete the assigned ambassador from this event. Are you sure?')){return false;}"><i class="fa fa-times"></i> Remove</asp:LinkButton>

                                                                        <span style="font-size: 14px" class="label label-success pull-right">Staffed</span>
                                                                    </asp:Panel>
                                                                    <!-- /end assigned panel -->


                                                                    <!-- NOT assigned panel -->
                                                                    <asp:Panel ID="NotAssignedPanel" runat="server" Visible='<%# getNotAssigned(Eval("assigned")) %>'>
                                                                        <div id="genreContainer">

                                                                            <asp:LinkButton ID="GenreLink" runat="server" CommandName="ShowTracks" CommandArgument='<%# Eval("RequirementID") %>'
                                                                                onmouseover='this.className += " selected";' onmouseout='this.className = this.className.split(" selected").join("");'>
                                           Unassigned (drag an ambassador from the left)
                                                                            </asp:LinkButton>



                                                                        </div>
                                                                        <div style="padding: 5px 0 5px 0; margin-bottom: 10px;">
                                                                            <span style="font-size: 14px; margin-bottom: 10px;" class="label label-danger pull-right">Available</span>
                                                                        </div>
                                                                    </asp:Panel>
                                                                    <!-- /end NOT assigned panel -->

                                                                    <table style="width: 100%" class="table">
                                                                        <tr>
                                                                            <th>Start Time</th>
                                                                            <th>End Time</th>
                                                                            <th>Rate</th>
                                                                            <th>Total Pay</th>
                                                                        </tr>

                                                                        <tr>

                                                                            <td>
                                                                                <telerik:RadDateTimePicker ID="startTimeRadTimePicker" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap" Width="220px"></telerik:RadDateTimePicker>
                                                                            </td>
                                                                            <td>
                                                                                <telerik:RadDateTimePicker ID="endTimeRadTimePicker" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap" Width="220px"></telerik:RadDateTimePicker>
                                                                            </td>
                                                                            <td>

                                                                                <telerik:RadNumericTextBox ID="RateTextBox" runat="server" NumberFormat-DecimalDigits="2" Culture="en-US" DbValueFactor="1" Type="Currency" Width="100px" ShowSpinButtons="true" DbValue='<%# Bind("rate") %>' DisplayText='<%# Bind("rate", "{0:C}") %>'>
                                                                                    <NumberFormat DecimalDigits="2" ZeroPattern="$n"></NumberFormat>
                                                                                </telerik:RadNumericTextBox>

                                                                            </td>
                                                                            <td style="padding-top: 15px"><strong>
                                                                                <asp:Label ID="TotalLabel" runat="server" Text='<%# getTotalPay(Eval("RequirementID"))%>'></asp:Label>
                                                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("RequirementID") %>' />
                                                                            </strong></td>

                                                                        </tr>
                                                                    </table>

                                                                    <asp:CompareValidator ID="dateCompareValidator" runat="server" ControlToValidate="endTimeRadTimePicker"
                                                                        ValidationGroup="eventdate" CssClass="errorlabel"
                                                                        ControlToCompare="startTimeRadTimePicker" Operator="GreaterThan" Type="String" ErrorMessage="The end date must be after the start date." />

                                                                </div>
                                                            </div>
                                                        </div>

                                                    </ItemTemplate>

                                                    <FooterTemplate>
                                                        </div>

                                                    </FooterTemplate>
                                                </asp:Repeater>

                                            </div>
                                        </div>


                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="assigned" TableName="tblEventStaffingRequirements" Where="eventID == @eventID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>
                                    </div>

                                    <div class="clearFix"></div>


                                    <asp:Panel ID="ResultsPanel" runat="server" CssClass="result">
                                    </asp:Panel>

                                </div>
                            </div>
                            <!-- End of Assign BA Selection Tab -->
                        </telerik:RadPageView>--%>


                        <%--<telerik:RadPageView runat="server" ID="RadPageView3">
                            <!-- Requirements Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div class="col-md-12">
                                        <label class="greenlabel pull-right">
                                            Positions Staffed:
                                <asp:Label ID="positionsStaffedCountLabel3" runat="server" /></label>
                                        <label class="redlabel pull-right">
                                            Positions Available:
                                <asp:Label ID="positionsAvailableCountLabel3" runat="server" /></label>
                                    </div>


                                    <telerik:RadListView ID="BrandPositionList" runat="server"
                                        DataKeyNames="RequirementID" DataSourceID="getEventPositions" InsertItemPosition="FirstItem">
                                        <LayoutTemplate>
                                            <div class="RadListView RadListView_Default">
                                                <table class="table" cellspacing="0" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Position</th>
                                                            <th>Start Time</th>
                                                            <th>End Time</th>
                                                            <th>&nbsp;</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr id="itemPlaceholder" runat="server">
                                                        </tr>
                                                    </tbody>
                                                    <tfoot>
                                                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                            CssClass="btn btn-xs btn-success pull-right" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Position</asp:LinkButton>
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr class="rlvI">

                                                <td>
                                                    <asp:Label ID="staffingPositionIDLabel" runat="server" Text='<%# getPositionName(Eval("positionID"))%>' />
                                                </td>
                                                <td>
                                                    <asp:Label ID="startTimeOffSetLabel" runat="server" Text='<%# Eval("startTime", "{0:t}")%>' />
                                                </td>
                                                <td>
                                                    <asp:Label ID="endTimeOffSetLabel" runat="server" Text='<%# Eval("endTime", "{0:t}")%>' />
                                                </td>
                                                <td>
                                                    <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass='<%# getButtonCssClass(Eval("RequirementID")) %>' Text='<%# getButtonText(Eval("RequirementID")) %>' ToolTip="Delete" Enabled='<%# getButtonEnabled(Eval("RequirementID")) %>' />
                                                </td>
                                            </tr>
                                        </ItemTemplate>

                                        <EditItemTemplate>
                                            <tr class="rlvIEdit">

                                                <td>
                                                    <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-med" SelectedValue='<%# Bind("positionID")%>'
                                                        DataTextField="positionTitle" DataValueField="staffingPositionID">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <telerik:RadDateTimePicker ID="RadTimePicker1" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadDateTimePicker>
                                                </td>
                                                <td>
                                                    <telerik:RadDateTimePicker ID="RadTimePicker2" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap"></telerik:RadDateTimePicker>
                                                </td>
                                                <td>
                                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Update" />
                                                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
                                                </td>

                                            </tr>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <tr class="rlvIEdit">


                                                <td>
                                                    <asp:DropDownList ID="ddlStaffingPositionID" runat="server" DataSourceID="getPositionList" CssClass="form-control input-med"
                                                        SelectedValue='<%# Bind("positionID")%>'
                                                        DataTextField="positionTitle" DataValueField="staffingPositionID">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>

                                                    <telerik:RadDateTimePicker ID="RadTimePicker12" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap" Width="220px"></telerik:RadDateTimePicker>

                                                </td>
                                                <td>
                                                    <telerik:RadDateTimePicker ID="RadTimePicker22" runat="server" DbSelectedDate='<%# Bind("endTime") %>' Skin="Bootstrap" Width="220px" Culture="en-US"></telerik:RadDateTimePicker>

                                                </td>
                                                <td>
                                                    <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                                                    <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" OnClick="CancelButton_Click" />
                                                </td>


                                            </tr>
                                        </InsertItemTemplate>
                                        <EmptyDataTemplate>
                                            <div class="RadListView RadListView_Default">
                                                <table class="table" cellspacing="0" style="width: 100%;">
                                                    <thead>
                                                        <tr>
                                                            <th>Position</th>
                                                            <th>Start Time</th>
                                                            <th>End Time</th>
                                                            <th>&nbsp;</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="5">
                                                                <div class="alert alert-warning" role="alert">
                                                                    There are no open positions.  To add a new position click on the "Add New Position" button above.
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                    <tfoot>
                                                        <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                            CssClass="btn btn-xs btn-success pull-right" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Position</asp:LinkButton>
                                                    </tfoot>
                                                </table>


                                            </div>
                                        </EmptyDataTemplate>

                                    </telerik:RadListView>

                                    <asp:Label ID="Label5" runat="server" />

                                    <asp:LinqDataSource ID="getEventPositions" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                        EnableDelete="True" EnableInsert="True" EnableUpdate="True"
                                        EntityTypeName="" TableName="tblEventStaffingRequirements" Where="eventID == @eventID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="Int32" />
                                        </WhereParameters>
                                    </asp:LinqDataSource>

                                    <asp:LinqDataSource ID="getPositionList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                        EntityTypeName="" OrderBy="positionTitle" TableName="tblStaffingPositions">
                                    </asp:LinqDataSource>



                                </div>
                            </div>

                        </telerik:RadPageView>--%>

                        <%--<telerik:RadPageView runat="server" ID="RadPageView4">
                            <!-- Payroll Expenses Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <asp:Panel ID="PayrollPanel" runat="server">
                                        <telerik:RadListView ID="PayrollList" runat="server" DataSourceID="getPayrolSummary" DataKeyNames="RequirementID">
                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>

                                                                <th>Payee Name</th>
                                                                <th>Position</th>
                                                                <th>Status</th>
                                                                <th>Payment Date</th>
                                                                <th>Hours</th>
                                                                <th>Rate</th>
                                                                <th>Total Labor</th>
                                                                <th>Expenses/Adjustments</th>
                                                                <th>Amount</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr class="rlvI">

                                                    <td><%# Eval("FullName") %></td>
                                                    <td><%# Eval("positionTitle") %></td>
                                                    <td><%# Eval("paymentStatus") %></td>
                                                    <td><%# Eval("paymentDate", "{0:d}") %></td>
                                                    <td><%# Eval("hours") %></td>
                                                    <td><%# Eval("rate", "{0:C}") %></td>
                                                    <td><%# Eval("Total", "{0:C}") %></td>
                                                    <td><%# Eval("expenses", "{0:C}") %></td>
                                                    <td><strong><%# Eval("TotalAmount", "{0:C}") %></strong></td>
                                                </tr>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                            </EditItemTemplate>

                                            <EmptyDataTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>Payee Name</th>
                                                                <th>Position</th>
                                                                <th>Status</th>
                                                                <th>Payment Date</th>
                                                                <th>Hours</th>
                                                                <th>Rate</th>
                                                                <th>Total Labor</th>
                                                                <th>Expenses/Adjustments</th>
                                                                <th>Amount</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="5">
                                                                    <div class="alert alert-warning" role="alert">There are no ambassadors currently assigned to this event.</div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        </tfoot>
                                                    </table>


                                                </div>
                                            </EmptyDataTemplate>
                                        </telerik:RadListView>
                                    </asp:Panel>

                                    <asp:Panel ID="ExpensePanel" runat="server">

                                        <telerik:RadListView ID="ExpenseList" runat="server" DataSourceID="getExpenses" DataKeyNames="eventExpenseID">
                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th></th>
                                                                <th>Expense/Adjustment</th>
                                                                <th>Type</th>
                                                                <th>Expense By</th>
                                                                <th>Amount</th>
                                                                <th>Receipt</th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsertExpense" runat="server" Visible="<%# Not Container.IsItemInserted %>"
                                                                CssClass="btn btn-xs btn-success pull-right" OnClick="btnInsertExpense_Click"><i class="fa fa-plus"></i>  Add New Expense</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnEditExpense" runat="server" CssClass="btn btn-sm btn-default" CommandName="EditExpense" CommandArgument='<%# Eval("eventExpenseID")%>'><i class="fa fa-pencil"></i> Edit</asp:LinkButton>
                                                    </td>
                                                    <td><%# Eval("description") %></td>
                                                    <td><%# Eval("expenseType") %></td>
                                                    <td><%# Eval("expenseBy") %></td>
                                                    <td><%# Eval("amount", "{0:C}") %></td>

                                                    <td>
                                                        <asp:Label ID="btnViewReciept" runat="server" Text="View Receipt" CssClass="btn btn-sm btn-default" OnClick='<%#CreateReceiptScript(Eval("eventExpenseID"))%>' Visible='<%# Eval("enabled") %>'></asp:Label>
                                                    </td>

                                                    <td>
                                                        <asp:Button ID="btnDeleteExpense" runat="server" Text="Delete" CommandName="DeleteExpense" CommandArgument='<%# Eval("eventExpenseID")%>' CssClass="btn btn-sm btn-danger"
                                                            OnClientClick="javascript:if(!confirm('This action will delete the selected expense. Are you sure?')){return false;}" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>


                                        </telerik:RadListView>


                                        <asp:SqlDataSource ID="getExpenses" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="SELECT * FROM [qryViewExpensesByEvent] WHERE ([eventID] = @eventID) ORDER BY [userName]">

                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    </asp:Panel>

                                    <asp:Panel ID="AddNewExpensePanel" runat="server" Visible="false">

                                        <div class="col-md-12">
                                            <div class="form-horizontal">

                                                <h3>Add Expense</h3>

                                                <div class="form-group">
                                                    <label for="AmbassadorDropDownList" class="col-sm-2 control-label">Ambassador </label>
                                                    <div class="col-md-4">
                                                        <asp:DropDownList ID="AmbassadorDropDownList" runat="server" CssClass="form-control" DataSourceID="getAmbassadorList" DataTextField="fullName" DataValueField="RequirementID" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Select Ambassador" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassadorList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="fullName" TableName="qryGetAssignedAmbassaorsbyEventIDs" Where="eventID == @eventID">
                                                            <WhereParameters>
                                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                                            </WhereParameters>
                                                        </asp:LinqDataSource>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ddlExpenseType" class="col-sm-2 control-label">Expense Type </label>
                                                    <div class="col-md-4">
                                                        <asp:DropDownList ID="ddlExpenseType" runat="server" CssClass="form-control" DataSourceID="getExpenseTypeList" DataTextField="expenseTypeTitle" DataValueField="expenseTypeID" AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Select Expense Type" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getExpenseTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="sort" TableName="tblExpenseTypes"></asp:LinqDataSource>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="descriptionTextBox" class="col-sm-2 control-label">Description</label>
                                                    <div class="col-md-4">
                                                        <asp:TextBox ID="descriptionTextBox" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="amountTextBox" class="col-sm-2 control-label">Amount</label>
                                                    <div class="col-md-4">
                                                        <telerik:RadNumericTextBox ID="amountTextBox" Type="Currency" runat="server" Skin="Bootstrap" Width="100px"></telerik:RadNumericTextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ReceiptFileUpload" class="col-sm-2 control-label">Receipt</label>
                                                    <div class="col-md-4">
                                                        <telerik:RadAsyncUpload ID="ReceiptAsyncUpload" runat="server" MaxFileInputsCount="1" Skin="Bootstrap"></telerik:RadAsyncUpload>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-sm-offset-2 col-sm-10">
                                                        <asp:Button ID="btnSaveExpense" runat="server" Text="Save Expense" CssClass="btn btn-primary" />
                                                        <asp:Button ID="btnCancelExpense" runat="server" Text="Cancel" CssClass="btn btn-default" OnClick="btnCancelExpense_Click" />

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>

                                    <asp:Panel ID="EditExpensePanel" runat="server" Visible="false">

                                        <div class="col-md-12">
                                            <div class="form-horizontal">

                                                <asp:HiddenField ID="HiddenExpenseID" runat="server" />
                                                <h3>Edit Expense:
                                                    <asp:Label ID="RecieptNameLabel" runat="server" Text="Label"></asp:Label></h3>



                                                <div class="form-group">
                                                    <label for="EditExpenseTypeDropDownList" class="col-sm-2 control-label">Expense Type </label>
                                                    <div class="col-md-4">
                                                        <asp:DropDownList ID="EditExpenseTypeDropDownList" runat="server" CssClass="form-control" DataSourceID="getExpenseTypeList"
                                                            DataTextField="expenseTypeTitle" DataValueField="expenseTypeID" AppendDataBoundItems="true">
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="descriptionTextBox2" class="col-sm-2 control-label">Description</label>
                                                    <div class="col-md-4">
                                                        <asp:TextBox ID="descriptionTextBox2" runat="server" Text='<%# Bind("description")%>' CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="amountTextBox" class="col-sm-2 control-label">Amount</label>
                                                    <div class="col-md-4">
                                                        <telerik:RadNumericTextBox ID="amountTextBox2" Type="Currency" runat="server" Text='<%# Bind("amount")%>' Skin="Bootstrap" Width="100px"></telerik:RadNumericTextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="ReceiptFileUpload" class="col-sm-2 control-label">Receipt</label>
                                                    <div class="col-md-4">
                                                        <telerik:RadAsyncUpload ID="ReceiptAsyncUpload2" runat="server" MaxFileInputsCount="1" Skin="Bootstrap"></telerik:RadAsyncUpload>
                                                        <span id="helpBlock" class="help-block">Warning: Uploading a new reciept will replace an existing image.</span>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-sm-offset-2 col-sm-10">
                                                        <asp:Button ID="btnEditExpense" runat="server" Text="Edit Expense" CssClass="btn btn-primary" />
                                                        <asp:Button ID="btnCancelEditExpense" runat="server" Text="Cancel" CssClass="btn btn-default" />

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>

                                    <asp:SqlDataSource runat="server" ID="getPayrolSummary" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPayrollSummaryByEvent" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </div>

                        </telerik:RadPageView>--%>
                    </telerik:RadMultiPage>

                </asp:Panel>

            </div>

        </div>


        <%--<div class="row">

            <div class="col-md-6">
                <h4>Product Training</h4>

                <div class="bs-example">
                    <ul id="producttrainingTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#courses" data-toggle="tab">Courses</a></li>
                        <li class=""><a href="#scores" data-toggle="tab">Scores</a></li>
                        <li class=""><a href="#documents" data-toggle="tab">Documents</a></li>
                    </ul>
                    <asp:Panel runat="server" ID="ProductTrainingPanel">
                        <div class="tab-content">
                            <div class="tab-pane fade active in" id="courses">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 200px;">


                                        <asp:PlaceHolder ID="CoursesPlaceHolder" runat="server"></asp:PlaceHolder>

                                        <div class="clearfix"></div>

                                        <asp:LinkButton runat="server" ID="InvitationButton" CssClass="btn btn-sm btn-primary pull-right"><i class="fa fa-link" aria-hidden="true"></i> Create Invitation Link</asp:LinkButton>

                                        <asp:Label ID="msgTrainingLabel" runat="server" />

                                        <asp:Panel runat="server" ID="InvitationPanel" Visible="false">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-horizontal">

                                                        <p>You may send an invitation to take a course for someone who is not registered on this site.  Each invitation is unique and expires once used.  </p>
                                                        <p>
                                                            Enter the guests email address:
                                                        </p>


                                                        <div class="form-group">
                                                            <label for="EmailTextBox" class="col-md-2 control-label">Email:</label>
                                                            <div class="col-md-8">
                                                                <asp:TextBox runat="server" ID="InvitationEmailTextBox" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="pull-right">
                                                <asp:LinkButton runat="server" ID="btnSubmitInvitation" CssClass="btn btn-sm btn-primary">Submit</asp:LinkButton>
                                                <asp:LinkButton ID="btnCancelInvitation" runat="server" CssClass="btn btn-sm btn-default">Cancel</asp:LinkButton>
                                            </div>
                                        </asp:Panel>

                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getBrandTrainingList" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblBrandTrainings" Where="brandID == @brandID">
                                            <WhereParameters>
                                                <asp:ControlParameter ControlID="HiddenBrandID" PropertyName="Value" Name="brandID" Type="Int32"></asp:ControlParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                        <asp:HiddenField ID="HiddenBrandID" runat="server" />

                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="scores">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 200px;">

                                        <h3>Test Results for Scheduled Ambassadors</h3>

                                        <asp:PlaceHolder ID="TestScoresPlaceHolder" runat="server"></asp:PlaceHolder>

                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="documents">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 200px;">
                                        <div class="col-md-12">

                                            <asp:PlaceHolder ID="DocumentsPlaceHolder" runat="server"></asp:PlaceHolder>

                                            <br />
                                            <br />

                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </asp:Panel>
                </div>
            </div>



            <div class="col-md-6">
                <h4>POS Shipping/Logistics</h4>

                <div class="bs-example">
                    <ul id="posTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active"><a href="#kits" data-toggle="tab">Kits</a></li>
                        <li class=""><a href="#shippinglocation" data-toggle="tab">Shipping Location</a></li>
                        <li class="" runat="server" id="costTab"><a href="#cost" data-toggle="tab">Cost</a></li>
                    </ul>
                    <div class="tab-content">

                        <div class="tab-pane fade active in" id="kits">

                            <asp:Panel ID="noPosItemsPanel" runat="server" Visible="false">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 200px;">

                                        <asp:Label ID="noPosItemsLabel" runat="server" />

                                        <asp:Literal ID="POSKitRequestedLabel" runat="server"></asp:Literal>

                                    </div>
                                </div>
                            </asp:Panel>


                            <asp:Panel ID="POSPanel" runat="server">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 200px;">

                                        <div class="row" style="padding: 15px;">
                                            <div class="col-sm-12 col-md-12">
                                                <p></p>
                                                <asp:Label ID="EventTypeName" runat="server" Font-Bold="true" /><br />

                                                <telerik:RadListBox RenderMode="Lightweight" ID="POSItemList" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="100%" Font-Bold="false">
                                                </telerik:RadListBox>
                                                <asp:Label ID="errorLabel2" runat="server" />
                                            </div>
                                        </div>



                                        <div class="row" style="padding: 0 15px 10px 15px;">
                                            <div class="col-sm-12 col-md-12">
                                                <asp:Label ID="labelForKits" runat="server" Font-Bold="true" Text="Would you like to have a kit shipped for event?" />
                                            </div>
                                            <div class="col-sm-12 col-md-12">
                                                <asp:RadioButtonList ID="KitRequested" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="False"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>


                                        <div class="row" style="padding: 0 15px 10px 15px;">
                                            <div class="col-sm-12 col-md-12">
                                                <strong>Ship to:</strong><br />
                                                <telerik:RadComboBox ID="SendToList" runat="server" Width="250px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="Brand Ambassador" Value="1" />
                                                        <telerik:RadComboBoxItem Text="Event Location" Value="2" />
                                                        <telerik:RadComboBoxItem Text="FedEx Office" Value="3" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </div>
                                        </div>


                                        <div class="row" style="padding: 0 15px 10px 15px;">
                                            <div class="col-sm-12 col-md-12">
                                                <strong>Shipping Notes:</strong><br />

                                                <telerik:RadTextBox ID="NotesTextBox" runat="server" Width="100%" Height="90px" TextMode="MultiLine"></telerik:RadTextBox>
                                            </div>
                                        </div>

                                        <div class="row" style="padding: 15px;">
                                            <div class="col-sm-12 col-md-12">



                                                <div class="pull-right">

                                                    <asp:Button ID="btnSavePosKitRequest" runat="server" Text="Save" CssClass="btn btn-primary" />

                                                </div>



                                            </div>

                                            <div class="col-sm-12 col-md-12">
                                                <asp:Label ID="SuccessLabel" runat="server" />
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>



                        <div class="tab-pane fade" id="shippinglocation">
                            <div class="widget stacked Container1">
                                <div class="widget-content" style="min-height: 200px;">
                                    <uc1:ShippingLocationControl runat="server" ID="ShippingLocationControl" />

                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="cost">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">

                                    <uc1:POSCostControl runat="server" ID="POSCostControl" />

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


        </div>--%>


        <div class="row pageBreak">
            <div class="col-md-12">
                <h4>Photo Gallery</h4>

                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 300px;">

                                        <asp:Panel ID="GalleryPanel" runat="server">
                                            <%--<h3>Photo Gallery
                                            </h3>--%>

                                            <%--<asp:LinkButton ID="btnAddPhotos" runat="server" CssClass="btn btn-xs btn-success pull-right"><i class="fa fa-plus"></i>  Add Photo</asp:LinkButton>--%>


                                            <telerik:RadListView runat="server" ID="PhotoListView" DataSourceID="getImageList" Skin="Bootstrap" DataKeyNames="photoID" OverrideDataSourceControlSorting="true">

                                                <LayoutTemplate>

                                                    <div id="list2">

                                                        <div class="clearFix">
                                                        </div>

                                                        <asp:Panel ID="itemPlaceholder" runat="server">
                                                        </asp:Panel>

                                                        <div class="clearFix">
                                                        </div>

                                                    </div>

                                                </LayoutTemplate>

                                                <ItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                            DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                                            ResizeMode="Crop"

                                                            AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                                        <%--<div style="margin-top: -22px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">
                                                            <asp:LoginView ID="LoginView_AddButton" runat="server">
                                                                <RoleGroups>
                                                                    <asp:RoleGroup Roles="Administrator, EventManager">
                                                                        <ContentTemplate>

                                                                            <asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>' CommandName="DeleteImage"><i class="fa fa-trash fa-1x delete pull-right"></i></asp:LinkButton>
                                                                             <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server"
                                                                                Text="Delete" CssClass="txt" />

                                                                            <asp:LinkButton ID="btnRotateImageLeft1" runat="server" ToolTip="Rotate Left" CommandName="RotateLeft"
                                                                                CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-undo fa-1x bin"></i></asp:LinkButton>

                                                                            <asp:LinkButton ID="btnRotateImage1" runat="server" ToolTip="Rotate Right" CommandName="RotateRight" CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-repeat fa-1x bin"></i></asp:LinkButton>


                                        <a href='/gallery/downloadhandler.aspx?photoID=<%# Eval("photoID") %>' title="Download" ><i class="fa fa-download fa-1x bin"></i></a>



                                                                        </ContentTemplate>
                                                                    </asp:RoleGroup>
                                                                </RoleGroups>
                                                            </asp:LoginView>




                                                        </div>--%>

                                                    </div>

                                                </ItemTemplate>

                                                <AlternatingItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1" SavedImageName='<%#Eval("photoID") %>'
                                                            DataValue='<%#Eval("Image") %>' Height='<%#ImageHeight %>' Width="<%#ImageWidth %>"
                                                            ResizeMode="Crop"

                                                            AlternateText="Click to view larger image" ToolTip="Click to view larger image" />

                                                        <%--<div style="margin-top: -22px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                                                            <asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>'
                                                                CommandName="DeleteImage"><i class="fa fa-trash fa-1x delete pull-right"></i></asp:LinkButton>
                                                              <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server"
                                                                                Text="Delete" CssClass="txt" />

                                                            <asp:LinkButton ID="btnRotateImageLeft2" runat="server" ToolTip="Rotate Left" CommandName="RotateLeft"
                                                                CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-undo fa-1x bin"></i></asp:LinkButton>

                                                            <asp:LinkButton ID="btnRotateImage2" runat="server" ToolTip="Rotate Right" CommandName="RotateRight" CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-repeat fa-1x bin"></i></asp:LinkButton>

                                                            <a href='/gallery/downloadhandler.aspx?photoID=<%# Eval("photoID") %>' title="Download"><i class="fa fa-download fa-1x bin"></i></a>


                                                        </div>--%>

                                                    </div>

                                                </AlternatingItemTemplate>
                                            </telerik:RadListView>

                                            <asp:Label ID="errorLabel" runat="server" />

                                            <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [Image], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID)">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </asp:Panel>

                                        <%--<asp:Panel ID="UploadPanel" runat="server" Visible="false">
                                            <div class="widget stacked" style="margin-top: 25px;">
                                                <div class="widget-content" style="padding: 25px">

                                                    <div class="demo-container size-wide">
                                                        <h2>Upload Photos</h2>
                                                        <p>
                                                            Upload your photos here using the file uploader or the drop box below.
                                                        </p>

                                                        <telerik:RadAsyncUpload runat="server" ID="PhotoAsyncUpload" MultipleFileSelection="Automatic" DropZones=".DropZone1,#DropZone2" PostbackTriggers="btnUpload" />


                                                        <div class="DropZone1">

                                                            <br />
                                                            <br />

                                                            <p>Drop Files Here</p>

                                                        </div>

                                                        <div class="btnbox">
                                                            <asp:Button ID="btnUpload" runat="server" Text="Upload Photos" CssClass="btn btn-md btn-primary" />
                                                            <asp:Button ID="btnCancelUpload" runat="server" Text="Cancel" CssClass="btn btn-md btn-default" />
                                                        </div>

                                                        <asp:Label ID="Label2" runat="server" />

                                                    </div>


                                                </div>

                                            </div>
                                        </asp:Panel>--%>

                                        <telerik:RadWindowManager runat="server" ID="RadWindowManager1">

                                            <Windows>

                                                <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" NavigateUrl="/PhotoGallery.aspx" Skin="Bootstrap"
                                                    Width="675px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false"
                                                    Modal="true">
                                                </telerik:RadWindow>

                                            </Windows>

                                        </telerik:RadWindowManager>

                                    </div>
                                </div>

            </div>
        </div>

        <asp:Panel ID="RecapPanel" runat="server">
            <div class="row pageBreak">
                <div class="col-md-12">
                    <h4>Event Recap</h4>
                    <asp:Label ID="RecapStausLabel" runat="server" />

                    <div class="bs-example">


                        <%--<ul id="recapTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                            <li class="active"><a href="#questionnaire" data-toggle="tab">Questionnaire</a></li>
                            <li><a href="#photogallery" data-toggle="tab">Photo Gallery <span class="badge">
                                <asp:Label ID="PhotoCountLabel" runat="server" /></span></a></li>

                            <li id="CreateRecapLink" runat="server" class="pull-right" visible="false">
                                <asp:LinkButton ID="btnCreateRecap" runat="server">
                             <i class="fa fa-plus"></i> Create Recap</asp:LinkButton></li>

                           <li id="EditRecapLink" runat="server" class="pull-right" visible="false"><a href="/Events/EditRecap?action=edit&EventID=<%= Request.QueryString("ID") %>"><i class="fa fa-pencil"></i>Edit Recap</a></li>
                            <li id="PrintPDFLink" runat="server" class="pull-right" visible="false">
                                <asp:LinkButton ID="btnCreatePDF" runat="server"><i class="fa fa-print"></i> Print PDF File</asp:LinkButton></li>

                            <asp:LinkButton ID="btnApproveRecap" runat="server" CssClass="btn-success btn-lg pull-right" Visible="false" Style="padding: 9px 10px; font-size: 14px; font-weight: bold; margin-right: 2px;" OnClientClick="javascript:if(!confirm('This action will change the status of the event to Approved. Are you sure?')){return false;}">Approve Recap</asp:LinkButton>
                        </ul>--%>



                        <asp:Label ID="msgLabel2" runat="server" />


                        <div class="tab-content">
                            <div class="tab-pane fade active in" id="questionnaire">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 300px;">

                                        <uc1:QuestionaireControl runat="server" ID="QuestionaireControl" />

                                    </div>
                                </div>
                            </div>
                            <!-- End questionnaire -->


                            <%--<div class="tab-pane fade" id="photogallery">

                            </div>--%>

                            <!-- End questionnaire -->
                            <!-- End Gallery -->


                        </div>
                        <!-- end content -->

                    </div>
                </div>

            </div>
        </asp:Panel>
    </div>
</asp:Panel>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>


        <script>
            // close the div in 5 secs
            window.setTimeout("closeDiv();", 3000);

            function closeDiv() {
                // jQuery version
                $("#messageHolder").fadeOut("slow", null);
            }

            function containerMouseover(sender) {
                sender.getElementsByTagName("div")[0].style.display = "";
            }

            function containerMouseout(sender) {
                sender.getElementsByTagName("div")[0].style.display = "none";
            }

            $("#tab1").click(function () {

                GetMap();
                $('#direct').hide();


                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");


            });

            $("#tab2").click(function () {

                GetMap();
                $("#printoutPanel").html("");

                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

                $('#accountTab a:first').tab('show');

                $('#tab1').removeClass('active');
                $('#tab2').addClass('active');
                $('#direct').show();


            });

            $("#btnFindGroceryStoresLink").click(function () {
                $("#btnFindGroceryStoresLink").addClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");
            });

            $("#btnFindConvienienceStoresLink").click(function () {
                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").addClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");
            });

            $("#btnFindGasStationsLink").click(function () {
                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").addClass("btn-success");
            });



            $("a.trigger").click(function (eventObject) {
                $(this).parent().parent().next().find('div.showDiv').toggle();
                return false;
            });

            function triggerShowDiv() {
                $("a.trigger").click(function (eventObject) {
                    $(this).parent().parent().next().find('div.showDiv').toggle();
                    return false;
                });
            };


        </script>


        <script type="text/javascript">

            function GetMap() {
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
            var locName = $('#<%=LocationNameMap.ClientID%>').val();
            var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                       {
                           credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                           center: new Microsoft.Maps.Location(lat, long),
                           zoom: 10
                       });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);


            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
                var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ address: locName });
                directionsManager.addWaypoint(waypoint1);
                directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
                directionsManager.setRequestOptions({ distanceUnit: Microsoft.Maps.Directions.DistanceUnit.miles });
                directionsManager.showInputPanel('directionsInputContainer');
                directionsManager.calculateDirections();

            });

            document.getElementById('printoutPanelGas').style.display = "none";
            document.getElementById('printoutPanelConvenience').style.display = "none";
            document.getElementById('printoutPanelGrocery').style.display = "none";

            $("#btnFindGroceryStoresLink").removeClass("btn-success");
            $("#btnFindConvienienceStoresLink").removeClass("btn-success");
            $("#btnFindGasStationsLink").removeClass("btn-success");

        }

        <%--function createDirections() {
            document.getElementById('printoutPanelGas').style.display = "none";
            document.getElementById('printoutPanelConvenience').style.display = "none";
            document.getElementById('printoutPanelGrocery').style.display = "none";

            // Initialize the map
            var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
          var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                     {
                         credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                         center: new Microsoft.Maps.Location(lat, long),
                         zoom: 10
                     });

          var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
          map.entities.push(pushpin);

          var FromAddress = $('#<%=SelectedDirectionsName.ClientID%>').val();
            var ToAddress = $('#<%=AccountAddressLabel1.ClientID%>').text();
          var ToLocation = $('#<%=LocationTextBox.ClientID%>').val();
          var locName = $('#<%=LocationNameMap.ClientID%>').val();


          Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
              var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
              // Set Route Mode to driving
              directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
              var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ address: FromAddress });
              var waypoint2 = new Microsoft.Maps.Directions.Waypoint({ address: locName, location: new Microsoft.Maps.Location(lat, long) });
              directionsManager.addWaypoint(waypoint1);
              directionsManager.addWaypoint(waypoint2);
              // Set the element in which the itinerary will be rendered
              directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
              directionsManager.setRequestOptions({ distanceUnit: Microsoft.Maps.Directions.DistanceUnit.miles });
              directionsManager.calculateDirections();
          });


          $("#btnFindGroceryStoresLink").removeClass("btn-success");
          $("#btnFindConvienienceStoresLink").removeClass("btn-success");
          $("#btnFindGasStationsLink").removeClass("btn-success");

      }--%>

      <%--function createDirectionsByAddress() {
          document.getElementById('printoutPanelGas').style.display = "none";
          document.getElementById('printoutPanelConvenience').style.display = "none";
          document.getElementById('printoutPanelGrocery').style.display = "none";

          // Initialize the map
          var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                    var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                               {
                                   credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                                   center: new Microsoft.Maps.Location(lat, long),
                                   zoom: 10
                               });

                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);

                    var FromAddress = $('#<%=txtFromAddress.ClientID%>').val();
            var ToAddress = $('#<%=AccountAddressLabel1.ClientID%>').text();
                    var ToLocation = $('#<%=LocationTextBox.ClientID%>').val();
                    var locName = $('#<%=LocationNameMap.ClientID%>').val();


                    Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                        var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                        // Set Route Mode to driving
                        directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
                        var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ address: FromAddress });
                        var waypoint2 = new Microsoft.Maps.Directions.Waypoint({ address: locName, location: new Microsoft.Maps.Location(lat, long) });
                        directionsManager.addWaypoint(waypoint1);
                        directionsManager.addWaypoint(waypoint2);
                        // Set the element in which the itinerary will be rendered
                        directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
                        directionsManager.setRequestOptions({ distanceUnit: Microsoft.Maps.Directions.DistanceUnit.miles });
                        directionsManager.calculateDirections();
                    });

                    $("#btnFindGroceryStoresLink").removeClass("btn-success");
                    $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                    $("#btnFindGasStationsLink").removeClass("btn-success");

                }--%>

                function MapTraffic() {
                    $("#hideTraffic").show();
                    $("#showTraffic").hide();
                    document.getElementById('printoutPanelGas').style.display = "none";
                    document.getElementById('printoutPanelConvenience').style.display = "none";
                    document.getElementById('printoutPanelGrocery').style.display = "none";


                    // Initialize the map
                    var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 10
                           });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

                Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                    var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                    var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(lat, long) });
                    directionsManager.addWaypoint(waypoint1);
                    directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
                    directionsManager.showInputPanel('directionsInputContainer');
                });

                Microsoft.Maps.loadModule('Microsoft.Maps.Traffic', function () {
                    var manager = new Microsoft.Maps.Traffic.TrafficManager(map);
                    manager.show();
                })

                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

            }

            function hideTrafficLayer() {
                $("#hideTraffic").hide();
                $("#showTraffic").show();
                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";

                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 10
                           });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);


                Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                    var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                    var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(lat, long) });
                    directionsManager.addWaypoint(waypoint1);
                    directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
                    directionsManager.showInputPanel('directionsInputContainer');
                });


                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

            }


            function GetGasStations() {
                document.getElementById('printoutPanelGrocery').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 13
                           });


                Microsoft.Maps.loadModule('Microsoft.Maps.SpatialDataService', function () {
                    //Create a query to get nearby data.
                    queryOptions = {
                        queryUrl: 'https://spatial.virtualearth.net/REST/v1/data/f22876ec257b474b82fe2ffcb8393150/NavteqNA/NavteqPOIs',
                        top: 15,
                        inlineCount: true,
                        spatialFilter: {
                            spatialFilterType: 'nearby',
                            location: map.getCenter(),
                            radius: 10
                        },
                        filter: 'EntityTypeID eq 5540'
                    };
                    //Trigger an initial search.
                    getNearByLocations();
                });
                function getNearByLocations() {
                    //Remove any existing data from the map.
                    map.entities.clear();
                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);
                    //Update the query options to skip results based on the page index.
                    queryOptions.skip = pageIdx * 10;
                    Microsoft.Maps.SpatialDataService.QueryAPIManager.search(queryOptions, map, function (data, inlineCount) {
                        //Store the number of results available.
                        numResults = inlineCount;
                        if (data.length > 0) {
                            //Calculate the start and end result index.
                            var start = pageIdx * 10 + 1;
                            var end = start + data.length - 1;
                            document.getElementById('pageInfo').innerText = 'Results: ' + start + ' - ' + end + ' of ' + inlineCount + ' results';
                            //Create a list of the results.
                            var listHTML = ['<table>'], locations = [];
                            for (var i = 0; i < data.length; i++) {
                                //Create HTML for each line item in the list.
                                //Add a column of index numbers.
                                listHTML.push('<tr><td>', (start + i), ') </td>');
                                //Create a link that calls a function, pass in the EntityID of a result.
                                listHTML.push('<td style="padding-left:20px;"><a href="javascript: void (0);" ', 'onclick="listItemClicked(\'', data[i].metadata.EntityID, '\');"></a>', data[i].metadata.DisplayName, '</td>');
                                //Create a column to display the distance to the location.
                                var num = data[i].metadata.__Distance / 1.61;
                                listHTML.push('<td style="padding-left:30px;">', Math.round(num * 100) / 100, ' mile(s)</td></tr>');
                                //Add the result number to the pushpin.
                                data[i].setOptions({ text: start + i + '' });
                                locations.push(data[i].getLocation());
                            }
                            listHTML.push('</table>');
                            document.getElementById('printoutPanelGas').innerHTML = listHTML.join('');
                            document.getElementById('printoutPanelGas').style.display = "block";
                            document.getElementById('printoutPanelGas').style.height = "130px";
                            document.getElementById('printoutPanelGas').style.overflow = "auto";
                            //Add results to the map.
                            map.entities.push(data);
                            //Set the map view to show all the locations.
                            //Add apadding to account for the pushpins pixel size.
                            map.setView({
                                bounds: Microsoft.Maps.LocationRect.fromLocations(locations),
                                padding: 30
                            });
                        }
                    });
                }
                function listItemClicked(entityId) {
                    //When an item in the list is clicked, look up its pushpin by entitiyId.
                    var shape, len = map.entities.getLength();
                    for (var i = 0; i < len; i++) {
                        shape = map.entities.get(i);
                        if (shape.metadata.EntityID == entityId) {
                            //Center the map over the pushpin and zoom in.
                            map.setView({ center: shape.getLocation(), zoom: 15 });
                            break;
                        }
                    }
                }
                function pageBackwards() {
                    if (pageIdx > 0) {
                        pageIdx--;
                        getNearByLocations();
                    }
                }
                function pageForward() {
                    //Ensure that paging does not exceed the number of results.
                    if ((pageIdx + 1) * 10 < numResults) {
                        pageIdx++;
                        getNearByLocations();
                    }
                }

            }


            function GetGroceryStores() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 13
                           });


                Microsoft.Maps.loadModule('Microsoft.Maps.SpatialDataService', function () {
                    //Create a query to get nearby data.
                    queryOptions = {
                        queryUrl: 'https://spatial.virtualearth.net/REST/v1/data/f22876ec257b474b82fe2ffcb8393150/NavteqNA/NavteqPOIs',
                        top: 15,
                        inlineCount: true,
                        spatialFilter: {
                            spatialFilterType: 'nearby',
                            location: map.getCenter(),
                            radius: 10
                        },
                        filter: 'EntityTypeID eq 5400'
                    };
                    //Trigger an initial search.
                    getNearByLocations();
                });

                function getNearByLocations() {
                    //Remove any existing data from the map.
                    map.entities.clear();
                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);
                    //Update the query options to skip results based on the page index.
                    queryOptions.skip = pageIdx * 10;
                    Microsoft.Maps.SpatialDataService.QueryAPIManager.search(queryOptions, map, function (data, inlineCount) {
                        //Store the number of results available.
                        numResults = inlineCount;
                        if (data.length > 0) {
                            //Calculate the start and end result index.
                            var start = pageIdx * 10 + 1;
                            var end = start + data.length - 1;
                            document.getElementById('pageInfo').innerText = 'Results: ' + start + ' - ' + end + ' of ' + inlineCount + ' results';
                            //Create a list of the results.
                            var listHTML = ['<table>'], locations = [];
                            for (var i = 0; i < data.length; i++) {
                                //Create HTML for each line item in the list.
                                //Add a column of index numbers.
                                listHTML.push('<tr><td>', (start + i), ') </td>');
                                //Create a link that calls a function, pass in the EntityID of a result.
                                listHTML.push('<td style="padding-left:20px;"><a href="javascript: void (0);" ', 'onclick="listItemClicked(\'', data[i].metadata.EntityID, '\');"></a>', data[i].metadata.DisplayName, '</td>');
                                //Create a column to display the distance to the location.
                                var num = data[i].metadata.__Distance / 1.61;
                                listHTML.push('<td style="padding-left:30px;">', Math.round(num * 100) / 100, ' mile(s)</td></tr>');
                                //Add the result number to the pushpin.
                                data[i].setOptions({ text: start + i + '' });
                                locations.push(data[i].getLocation());
                            }
                            listHTML.push('</table>');
                            document.getElementById('printoutPanelGrocery').innerHTML = listHTML.join('');
                            document.getElementById('printoutPanelGrocery').style.display = "block";
                            document.getElementById('printoutPanelGrocery').style.height = "130px";
                            document.getElementById('printoutPanelGrocery').style.overflow = "auto";
                            //Add results to the map.
                            map.entities.push(data);
                            //Set the map view to show all the locations.
                            //Add apadding to account for the pushpins pixel size.
                            map.setView({
                                bounds: Microsoft.Maps.LocationRect.fromLocations(locations),
                                padding: 30
                            });
                        }
                    });
                }
                function listItemClicked(entityId) {
                    //When an item in the list is clicked, look up its pushpin by entitiyId.
                    var shape, len = map.entities.getLength();
                    for (var i = 0; i < len; i++) {
                        shape = map.entities.get(i);
                        if (shape.entity.EntityID == entityId) {
                            //Center the map over the pushpin and zoom in.
                            map.setView({ center: shape.getLocation(), zoom: 15 });
                            break;
                        }
                    }
                }
                function pageBackwards() {
                    if (pageIdx > 0) {
                        pageIdx--;
                        getNearByLocations();
                    }
                }
                function pageForward() {
                    //Ensure that paging does not exceed the number of results.
                    if ((pageIdx + 1) * 10 < numResults) {
                        pageIdx++;
                        getNearByLocations();
                    }
                }

            }


            function GetConvenienceStores() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                // Initialize the map
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                  var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                           {
                               credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                               center: new Microsoft.Maps.Location(lat, long),
                               zoom: 13
                           });


                Microsoft.Maps.loadModule('Microsoft.Maps.SpatialDataService', function () {

                    //Create a query to get nearby data.
                    queryOptions = {
                        queryUrl: 'https://spatial.virtualearth.net/REST/v1/data/f22876ec257b474b82fe2ffcb8393150/NavteqNA/NavteqPOIs',
                        top: 15,
                        inlineCount: true,
                        spatialFilter: {
                            spatialFilterType: 'nearby',
                            location: map.getCenter(),
                            radius: 10
                        },
                        filter: 'EntityTypeID eq 9535'
                    };
                    //Trigger an initial search.
                    getNearByLocations();
                });

                function getNearByLocations() {
                    //Remove any existing data from the map.
                    map.entities.clear();
                    var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                    map.entities.push(pushpin);
                    //Update the query options to skip results based on the page index.
                    queryOptions.skip = pageIdx * 10;
                    Microsoft.Maps.SpatialDataService.QueryAPIManager.search(queryOptions, map, function (data, inlineCount) {
                        //Store the number of results available.
                        numResults = inlineCount;
                        if (data.length > 0) {
                            //Calculate the start and end result index.
                            var start = pageIdx * 10 + 1;
                            var end = start + data.length - 1;
                            document.getElementById('pageInfo').innerText = 'Results: ' + start + ' - ' + end + ' of ' + inlineCount + ' results';
                            //Create a list of the results.
                            var listHTML = ['<table>'], locations = [];
                            for (var i = 0; i < data.length; i++) {
                                //Create HTML for each line item in the list.
                                //Add a column of index numbers.
                                listHTML.push('<tr><td>', (start + i), ') </td>');
                                //Create a link that calls a function, pass in the EntityID of a result.
                                listHTML.push('<td style="padding-left:20px;"><a href="javascript: void (0);" ', 'onclick="listItemClicked(\'', data[i].metadata.EntityID, '\');"></a>', data[i].metadata.DisplayName, '</td>');
                                //Create a column to display the distance to the location.
                                var num = data[i].metadata.__Distance / 1.61;
                                listHTML.push('<td style="padding-left:30px;">', Math.round(num * 100) / 100, ' mile(s)</td></tr>');
                                //Add the result number to the pushpin.
                                data[i].setOptions({ text: start + i + '' });
                                locations.push(data[i].getLocation());
                            }
                            listHTML.push('</table>');
                            document.getElementById('printoutPanelConvenience').innerHTML = listHTML.join('');
                            document.getElementById('printoutPanelConvenience').style.display = "block";
                            document.getElementById('printoutPanelConvenience').style.height = "130px";
                            document.getElementById('printoutPanelConvenience').style.overflow = "auto";
                            //Add results to the map.
                            map.entities.push(data);
                            //Set the map view to show all the locations.
                            //Add apadding to account for the pushpins pixel size.
                            map.setView({
                                bounds: Microsoft.Maps.LocationRect.fromLocations(locations),
                                padding: 30
                            });
                        }
                    });
                }
                function listItemClicked(entityId) {
                    //When an item in the list is clicked, look up its pushpin by entitiyId.
                    var shape, len = map.entities.getLength();
                    for (var i = 0; i < len; i++) {
                        shape = map.entities.get(i);
                        if (shape.entity.EntityID == entityId) {
                            //Center the map over the pushpin and zoom in.
                            map.setView({ center: shape.getLocation(), zoom: 15 });
                            break;
                        }
                    }
                }
                function pageBackwards() {
                    if (pageIdx > 0) {
                        pageIdx--;
                        getNearByLocations();
                    }
                }
                function pageForward() {
                    //Ensure that paging does not exceed the number of results.
                    if ((pageIdx + 1) * 10 < numResults) {
                        pageIdx++;
                        getNearByLocations();
                    }
                }

            }

            function ClearMap() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                // Initialize the map

                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
            var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
            var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                       {
                           credentials: "AtZLhyYLi346YOtzBdKNz_1w5wJFUyGxNqgw-ShJ3zNmDp84EEiGQXcN7VfbzTJj",
                           center: new Microsoft.Maps.Location(lat, long),
                           zoom: 10
                       });

            var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
            map.entities.push(pushpin);


            Microsoft.Maps.loadModule('Microsoft.Maps.Directions', function () {
                var directionsManager = new Microsoft.Maps.Directions.DirectionsManager(map);
                directionsManager.setRequestOptions({ routeMode: Microsoft.Maps.Directions.RouteMode.driving });
                var waypoint1 = new Microsoft.Maps.Directions.Waypoint({ location: new Microsoft.Maps.Location(lat, long) });
                directionsManager.addWaypoint(waypoint1);
                directionsManager.setRenderOptions({ itineraryContainer: document.getElementById('printoutPanel') });
                directionsManager.showInputPanel('directionsInputContainer');
                directionsManager.calculateDirections();
            });

            $("#btnFindGroceryStoresLink").removeClass("btn-success");
            $("#btnFindConvienienceStoresLink").removeClass("btn-success");
            $("#btnFindGasStationsLink").removeClass("btn-success");

        }

        </script>

    </telerik:RadScriptBlock>

    <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1" OnClientPdfExported="stopAjax" >
        <PdfSettings MarginRight="20mm" MarginBottom="20mm" MarginTop="30mm" MarginLeft="20mm" PaperSize="A4" FileName="Recap.pdf" PageBreakSelector=".pageBreak" />
    </telerik:RadClientExportManager>

     <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
        <script>
            var $ = $telerik.$;

            function exportPDF() {

                $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".MyRecapView"));

                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= containerPage.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);
            };

          function stopAjax() {
                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= containerPage.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.hide(currentUpdatedControl);
            };


        </script>
    </telerik:RadScriptBlock>


    </form>
</body>
</html>

