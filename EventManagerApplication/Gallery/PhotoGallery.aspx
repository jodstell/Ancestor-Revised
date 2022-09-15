<%@ Page Title="Gallery" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="PhotoGallery.aspx.vb" Inherits="EventManagerApplication.PhotoGallery1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Events/css/RadScheduler.css" rel="stylesheet" />

    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="-1" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .photoDiv {
            background-color: #c9c9c9;
            padding-left: 15px;
            margin-top: -20px;
        }



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
        /*End Photo Galery Styles*/

        /*showHidenDiv*/
        .showDiv {
            display: none;
        }
    </style>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">

            // close the div in 3 secs
            window.setTimeout("closeDiv();", 3000);

            function closeDiv() {
                // jQuery version
                $("#messageHolder").fadeOut("slow", null);
            }

            ////on click calendar
            function OnClientAppointmentClick(sender, eventArgs) {
                var apt = eventArgs.get_appointment().get_id();
                window.location.href = "/Events/EventDetails?ID=" + apt;
            }


            function requestStart(sender, args) {

                if (args.get_eventTarget().indexOf("btnExport") > 0 ||

                    args.get_eventTarget().indexOf("btnExport") > 0)

                    args.set_enableAjax(false);
            }

            function requestEnd(sender, args) {
                $('.ui-tooltip').tooltip();
            }

            function bntViewEvent() {

                var loadingPanel = $find('<%= RadAjaxLoadingPanel1.ClientID %>');
                var currentUpdatedControl = "<%= Panel1.ClientID %>";
                loadingPanel.set_modal(true);
                loadingPanel.show(currentUpdatedControl);

            }

        </script>
    </telerik:RadCodeBlock>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="messageHolder">
                    <asp:Literal ID="msgLabel" runat="server" />
                </div>
            </div>
        </div>
    </div>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Bootstrap"></telerik:RadAjaxLoadingPanel>

    <asp:HiddenField ID="HiddenSessionGUID" runat="server" />
    <asp:HiddenField ID="HiddenUserID" runat="server" />

    <asp:Panel ID="Panel1" runat="server">

        <div class="container min-height">
            <div class="row">
                <div class="col-xs-12">

                    <asp:Panel ID="Panel2" runat="server">
                        <div class="pull-right btn-group" role="group" style="padding-top: 5px;">


                            <button class="btn btn-default btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Photo Bin  <span class="badge"><span id="PhotoBinCountLabel"></span>
                                </span>
                            </button>
                            <ul class="dropdown-menu">
                                <li>

                                    <asp:HyperLink ID="btnDownloadBin" runat="server">Download Photo Bin</asp:HyperLink>

                                </li>

                                <li>
                                    <asp:LinkButton ID="btnDeleteBin" runat="server" CssClass="">
                                Delete Photo Bin
                                    </asp:LinkButton></li>


                            </ul>

                        </div>
                    </asp:Panel>

                    <h2>Gallery</h2>

                    <div class="widget-box">
                        <div class="widget-title">
                            <h5>
                                <asp:Label ID="lblWeek" runat="server" Text="Label" Font-Bold="true" Font-Size="Larger" />
                            </h5>
                        </div>
                    </div>

                    <ol class="breadcrumb">
                        <li><i class="fa fa-home" aria-hidden="true"></i> <a href="/"> Dashboard</a></li>
                        <li class="active">Gallery</li>
                    </ol>

                </div>
            </div>

            <div id="mainDiv">

                <!-- Date Filter -->
                <div style="margin-bottom: 15px;">
                    From:
                <telerik:RadDatePicker ID="FromDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>
                    To:
                <telerik:RadDatePicker ID="ToDatePicker" runat="server">
                    <Calendar runat="server">
                        <SpecialDays>
                            <telerik:RadCalendarDay Repeatable="Today">
                                <ItemStyle CssClass="rcToday" />
                            </telerik:RadCalendarDay>
                        </SpecialDays>
                    </Calendar>
                </telerik:RadDatePicker>
                    <asp:Button ID="btnChangeDateRange" runat="server" Text="Go" CssClass="btn btn-default ui-tooltip" data-toggle="tooltip" data-placement="top" title="" data-original-title="Filter by Date Range" />




                </div>

                <asp:Label ID="errorLabel" runat="server" />


                <div style="margin-bottom: 15px;">

                    <!-- Grid Panel -->
                    <asp:Panel ID="GridPanel" runat="server" CssClass="GridPanelCss">
                        <div class="row">
                            <div class="col-sm-12">

                                <telerik:RadGrid ID="EventDataGrid" runat="server"
                                    AllowPaging="True"
                                    AllowSorting="True"
                                    ShowFooter="True"
                                    ShowStatusBar="true"
                                    AllowFilteringByColumn="True"
                                    PageSize="20" CellSpacing="-1"
                                    FilterType="HeaderContext"
                                    EnableHeaderContextMenu="true"
                                    EnableHeaderContextFilterMenu="true" OnFilterCheckListItemsRequested="EventDataGrid_FilterCheckListItemsRequested">

                                    <ExportSettings IgnorePaging="true" OpenInNewWindow="true"></ExportSettings>
                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="eventID" CommandItemDisplay="Top" AllowSorting="true" HierarchyDefaultExpanded="true">

                                        <NoRecordsTemplate>

                                            <br />
                                            <div class="col-md-12">
                                                <div class="alert alert-warning" role="alert"><strong>No Events Found.</strong>  Please adjust your filter options.</div>
                                            </div>

                                        </NoRecordsTemplate>

                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>

                                        <CommandItemTemplate>
                                            <div style="padding: 3px 0 3px 5px">

                                                <asp:LinkButton ID="btnClearFilter" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-filter"></i> Clear Filters</asp:LinkButton>

                                                <asp:LinkButton ID="LinkButton2" Visible="false" runat="server" CommandName="ClearFilters" CssClass="btn btn-default btn-sm" ForeColor="Black"><i class="fa fa-refresh"></i> Refresh</asp:LinkButton>

                                                <div class="pull-right" style="padding-right: 3px">
                                                </div>
                                        </CommandItemTemplate>

                                        <Columns>
                                            <telerik:GridTemplateColumn AllowFiltering="false" UniqueName="ViewButton">
                                                <ItemStyle Width="40px" />
                                                <ItemTemplate>
                                                    <a href='/Events/EventDetails?ID=<%# Eval("eventID")%>' class="btn btn-primary btn-xs" style="color: #fff" onclick="bntViewEvent()">View  &nbsp;&nbsp;<i class="fa fa-chevron-right"></i></a><br />
                                                    <asp:Label ID="NotificationLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("labelText")%>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridBoundColumn DataField="eventID"
                                                FilterControlAltText="Filter eventID column"
                                                HeaderText="ID"
                                                SortExpression="eventID" UniqueName="eventID"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" ShowFilterIcon="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text="" />
                                                </ColumnValidationSettings>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="supplierName"
                                                FilterControlAltText="Filter supplierName column"
                                                HeaderText="Supplier Name"
                                                SortExpression="supplierName" UniqueName="supplierName" FilterControlWidth="150px"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                <HeaderStyle Width="175px"></HeaderStyle>
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text="" />
                                                </ColumnValidationSettings>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="brands" FilterControlAltText="Filter brandName column"
                                                HeaderText="Brands" SortExpression="brands" UniqueName="brands"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text="" />
                                                </ColumnValidationSettings>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridDateTimeColumn
                                                AllowFiltering="false"
                                                DataField="eventDate"
                                                UniqueName="eventDate"
                                                HeaderText="Date"
                                                SortExpression="eventDate"
                                                PickerType="None"
                                                ShowFilterIcon="false"
                                                DataFormatString="{0:D}">
                                                <HeaderStyle Width="160px"></HeaderStyle>
                                                <ItemStyle Width="160px" />
                                            </telerik:GridDateTimeColumn>


                                            <telerik:GridTemplateColumn DataField="statusName" FilterControlAltText="Filter statusName column"
                                                HeaderText="Status" SortExpression="statusName" UniqueName="statusName" FilterControlWidth="120px"
                                                FilterCheckListEnableLoadOnDemand="true" GroupByExpression="statusName statusID Group By statusName">
                                                <ItemStyle Width="100px" />
                                                <ItemTemplate>
                                                    <asp:Image ID="StatusImage" runat="server" ImageUrl='<%# getImage(Eval("statusName")) %>' Width="10px" Height="10px" Style="margin-bottom: 2px;" />
                                                    <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("statusName")%>' />
                                                </ItemTemplate>


                                            </telerik:GridTemplateColumn>

                                            <telerik:GridBoundColumn DataField="marketName" FilterControlAltText="Filter marketName column"
                                                HeaderText="Market" SortExpression="marketName" UniqueName="marketName" FilterControlWidth="120px"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text="" />
                                                </ColumnValidationSettings>


                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn DataField="eventTypeName" FilterControlAltText="Filter typeName column"
                                                HeaderText="Event Type" SortExpression="eventTypeName" UniqueName="eventTypeName" FilterControlWidth="120px"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                <HeaderStyle Width="150px"></HeaderStyle>
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text="" />
                                                </ColumnValidationSettings>


                                            </telerik:GridBoundColumn>


                                            <telerik:GridTemplateColumn HeaderText="Location" AllowFiltering="true" UniqueName="accountName" DataField="accountName" SortExpression="accountName"
                                                FilterCheckListEnableLoadOnDemand="true">
                                                <ItemTemplate>
                                                    <a href='/Accounts/AccountDetails?AccountID=<%# Eval("vpID")%>' style="color: cornflowerblue"><%# Eval("accountName")%></a><br />
                                                    <%# Eval("address")%><br>
                                                    <%# Eval("city")%>, <%# Eval("state")%>
                                                </ItemTemplate>
                                                <ItemStyle Width="160px" />



                                            </telerik:GridTemplateColumn>

                                        </Columns>


                                        <NestedViewTemplate>
                                            <div runat="server" class="photoDiv">



                                                <asp:Label runat="server" ID="HIddenEventIDLabel" Font-Bold="true" Font-Italic="true" Text='<%# Eval("eventID") %>' Visible="false"></asp:Label>


                                                <asp:SqlDataSource ID="getImageList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT [SmallImage], [eventID], [photoID] FROM [tblPhoto] WHERE ([eventID] = @eventID)">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="HIddenEventIDLabel" PropertyName="Text" Type="String" Name="eventID" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>



                                                <asp:Repeater ID="GalleryRepeater" runat="server" DataSourceID="getImageList">

                                                    <HeaderTemplate>

                                                        <div class="row margintop20">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>

                                                        <div class="">


                                                            <div class="imageContainer" onmouseover="containerMouseover(this)" onmouseout="containerMouseout(this)">
                                                                <asp:LinkButton ID="btnOpenWindow" runat="server" OnClick='<%#CreateWindowScript3(Eval("eventID"), Eval("photoID")) %>'>

                                                                    <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" DataValue='<%#IIf(TypeOf (Eval("SmallImage")) Is DBNull, Nothing, Eval("SmallImage"))%>'
                                                                        Height='<%#ImageHeight %>' Width="<%#ImageWidth %>" ResizeMode="Crop" />

                                                                </asp:LinkButton>


                                                                <div style="margin-top: -22px; margin-bottom: 40px; position: absolute; display: none; width: <%#ImageHeight.Value/1.5 %>px;">

                                                                    <asp:LinkButton ID="btnRotateImage1" runat="server" ToolTip="Rotate Left" OnClientClick='<%# Eval("photoID", "return rotateleft({0})") %>'>
                                            <i class="fa fa-undo fa-1x bin"></i></asp:LinkButton>

                                                                    <asp:LinkButton ID="btnRotateImage2" runat="server" ToolTip="Rotate Right" OnClientClick='<%# Eval("photoID", "return rotatephoto({0})") %>'>
                                            <i class="fa fa-repeat fa-1x bin"></i></asp:LinkButton>

                                                                    <asp:LinkButton ID="btnSavetoBin" runat="server" ToolTip="Add to Bin" OnClientClick='<%# Eval("photoID", "return addtobin({0})") %>'>
                                            <i class="fa fa-archive fa-1x bin"></i></asp:LinkButton>

                                                                    <a href='/gallery/downloadhandler.aspx?photoID=<%# Eval("photoID") %>' title="Download"><i class="fa fa-download fa-1x bin"></i></a>





                                                                    <asp:LinkButton ID="btnViewItem" Visible="false" runat="server" ToolTip="View Event" CommandName="View"
                                                                        OnClick='<%#CreateWindowScript2(Eval("eventID")) %>'><i class="fa fa-eye fa-2x bin"></i></asp:LinkButton>

                                                                    <%--<asp:LinkButton ID="btnDeleteImage" runat="server" ToolTip="Delete Image" CommandArgument='<%# Eval("photoID") %>' CommandName="DeleteImage"><i class="fa fa-trash fa-2x delete"></i></asp:LinkButton>--%>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </div>
                                                    </FooterTemplate>
                                                </asp:Repeater>



                                            </div>

                                        </NestedViewTemplate>


                                    </MasterTableView>

                                    <PagerStyle Position="TopAndBottom" />


                                </telerik:RadGrid>



                                <asp:HiddenField ID="HiddenClientID" runat="server" />

                               <%-- <asp:SqlDataSource ID="getEventsByUserID" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="getGalleryEventsByUserID" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                        <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                        <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="fromDate" Type="DateTime"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="toDate" Type="DateTime"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>--%>

                                <%--<asp:LinqDataSource ID="getFilteredEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                    EntityTypeName="" TableName="qryViewEventsbyMarkets" Where="eventDate >= @eventDate && eventDate <= @eventDate1 && clientID == @clientID && userID == @userID" OrderBy="eventDate">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="eventDate" Type="DateTime"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="eventDate1" Type="DateTime"></asp:ControlParameter>
                                        <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>--%>

                               <%-- <asp:LinqDataSource ID="getFilteredMarketEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                    EntityTypeName="" TableName="qryViewEventsbyMarkets" Where="eventDate >= @eventDate && eventDate <= @eventDate1 && clientID == @clientID && userID == @userID" OrderBy="eventDate">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="eventDate" Type="DateTime"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="eventDate1" Type="DateTime"></asp:ControlParameter>
                                        <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>--%>

                                <%--<asp:LinqDataSource ID="getFilteredSupplierEvents" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext"
                                    EntityTypeName="" TableName="qryViewEventsbySuppliers" Where="eventDate >= @eventDate && eventDate <= @eventDate1 && clientID == @clientID && userID == @userID" OrderBy="eventDate">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="FromDatePicker" PropertyName="SelectedDate" Name="eventDate" Type="DateTime"></asp:ControlParameter>
                                        <asp:ControlParameter ControlID="ToDatePicker" PropertyName="SelectedDate" Name="eventDate1" Type="DateTime"></asp:ControlParameter>
                                        <asp:SessionParameter SessionField="CurrentClientID" DefaultValue="" Name="clientID" Type="Int32"></asp:SessionParameter>
                                        <asp:SessionParameter SessionField="CurrentUserID" Name="userID" Type="String"></asp:SessionParameter>
                                    </WhereParameters>
                                </asp:LinqDataSource>--%>



                               <%-- <asp:SqlDataSource ID="getStatusList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                                    SelectCommand="SELECT DISTINCT statusName FROM qryViewEvents"
                                    runat="server"></asp:SqlDataSource>

                                <asp:SqlDataSource ID="getMarketList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                                    ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT marketName FROM qryViewEvents"
                                    runat="server"></asp:SqlDataSource>

                                <asp:SqlDataSource ID="getEventTypeList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                                    ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT typename as eventTypeName FROM tblEvent Order By typeName"
                                    runat="server"></asp:SqlDataSource>

                                <asp:SqlDataSource ID="getEventAccountNameList" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                                    ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT accountName FROM qryViewEvents"
                                    runat="server"></asp:SqlDataSource>--%>

                            </div>





                        </div>
                    </asp:Panel>

                </div>


            </div>

            <div id="loading">
                <div class="widget stacked">
                    <div class="widget-content" style="padding-top: 20px; padding-bottom: 40px;">
                        <i class="fa fa-refresh fa-spin-2x fa-2x fa-fw" style="color: #0670cd;"></i>
                        <br />
                        <br />
                        <p style="font-size: 22px;">Please wait</p>
                        <br />
                        <p style="font-size: 18px;">This will take a few seconds</p>
                    </div>
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


    <script src="jQueryRotate.js"></script>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">


        <%--<script>
             function rotatephoto(photoID) {
                 alert(photoID);
                 var value = 0

                 $("#2856").rotate({
                     bind:
                     {
                         click: function () {
                             value += 90;
                             $(this).rotate({ animateTo: value })
                         }
                     }
                 });

             }


    </script>--%>



        <script type="text/javascript">
            $('#gallery').addClass('active');
            $('.ui-tooltip').tooltip();

            getPhotoBinCount();

            function getPhotoBinCount() {

                var obj = {};

                obj.userID = document.getElementById('<%=HiddenUserID.ClientID%>').value;


             $.ajax({
                 type: "POST",
                 url: "/ClientService.asmx/GetPhotoBinCount",
                 data: JSON.stringify(obj),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (r) {

                     //   alert(r.d);
                     $("#PhotoBinCountLabel").html(r.d == "" ? "0" : r.d);
                     // alert("Photo Added to the Bin");
                     getPhotoBinCount();
                 }
             });

             return false;

            }


            function addtobin(photoID) {

                var obj = {};
                obj.HiddenSessionGUID = document.getElementById('<%=HiddenSessionGUID.ClientID%>').value;
            obj.photoID = photoID;

            $.ajax({
                type: "POST",
                url: "/ClientService.asmx/AddPhotoToBin",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    // alert(r.d);
                    alert("Photo Added to the Bin");
                    getPhotoBinCount();
                }
            });

            return false;
            }


            function downloadphoto(photoID) {
                alert("fuction started");
                var obj = {};
                obj.photoID = photoID;

                $.ajax({
                    type: "POST",
                    url: "/DownloadHandler.aspx?photoID",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        alert("fuction success");

                    }
                });

                return false;
            }

            function rotatephoto(photoID) {
                var obj = {};
                obj.photoID = photoID;

                $.ajax({
                    type: "POST",
                    url: "/ClientService.asmx/RotateImage",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {

                        //alert("fuction success");

                    }
                });

                //document.getElementById("loading").style.display = "block";
                //document.getElementById("loading").scrollIntoView();
                document.getElementById("mainDiv").style.opacity = "0.5";

                //var value = 0

                //$("#" + photoID).rotate({
                //    bind:
                //    {
                //        click: function () {
                //            value += 90;
                //            $(this).rotate({ animateTo: value })
                //        }
                //    }
                //});


                //d = new Date();
                //$("#" + photoID).attr("src", "/GalleryImageHandler.ashx?PhotoID=" + photoID + "#" + d.getTime());

                //  __doPostBack('', '');

                //location.reload(true);
                $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
            return false;
            }

            function rotateleft(photoID) {
                var obj = {};
                obj.photoID = photoID;

                $.ajax({
                    type: "POST",
                    url: "/ClientService.asmx/RotateImageLeft",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {

                        //alert("fuction success");

                    }
                });

                document.getElementById("mainDiv").style.opacity = "0.5";
                $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
            return false;
            }




            function containerMouseover(sender) {
                sender.getElementsByTagName("div")[0].style.display = "";
            }

            function containerMouseout(sender) {
                sender.getElementsByTagName("div")[0].style.display = "none";
            }
        </script>
    </telerik:RadScriptBlock>

</asp:Content>
