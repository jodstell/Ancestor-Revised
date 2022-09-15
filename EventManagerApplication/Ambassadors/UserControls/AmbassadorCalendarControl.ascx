<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AmbassadorCalendarControl.ascx.vb" Inherits="EventManagerApplication.AmbassadorCalendarControl" %>



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


<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
      
            ////on click calendar             
            function OnClientAppointmentClick(sender, eventArgs) {
                var apt = eventArgs.get_appointment().get_id();
                window.location.href = "/Events/EventDetails?ID=" + apt;
            }
            
        </script>

    </telerik:RadCodeBlock>

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">


                            <telerik:RadScheduler ID="RadScheduler1" runat="server" DataSourceID="getMyEvents" DataKeyField="eventID" SelectedView="TimelineView" AppointmentStyleMode="Default"
                                AllowEdit="false" AllowInsert="false" Skin="Bootstrap" OverflowBehavior="Expand" DataEndField="endTime" DataStartField="startTime" DataDescriptionField="tooltiptext"
                                DataSubjectField="supplierName" RowHeight="30px" OnClientAppointmentClick="OnClientAppointmentClick">
                                <ResourceTypes>
                                    <telerik:ResourceType KeyField="eventID" Name="StatusName" TextField="statusName" ForeignKeyField="eventID"
                                        DataSourceID="getMyEvents"></telerik:ResourceType>
                                </ResourceTypes>
                            </telerik:RadScheduler>

                 

</telerik:RadAjaxPanel>
                

  <asp:LinqDataSource ID="getMyEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" 
        EntityTypeName="" TableName="qryViewEventsByAmbassadors" Where="userID == @userID">
        <WhereParameters>
            <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
        </WhereParameters>

  </asp:LinqDataSource>