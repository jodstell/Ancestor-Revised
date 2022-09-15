<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="StaffingControl.ascx.vb" Inherits="EventManagerApplication.StaffingControl" %>

<link href="../../Theme/css/custom.css" rel="stylesheet" />

<style> 
    #genreContainer {
    }

        #genreContainer a,
        .result .genre {
            display: block;
            padding: 18px 5px 17px 55px;
            font-size: 14px;
            text-decoration: none;
        }

    * > #genreContainer a,
    * > .result .genre {
        background: #ECF4FF;
    }

    * html #genreContainer a,
    * html .result .genre {
        background: #ECF4FF;
    }

        #genreContainer a:hover,
        #genreContainer a.selected {
            background-color: #FFCB60;
            color: #00156E;
        }

    #GenreLink a:hover,
    #GenreLink a.selected {
        background-color: #FFCB60;
        color: #00156E;
    }

    #genreContainer a.Unsorted,
    .result .Unsorted {
        background-position: 10px -94px;
    }





    .fieldsetBox {
        float: left;
        width: 400px;
        height: 180px;
    }



    .RadForm_BlackMetroTouch .fieldsetBox {
        width: 400px;
    }



    .demoWrapper {
        font-size: 12px;
    }



    .pagerWrapper {
        padding-top: 10px;
        text-align: left;
    }



    .demoPager {
        float: left;
        margin-left: 25%;
    }



    .numericPageSize {
        vertical-align: middle;
        margin-top: 3px;
        line-height: 22px;
        display: inline-block;
    }



    .pageSize {
        vertical-align: middle;
        line-height: 22px;
        display: inline-block;
        padding-left: 5px;
    }



    .itemTable {
        width: 95%;
        border-spacing: 0px;
    }



    .cellLabel {
        width: 25%;
    }



    .cellInfo {
        width: 75%;
    }



    .image {
        vertical-align: bottom;
        text-align: right;
        width: 25%;
    }



    .clear {
        clear: both;
    }



    .demo-container {
        max-width: 920px;
    }





    .filterWrapper {
        overflow: hidden;
    }



    .filterDropDown {
        color: #2a6ca3;
        font-size: 11px;
        width: 170px;
        margin-bottom: 20px;
    }



    div.radioButtonDiv {
        display: none;
        float: left;
        margin: -6px 10px 0 0;
        color: #2a6ca3;
        font-size: 11px;
    }



    div.boxValueDiv {
        display: none;
        float: left;
        margin-right: 10px;
        color: #2a6ca3;
        font-size: 11px;
    }



    div.buttonsDiv {
        display: none;
        float: left;
        margin-right: 10px;
        color: #2a6ca3;
        font-size: 11px;
    }



    .boxValue {
        vertical-align: middle;
    }



    .clearFix {
        clear: both;
    }



    /*.itemStyle {

    float: left;

    color: #2a6ca3;

    width: 230px;

    height: 150px;

    background: no-repeat;

    background-image: url(images/productsBackground5.png);

    margin-left: 23px;

    position: relative;

}*/



    .labelLarge {
        position: absolute;
        top: 20px;
        left: 29px;
        font-size: 10pt;
        font-weight: bold;
        width: 140px;
    }



    .labelSmall {
        position: absolute;
        top: 60px;
        left: 50px;
        font-size: 8pt;
        margin-right: 8px;
    }



    legend {
        padding: 0.2em 0.5em;
        color: #2a6ca3;
        font-size: 12px;
    }



    fieldset {
        margin-top: 20px;
        border: solid 1px #e2e4e7 !important;
        height: 100%;
        width: 780px;
    }



    .rdpWrap + .rdpWrap + .rdpWrap + .rdpWrap + .rdpWrap {
        width: 140px;
    }



        .rdpWrap + .rdpWrap + .rdpWrap + .rdpWrap + .rdpWrap + .rdpWrap {
            width: auto;
        }
</style>

<link href="../css/RequiredPositions.css" rel="stylesheet" />
<link href="../css/RadListViewFilter.css" rel="stylesheet" />


