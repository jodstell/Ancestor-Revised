<%@ Page Title="Event Details" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EventDetails.aspx.vb" Inherits="EventManagerApplication.EventDetails_V3" %>


<%@ Register Src="~/Events/UserControls/QuestionaireControl.ascx" TagPrefix="uc1" TagName="QuestionaireControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        @media screen and (min-width: 1150px) and (max-width: 1465px) {
            .hideCol {
                display: none !important;
            }
        }

         .filterWrapper {
        overflow: hidden;
    }



    .filterDropDown1 {
        color: #2a6ca3;
        font-size: 11px;
        margin-bottom: 20px;
    }

    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">



    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="css/EventDetails.css" rel="stylesheet" />

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" ClientEvents-OnResponseEnd="triggerShowDiv()">
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
                    <telerik:AjaxUpdatedControl ControlID="btnUnapprove" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="StaffingPnel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="StaffingPnel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DetailsPanel" />
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

        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="POSPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="POSPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="LogisticsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="LogisticsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
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

    </telerik:RadAjaxManager>


    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"
        Style="position: absolute; top: 0; left: 0; width: 100%; height: 100%">
    </telerik:RadAjaxLoadingPanel>


    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="EventDataGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>

    <!-- Hidden values for map -->
    <asp:HiddenField ID="LatitudeTextBox" runat="server" />
    <asp:HiddenField ID="LongtitudeTextBox" runat="server" />
    <asp:HiddenField ID="LocationTextBox" runat="server" />
    <asp:HiddenField ID="LocationNameMap" runat="server" />


    <asp:Label ID="lblStreetAddress" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblCityAddress" runat="server" Visible="false"></asp:Label>


    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />

                </div>

                <span id="total"></span>

            </div>
        </div>
        <!--End Row-->

        <!-- Header Row -->
        <div class="row">
            <div class="col-xs-12 eventDetails">
                <h2>Event Details</h2>

                <asp:Panel ID="BreadCrumbPanel" runat="server">
                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i>&nbsp;<a href="/">Dashboard</a></li>
                        <li>
                            <asp:HyperLink ID="ReturnLink1" runat="server" NavigateUrl="/Events/ViewEvents?LoadState=Yes">Events</asp:HyperLink></li>
                        <li class="active">Event Details</li>
                    </ol>

                    <a href="/Events/ViewEvents?LoadState=Yes" class="btn btn-default pull-right"><i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;Go Back to Events</a>
                </asp:Panel>

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
                    <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li class="active" runat="server" id="informationTab"><a href="#information" data-toggle="tab">Information</a></li>
                        <li class="" runat="server" id="budgetTab"><a href="#budget" data-toggle="tab">Budget</a></li>
                        <li class="" runat="server" id="notesTab"><a href="#notes" data-toggle="tab">Notes <span class="badge">
                            <asp:Label ID="NoteCountLabel" runat="server" /></span></a></li>
                        <li class="" runat="server" id="logTab"><a href="#log" data-toggle="tab">Log</a></li>

                        <li runat="server" id="EditButtonPanel1" class="danger pull-right"><a href="/Events/EditEvent?EventID=<%= Request.QueryString("ID") %>"><i class="fa fa-pencil"></i>Edit Event</a></li>

                    </ul>


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

                                    <asp:Panel ID="DetailsPanel" runat="server">
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
                                    </asp:Panel>

                                    <div class="col-md-12">
                                        <div>
                                            <label>Brands:</label>
                                            <asp:Label ID="BrandsLabel" runat="server" />
                                        </div>

                                        <div>
                                            <label>Team:</label>
                                            <asp:Label ID="TeamLabel" runat="server" />
                                        </div>


                                        <hr />
                                        <div>
                                            <label class="tightlabel">Attire:</label><br />
                                            <asp:Literal ID="AttireLabel" runat="server"></asp:Literal>

                                        </div>
                                        <br />
                                        <div>
                                            <label>POS:</label><br />
                                            <asp:Label ID="POSLabel" runat="server" />
                                        </div>
                                        <br />
                                        <div>
                                            <label>Sampling Notes:</label><br />
                                            <asp:Label ID="SamplingLabel" runat="server" />
                                        </div>
                                        <br />
                                        <div>
                                            <label>Additional Instructions:</label><br />
                                            <asp:Label ID="AdditionalInstruvtionsLabel" runat="server" Text="Take a photo of the product in all the locations in the store."></asp:Label>
                                        </div>
                                        <br />
                                        <div>
                                            <label>Event Description:</label><br />
                                            <asp:Label ID="DescriptionLabel" runat="server" />
                                        </div>
                                    </div>

                                    <!-- End Event Details -->

                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="budget">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 300px;">

                                    <div class="col-md-12">

                                        <div>
                                            <asp:Label ID="Label1" runat="server" Text='Billable:' Font-Bold="true" />
                                            <asp:Label ID="BillableCheckBoxLabel" runat="server" />
                                            <%--<asp:CheckBox ID="BillableCheckBox" runat="server"  />--%>
                                        </div>

                                        <br />
                                        <div>
                                            <asp:Label ID="PONumberLabel" runat="server" Text='PO Number:' Font-Bold="true" />
                                            <asp:Label ID="PONumberTextBox" runat="server" />
                                        </div>
                                        <br />

                                        <div>
                                            <asp:Label ID="DistributorLabel1" runat="server" Text='Distributor:' Font-Bold="true" />
                                            <asp:Label ID="DistributorTextBox" runat="server" />
                                        </div>
                                        <br />

                                        <div>
                                            <asp:Label ID="RequestedLabel" runat="server" Text='Requested:' Font-Bold="true" />
                                            <asp:Label ID="RequestedTextBox" runat="server" />
                                        </div>
                                        <br />

                                    </div>


                                    <asp:Repeater ID="SupplierBudgetRepeater" runat="server" DataSourceID="getSupplierBudgetResultList">

                                        <ItemTemplate>

                                            <div class="col-md-12">
                                                <div>
                                                    <asp:Label ID="lblQuestion" runat="server" Text='<%#Eval("question", "{0}:  ") %>' Font-Bold="true" />
                                                    <asp:Label ID="lblAnswer" runat="server" Text='<%#Eval("answer") %>' />
                                                </div>
                                                <br />
                                            </div>


                                        </ItemTemplate>
                                        <FooterTemplate>

                                            <asp:Label ID="lblEmptyData"
                                                Text='<%# Common.ShowAlertNoClose("warning", "There is no budget information to show.")%>' runat="server" Visible="false">
                                            </asp:Label>
                                        </FooterTemplate>

                                    </asp:Repeater>

                                    <asp:SqlDataSource ID="getSupplierBudgetResultList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="GetSupplierBudgetResult" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                    <asp:LinqDataSource ID="getSupplierBudgetList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                        EntityTypeName="" OrderBy="order" TableName="tblSupplierBudgetQuestionResults" Where="eventID == @eventID"
                                        Select="new (supplierBudgetQuestionResultID, eventID, question, answer, order)">
                                        <WhereParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>



                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="notes">
                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 300px;">

                                    <%--<uc1:EventNoteControl runat="server" ID="EventNoteControl" />--%>


                                    <asp:Panel runat="server" ID="NotesPanel">

                                        <telerik:RadListView ID="NoteList" runat="server"
                                            DataKeyNames="eventNoteID" DataSourceID="getNotes" InsertItemPosition="FirstItem">
                                            <LayoutTemplate>
                                                <div class="RadListView RadListView_Default">
                                                    <table class="table" cellspacing="0" style="width: 100%;">

                                                        <tbody>
                                                            <tr></tr>
                                                            <tr id="itemPlaceholder" runat="server">
                                                            </tr>
                                                        </tbody>
                                                        <tfoot>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
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
                                                            <asp:Label ID="dateLabel" runat="server" Text='<%# Common.GetFullName(Eval("createdBy"))%>' />
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
                                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" OnClick="UpdateButton_Click" />
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
                                                            <asp:LinkButton ID="btnInsert" runat="server" CssClass="btn btn-xs btn-success pull-right" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"><i class="fa fa-plus"></i>  Add New Note</asp:LinkButton>
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
                        </div>

                        <div class="tab-pane fade" id="log">
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
                                                        By  <%#Common.GetFullName(Eval("createdBy"))%> on <%# Common.GetTimeAdjustment(Eval("createdDate"))%>
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
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <h4>Account/Location</h4>

                <div class="bs-example">

                    <ul id="accountTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                        <li id="tab1" class="active"><a href="#address" data-toggle="tab">Address</a></li>
                        <li id="tab2" class=""><a href="#address" data-toggle="tab">Directions</a></li>
                        <li class=""><a href="#weather" data-toggle="tab">Weather</a></li>
                    </ul>



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

                                    <asp:Panel ID="DirectionsPanel" runat="server">
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
                                    </asp:Panel>

                                    <div style="margin-bottom: 10px;">
                                        <input type="button" id="showTraffic" value="Show Traffic" onclick="MapTraffic()" class="btn btn-xs btn-secondary" /><input type="button" id="hideTraffic" value="Hide Traffic" onclick="    hideTrafficLayer()" class="btn btn-xs btn-secondary" style="display: none" />
                                    </div>
                                    <div id='mapDiv' style="position: relative; width: 100%; height: 50%;"></div>
                                    <div style="width: 100%" id="printoutPanel"></div>
                                    <div id="printoutPanelGas"></div>
                                    <div id="printoutPanelGrocery"></div>
                                    <div id="printoutPanelConvenience"></div>
                                    <div id='sdsPageResultsHeader' style="display: none;">
                                        <div id='pageResultsButtons'>
                                            <input type='button' value='<' onclick='pageBackwards();' />
                                            <input type='button' value='>' onclick='pageForward();' />
                                        </div>
                                        <div id='pageInfo' style="display: none;"></div>
                                    </div>


                                    <div style="margin-top: 5px;">

                                        <label>Show Helpful Locations:</label><br />
                                        <div class="btn-group pull-left gridbuttons" role="group" aria-label="...">

                                            <input type="button" id="btnFindGroceryStoresLink" value="Grocery Stores" onclick="GetGroceryStores()" class="btn btn-default" />
                                            <input type="button" id="btnFindConvienienceStoresLink" value="Convenience Stores" onclick="GetConvenienceStores()" class="btn btn-default" />
                                            <input type="button" id="btnFindGasStationsLink" value="Gas Stations" onclick="GetGasStations()" class="btn btn-default" />
                                        </div>
                                        <div class="btn-group pull-right gridbuttons" role="group" aria-label="...">
                                            <input type="button" id="btnFindPartyStoresLink" value="Clear Locations" onclick="ClearMap()" class="btn btn-default" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="weather">
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <div style="margin-bottom: 5px;">
                                        <div>
                                            <asp:Label ID="CityLabel" Font-Bold="true" Font-Size="X-Large" runat="server" />
                                        </div>

                                    </div>

                                    <asp:Panel ID="WeatherForcastPanel" runat="server">
                                        <asp:Repeater ID="WeatherListRepeater" runat="server" DataSourceID="getWeatherList">
                                            <ItemTemplate>
                                                <div class="row weatherwrapper">
                                                    <div class="col-xs-2 datebox">
                                                        <asp:Label ID="lblDay0" runat="server" Text='<%# Eval("dayNumber") %>' />
                                                        <div class="monthlabel">
                                                            <asp:Label ID="lblMonth0" runat="server" Text='<%# String.Format("{0:MMM}", Eval("weatherDate")) %>' />
                                                        </div>

                                                    </div>
                                                    <div class="col-xs-4 col2">
                                                        <div class="daylabel"><%# Eval("day") %></div>
                                                        <div class="templabel">
                                                            Low:
                                                            <asp:Label ID="lblTempMin0" runat="server" Text='<%# Eval("lowTemp") %>' />
                                                        </div>
                                                        <div class="templabel">
                                                            High:
                                                            <asp:Label ID="lblTempMax0" runat="server" Text='<%# Eval("highTemp") %>' />
                                                        </div>

                                                    </div>
                                                    <div class="col-xs-4 col3">
                                                        <asp:Image ID="imgWeatherIcon0" runat="server" Width="60px" ImageUrl='<%# Eval("icon") %>' />
                                                        <div>
                                                            <asp:Label ID="lblMain0" runat="server" Text='<%# Eval("condition") %>' />
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                <asp:Label ID="lblEmptyData" Text='<%# Common.ShowAlertNoClose("warning", "There are no weather results found to display.")%>'
                                                    runat="server" Visible="false">
                                                </asp:Label>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                        <!-- Today -->

                                        <asp:SqlDataSource runat="server" ID="getWeatherList" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getWeatherbyEvent" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                    </asp:Panel>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>


        <!-- Staffing Section -->
        <div id="staffingPanel" runat="server" class="row">
            <div class="col-md-12">
                <h4>Staffing</h4>
                <asp:Panel runat="server" ID="StaffingPnel1">
                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="false" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="Status" runat="server" ID="statusTab" Value="status"></telerik:RadTab>
                            <telerik:RadTab Text="Assign BA" runat="server" ID="assignTab" Value="AssignBA"></telerik:RadTab>
                            <telerik:RadTab Text="Requirements" runat="server" ID="requirementsTab" Value="requirement"></telerik:RadTab>
                            <telerik:RadTab Text="Payroll/Expenses" runat="server" ID="payrollTab" Value="payroll"></telerik:RadTab>
                            <telerik:RadTab Text="Expenses" runat="server" ID="expensesClientTab" Value="clientExpenses" Visible="false"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>

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
                                                        <th class="hidden-xs">Hours</th>
                                                        <th class="hidden-xs">Check-in Time</th>
                                                        <th class="hidden-xs">Check-in Confirmed</th>
                                                    </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td class="hidden-xs">
                                                    <div class="thumbnail" style="width: 82px; min-height: 100px;">
                                                        <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" GenerateEmptyAlternateText="true" AlternateText="Click to view larger image"
                                                            DataValue='<%# IIf(Eval("headShot") IsNot DBNull.Value, Eval("headShot"), New System.Byte(-1) {})%>'
                                                            AutoAdjustImageControlSize="false" Width="80px" ToolTip='<%# Eval("FullName") %>'
                                                            onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' Visible='<%# setImage(Eval("userID")) %>' />
                                                    </div>
                                                </td>

                                                <td>
                                                    <asp:Label ID="AssignedNameLabel" runat="server" Text='<%# Eval("FullName") %>' Visible='<%# Eval("EnableLabel") %>'></asp:Label><asp:HyperLink ID="AssignedNameLink" runat="server" NavigateUrl='<%# Eval("userID", "/ambassadors/ViewAmbassadorDetails?UserID={0}") %>' Visible='<%# Eval("EnableLink") %>'><%# Eval("FullName") %></asp:HyperLink></td>
                                                <td><%# Eval("positionTitle") %></td>
                                                <td><%# Eval("startTime", "{0:t}") %></td>
                                                <td><%# Eval("endTime", "{0:t}") %></td>
                                                <td class="hidden-xs"><%# Eval("hours") %></td>
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
                                            <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>



                                </div>
                            </div>
                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView2">
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

                                    <%--<link href="/events/css/RequiredPositions1.css" rel="stylesheet" />--%>

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

                                    <p>
                                        Total Staffing Spend:
                                        <asp:Label ID="TotalSpendLabel" runat="server" Font-Bold="true" />
                                    </p>
                                    <p>
                                        Total Staff Results:
                                        <asp:Label ID="StaffCountLabel" runat="server" />  
                                        
                                        
                                    </p>




                                    <!-- Left Column Available BA's -->
                                    <div class="col-md-6">

                                        <div class="row">
                                            <div class="col-md-12" style="margin-bottom: 10px;">

                                                <div class="filterWrapper">
                                                    <div class="filterDropDown1">

                                                        <asp:Panel ID="LookupPanel" runat="server">
                                                            <div>

                                                                

                                                                <telerik:RadComboBox ID="LookupAmbassadorText" runat="server" DataTextField="FullName" AllowCustomText="false" MarkFirstMatch="true"
                                                                    DataValueField="userName" Height="200px" Width="280px" LoadingMessage="Searching..." EmptyMessage="Ambassador Name" AutoPostBack="true">
                                                                </telerik:RadComboBox>



                                                                
                                                                    <asp:LinkButton ID="btnClearFiltersAmbassador" runat="server" CssClass="btn btn-default"><i class="fa fa-refresh" aria-hidden="true"></i> Refresh</asp:LinkButton>
                                                                    

                                                                <span class="pull-right">
                                                                <asp:LinkButton ID="BtnAdvancedScheduler" runat="server" CssClass="btn btn-warning" Visible="true"><i class="fa fa-search" aria-hidden="true"></i> Advanced Scheduler</asp:LinkButton></span>

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


                                                    <%--use getAvailableAmbassadorList--%>
                                                    <telerik:RadListView ID="AvailableAmbassadorList" runat="server" Skin="Silk" DataKeyNames="userName,FirstName,LastName"
                                                        ClientDataKeyNames="userName,FirstName,LastName" OnItemDrop="AvailableAmbassadorList_ItemDrop" 
                                                        ItemPlaceholderID="TrackContainer" AllowPaging="True" PageSize="10">

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
                                                                        Enabled="<%#Container.CurrentPageIndex > 0 %>" 
                                                                        OnClick="btnFirst_Click">
                                                                    </telerik:RadButton>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnPrev" 
                                                                        CommandName="Page" CommandArgument="Prev"
                                                                        Text="Prev" Enabled="<%#Container.CurrentPageIndex > 0 %>" 
                                                                        OnClick="btnPrev_Click">
                                                                    </telerik:RadButton>

                                                                    <span class="numericPageSize">Page <%#Container.CurrentPageIndex + 1 %>of <%#Container.PageCount %></span><telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnNext" 
                                                                        CommandName="Page" CommandArgument="Next"
                                                                        Text="Next" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>" 
                                                                        OnClick="btnNext_Click">
                                                                    </telerik:RadButton>

                                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnLast" 
                                                                        CommandName="Page" CommandArgument="Last"
                                                                        Text="Last" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>" 
                                                                        OnClick="btnLast_Click">
                                                                    </telerik:RadButton>

                                                                </div>

                                                                <div>

                                                                    <span class="pageSize">Page Size:</span>
                                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cmbPageSize" 
                                                                        OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" AutoPostBack="true" 
                                                                        Width="60px"
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
                                                                                        <telerik:RadListViewItemDragHandle 
                                                                                            ID="RadListViewItemDragHandle1" runat="server" 
                                                                                            ToolTip="Drag to schedule" 
                                                                                            Visible='<%# hasInvoice() %>'>
                                                                                        </telerik:RadListViewItemDragHandle>
                                                                                    </div>

                                                                                    <div class="col-md-7" draggable="false">


                                                                                        <telerik:RadBinaryImage ID="RadBinaryImage2" runat="server"
                                                                                            draggable="false"
                                                                                            GenerateEmptyAlternateText="true" 
                                                                                            AlternateText="Click to view larger image"
                                                                                            DataValue='<%# IIf(Eval("headshot") IsNot DBNull.Value, Eval("headshot"), New System.Byte(-1) {})%>' SavedImageName='<%# Eval("UserName") %>'
                                                                                            AutoAdjustImageControlSize="false" Width="70px" Height="80px" CssClass="thumbnail img-circle" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' />
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <!-- end row -->

                                                                        </div>

                                                                        <div class="col-md-10">

                                                                            <div class="col-md-6" style="padding-right: 0px; padding-left: 23px;">
                                                                                <a id="ambassadorlink" draggable="false" target="_blank" href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID") %>'><span style="font-size: medium; font-weight: 400; color: black">
                                                                                    <header><%# Eval("FirstName") %>  <%# Eval("LastName") %></header>
                                                                                </span>
                                                                                </a>
                                                                                <i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;<a href='mailto:<%# Eval("EmailAddress") %> '><%# Eval("EmailAddress") %></a><br />

                                                                                <i class="fa fa-phone-square" aria-hidden="true"></i>&nbsp;<%# Common.FormatPhoneNumber(Eval("Phone").ToString()) %>
                                                                            </div>
                                                                            <div class="col-md-2"><%# Eval("City")%></div>
                                                                            <div class="col-md-2"><%# Eval("State") %></div>
                                                                            <div class="col-md-2" style="padding: 5px; right: 10px;">
                                                                                <a href="#" class="trigger btn btn-sm btn-default">More Details</a>
                                                                            </div>
                                                                            <div class="col-md-12" style="padding-top: 10px;">
                                                                                <asp:Label ID="milesLabel" runat="server" />
                                                                                <%# Eval("miles") %> miles from Event Location <a href='/Events/BrandAmbassadorsDetails.aspx?userID=<%# Eval("UserID") %>&ID=<%=Request.QueryString("ID") %>' onclick="window.open(this.href, '', 'width=600,height=600,toolbar=0,resizable=0'); return false;">(View Map)</a>
                                                                            </div>
                                                                            <div class="col-md-12">
                                                                                <asp:Label ID="ConflictLabel" runat="server" Text='<%# checkSchedule(Eval("UserID")) %>' />
                                                                            </div>

                                                                            <div class="col-md-6">
                                                                                <asp:Label ID="IsRequestLabel" runat="server" Text='<%# Eval("Requested") %>'></asp:Label>
                                                                            </div>

                                                                            <div class="col-md-6" style="bottom: 3px !important; left: 26px !important;">
                                                                                <asp:Button ID="BtnIsRequested" runat="server" Text="Delete Request" CssClass="btn btn-sm btn-danger pull-right"
                                                                                    CommandName="RemoveRequest" CommandArgument='<%# Eval("UserID") %>' Visible='<%# Eval("IsRequested") %>' OnClientClick="javascript:if(!confirm('This action will delete the request for this BA. Are you sure?')){return false;}" />
                                                                            </div>




                                                                        </div>

                                                                        <table style="width: 100%">

                                                                            <tr>
                                                                                <td>
                                                                                    <div class="showDiv" style="padding-left: 0px; padding-top: 10px;">

                                                                                        <div class="col-md-4" style="padding-top: 0px;">
                                                                                           
                                                                                            <div class="panel panel-default">
                                                                                                <div class="panel-body">
                                                                                                    Events Participated <span class="badge pull-right"><%# Eval("YTDEventCount") %></span><br />
                                                                                                    Total Hours TYD <span class="badge pull-right"><%# Eval("YTDHours") %></span><br />
                                                                                                    
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-8" style="padding-top: 0px;">

                                                                                            <div class="panel panel-default">
                                                                                                <div class="panel-body">

                                                                                                    
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

                                        <asp:SqlDataSource ID="getAvailableAmbassadorList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getAvailableAmbassador" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LatitudeTextBox" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="LongtitudeTextBox" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <%-- <asp:SqlDataSource ID="getAvailableAmbassadorList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tempAvailableAmbassador] ORDER BY CASE WHEN Requested = '' THEN 1 ELSE 0 END, miles asc"></asp:SqlDataSource>--%>

                                        <asp:SqlDataSource ID="getAvailableAmbassadorListByUserName" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getAvailableAmbassadorByUserID" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LatitudeTextBox" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="LongtitudeTextBox" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />

                                                <asp:ControlParameter ControlID="LookupAmbassadorText" PropertyName="SelectedValue" Name="userName" Type="String"></asp:ControlParameter>
                                            </SelectParameters>


                                        </asp:SqlDataSource>




                                        <asp:SqlDataSource ID="getAvailableAmbassadorNameList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                            SelectCommand="getAvailableAmbassadorNameList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LatitudeTextBox" PropertyName="Value" Name="lat" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="LongtitudeTextBox" PropertyName="Value" Name="long" Type="String"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_MarketID" PropertyName="Value" Name="marketID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="HF_PositionID" PropertyName="Value" Name="positionID" Type="Int32"></asp:ControlParameter>
                                                <asp:QueryStringParameter Name="eventID" QueryStringField="ID" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>


                                        <br />
                                    </div>


                                    <!-- Right Column Assignements -->
                                    <div class="col-md-6">
                                        <div class="row">
                                            <!-- The buttons will not be visiable if the event was invoiced -->
                                            <div class="col-md-12" style="margin-bottom: 10px;">
                                                <asp:Label ID="msgLabel1" runat="server" Text=""></asp:Label><div class="btn-group pull-right" role="group" aria-label="...">
                                                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-sm btn-primary" />
                                                    <asp:Button ID="btnCancelChanges" runat="server" Text="Cancel" CssClass="btn btn-sm btn-default" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row overflow">

                                            <div id="" class="col-md-12">

                                                <asp:Repeater ID="PositionList" runat="server">
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

                                                                        <asp:LinkButton ID="btnRemoveAssigned" runat="server" CommandName="Remove" CommandArgument='<%# Eval("RequirementID") %>' CssClass="btn btn-xs btn-warning marginbottom5" OnClientClick="javascript:if(!confirm('This action will delete the assigned ambassador from this event. Are you sure?')){return false;}" Visible='<%# hasInvoice() %>'><i class="fa fa-times"></i> Remove</asp:LinkButton><span style="font-size: 14px" class="label label-success pull-right">Staffed</span>
                                                                    </asp:Panel>
                                                                    <!-- /end assigned panel -->
                                                                    <!-- NOT assigned panel -->
                                                                    <asp:Panel ID="NotAssignedPanel" runat="server" Visible='<%# getNotAssigned(Eval("assigned")) %>'>
                                                                        <div id="genreContainer">

                                                                            <asp:LinkButton ID="GenreLink" runat="server" CommandName="ShowTracks" CommandArgument='<%# Eval("RequirementID") %>' onmouseover='this.className += " selected";' onmouseout='this.className = this.className.split(" selected").join("");'>
                                           Unassigned (drag an ambassador from the left)</asp:LinkButton>
                                                                        </div>
                                                                        <div style="padding: 5px 0 5px 0; margin-bottom: 10px;">
                                                                            <span style="font-size: 14px; margin-bottom: 10px;" class="label label-warning pull-right">Available</span>
                                                                        </div>
                                                                    </asp:Panel>
                                                                    <!-- /end NOT assigned panel -->
                                                                    <table style="width: 100%" class="table-responsive">
                                                                        <tr>
                                                                            <th>Start Time</th>
                                                                            <th>End Time</th>
                                                                            <th>Rate</th>
                                                                            <th class="hideCol">Total Pay</th>
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
                                                                            <td class="hideCol" style="padding-top: 15px"><strong>
                                                                                <asp:Label ID="TotalLabel" runat="server" Text='<%# getTotalPay(Eval("RequirementID"))%>'></asp:Label><asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("RequirementID") %>' />
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


                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="LinqDataSource1"
                                            ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="assigned"
                                            TableName="tblEventStaffingRequirements" Where="eventID == @eventID">
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
                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView3">
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
                                        DataKeyNames="RequirementID" InsertItemPosition="FirstItem">
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

                                                        <div runat="server" visible='<%# hasInvoice() %>'>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                CssClass="btn btn-xs btn-success pull-right" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Position</asp:LinkButton>
                                                        </div>
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
                                                    <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" CssClass='<%# getButtonCssClass(Eval("RequirementID")) %>' Text='<%# getButtonText(Eval("RequirementID")) %>' ToolTip="Delete" Enabled='<%# getButtonEnabled(Eval("RequirementID")) %>' OnClick="DeleteButton_Click2" />
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
                                                    <telerik:RadDateTimePicker ID="RadTimePicker1" RenderMode="Lightweight" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadDateTimePicker>
                                                </td>
                                                <td>
                                                    <telerik:RadDateTimePicker ID="RadTimePicker2" RenderMode="Lightweight" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap"></telerik:RadDateTimePicker>
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

                                                    <telerik:RadDateTimePicker ID="RadTimePicker12" RenderMode="Lightweight" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap" Width="220px"></telerik:RadDateTimePicker>

                                                </td>
                                                <td>
                                                    <telerik:RadDateTimePicker ID="RadTimePicker22" RenderMode="Lightweight" runat="server" DbSelectedDate='<%# Bind("endTime") %>' Skin="Bootstrap" Width="220px" Culture="en-US"></telerik:RadDateTimePicker>

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
                                                        <div runat="server" visible='<%# hasInvoice() %>'>
                                                            <asp:LinkButton ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                                CssClass="btn btn-xs btn-success pull-right" OnClick="btnInsert_Click"><i class="fa fa-plus"></i>  Add New Position</asp:LinkButton>
                                                        </div>
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

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView4">
                            <!-- Payroll Expenses Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <asp:Panel ID="PayrollPanel" runat="server">
                                        <telerik:RadListView ID="PayrollList" runat="server" DataKeyNames="RequirementID">
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
                                                                <td colspan="12">
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

                                        <telerik:RadListView ID="ExpenseList" runat="server" DataKeyNames="eventExpenseID">
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

                                                            <%--Visible="<%# Not Container.IsItemInserted %>"--%>
                                                            <asp:LinkButton ID="btnInsertExpense" runat="server"
                                                                CssClass="btn btn-xs btn-success pull-right" OnClick="btnInsertExpense_Click" Visible='<%# hasInvoice() %>'><i class="fa fa-plus"></i>  Add New Expense</asp:LinkButton>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="btnEditExpense" runat="server" CssClass="btn btn-sm btn-default" CommandName="EditExpense" CommandArgument='<%# Eval("eventExpenseID")%>'><i class="fa fa-pencil"></i> Edit</asp:LinkButton></td>
                                                    <td><%# Eval("description") %></td>
                                                    <td><%# Eval("expenseType") %></td>
                                                    <td><%# Eval("expenseBy") %></td>
                                                    <td><%# Eval("amount", "{0:C}") %></td>

                                                    <td>
                                                        <asp:Label ID="btnViewReciept" runat="server" Text="View Receipt" CssClass="btn btn-sm btn-default" OnClick='<%#CreateReceiptScript(Eval("eventExpenseID"))%>' Visible='<%# Eval("enabled") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Button ID="btnDeleteExpense" runat="server" Text="Delete" CommandName="DeleteExpense" CommandArgument='<%# Eval("eventExpenseID")%>' CssClass="btn btn-sm btn-danger"
                                                            OnClientClick="javascript:if(!confirm('This action will delete the selected expense. Are you sure?')){return false;}" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>


                                        </telerik:RadListView>


                                        <asp:LinqDataSource ID="getExpensesList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                            EntityTypeName="" TableName="qryViewExpensesByEvents" Where="eventID == @eventID">
                                            <WhereParameters>
                                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>



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
                                                        </asp:DropDownList><asp:LinqDataSource runat="server" EntityTypeName="" ID="getAmbassadorList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="fullName" TableName="qryGetAssignedAmbassaorsbyEventIDs" Where="eventID == @eventID">
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
                                                        </asp:DropDownList><asp:LinqDataSource runat="server" EntityTypeName="" ID="getExpenseTypeList" ContextTypeName="EventManagerApplication.DataClassesDataContext" OrderBy="sort" TableName="tblExpenseTypes"></asp:LinqDataSource>
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
                                                        <telerik:RadNumericTextBox ID="amountTextBox" Type="Currency" runat="server" Skin="Bootstrap" Width="100px" Value="0">
                                                            <ClientEvents OnBlur="OnBlur" />
                                                        </telerik:RadNumericTextBox>
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
                                                        <telerik:RadNumericTextBox ID="amountTextBox2" Type="Currency" runat="server" Text='<%# Bind("amount")%>' Skin="Bootstrap" Width="100px" OnBlur="OnBlur"></telerik:RadNumericTextBox>
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
                                                        <asp:Button ID="btnCancelEditExpense" runat="server" Text="Cancel" CssClass="btn btn-default" OnClick="CancelEditExpenseButton_Click" />

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </asp:Panel>

                                    <asp:SqlDataSource runat="server" ID="getPayrolSummary" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                        SelectCommand="ViewPayrollSummaryByEvent" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView11">
                            <!-- Payroll Expenses Tab -->
                            <div class="widget stacked">
                                <div class="widget-content">

                                    <asp:Panel ID="Panel2" runat="server">

                                        <telerik:RadListView ID="ClientExpensesListView" runat="server" DataKeyNames="eventExpenseID">
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
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td></td>
                                                    <td><%# Eval("description") %></td>
                                                    <td><%# Eval("expenseType") %></td>
                                                    <td><%# Eval("expenseBy") %></td>
                                                    <td><%# Eval("amount", "{0:C}") %></td>

                                                    <td>
                                                        <asp:Label ID="btnViewReciept" runat="server" Text="View Receipt" CssClass="btn btn-sm btn-default" OnClick='<%#CreateReceiptScript(Eval("eventExpenseID"))%>' Visible='<%# Eval("enabled") %>'></asp:Label></td>
                                                    <td></td>
                                                </tr>
                                            </ItemTemplate>


                                        </telerik:RadListView>


                                    </asp:Panel>


                                </div>
                            </div>

                        </telerik:RadPageView>
                    </telerik:RadMultiPage>

                </asp:Panel>

            </div>

        </div>


        <div class="row">

            <div class="col-md-6">
                <h4>Product Training</h4>
                <asp:Panel runat="server" ID="ProductTrainingPanel">

                    <telerik:RadTabStrip ID="TrainingRadTabStrip" runat="server" AutoPostBack="false" MultiPageID="TrainingRadMultiPage" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="Courses" runat="server" ID="coursesTab" vaule="courses"></telerik:RadTab>
                            <telerik:RadTab Text="Scores" runat="server" ID="scoresTab" Value="scores"></telerik:RadTab>
                            <telerik:RadTab Text="Documents" runat="server" ID="documentsTab" Value="documents"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>

                    <telerik:RadMultiPage runat="server" ID="TrainingRadMultiPage" SelectedIndex="0" RenderSelectedPageOnly="false">

                        <telerik:RadPageView runat="server" ID="RadPageView5">


                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">
                                    <div class="col-md-12">
                                    <telerik:RadListView ID="EventCourseListView" runat="server" 
                                        DataSourceID="getEventCourse"
                                        ItemPlaceholderID="ItemPlaceHolder" BorderWidth="0" Width="100%">

                                        <LayoutTemplate>
                                            <asp:Panel ID="GroupPlaceHolder" runat="server"></asp:Panel>
                                        </LayoutTemplate>

                                        <ItemTemplate>
                                            <div>
                                                <div class="leftColumn"><%# Eval("icon") %></div>
                                                <asp:HyperLink ID="CurriculumLink" runat="server" CssClass="pointer" onclick='<%# "return getLink(""" + Eval("url") + """);"%>'>
                                                        <%# Eval("curriculumTitle") %></asp:HyperLink><asp:Label ID="CurriculumID" runat="server" Text='<%# Eval("CurriculumID") %>' Visible="false" />
                                                <asp:Label ID="TestID" runat="server" Text='<%# Eval("TestID") %>' Visible="false" />
                                                <asp:Label ID="TypeLabel" runat="server" Text='<%# Eval("ContentID") %>' Visible="false" />
                                            </div>
                                        </ItemTemplate>

                                        <DataGroups>
                                            <telerik:ListViewDataGroup GroupField="CourseTitle" DataGroupPlaceholderID="GroupPlaceHolder">
                                                <DataGroupTemplate>
                                                    <asp:Panel runat="server" ID="DataGroupPanel" CssClass="dataGroup">
                                                        <h3><%# CType(Container, RadListViewDataGroupItem).DataGroupKey %></h3>
                                                        <asp:PlaceHolder runat="server" ID="ItemPlaceHolder"></asp:PlaceHolder>
                                                    </asp:Panel>
                                                </DataGroupTemplate>
                                            </telerik:ListViewDataGroup>
                                        </DataGroups>

                                        <EmptyDataTemplate>
                                            <div class="RadListView RadListView_Default">
                                                <table class="table" cellspacing="0" style="width: 100%;">

                                                    <tbody>
                                                        <tr>
                                                            <td colspan="7">
                                                                <div class="alert alert-warning" role="alert">Theres no product training content available at this time. </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </EmptyDataTemplate>
                                    </telerik:RadListView>
                                    </div>
                                    <asp:LinqDataSource runat="server" EntityTypeName="" ID="getEventCourse"
                                        ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                        TableName="qryGetEventCourses" Where="eventID == @eventID">
                                        <WhereParameters>
                                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                        </WhereParameters>
                                    </asp:LinqDataSource>

                                    <div class="clearfix"></div>

                                    <div>
                                        <asp:LinkButton runat="server" ID="InvitationButton" CssClass="btn btn-sm btn-primary pull-right"><i class="fa fa-link" aria-hidden="true"></i> Create Invitation Link</asp:LinkButton>
                                    </div>
                                    <div>
                                        <asp:Label ID="msgTrainingLabel" runat="server" />
                                    </div>

                                    <asp:Panel runat="server" ID="InvitationPanel" Visible="false">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-horizontal">

                                                    <p>You may send an invitation to take a course for someone who is <strong>not registered</strong> on this site.  Each invitation is unique and expires once used. </p>
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
                                            <div class="btn-group" role="group">
                                                <asp:LinkButton runat="server" ID="btnSubmitInvitation" CssClass="btn btn-sm btn-primary">Submit</asp:LinkButton>
                                                <asp:LinkButton ID="btnCancelInvitation" runat="server" CssClass="btn btn-sm btn-default">Cancel</asp:LinkButton>
                                            </div>
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


                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView6">


                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">
                                    <div class="col-md-12">
                                    <h3>Test Results for Scheduled Ambassadors</h3>
                                    <asp:PlaceHolder ID="TestScoresPlaceHolder" runat="server"></asp:PlaceHolder>
                                        </div>
                                </div>
                            </div>


                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView7">


                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">
                                    <div class="col-md-12">

                                        <asp:Panel ID="DocumentPanel" runat="server">

                                        <asp:Repeater ID="DocumentRepeater" runat="server">
                                            <HeaderTemplate>
                                                <h3>Documents</h3>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div>
                                                    <div class="leftColumn"><%# Common.getIcon(Eval("FileType")) %>
                                                       </div>
                                                    <a href='<%# Eval("FileURL") %>'><%# Eval("FileName") %></a>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="pull-right"
                                                        CommandName='<%# Eval("CommandName") %>'  CommandArgument='<%# Eval("FileID") %>' 
                                                        Visible='<%# Eval("ShowRemove") %>'><i class='fa fa-trash' aria-hidden='true'></i> Remove</asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                 <asp:Label ID="lblEmptyData"
                                                Text='<%# Common.ShowAlertNoClose("warning", "There are no documents for this event.")%>'  runat="server" Visible="false">
                                         </asp:Label>

                                            </FooterTemplate>
                                        </asp:Repeater>

                                      
                                        <br />

                                            <%--<telerik:RadGrid ID="RadGrid1" runat="server"></telerik:RadGrid>--%>

                                        <asp:LinkButton ID="BtnAttachDocument" runat="server" 
                                            CssClass="btn btn-sm btn-success pull-right"><i class="fa fa-paperclip" aria-hidden="true"></i> Attach Document</asp:LinkButton>


                                       </asp:Panel>

                        <asp:Panel ID="NewDocumentPanel" runat="server" Visible="false">

                        <h3>Upload File</h3>
                            <p>Upload and attach documents to this event only.</p>
                                    <hr />

                            <div class="col-md-12">

            <div class="form-horizontal">
			   
                <div class="form-group">
				    <label class="col-md-2">Upload File</label>

				    <div class="col-md-6">
                        <telerik:RadAsyncUpload ID="RadAsyncUpload" runat="server" MultipleFileSelection="Automatic"
                            HideFileInput="true" 
                AllowedFileExtensions=".pdf,.jpeg,.jpg,.png,.gif,.doc,.docx" />
                        <span class="allowed-attachments">Select files to upload <span class="allowed-attachments-list">(<%= String.Join(",", RadAsyncUpload.AllowedFileExtensions) %>)</span>
            </span>

				    </div>
			    </div>

                <div class="form-group">
				    <label class="col-md-2"></label>

				    <div class="col-md-6">
                        <asp:Button ID="btnSubmitFileUpload" runat="server" Text="Submit" CssClass="btn btn-primary" />
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="btnExitUpload" runat="server" CssClass="btn btn-secondary">Cancel & Close</asp:LinkButton>
				    </div>
			    </div>

                <asp:Label ID="msgUploadError" runat="server" />
            </div>
