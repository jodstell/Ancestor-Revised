<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AmbassadorMapControl.ascx.vb" Inherits="EventManagerApplication.AmbassadorMapControl" %>



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

<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">

 <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
      
            ////on click calendar             
            function OnClientAppointmentClick(sender, eventArgs) {
                var apt = eventArgs.get_appointment().get_id();
                window.location.href = "/Events/EventDetails?ID=" + apt;
            }
            
        </script>

    </telerik:RadCodeBlock>

 <telerik:RadMap runat="server" ID="RadMap1" Zoom="10" CssClass="MyMap" Skin="Bootstrap" RenderMode="Lightweight" DataSourceID="getMyEvents"
                                Width="100%" Height="500" Zoomable="true">

                                <DataBindings>
                                    <MarkerBinding DataShapeField="statusName" DataTitleField="tooltipformap"
                                        DataLocationLatitudeField="latitude" DataLocationLongitudeField="longitude" />
                                </DataBindings>

                            </telerik:RadMap>


    <asp:LinqDataSource ID="getMyEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
        EntityTypeName="" TableName="qryViewEventsByAmbassadors" Where="userID == @userID">
        <WhereParameters>
            <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
        </WhereParameters>
    </asp:LinqDataSource>



    </telerik:RadAjaxPanel>