<script src="../js/ListViewFilter.js"></script>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">


    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="false" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Bootstrap" >
        <Tabs>
            <telerik:RadTab Text="Status" runat="server" ID="statusTab" PostBack="true" ></telerik:RadTab>
            <telerik:RadTab Text="Assign BA" runat="server" ID="assignTab"></telerik:RadTab>
            <telerik:RadTab Text="Requirements" runat="server" ID="requirementsTab"></telerik:RadTab>
            <telerik:RadTab Text="Payroll/Expenses" runat="server" ID="payrollTab"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0">
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
                                        <th></th>
                                        <th>Name</th>
                                        <th>Position</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Check-in Time</th>
                                        <th>Check-in Confirmed</th>
                                    </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>

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
                                <td><%# Eval("checkInTime", "{0:t}") %></td>
                                <td></td>

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
                        SelectCommand="SELECT * FROM [qryEventStaffingStatus] WHERE ([eventID] = @eventID)">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
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
                            <asp:Label ID="eventDateLabel" runat="server" />
                        - Event Start:
                            <asp:Label ID="startTimeLabel" runat="server" />
                        - Event End:
                            <asp:Label ID="endTimeLabel" runat="server" /></h4>

                    <p>Total Staffing Spend:
                        <asp:Label ID="TotalSpendLabel" runat="server" Font-Bold="true" /></p>
                    <p>Total Staff Results:
                        <asp:Label ID="StaffCountLabel" runat="server" /></p>





                    <div class="col-md-6">

                        <div class="row">
                            <div class="col-md-12" style="margin-bottom: 10px;">

                                <div class="filterWrapper">

                                  


                                

                                    <div class="filterDropDown">


    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearchAmbassador" Width="300px">                                                                             
        <div class="input-group">
            <asp:TextBox ID="txtSearchBox" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
          <span class="input-group-btn">
              <asp:LinkButton ID="btnSearchAmbassador" runat="server" CssClass="btn btn-success">Search</asp:LinkButton>
          </span>
          <span class="input-group-btn">
              <asp:LinkButton ID="btnClearFiltersAmbassador" runat="server" CssClass="btn btn-default">Clear Filters</asp:LinkButton>
          </span>
        </div><!-- /input-group -->
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
                                        ClientDataKeyNames="userName,FirstName,LastName" OnItemDrop="AvailableAmbassadorList_ItemDrop" ItemPlaceholderID="TrackContainer" AllowPaging="True" PageSize="6">

                                        <ClientSettings AllowItemsDragDrop="true">

                                            <ClientEvents OnItemDragStarted="itemDragStarted" OnItemDragging="itemDragging" OnItemDropping="trackDropping"></ClientEvents>

                                        </ClientSettings>



                                        <LayoutTemplate>
                                            <div class="RadListView RadListView_Silk">
                                                <asp:PlaceHolder ID="TrackContainer" runat="server"></asp:PlaceHolder>
                                            </div>

                                            <div class="pagerWrapper">

                                                <div class="demoPager">

                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnFirst" CommandName="Page" CommandArgument="First"
                                                        Text="First" Enabled="<%#Container.CurrentPageIndex > 0 %>">
                                                    </telerik:RadButton>

                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnPrev" CommandName="Page" CommandArgument="Prev"
                                                        Text="Prev" Enabled="<%#Container.CurrentPageIndex > 0 %>">
                                                    </telerik:RadButton>

                                                    <span class="numericPageSize">Page

                                        <%#Container.CurrentPageIndex + 1 %>

                                        of

                                        <%#Container.PageCount %></span>

                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnNext" CommandName="Page" CommandArgument="Next"
                                                        Text="Next" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>">
                                                    </telerik:RadButton>

                                                    <telerik:RadButton RenderMode="Lightweight" runat="server" ID="btnLast" CommandName="Page" CommandArgument="Last"
                                                        Text="Last" Enabled="<%#Container.CurrentPageIndex + 1 < Container.PageCount %>">
                                                    </telerik:RadButton>

                                                </div>

                                                <div>

                                                    <span class="pageSize">Page Size:</span>

                                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="cmbPageSize" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged"
                                                        AutoPostBack="true" Width="60px" SelectedValue="<%#Container.PageSize %>">

                                                        <Items>

                                                            <telerik:RadComboBoxItem Text="3" Value="3"></telerik:RadComboBoxItem>

                                                            <telerik:RadComboBoxItem Text="6" Value="6"></telerik:RadComboBoxItem>

                                                            <telerik:RadComboBoxItem Text="9" Value="9"></telerik:RadComboBoxItem>

                                                            <telerik:RadComboBoxItem Text="12" Value="12"></telerik:RadComboBoxItem>

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
                                                                            DataValue='<%# IIf(Eval("headShot") IsNot DBNull.Value, Eval("headShot"), New System.Byte(-1) {})%>'
                                                                            AutoAdjustImageControlSize="false" Width="70px" CssClass="thumbnail" onclick='<%#CreateWindowScript(Eval("userID"), 1)%>' />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end row -->

                                                        </div>

                                                        <div class="col-md-10">

                                                            <div class="col-md-5">
                                                                <a id="ambassadorlink" draggable="false" target="_blank" href='/ambassadors/ViewAmbassadorDetails?UserID=<%# Eval("UserID") %>'>
                                                                    <header><%# Eval("FirstName") %>  <%# Eval("LastName") %></header>
                                                                </a>
                                                            </div>
                                                            <div class="col-md-3"><%# Eval("City")%></div>
                                                            <div class="col-md-2"><%# Eval("State") %></div>
                                                            <div class="col-md-2">
                                                                <asp:LinkButton ID="btnDetails" runat="server" Text="Details" CssClass="btn btn-sm btn-primary" OnClientClick='<%#CreateWindowScript2(Eval("UserID"))%>' />                                                                   
                                                                
                                                            </div>


                                                            <div class="col-md-12">
                                                                <asp:Label ID="milesLabel" runat="server" />
                                                                <%# Eval("miles") %> miles from Event Location
                                                            </div>

                                                            <div class="col-md-12">
                                                                <asp:Label ID="ConflictLabel" runat="server" Text='<%# checkSchedule(Eval("UserID")) %>' />
                                                            </div>

                                                        </div>

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
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <br>
                    </div>

                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-12" style="margin-bottom: 10px;">
                                <div class="btn-group pull-right" role="group" aria-label="...">
                                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-sm btn-primary" />
                                    <asp:Button ID="btnCancelChanges" runat="server" Text="Cancel" CssClass="btn btn-sm btn-default" />
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div id="" class="col-md-12">

                                <asp:Repeater ID="PositionList" runat="server"
                                    DataSourceID="getEventPositions">
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
                                                                <telerik:RadTimePicker ID="RadTimePicker1" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>
                                                            </td>
                                                            <td>
                                                                <telerik:RadTimePicker ID="RadTimePicker2" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtRate" runat="server" CssClass="form-control" Text='<%# Bind("rate")%>'></asp:TextBox></td>
                                                            <td style="padding-top: 15px"><strong>
                                                                <asp:Label ID="TotalLabel" runat="server" Text='<%# getTotalPay(Eval("RequirementID"))%>'></asp:Label>
                                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("RequirementID") %>' />
                                                            </strong></td>

                                                        </tr>
                                                    </table>

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

                        <h4>Event Date:
                            <asp:Label ID="RequirementsEventDateLabel" runat="server" />
                            - Event Start:
                            <asp:Label ID="RequirementsStartTimeLabel" runat="server" />
                            - Event End:
                            <asp:Label ID="RequirementsEndTimeLabel" runat="server" /></h4>

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
                                            <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                Text="Add New Position" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
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
                                        <telerik:RadTimePicker ID="RadTimePicker1" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>
                                    </td>
                                    <td>
                                        <telerik:RadTimePicker ID="RadTimePicker2" runat="server" DbSelectedDate='<%# Bind("endTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>
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

                                        <telerik:RadTimePicker ID="RadTimePicker12" runat="server" DbSelectedDate='<%# Bind("startTime")%>' Skin="Bootstrap"></telerik:RadTimePicker>

                                    </td>
                                    <td>
                                        <telerik:RadTimePicker ID="RadTimePicker22" runat="server" DbSelectedDate='<%# Bind("endTime") %>' Skin="Bootstrap" Culture="en-US"></telerik:RadTimePicker>

                                    </td>
                                    <td>
                                        <asp:Button ID="PerformInsertButton" runat="server" CommandName="PerformInsert" CssClass="btn btn-xs btn-primary" Text="Save Changes" ToolTip="Insert" />
                                        <asp:Button ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn btn-xs btn-default" Text="Cancel" ToolTip="Cancel" />
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
                                            <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                Text="Add New Position" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
                                        </tfoot>
                                    </table>


                                </div>
                            </EmptyDataTemplate>

                        </telerik:RadListView>

                        <asp:Label ID="MsgLabel" runat="server" />

                        <asp:LinqDataSource ID="getEventPositions" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                            EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="tblEventStaffingRequirements" Where="eventID == @eventID">
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

            <div class="widget stacked">
                <div class="widget-content">

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
                                <td><%# Eval("expenses", "{0:C}") %></td>
                                <td><%# getTotalPay(Eval("RequirementID")) %></td>
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
                                            <asp:Button ID="btnInsert" runat="server" CommandName="InitInsert" Visible="<%# Not Container.IsItemInserted %>"
                                                Text="Add New Expense" CssClass="btn btn-xs btn-primary pull-right"></asp:Button>
                                        </tfoot>
                                    </table>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-primary" /></td>
                                    <td><%# Eval("description") %></td>
                                    <td><%# Eval("expenseType") %></td>
                                    <td><%# Eval("expenseBy") %></td>
                                    <td><%# Eval("amount", "{0:C}") %></td>

                                    <td>
                                        <asp:Label ID="btnViewReciept" runat="server" Text="View Receipt" CssClass="btn btn-sm btn-default" OnClick='<%#CreateReceiptScript(Eval("eventExpenseID"))%>'></asp:Label>
                                    </td>

                                    <td>
                                        <asp:Button ID="Button2" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" /></td>
                                </tr>
                            </ItemTemplate>

                        </telerik:RadListView>


                        <asp:SqlDataSource ID="getExpenses" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [qryViewExpensesByEvent] WHERE ([eventID] = @eventID) ORDER BY [userName]">

                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </asp:Panel>


                    <asp:SqlDataSource runat="server" ID="getPayrolSummary" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="ViewPayrollSummaryByEvent" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="ID" Name="eventID" Type="Int32"></asp:QueryStringParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </div>

        </telerik:RadPageView>
    </telerik:RadMultiPage>


