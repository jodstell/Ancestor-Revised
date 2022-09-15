<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="Calendar.aspx.vb" Inherits="EventManagerApplication.StudentCalendar" %>

<%@ Register Src="~/Application/Classroom/UserControls/TitleBlockControl.ascx" TagPrefix="uc1" TagName="TitleBlockControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/ClassRoomNavBar.ascx" TagPrefix="uc1" TagName="ClassRoomNavBar" %>
<%@ Register Src="~/Application/Classroom/UserControls/MyAssignmentsControl.ascx" TagPrefix="uc1" TagName="MyAssignmentsControl" %>
<%@ Register Src="~/Application/Classroom/UserControls/ClassAnnouncementsControl.ascx" TagPrefix="uc1" TagName="ClassAnnouncementsControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main {
            padding: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container min-height">

        <uc1:TitleBlockControl runat="server" ID="TitleBlockControl" />

    <div class="row">
        <div class="col-md-2">
            <uc1:ClassRoomNavBar runat="server" ID="ClassRoomNavBar" />
        </div>

        <div class="col-md-7">
            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <h2 class="hidden-xs"><%: GetWidgetName()%></h2>
            <p><%: GetWidgetDescription()%></p>
            <hr />
            </telerik:RadScriptBlock>

            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1">
                    </telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    
            <div class="exampleContainer">
        <telerik:RadScheduler runat="server" ID="RadScheduler1" Width="100%" DayStartTime="08:00:00"
            DayEndTime="18:00:00" TimeZoneOffset="03:00:00" OnAppointmentInsert="RadScheduler1_AppointmentInsert"
            OnAppointmentUpdate="RadScheduler1_AppointmentUpdate" OnAppointmentDelete="RadScheduler1_AppointmentDelete"
            DataKeyField="ID" DataSubjectField="Subject" DataStartField="Start" DataEndField="End"
            DataRecurrenceField="RecurrenceRule" DataRecurrenceParentKeyField="RecurrenceParentId"
            DataReminderField="Reminder">
            <AdvancedForm Modal="true"></AdvancedForm>
            <TimelineView UserSelectable="false"></TimelineView>
            <TimeSlotContextMenuSettings EnableDefault="true"></TimeSlotContextMenuSettings>
            <AppointmentContextMenuSettings EnableDefault="true"></AppointmentContextMenuSettings>
            <Reminders Enabled="true"></Reminders>
        </telerik:RadScheduler>
            
        </div>

            </div>

        <div class="col-md-3 col-sidebar-right">

            <uc1:ClassAnnouncementsControl runat="server" ID="ClassAnnouncementsControl" />
<uc1:MyAssignmentsControl runat="server" ID="MyAssignmentsControl" />
        </div>



    </div>

    <script type="text/javascript">
        $('#nav_5').addClass('active');
    </script>

    <script type="text/javascript">
        $('#calendar').addClass('active');
    </script>

    </div>

</asp:Content>
