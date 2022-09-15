<%@ Page Title="Edit Event" Language="vb" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Dashboard.Master" CodeBehind="EditEvent.aspx.vb" Inherits="EventManagerApplication.EditEventaspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <style>
        #span1 {
            display: none;
        }
        .fixblock {
            display: inline;
        }

    </style>

    <link href="UserControls/css/listcontainer.css" rel="stylesheet" />

    <link href="../Theme/css/custom.css" rel="stylesheet" />

    <!-- Add msgLabel here -->

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Edit Event Details</h2>
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

        <asp:Label ID="msgLabel" runat="server" />



    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

        <AjaxSettings>

            <telerik:AjaxSetting AjaxControlID="FormPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="FormPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="LocationPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="CancelEventPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="BrandPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BrandPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="LocationPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="FormPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="LocationPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="CancelEventPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="FormPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="CancelEventPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

             <telerik:AjaxSetting AjaxControlID="LastMinuteCheckBox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="WarningPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DonePanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
        
    </telerik:RadAjaxManager>


    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Style="position: absolute; top: 0; left: 0; width: 100%; height: 100%">
    </telerik:RadAjaxLoadingPanel>



        <div id="span1">
            <asp:Panel ID="ValidationPanel" runat="server">

                <i class="fa fa-refresh fa-spin fa fa-fw"></i>
                <span class="text-success">Saving Changes...</span>

            </asp:Panel>

        </div>

        <div id="formPanel">
            <asp:Panel ID="FormPanel" runat="server">
        <asp:FormView ID="EditEventForm" runat="server" Width="100%" DefaultMode="Edit" DataKeyNames="eventID" DataSourceID="GetEvent">
            <EditItemTemplate>

                <div class="row">

                    <div class="col-md-12">

                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Save Changes" CssClass="btn btn-primary" OnClientClick="ValidatePage()" />
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default"   />



                        <asp:LoginView ID="LoginView_AddButton" runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="Administrator, EventManager, Recruiter/Booking">
                                    <ContentTemplate>
                                        <div class="btn-group pull-right" role="group" aria-label="...">

                                    <asp:LinkButton ID="btnEnableEvent" CommandName="EnableEvent" runat="server" CssClass="btn btn-success" Visible='<%# showEnable() %>'><i class="fa fa-check-square-o" aria-hidden="true"></i>  Enable Event</asp:LinkButton>

                                        <asp:LinkButton ID="CancelEventButton" runat="server" CausesValidation="False" CommandName="CancelEvent" CssClass="btn btn-warning"
                                                OnClientClick="javascript:if(!confirm('This action will remove any assigned BA's and mark the event as canceled. Are you sure?')){return false;}" Visible='<%# showCancel() %>'>
                                                <i class="fa fa-ban"></i>  Cancel Event
                                            </asp:LinkButton>


                                            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="DeleteEvent" CssClass="btn btn-danger pull-right"
                                                OnClientClick="javascript:if(!confirm('This action will delete the selected event and assignments. Are you sure?')){return false;}">
                                                <i class="fa fa-trash"></i>  Delete Event
                                            </asp:LinkButton>

                                            </div>
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>



                        <p>Use the tabs below to edit the event detail and settings.  Click "Save Changes" to update the system.</p>

                        <hr />

                        <%--<ul id="myTab" class="nav nav-tabs" style="margin-bottom: 3px; border-bottom: 0">
                            <li class="active"><a href="#details" data-toggle="tab">Event Information</a></li>
                            <li class=""><a href="#brands" data-toggle="tab">Brands</a></li>
                            <li class=""><a href="#date" data-toggle="tab">Date & Times</a></li>
                            <li class=""><a href="#more" data-toggle="tab">Event Details</a></li>
                            <li class=""><a href="#location" data-toggle="tab">Location</a></li>
                            <li class=""><a href="#poskit" data-toggle="tab">POS Kit Pickup</a></li>
                            <li class=""><a href="#budget" data-toggle="tab">Budget & Event Tracking</a></li>
                        </ul>

                        <div class="tab-content" id="tabs">

                            <!-- Event Detail -->

                            <div class="tab-pane fade active in" id="details">
                                

                            </div>


                            <!-- Date & Time -->

                            <div class="tab-pane fade" id="date">

                                
                            </div>

                            <div class="tab-pane fade" id="brands">

                                
                            </div>

                            <div class="tab-pane fade" id="budget">

                                
                            </div>

                            <!-- Location -->

                            <div class="tab-pane fade" id="location">
                                



                            </div>




                            <!-- More -->

                            <div class="tab-pane fade" id="more">
                                


                            </div>


                            <!-- Poskit -->

                            <div class="tab-pane fade" id="poskit">
                                
                            </div>



                        </div>--%>

                        

                    <telerik:RadTabStrip runat="server" ID="RadTabStrip1" MultiPageID="RadMultiPage1" SelectedIndex="0" AutoPostBack="false">
                        <Tabs>
                            <telerik:RadTab Text="Event Information" runat="server"></telerik:RadTab>
                            <telerik:RadTab Text="Brands" runat="server"></telerik:RadTab>
                            <telerik:RadTab Text="Date & Times" runat="server"></telerik:RadTab>
                            <telerik:RadTab Text="Event Details" runat="server"></telerik:RadTab>
                            <telerik:RadTab Text="Location" runat="server"></telerik:RadTab>
                            <telerik:RadTab Text="POS Kit Pickup" runat="server"></telerik:RadTab>
                            <telerik:RadTab Text="Budget & Event Tracking" runat="server"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>

                    <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
                        <telerik:RadPageView runat="server" ID="RadPageView1">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="form-horizontal">

                                                     <%--<div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Status</label>
                                                        <div class="col-sm-9">
                                                            <asp:DropDownList ID="statusIDTextBox" runat="server" DataSourceID="GetStatusList" DataTextField="statusName" DataValueField="statusID" SelectedValue='<%# Bind("statusID") %>' CssClass="form-control"></asp:DropDownList>

                                                        </div>
                                                    </div>--%>

                                                 <div class="form-group">
                                                        <label class="col-sm-3 control-label">Event Type:</label>
                                                        <div class="col-sm-9">

                                                            <asp:DropDownList ID="EventTypeIDTextBox" runat="server" DataSourceID="GetEventTypeList"
                                                                SelectedValue='<%# Bind("eventTypeID") %>' CssClass="form-control" DataTextField="eventTypeName"
                                                                DataValueField="eventTypeID">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Name of Event:</label>
                                                        <div class="col-sm-9">
                                                            <asp:TextBox ID="eventTitleTextBox" runat="server" Text='<%# Bind("eventTitle") %>' CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Supplier:</label>
                                                        <div class="col-sm-9">

                                                            <asp:DropDownList ID="supplierIDTextBox" runat="server" Enabled="false" DataSourceID="getSuppliers" CssClass="form-control" DataTextField="supplierName" DataValueField="supplierID" SelectedValue='<%# Bind("supplierID") %>'>
                                                            </asp:DropDownList>

                                                    <asp:LinqDataSource ID="getSuppliers" runat="server"
                                                        ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                        EntityTypeName="" OrderBy="supplierName" TableName="tblSuppliers">

                                                    </asp:LinqDataSource>

                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Team:</label>
                                                        <div class="col-md-9">

                                                        <telerik:RadComboBox ID="TeamComboBox" runat="server" DataSourceID="GetTeamList" DataTextField="teamName" 
                                                            DataValueField="teamID" MarkFirstMatch="true" Width="400px" AppendDataBoundItems="true" 
                                                            SelectedValue='<%# Bind("teamID") %>'>                                                         
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="None" Value="0" Selected="true" />
                                                            </Items>
                                                        </telerik:RadComboBox>

                                                        <p>Assigning an event to a team will limit the view of the events to only BA's assigned to the team.</p>

                                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="GetTeamList" 
                                                            ContextTypeName="EventManagerApplication.DataClassesDataContext" 
                                                            OrderBy="teamName" TableName="tblTeams" Where="active == @active">
                                                            <WhereParameters>
                                                                <asp:Parameter DefaultValue="True" Name="active" Type="Boolean"></asp:Parameter>
                                                            </WhereParameters>
                                                        </asp:LinqDataSource>

                                                        </div>
                                                    </div>





                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Event Description:</label>
                                                        <div class="col-sm-9">
                                                            <telerik:RadEditor ID="eventDescriptionRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("eventDescription")%>' Width="100%" Height="300px"></telerik:RadEditor>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Program Name:</label>
                                                        <div class="col-sm-5">
                                                            <asp:TextBox ID="programNameTextBox" runat="server" Text='<%# Bind("programName") %>' CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                 <%--<div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Source</label>
                                                        <div class="col-sm-5">
                                                            <telerik:RadComboBox ID="RadComboBox1" runat="server" MarkFirstMatch="true"                                       Width="200px" AppendDataBoundItems="true" 
                                                                SelectedValue='<%# Bind("createdSource") %>'>                                                         
                                                            <Items>
                                                                <telerik:RadComboBoxItem Text="None" Value="" />
                                                                <telerik:RadComboBoxItem Text="Imported" Value="2" />
                                                                <telerik:RadComboBoxItem Text="Requested" Value="3" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        </div>
                                                    </div>--%>

                                                    
                                                </div>

                                        <%--<asp:LinqDataSource ID="GetEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                    EntityTypeName="" OrderBy="eventTypeName" TableName="tblEventTypes"></asp:LinqDataSource>--%>

                                        <asp:LinqDataSource ID="GetEventTypeList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                            EntityTypeName="" OrderBy="eventTypeName" TableName="qryEventTypeByClients" Where="clientID == @clientID">
                                            <WhereParameters>
                                                <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>

                                        <asp:LinqDataSource ID="GetStatusList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                                    EntityTypeName="" OrderBy="statusName" TableName="tblStatus"></asp:LinqDataSource>

                                            </div>

                                            <div class="col-md-4">
                                                <%--Right side for instructions--%>


                                            </div>

                                        </div>
                                    </div>

                                </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView2">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">
                                        <div class="row">
                                            <div class="col-md-8">

                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Brands:</label>
                                                        <div class="col-sm-9">

                                                            <asp:Panel ID="BrandPanel" runat="server">
                                                            <div class="list-containers">

                                                                    <div class="list-container size-thin">
                                                                        <div class="title">
                                                                            Available Brands
                                                                        </div>
                                                                        <telerik:RadListBox ID="AssociatedBrandsList" runat="server"
                                                                            TransferToID="SelectedBrandsList"
                                                                            AllowTransferOnDoubleClick="True"
                                                                            EnableDragAndDrop="True"
                                                                            ButtonSettings-AreaWidth="35px" Height="200px" Width="225px"
                                                                            DataKeyField="brandID"
                                                                            DataSortField="brandName"
                                                                            DataSourceID="SqlDataSource1"
                                                                            DataTextField="brandName"
                                                                            DataValueField="brandID"
                                                                            AutoPostBack="false"
                                                                            AllowTransfer="True"
                                                                            AutoPostBackOnTransfer="true"
                                                                            Skin="Bootstrap">
                                                                            <ButtonSettings ShowTransferAll="false" />

                                                                        </telerik:RadListBox>
                                                                    </div>

                                                                    <div class="list-container size-thin">

                                                                        <div class="title">
                                                                            Selected Brands
                                                                        </div>
                                                                        <telerik:RadListBox runat="server" ID="SelectedBrandsList"
                                                                            OnInserted="SelectedBrandsList_Inserted1" OnDeleted="SelectedBrandsList_Deleted1"
                                                                            AllowDelete="True"
                                                                            AutoPostBack="false"
                                                                            DataSourceID="getSelectedBrands"
                                                                            DataKeyField="brandID"
                                                                            DataTextField="brandName"
                                                                            DataValueField="brandID"
                                                                            DataSortField="brandName"
                                                                            AutoPostBackOnDelete="true"
                                                                            Height="200px" Width="225px" Skin="Bootstrap">
                                                                        </telerik:RadListBox>

                                                                    </div>

                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </div>


                                                   


                                                  
                                                </div>


                                            </div>

                                            <div class="col-md-4">

                                            </div>
                                        </div>
                                    </div>
                                </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView3">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">
                                        <div class="row">
                                            <div class="col-md-4">

                                                <div class="form-horizontal">
                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-4 control-label">Event Date:</label>
                                                        <div class="col-sm-8">

                                                            <telerik:RadDatePicker ID="EventDatePicker" runat="server" Culture="en-US"
                                                                DbSelectedDate='<%# Bind("eventDate") %>' Skin="Bootstrap">
                                                            </telerik:RadDatePicker>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-4 control-label">Start Time:</label>
                                                        <div class="col-sm-8">

                                                            <telerik:RadTimePicker ID="StartTimeDatePicker" runat="server" ShowPopupOnFocus="true"  Skin="Bootstrap" DbSelectedDate='<%# Bind("startTime")%>'></telerik:RadTimePicker>

                                                            <%-- <telerik:RadDateTimePicker  ID="StartDateTimePicker" Culture="en-US" ShowPopupOnFocus="true" runat="server"  Skin="Bootstrap" Width="230px" DbSelectedDate='<%# Bind("startTime")%>'></telerik:RadDateTimePicker>--%>

                                                        </div>
                                                    </div>


                                                    <%--<div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-4 control-label">End Time:</label>
                                                        <div class="col-sm-8">
                                                                                                                 

                                                             <telerik:RadDateTimePicker  ID="EndDateTimePicker" Culture="en-US" ShowPopupOnFocus="true" runat="server"  Skin="Bootstrap" Width="230px" DbSelectedDate='<%# Bind("endTime")%>'></telerik:RadDateTimePicker>

                                                        </div>
                                                    </div>--%>



                                                     <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-4 control-label">Duration:</label>
                                                        <div class="col-sm-8">

                                                            <asp:DropDownList ID="HoursDropDownList1" runat="server" Width="70px" AppendDataBoundItems="true" 
                                                                SelectedValue='<%# Bind("eventHours")%>' CssClass="form-control fixblock">
                                                                <asp:ListItem Text="0" Value="0" />
                                                                <asp:ListItem Text="1" Value="1" />
                                                                    <asp:ListItem Text="2" Value="2" />
                                                                    <asp:ListItem Text="3" Value="3" />
                                                                    <asp:ListItem Text="4" Value="4" />
                                                                    <asp:ListItem Text="5" Value="5" />
                                                                    <asp:ListItem Text="6" Value="6" />
                                                                    <asp:ListItem Text="7" Value="7" />
                                                                    <asp:ListItem Text="8" Value="8" />
                                                                    <asp:ListItem Text="9" Value="9" />
                                                                    <asp:ListItem Text="10" Value="10" />
                                                                    <asp:ListItem Text="11" Value="11" />
                                                                    <asp:ListItem Text="12" Value="12" />
                                                                <asp:ListItem Text="13" Value="13" />
                                                                <asp:ListItem Text="14" Value="14" />
                                                                <asp:ListItem Text="15" Value="15" />
                                                                <asp:ListItem Text="16" Value="16" />
                                                            </asp:DropDownList> Hours

                                                            <asp:DropDownList ID="MinutesDropDownList1" runat="server" Width="70px" AppendDataBoundItems="true" 
                                                                SelectedValue='<%# Bind("eventMinutes")%>' CssClass="form-control fixblock">
                                                                <asp:ListItem Text="0" Value="0" />
                                                                <asp:ListItem Text="5" Value="5" />
                                                                <asp:ListItem Text="10" Value="10" />
                                                                    <asp:ListItem Text="15" Value="15" />
                                                                <asp:ListItem Text="20" Value="20" />
                                                                <asp:ListItem Text="25" Value="25" />
                                                                    <asp:ListItem Text="30" Value="30" />
                                                                <asp:ListItem Text="35" Value="35" />
                                                                <asp:ListItem Text="40" Value="40" />
                                                                    <asp:ListItem Text="45" Value="45" />
                                                                <asp:ListItem Text="50" Value="50" />
                                                                <asp:ListItem Text="55" Value="55" />
                                                                </asp:DropDownList> Minutes
                                                         </div>
                                                      </div>



                                                </div>


                                            </div>

                                            <div class="col-md-8">

                                                <div class="alert alert-warning">
                                                  <strong>Warning!</strong> Changing the Event Date, Start Time, or Duration will automatically update the dates and times for any positions and assignments.
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView4">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">

                                        <div class="row">
                                            <div class="col-md-8">

                                                <div class="form-horizontal">
                                                    
                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Attire:</label>
                                                        <div class="col-sm-9">

                                                            <telerik:RadEditor ID="RadEditor1" runat="server" RenderMode="Lightweight" ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("attire")%>' Width="100%" Height="300px"></telerik:RadEditor>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">POS Requirements:</label>
                                                        <div class="col-sm-9">
                                                            <telerik:RadEditor ID="posRequirementsRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("posRequirements")%>' Width="100%" Height="300px"></telerik:RadEditor>

                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Sampling Notes:</label>
                                                        <div class="col-sm-9">
                                                            <telerik:RadEditor ID="samplingNotesRadEditor" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("samplingNotes")%>' Width="100%" Height="300px"></telerik:RadEditor>

                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="col-md-4">
                                                <%--Right side for instructions--%>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView5">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">

                                        <div class="row">

                                            <div class="col-md-8">
                                                <div class="form-horizontal">


                                                    <asp:Panel ID="LocationPanel" runat="server" Visible="true">

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label">Selected Account:</label>
                                                            <div class="col-sm-9" style="padding-top: 8px;">
                                                                <asp:Label ID="AccountNameLabel" runat="server" /><br />
                                                                <asp:Label ID="AccountAddressLabel" runat="server" /><br />
                                                                <asp:Label ID="AccountCityStateLabel" runat="server" /><br />
                                                                <br />
                                                                <asp:Button ID="btnRemoveAccount" runat="server" Text="Change Account" CssClass="btn btn-default btn-sm" Visible="true" CommandName="ChangeAccount" />


                                                            </div>
                                                        </div>
                                                    </asp:Panel>

                                                    

                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <%--Right side for instructions--%>
                                            </div>

                                        </div>
                                            
                                    </div>

                                </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView6">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">

                                        <div class="row">
                                            <div class="col-md-8">


                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-3 control-label">FedEx Office Print and Ship Center:</label>
                                                    <div class="col-sm-9">

                                                        <telerik:RadEditor ID="RadEditor2" runat="server" RenderMode="Lightweight"  ToolsFile="BasicTools.xml" EditModes="Design" Content='<%# Bind("posShippingAddress")%>' Width="100%" Height="300px"></telerik:RadEditor>


                                                    </div>
                                                </div>



                                            </div>

                                            <div class="col-md-4">
                                                <%--Right side for instructions--%>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                        </telerik:RadPageView>

                        <telerik:RadPageView runat="server" ID="RadPageView7">

                            <div class="widget stacked">
                                    <div class="widget-content min-height">
                                        <div class="row">
                                            <div class="col-md-8">

                                                <div class="form-horizontal">

                                                    <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Billable Event:</label>
                                                        <div class="col-sm-9">
                                                            <asp:CheckBox ID="billableEventCheckBox" runat="server" data-group-cls="btn-group-sm" Checked='<%# Bind("billableEvent") %>'  />

                                                            
                                                        </div>
                                                    </div>

                                                   
                                                       

                                                            <div class="form-group">
                                                            <label class="col-sm-3 control-label">PO Number:</label>
                                                            <div class="col-sm-3">

                                                                <%--<asp:TextBox ID="POTextBox" runat="server" Text='<%# Bind("purchaseOrderNumber") %>' CssClass="form-control"/>--%>

                                                        <telerik:RadComboBox  ID="PONumberComboBox" runat="server" DataSourceID="getPOs"
                                                            DataTextField="purchaseOrderNumber" Width="200px" AllowCustomText="true" MarkFirstMatch="true"
                                                            DataValueField="purchaseOrderID" SelectedValue='<%# Bind("purchaseOrderNumber") %>' AppendDataBoundItems="true">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Value='<%# DBNull.Value %>' Text="None" Selected="true" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                                
                                            <asp:LinqDataSource ID="getPOs" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EntityTypeName="" TableName="tblPurchaseOrders" Where="supplierID == @supplierID">
                                                <WhereParameters>
                                                    <asp:ControlParameter ControlID="supplierIDTextBox" PropertyName="SelectedValue" DefaultValue="" Name="supplierID" Type="Int32"></asp:ControlParameter>
                                                </WhereParameters>
                                            </asp:LinqDataSource>

                                                            </div>
                                                        
                                                           
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label">Distributor:</label>
                                                            <div class="col-sm-5">

                                                                <asp:TextBox ID="DistributorTextBox" runat="server" Text='<%# Bind("distributer") %>' CssClass="form-control"/>


                                                            </div>
                                                        
                                                           
                                                        </div>

                                                        <div class="form-group">
                                                        <label for="inputEmail3" class="col-sm-3 control-label">Requested by:</label>
                                                        <div class="col-sm-5">
                                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("requestedBy") %>' CssClass="form-control" />
                                                        </div>
                                                    </div>

                                                    

                                                    <asp:PlaceHolder ID="SupplierBudgetPlaceHolder" runat="server"></asp:PlaceHolder>
                                                   


                                                  
                                                </div>


                                            </div>

                                            <div class="col-md-4">

                                            </div>
                                        </div>
                                    </div>
                                </div>

                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                        

                        


                    </div>

                </div>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                    SelectCommand="getAvailableBrandsBySupplierForEvent" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="supplierIDTextBox" Name="supplierID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:QueryStringParameter Name="eventID" QueryStringField="EventID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:LinqDataSource ID="GetBrandsBySupplier" runat="server"
                    ContextTypeName="EventManagerApplication.DataClassesDataContext"
                    EntityTypeName="" TableName="getBrandsbySuppliers" Where="supplierID == @supplierID">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="supplierIDTextBox" Name="supplierID" PropertyName="SelectedValue" Type="Int32" />
                    </WhereParameters>
                </asp:LinqDataSource>

                <asp:SqlDataSource ID="getSelectedBrands" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="getBrandsInEvent"
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="eventID" QueryStringField="EventID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </EditItemTemplate>






        </asp:FormView>
            </asp:Panel>
        </div>


        <div class="form-horizontal">

    <asp:Panel ID="LocationPanel" runat="server" Visible="false">
            <asp:Panel ID="SearchPanel" runat="server" Visible="true">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Search Market: <span class="text-danger">*</span>
                        <br />
                        <br />
                        <asp:LinkButton ID="btnCancelLocation" runat="server" CssClass="btn btn-default">Cancel Change Location</asp:LinkButton>
                    </label>
                    <div class="col-sm-5">
                        <asp:DropDownList ID="MarketList" runat="server" AutoPostBack="true"
                            DataSourceID="GetMarketList" DataTextField="marketName"
                            DataValueField="marketID" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem Text="-- Select Market to Search --" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <%--<div class="form-group">
                    <label class="col-sm-3 control-label">Search Account:</label>
                    <div class="col-sm-5">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search by Account Name" name="q" />
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                            </div>
                        </div>

                    </div>
                </div>--%>
            </asp:Panel>
            <!-- End Search Panel -->


            <asp:Label ID="Label1" runat="server" />

            <asp:Panel ID="ResultsPanel" runat="server" Visible="false">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Select an Account:</label>
                    <div class="col-sm-9">

                        <!-- Find the results until the selected market is changed -->
                        <telerik:RadGrid ID="ResultsGrid" runat="server" CellSpacing="-1" DataSourceID="GetAccountListbyMarketSearch"
                            Visible="false" GridLines="None" GroupPanelPosition="Top"
                            AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True">

                            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

                            <MasterTableView AutoGenerateColumns="False" DataSourceID="GetAccountListbyMarketSearch">

                                <Columns>

                                    <telerik:GridTemplateColumn AllowFiltering="false">
                                        <ItemStyle Width="40px" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnSelect" runat="server"
                                                CommandName="SelectAccount" CommandArgument='<%# Eval("Vpid") %>'
                                                CssClass="btn btn-primary btn-md" ForeColor="White">Select</asp:LinkButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridBoundColumn DataField="accountName"
                                        FilterControlAltText="Filter accountName column"
                                        HeaderText="Account Name" ReadOnly="True" SortExpression="accountName"
                                        UniqueName="accountName"
                                        FilterControlWidth="175px"
                                        AutoPostBackOnFilter="true"
                                        CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="streetAddress1"
                                        FilterControlAltText="Filter streetAddress1 column"
                                        HeaderText="Address" ReadOnly="True"
                                        SortExpression="streetAddress1" UniqueName="streetAddress1"
                                        FilterControlWidth="150px"
                                        AutoPostBackOnFilter="true"
                                        CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false">
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="City"
                                        FilterControlAltText="Filter city column"
                                        HeaderText="City"
                                        ReadOnly="True"
                                        SortExpression="city"
                                        UniqueName="city">

                                        <FilterTemplate>
                                            <telerik:RadComboBox ID="FilterCityTextBox"
                                                Height="200px" Width="150px" AppendDataBoundItems="True"
                                                runat="server" DataSourceID="GetCityList" DataTextField="city"
                                                DataValueField="city" SelectedValue='<%# TryCast(Container, GridItem).OwnerTableView.GetColumn("city").CurrentFilterValue%>'
                                                OnClientSelectedIndexChanged="CityIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="All" />
                                                </Items>
                                            </telerik:RadComboBox>

                                            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                                <script type="text/javascript">
                                                    function CityIndexChanged(sender, args) {
                                                        var tableView = $find("<%# TryCast(Container, GridItem).OwnerTableView.ClientID %>");
                                                    tableView.filter("city", args.get_item().get_value(), "EqualTo");
                                                }
                                                </script>
                                            </telerik:RadScriptBlock>

                                        </FilterTemplate>

                                    </telerik:GridBoundColumn>
                                    
                                </Columns>

                            </MasterTableView>

                            <PagerStyle Position="TopAndBottom" />

                        </telerik:RadGrid>

                    </div>
                </div>
            </asp:Panel>
            <!-- End Results Panel -->
    </asp:Panel>
            </div>


        <div class="form-horizontal">

            <asp:Panel ID="CancelEventPanel" runat="server" Visible="false">

                <h3>Cancel Event</h3>
                <hr />

                <asp:Label ID="msgLabel2" runat="server" />

                <asp:Panel ID="WarningPanel" runat="server">
                    <div class="form-group">
                        <div class="col-md-6">
                            <div class="alert alert-warning" role="alert">All assinged BA's will be removed from this event unless it is marked as Last Minute.</div>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="DonePanel" runat="server" Visible="false">
                    <div class="form-group">
                        <div class="col-md-6">
                            <div class="alert alert-success" role="alert">Any BA's assigned to this event will remain unless you remove them from the Event Details page.</div>
                        </div>
                    </div>
                </asp:Panel>

                <div class="form-group">
                    <div class="col-md-10">
                        <asp:CheckBox ID="LastMinuteCheckBox" runat="server" Text="Last Minute"  />
                        <%--<span class="help-block">Any BA's assigned to this event will remain unless you remove them from the Event Details page.</span>--%>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-1 control-label">Explaination:</label>
                    <div class="col-sm-12" style="padding-left: 20px;">
                        <asp:TextBox ID="ExplainationTextBox" runat="server" TextMode="MultiLine" Height="120px" Width="650px" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <%--<div class="form-group">
                    <div class="col-md-2">
                        <asp:CheckBox ID="NotifyCheckBox" runat="server" Text="Notify BA's Assigned" />
                    </div>
                </div>--%>

                <div class="form-group">
                    <div class="col-md-2">
                        <asp:Button ID="btnConfirmCancel" runat="server" Text="Confirm" CssClass="btn btn-success" />
                        <asp:Button ID="btnCancelCancel" runat="server" Text="Cancel" CssClass="btn btn-default" />
                    </div>
                </div>

            </asp:Panel>

        </div>


        <asp:LinqDataSource ID="GetMarketList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
            EntityTypeName="" OrderBy="marketName" TableName="qryMarketsbyClients" Where="clientID == @clientID">
            <WhereParameters>
                <asp:ControlParameter ControlID="HiddenClientID" Name="clientID" PropertyName="Value" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <%--<asp:LinqDataSource ID="GetAccountListbyMarketSearch" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
            EntityTypeName="" OrderBy="accountName" Select="new (Vpid, accountID, accountName, streetAddress1, city, state, zipCode)" TableName="tblAccounts" Where="clientID == @clientID &amp;&amp; marketID == @marketID">
            <WhereParameters>
                <asp:ControlParameter ControlID="MarketList" Name="marketID" PropertyName="SelectedValue" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>--%>

    <asp:LinqDataSource ID="GetAccountListbyMarketSearch" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="accountName" TableName="qryViewAccounts" Where="marketID == @marketID">
        <WhereParameters>

            <asp:ControlParameter ControlID="MarketList" Name="marketID" PropertyName="SelectedValue" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="GetCityList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="city" TableName="qryAccountCityLists" Where="marketID == @marketID">
        <WhereParameters>
            <asp:ControlParameter ControlID="MarketList" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
        </WhereParameters>
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="GetStateList" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" OrderBy="city" TableName="qryStateListbyMarketIDs" Where="marketID == @marketID">
        <WhereParameters>
            <asp:ControlParameter ControlID="MarketList" PropertyName="SelectedValue" Name="marketID" Type="Int32"></asp:ControlParameter>
        </WhereParameters>
    </asp:LinqDataSource>

        <asp:LinqDataSource ID="GetEvent" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="tblEvents" Where="eventID == @eventID">
            <WhereParameters>
                <asp:QueryStringParameter Name="eventID" QueryStringField="EventID" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <br />

    </div>

    <asp:HiddenField ID="HF_SelectedItemID" runat="server" />
    <asp:HiddenField ID="HiddenClientID" runat="server" />


    <telerik:RadNotification RenderMode="Lightweight" ID="RadNotification1" runat="server" Height="140px"
        Animation="Fade" EnableRoundedCorners="true" EnableShadow="true" AutoCloseDelay="3500"
        Position="BottomRight" OffsetX="-40" OffsetY="-50" ShowCloseButton="true" Text="The event location was updated successfully!" Title="Success" TitleIcon="info"
        KeepOnMouseOver="true" Skin="Glow">
    </telerik:RadNotification>


    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">

        function ValidatePage() {
            $("#span1").show();
            document.getElementById("formPanel").style.opacity = "0.5";
        }

        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }



        //show tab
        $(document).ready(function () {

            handleTabLinks();
        });

        function handleTabLinks() {
            if (window.location.hash == '') {
                window.location.hash = window.location.hash + '#_';
            }
            var hash = window.location.hash.split('#')[1];
            var prefix = '_';
            var hpieces = hash.split('/');
            for (var i = 0; i < hpieces.length; i++) {
                var domelid = hpieces[i].replace(prefix, '');
                var domitem = $('a[href=#' + domelid + '][data-toggle=tab]');
                if (domitem.length > 0) {
                    domitem.tab('show');
                }
            }
            $('a[data-toggle=tab]').on('shown', function (e) {
                if ($(this).hasClass('nested')) {
                    var nested = window.location.hash.split('/');
                    window.location.hash = nested[0] + '/' + e.target.hash.split('#')[1];
                } else {
                    window.location.hash = e.target.hash.replace('#', '#' + prefix);
                }
            });
        }

        
     </script>
        <script src="/js/bootstrap-checkbox.min.js"></script>
    <script>
        $(':checkbox').checkboxpicker();
    </script>

    <%--<link href="/skins/square/green-red.css" rel="stylesheet" />
    <script src="/js/icheck.js"></script>

    <script>
        $(document).ready(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                increaseArea: '30%' // optional

            });
        });

        function formatCheckBox() {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                increaseArea: '30%' // optional

            });
        }
    </script>--%>

    </telerik:RadScriptBlock>

</asp:Content>