</telerik:RadAjaxPanel>


<telerik:RadWindowManager runat="server" ID="RadWindowManager1">

    <Windows>
        <telerik:RadWindow runat="server" ID="Details" VisibleStatusbar="false" Skin="Bootstrap"
            Width="675px" Height="530px" AutoSize="true" Behaviors="Close,Move" ShowContentDuringLoad="false"
            Modal="true">
        </telerik:RadWindow>

        <telerik:RadWindow  OpenerElementID="elementID" runat="server" ID="RadWindow1" VisibleStatusbar="false" Skin="Bootstrap"
                Width="725px" Height="530px" AutoSize="false" Behaviors="Close,Move" ShowContentDuringLoad="false" Modal="true">
        </telerik:RadWindow>

        <%--<telerik:RadWindow runat="server" ID="Receipt" VisibleStatusbar="false" NavigateUrl="/Receipt_Image.aspx" Skin="Bootstrap"
                                Width="675px" Height="530px" AutoSize="true" Behaviors="Close,Move" ShowContentDuringLoad="false"
                                Modal="true">
                            </telerik:RadWindow> --%>
    </Windows>

</telerik:RadWindowManager>



<%--<telerik:RadWindowManager runat="server" ID="RadWindowManager2">

           <Windows>
                        <telerik:RadWindow runat="server" ID="Receipt" VisibleStatusbar="false" NavigateUrl="/Receipt_Image.aspx" Skin="Bootstrap"
                                Width="675px" Height="530px" AutoSize="true" Behaviors="Close,Move" ShowContentDuringLoad="false"
                                Modal="true">
                            </telerik:RadWindow>
                    </Windows>

       </telerik:RadWindowManager>--%>



