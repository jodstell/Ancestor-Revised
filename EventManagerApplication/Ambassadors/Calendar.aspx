<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Calendar.aspx.vb" Inherits="EventManagerApplication.AmbassadorCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../Theme/css/custom.css" rel="stylesheet" />
    <link href="../Theme/css/custom1.css" rel="stylesheet" />

    <style>
        /*calendar*/
        .rsAptDelete {
            display: none;
        }

        .RadScheduler .rsRequested .rsAptContent {
            background: #005991;
            border-color: #005991;
        }

        .RadScheduler .rsScheduled .rsAptContent {
            background: #fe9a00;
            border-color: #fe9a00;
        }

        .RadScheduler .rsBooked .rsAptContent {
            background: #669934;
            border-color: #669934;
        }

        .RadScheduler .rsCancelled .rsAptContent {
            background: #c9302b;
            border-color: #c9302b;
        }

        .RadScheduler .rsToplined .rsAptContent {
            background: #790091;
            border-color: #790091;
        }

        .RadScheduler .rsApproved .rsAptContent {
            background: #3398cc;
            border-color: #3398cc;
        }


        /*map tooltip*/
        .RadMap_Bootstrap.k-widget.k-tooltip {
            text-align: left;
            background-color: #ffffff !important;
            color: #000 !important;
        }
              
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
      
            ////on click calendar             
            function OnClientAppointmentClick(sender, eventArgs) {
                var apt = eventArgs.get_appointment().get_id();
                window.location.href = "/Events/EventDetails?ID=" + apt;
            }
            
        </script>

    </telerik:RadCodeBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"
        IsSticky="true" Style="position: absolute; top: 0; left: 0; height: 100%; width: 100%;">
    </telerik:RadAjaxLoadingPanel>

    <asp:Panel ID="Panel1" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Ambassador Calendar and Map</h2>

            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <h2>Map</h2>

                <asp:Panel ID="MapPanel" runat="server">

                    <div class="widget stacked min-height">
                        <div class="widget-content">

                            <telerik:RadMap runat="server" ID="RadMap1" Zoom="4" CssClass="MyMap" Skin="Bootstrap" RenderMode="Mobile" DataSourceID="getMyEvents"
                                Width="100%" Height="500" Zoomable="true">

                                <CenterSettings Latitude="39.639537564366705" Longitude="-92.548828125" />

                                <DataBindings>
                                    <MarkerBinding DataShapeField="statusName" DataTitleField="tooltipformap"
                                        DataLocationLatitudeField="latitude" DataLocationLongitudeField="longitude" />
                                </DataBindings>

                            </telerik:RadMap>

                        </div>
                    </div>


                </asp:Panel>

            </div>
        </div>


        <div class="row">
            <div class="col-sm-12">
                <h2>Calendar</h2>

                <asp:Panel ID="CalendarPanel" runat="server">
                    <div class="widget stacked min-height">
                        <div class="widget-content">

                            <telerik:RadScheduler ID="RadScheduler1" runat="server" DataSourceID="getMyEvents" DataKeyField="eventID" SelectedView="MonthView" AppointmentStyleMode="Default"
                                AllowEdit="false" AllowInsert="false" Skin="Bootstrap" OverflowBehavior="Expand" DataEndField="endTime" DataStartField="startTime" DataDescriptionField="tooltiptext"
                                DataSubjectField="supplierName" RowHeight="30px" OnClientAppointmentClick="OnClientAppointmentClick">
                                <ResourceTypes>
                                    <telerik:ResourceType KeyField="eventID" Name="StatusName" TextField="statusName" ForeignKeyField="eventID"
                                        DataSourceID="getMyEvents"></telerik:ResourceType>
                                </ResourceTypes>
                            </telerik:RadScheduler>

                        </div>

                    </div>

                </asp:Panel>

            </div>
        </div>


        


    </div>


    <asp:LinqDataSource ID="getMyEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EntityTypeName="" TableName="qryViewEventsByAmbassadors"></asp:LinqDataSource>

        </asp:Panel>

</asp:Content>