</div>
        </asp:Panel>

                                    </div>
                                </div>
                            </div>


                        </telerik:RadPageView>

                    </telerik:RadMultiPage>

                </asp:Panel>
            </div>



            <div class="col-md-6">
                <h4>POS Shipping/Logistics</h4>
                <asp:Panel ID="LogisticsPanel" runat="server">

                    <telerik:RadTabStrip ID="POSRadTabStrip" runat="server" MultiPageID="POSRadMultiPage" AutoPostBack="false" SelectedIndex="0" Skin="Bootstrap">
                        <Tabs>
                            <telerik:RadTab Text="Kits" runat="server" ID="kitsTab" Value="kits"></telerik:RadTab>
                            <telerik:RadTab Text="Shipping Location" runat="server" ID="shippinglocationTab" Value="shippinglocation"></telerik:RadTab>
                            <telerik:RadTab Text="Cost" runat="server" ID="costTab" Value="cost"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>

                    <telerik:RadMultiPage runat="server" ID="POSRadMultiPage" SelectedIndex="0" RenderSelectedPageOnly="false">

                        <telerik:RadPageView runat="server" ID="RadPageView8">

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
                                                <strong>Ship to:</strong><br />
                                                <telerik:RadComboBox ID="SendToList" runat="server" Width="250px">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="FedEx Office" Value="3" />
                                                        <telerik:RadComboBoxItem Text="Brand Ambassador" Value="1" />
                                                        <telerik:RadComboBoxItem Text="Event Location" Value="2" />
                                                        <telerik:RadComboBoxItem Text="Team Lead Pick-up/Drop-off" Value="4" />
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

                                        <hr />

                                        <div class="row" style="padding: 0 15px 10px 15px;">
                                            <div class="col-sm-12 col-md-12">
                                                <asp:Label ID="labelForKits" runat="server" Font-Bold="true" Text="Please check the box below to signify that you want to have a POS kit sent." />
                                            </div>

                                            <div class="col-sm-12 col-md-12" style="right: 5px;">
                                                <asp:CheckBox ID="SelectYesCheckBox" runat="server" Checked="false" Text="Send POS" />
                                            </div>

                                            <div class="col-sm-12 col-md-12" style="margin-left: 15px; margin-top: 5px;">
                                                <asp:CustomValidator ID="CustomValidator1" runat="server"
                                                    ErrorMessage="You must select the checkbox above in order to submit this form." CssClass="errorlabel" ValidationGroup="YesPOS"
                                                    Display="Dynamic"></asp:CustomValidator>

                                            </div>
                                        </div>


                                        <div class="row" style="padding: 15px;">
                                            <div class="col-sm-12 col-md-12">
                                                <div class="pull-right">
                                                    <asp:Button ID="btnSavePosKitRequest" runat="server" Text="Submit" CssClass="btn btn-primary" ValidationGroup="YesPOS" />
                                                </div>
                                            </div>

                                            <div class="col-sm-12 col-md-12">
                                                <asp:Label ID="SuccessLabel" runat="server" />
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView9">

                            <div class="widget stacked Container1">
                                <div class="widget-content" style="min-height: 200px;">

                                    <asp:HiddenField ID="Hidden_POSLatitude" runat="server" Visible="true" />
                                    <asp:HiddenField ID="HIdden_POSLongtitude" runat="server" Visible="true" />

                                    <div class="row" style="padding: 15px;">
                                        <div class="col-sm-12 col-md-12">

                                            <p>
                                                <asp:Label ID="ShippingStatusLabel" runat="server" />
                                            </p>

                                        </div>

                                    </div>

                                    <asp:Panel ID="ShippingPanel" runat="server">

                                        <div class="row" style="padding: 0 15px 0 15px;">
                                            <div class="col-sm-7 col-md-7">

                                                <asp:Label ID="ShippingEventTypeName" runat="server" Font-Bold="true" />

                                                <asp:Repeater ID="POSItems" runat="server" DataSourceID="getKitItems">
                                                    <HeaderTemplate>

                                                        <table class="table compacttable">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Eval("qty") %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("itemName") %>
                                                            </td>

                                                            <td class="pull-right">$<%#Eval("total") %></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>

                                                <asp:LinqDataSource runat="server" EntityTypeName="" ID="getKitItems" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetPosKitItems" Where="eventID == @eventID">
                                                    <WhereParameters>
                                                        <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                                    </WhereParameters>
                                                </asp:LinqDataSource>

                                            </div>


                                            <div class="col-sm-5 col-md-5">

                                                <strong>Shipping Address:</strong><br />
                                                <asp:Label ID="ShippingAddressLabel" runat="server" Text="Shipping Address Label" /><br />
                                                <asp:Label ID="AttLabel" runat="server" /><br />
                                                <br />

                                                <asp:Label ID="ShippedViaLabel" runat="server" /><br />
                                                <asp:Label ID="ShippedTypeLabel" runat="server" /><br />
                                                <asp:Label ID="TrackingLabel" runat="server" />


                                            </div>
                                        </div>

                                    </asp:Panel>

                                </div>
                            </div>


                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView10">

                            <div class="widget stacked">
                                <div class="widget-content" style="min-height: 200px;">

                                    <div class="col-sm-12 col-md-12">

                                        <p>
                                            <asp:Label ID="CostShippingStatusLabel" runat="server" />
                                        </p>

                                    </div>

                                    <asp:Panel ID="CostPanel" runat="server">

                                        <div class="col-sm-12 col-md-12">
                                            <strong>POS Kit</strong>
                                            <asp:Repeater ID="POSItemsRepeater" runat="server" DataSourceID="getKitItems2">
                                                <HeaderTemplate>

                                                    <table class="table compacttable">
                                                        <tr>
                                                            <th>Qty</th>
                                                            <th>Item/Category</th>
                                                            <th class="pull-right">Price</th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%#Eval("qty") %>
                                                        </td>
                                                        <td>
                                                            <%#Eval("itemName") %>
                                                        </td>

                                                        <td class="pull-right">$<%#Eval("total") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>


                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getKitItems2" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="qryGetPosKitItems" Where="eventID == @eventID">
                                                <WhereParameters>
                                                    <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>


                                            <asp:Label ID="ShippingLabel" runat="server" Font-Bold="true" Text="Shipping" /><br />

                                            <asp:Repeater ID="ShippingRepeater" runat="server" DataSourceID="getShippingCost">
                                                <HeaderTemplate>

                                                    <table class="table compacttable">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>Shipping Cost
                                                        </td>
                                                        <td class="pull-right">$<%#Eval("shippingcost") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>


                                            <asp:LinqDataSource runat="server" EntityTypeName="" ID="getShippingCost" ContextTypeName="EventManagerApplication.DataClassesDataContext" TableName="tblPosKits" Where="eventID == @eventID">
                                                <WhereParameters>
                                                    <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                            <asp:Label ID="LogisticsLabel" runat="server" Font-Bold="true" Text="Logistics/Handling" />

                                            <asp:Repeater ID="LogisticsRepeater" runat="server" DataSourceID="getShippingCost">
                                                <HeaderTemplate>

                                                    <table class="table compacttable">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>Material and Handling for 1 kit(s)
                                                        </td>
                                                        <td class="pull-right">$<%#Eval("handlingFee") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>



                                            <hr style="border-top: 1px solid #333;" />

                                            <table class="table">


                                                <tr>
                                                    <td>
                                                        <strong>Total:</strong> </td>
                                                    <td class="pull-right">
                                                        <strong>$<asp:Label ID="TotalCostLabel" runat="server" /></strong>
                                                    </td>
                                                </tr>

                                            </table>

                                        </div>

                                    </asp:Panel>

                                </div>
                            </div>

                        </telerik:RadPageView>

                    </telerik:RadMultiPage>

                </asp:Panel>

            </div>


        </div>


        <asp:Panel ID="RecapPanel" runat="server">
            <div class="row">
                <div class="col-md-12">
                    <h4>Event Recap</h4>
                    <asp:Label ID="RecapStausLabel" runat="server" />

                    <div class="bs-example">


                        <ul id="recapTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                            <li class="active"><a href="#questionnaire" data-toggle="tab">Questionnaire</a></li>
                            <li>
                                <a href="#photogallery" data-toggle="tab">Photo Gallery <span class="badge">
                                    <asp:Label ID="PhotoCountLabel" runat="server" /></span></a></li>

                            <li id="CreateRecapLink" runat="server" class="pull-right" visible="false">
                                <asp:LinkButton ID="btnCreateRecap" runat="server">
                             <i class="fa fa-plus"></i> Create Recap</asp:LinkButton></li>
                            <li id="EditRecapLink" runat="server" class="pull-right" visible="false"><a href="/Events/EditRecap?action=edit&EventID=<%= Request.QueryString("ID") %>"><i class="fa fa-pencil"></i>Edit Recap</a></li>
                            <li id="PrintPDFLink" runat="server" class="pull-right" visible="false">
                                <%--<a href='/Events/EventRecap?ID=<%= Request.QueryString("ID") %>' target="_blank"><i class="fa fa-print"></i> Print PDF File</a>--%>
                                <asp:LinkButton ID="btnCreatePDF" runat="server" Visible="true"><i class="fa fa-print"></i> Print PDF File</asp:LinkButton></li>
                            <asp:LinkButton ID="btnApproveRecap" runat="server" CssClass="btn-success btn-lg pull-right" Visible="false" Style="padding: 9px 10px; font-size: 14px; font-weight: bold; margin-right: 2px;" OnClientClick="javascript:if(!confirm('This action will change the status of the event to Approved. Are you sure?')){return false;}">Approve Recap</asp:LinkButton>
                            <asp:LinkButton ID="btnUnapprove" runat="server" CssClass="btn-primary btn-lg pull-right" Visible="false" Style="padding: 9px 10px; font-size: 14px; font-weight: bold; margin-right: 2px;" OnClientClick="javascript:if(!confirm('This action will change the status of the event to Toplined. Are you sure?')){return false;}">Unapprove</asp:LinkButton>
                        </ul>
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


                            <div class="tab-pane fade" id="photogallery">
                                <div class="widget stacked">
                                    <div class="widget-content" style="min-height: 300px;">

                                        <asp:Panel ID="GalleryPanel" runat="server">
                                            <h3>Photo Gallery </h3>
                                            <asp:LinkButton ID="btnAddPhotos" runat="server" CssClass="btn btn-xs btn-success pull-right"><i class="fa fa-plus"></i>  Add Photo</asp:LinkButton>



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

                                                <EmptyItemTemplate>
                                                    <div class="RadListView RadListView_Default">

                                                        <div class="alert alert-warning" role="alert">
                                                            There are no photos to be displayed.  To add a new items click on the <strong>Add New Photos</strong>
                                                            button above.
                                                        </div>

                                                    </div>
                                                </EmptyItemTemplate>

                                                <ItemTemplate>

                                                    <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">

                                                        <telerik:RadBinaryImage CssClass="image" runat="server" ID="RadBinaryImage1"
                                                            SavedImageName='<%#Eval("photoID") %>'
                                                            DataValue='<%#Eval("SmallImage") %>'
                                                            Height='<%#ImageHeight %>'
                                                            Width="<%#ImageWidth %>"
                                                            ResizeMode="Crop"
                                                            onclick='<%#CreateWindowScript3(Eval("eventID"), Eval("photoID")) %>'
                                                            AlternateText="Click to view larger image"
                                                            ToolTip="Click to view larger image" />

                                                        <div style="margin-top: -22px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">


                                                            <asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>' CommandName="DeleteImage" Visible='<%# showHide() %>'><i class="fa fa-trash fa-1x delete pull-right"></i></asp:LinkButton><%--                                                                            <asp:Button ID="btnDelete" CommandName="DeleteImage" CommandArgument='<%#Eval("photoID") %>' runat="server"
                                                                                Text="Delete" CssClass="txt" />--%><asp:LinkButton ID="btnRotateImageLeft1" runat="server" ToolTip="Rotate Left" CommandName="RotateLeft" CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-undo fa-1x bin"></i></asp:LinkButton><asp:LinkButton ID="btnRotateImage1" runat="server" ToolTip="Rotate Right" CommandName="RotateRight" CommandArgument='<%# Eval("photoID") %>'>
                                            <i class="fa fa-repeat fa-1x bin"></i></asp:LinkButton><asp:HyperLink ID="btnDownload" runat="server" NavigateUrl='<%#"/gallery/downloadhandler.aspx?photoID=" & Eval("photoID") %>'><i class="fa fa-download fa-1x bin"></i></asp:HyperLink>
                                                        </div>
                                                    </div>

                                                </ItemTemplate>



                                            </telerik:RadListView>






                                            <asp:Label ID="errorLabel" runat="server" />

                                            <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                                                SelectCommand="SELECT [photoID], [photoTitle], [photoDescription], [SmallImage], [accountID], [eventID], [brandID] FROM [tblPhoto] WHERE ([eventID] = @eventID) and ([Tag] Is Not Null)">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="String"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </asp:Panel>

                                        <asp:Panel ID="UploadPanel" runat="server" Visible="false">
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
                                        </asp:Panel>

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

                            <!-- End questionnaire -->
                            <!-- End Gallery -->


                        </div>
                        <!-- end content -->

                    </div>
                </div>

            </div>
        </asp:Panel>
    </div>

    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Event status updated to Booked!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification2" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="Event status updated to Scheduled!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <script type="text/javascript">
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

                                                // var string1 = username + ";" + eventid;
                                                var string1 = "EventDetails";

                                                $.ajax({
                                                    type: "POST",
                                                    url: "/ClientService.asmx/LoadBingMap",
                                                    data: "{ 'mystring': '" + string1 + "'}",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    success: function (response) {
                                                        //alert("You have been checked in");

                                                    },
                                                    error: function (request, status, error) {
                                                        //alert(request.responseText);
                                                    },

                                                    complete: function (response) {
                                                        //alert("You are now able to go to work");
                                                    }

                                                });

                                                // Initialize the map
                                                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'

                   var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var locName = $('#<%=LocationNameMap.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
                        center: new Microsoft.Maps.Location(lat, long),
                        zoom: 10
                    });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                document.getElementById('printoutPanel').style.display = "none";


                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

                                            }

                                            function createDirections() {
                                                document.getElementById('printoutPanelGas').style.display = "none";
                                                document.getElementById('printoutPanelConvenience').style.display = "none";
                                                document.getElementById('printoutPanelGrocery').style.display = "none";
                                                document.getElementById('printoutPanel').style.display = "block";

                                                // Initialize the map
                                                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
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

               }

               function createDirectionsByAddress() {
                   document.getElementById('printoutPanelGas').style.display = "none";
                   document.getElementById('printoutPanelConvenience').style.display = "none";
                   document.getElementById('printoutPanelGrocery').style.display = "none";
                   document.getElementById('printoutPanel').style.display = "block";

                   // Initialize the map
                   var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
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

            }



            function MapTraffic() {
                $("#hideTraffic").show();
                $("#showTraffic").hide();
                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";


                // Initialize the map
                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
                        center: new Microsoft.Maps.Location(lat, long),
                        zoom: 10
                    });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

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
                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
                        center: new Microsoft.Maps.Location(lat, long),
                        zoom: 10
                    });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

            }


            function GetGasStations() {
                document.getElementById('printoutPanelGrocery').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                // Initialize the map
                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
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

            }


            function GetGroceryStores() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                // Initialize the map
                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
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

            }


            function GetConvenienceStores() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                // Initialize the map
                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map, queryOptions, numResults;
                var pageIdx = 0;
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
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

            }

            function ClearMap() {

                document.getElementById('printoutPanelGas').style.display = "none";
                document.getElementById('printoutPanelConvenience').style.display = "none";
                document.getElementById('printoutPanelGrocery').style.display = "none";
                // Initialize the map
                var bingkey = '<%=ConfigurationManager.AppSettings("BingMapsAPIKey").ToString() %>'
                var lat = $('#<%=LatitudeTextBox.ClientID%>').val();
                var long = $('#<%=LongtitudeTextBox.ClientID%>').val();
                var map = new Microsoft.Maps.Map(document.getElementById('mapDiv'),
                    {
                        credentials: bingkey,
                        center: new Microsoft.Maps.Location(lat, long),
                        zoom: 10
                    });

                var pushpin = new Microsoft.Maps.Pushpin(map.getCenter(), { color: 'red' });
                map.entities.push(pushpin);

                $("#btnFindGroceryStoresLink").removeClass("btn-success");
                $("#btnFindConvienienceStoresLink").removeClass("btn-success");
                $("#btnFindGasStationsLink").removeClass("btn-success");

            }

        </script>


    </telerik:RadScriptBlock>

    <script src="/events/js/RequiredPositions.js"></script>

    <asp:Panel ID="LoadMapPanel" runat="server" Visible="true">
        <script type='text/javascript' src='http://www.bing.com/api/maps/mapcontrol?branch=release&callback=GetMap' async defer></script>
    </asp:Panel>

    <script type="text/javascript">
            $('#events').addClass('active');
            $('#events_dropdown').addClass('active');

            //$('.ui-tooltip').tooltip();

            function getLink(link) {
                //alert(link);
                var win = window.radopen(link, 'null');
                win.center(); win.setSize(700, 700); win.set_status = ' ';
                win.SetModal(true);
                win.set_behaviors(Telerik.Web.UI.WindowBehaviors.Close + Telerik.Web.UI.WindowBehaviors.Move + Telerik.Web.UI.WindowBehaviors.Resize);
            }

            function OnBlur(sender, args) {
                if (sender.get_value() == "") {
                    sender.set_value("0");
                }
            }


    </script>



    <%--   <link href="/skins/square/blue.css" rel="stylesheet" />
    <link href="/skins/square/green-red.css" rel="stylesheet" />
    <script src="/js/icheck.js"></script>

    <script>
            $(document).ready(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '30%' // optional

                });
            });

            function formatCheckBox() {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '30%' // optional

                });
            }
    </script>--%>
</asp:Content>