<script>


    var interval = 500;



    function FilterData(evt) {

        if (evt.keyCode == "13") {

            //prevent event bubbling

            evt.cancelBubble = true;

            evt.returnValue = false;



            if (evt.stopPropagation) {

                evt.stopPropagation();

                evt.preventDefault();

            }



            if ($('div[id*=numericBoxValueDiv]')[0].style.display != 'none' && numericBox.get_value() == "") {

                return false;

            }



            //trigger an ajax request to apply the selected filter expression

            btnSearch.click();

        }

    }



    function btnSearchClick(evt) {



        if ($('div[id*=numericBoxValueDiv]')[0].style.display != 'none' && numericBox.get_value() == "") {

            //prevent event bubbling

            evt.cancelBubble = true;

            evt.returnValue = false;



            if (evt.stopPropagation) {

                evt.stopPropagation();

                evt.preventDefault();

            }

            return false;

        }

    }



    function NoFilterChosen() {

        //hide the UI filter data controls

        $('div[id*=radioButtonDiv2]').hide(interval);

        $('div[id*=radioButtonDiv1]').hide(interval, hideRemainingControls);



        //trigger an ajax request to rebind the RadListView

        setTimeout(function () { btnShowAll.click() }, interval * 2);



    }



    function fieldComboSelectedIndexChanged(sender, args) {

        if (args.get_item().get_text() == "Choose Filter") {

            NoFilterChosen();

        }

        else if (args.get_item().get_value().split('_')[1] != 'System.String') {



            //replace the regular TextBox control with a RadNumericTextBox   

            $('div[id*=boxValueDiv]').hide(0);

            $('div[id*=numericBoxValueDiv]').show(0);



            //hide the UI filter data controls for the string-type fields

            $('div[id*=radioButtonDiv2]').hide(interval);



            //show the UI filter data controls for the nonstring-type fields

            $('div[id*=radioButtonDiv1]').show(interval, showRemainingControls);



            //set a default filter function

            $('table[id*=filterFunctionsList1] input[type=radio]')[0].checked = true;



            //clear the filter value box controls

            $('input[id*=boxValue]')[0].value = '';

            numericBox.clear();

        }

        else {



            //replace the RadNumericTextBox with a regular TextBox control    

            $('div[id*=numericBoxValueDiv]').hide(0);

            $('div[id*=boxValueDiv]').show(0);



            //hide the UI filter data controls for the nonstring-type fields

            $('div[id*=radioButtonDiv1]').hide(interval);



            //show the UI filter data controls for the nonstring-type fields    

            $('div[id*=radioButtonDiv2]').show(interval, showRemainingControls);



            //set a default filter function

            $('table[id*=filterFunctionsList2] input[type=radio]')[0].checked = true;



            //clear the filter value box controls

            $('input[id*=boxValue]')[0].value = '';

            numericBox.clear();

        }

    }



    function showRemainingControls() {

        //show the UI filter button controls

        $('div[id*=buttonsDiv]').fadeIn(interval);

    }





    function hideRemainingControls() {

        //hide all the UI filter data controls

        $('div[id*=boxValueDiv]').fadeOut(interval);

        $('div[id*=numericBoxValueDiv]').fadeOut(interval);

        $('div[id*=buttonsDiv]').fadeOut(interval);

    }







    var originalMsg = "";



    function itemDragStarted(sender, args) {

        var title = args.get_dataKeyValues().Title;

        var artist = args.get_dataKeyValues().Artist;



        showAction(title, artist);

    }



    function itemDragging(sender, args) {

        var evt = args.get_domEvent();

        var genreContainer = $get("genreContainer");

        var itemIndex = sender._itemDrag._draggedItemIndex;

        var clientKeys = sender.get_clientDataKeyValue()[itemIndex];

        var title = clientKeys.Title;

        var artist = clientKeys.Artist



        if ($telerik.isMouseOverElementEx(genreContainer, evt)) {

            var target = evt.srcElement || evt.originalTarget;

            var genre = target.className;



            showAction(title, artist, genre.split(' ')[0]);

        }

        else {

            showAction(title, artist);

        }

    }



    function showAction(title, artist, genre) {

        var titleDiv = title ? String.format("<div class='track'><b>{0}</b><br />{1}</div>", title, artist) : "";

        var arrowDiv = genre ? "<div class='arrow'></div>" : "";

        var genreDiv = genre ? String.format("<div class='genre {0}'>{0}</div>", genre) : "";



        resultsPanel.innerHTML = String.format("{0}{1}{2}", titleDiv, genreDiv, arrowDiv);

    }



    function trackDropping(sender, args) {

        var dest = args.get_destinationElement();

        if (!dest || !dest.id || dest.id.indexOf("GenreLink") < 0) {

            args.set_cancel(true);

        }



        showAction();

    }

    

</script>



 <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                        <script type="text/javascript">

                            $('#RadBinaryImage2').draggable("destroy")
                            $('#ambassadorlink').draggable("destroy")


                            function onTabSelecting(sender, args) {
                                if (args.get_tab().get_pageViewID()) {
                                    args.get_tab().set_postBack(false);
                                }
                            }

                        </script>
                    </telerik:RadCodeBlock>
