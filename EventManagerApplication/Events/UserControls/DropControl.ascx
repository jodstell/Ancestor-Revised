<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DropControl.ascx.vb" Inherits="EventManagerApplication.DropControl" %>

<link href="/events/css/RequiredPositions.css" rel="stylesheet" />

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">

            var resultsPanel;
            Sys.Application.add_load(function myfunction() {
                resultsPanel = $get("<%= ResultsPanel.ClientID %>");

            })

        </script>

    </telerik:RadCodeBlock>

<script src="/events/js/RequiredPositions.js"></script>

 <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">

    </telerik:RadAjaxLoadingPanel>

    <div class="demo-container">

        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">

            <div id="trackContainer">

                <telerik:RadListView ID="RadListView1" runat="server" Skin="Silk" ItemPlaceholderID="TrackContainer" DataKeyNames="TrackID, Title, Artist"
                    ClientDataKeyNames="TrackID, Title, Artist">

                    <ClientSettings AllowItemsDragDrop="true">
                        <ClientEvents OnItemDragStarted="itemDragStarted" OnItemDragging="itemDragging" OnItemDropping="trackDropping"></ClientEvents>
                    </ClientSettings>

                    <LayoutTemplate>

                        <div class="RadListView RadListView_Silk">

                            <asp:PlaceHolder ID="TrackContainer" runat="server"></asp:PlaceHolder>

                        </div>

                    </LayoutTemplate>

                    <ItemTemplate>

                        <div class="track rlvI">

                            <telerik:RadListViewItemDragHandle ID="RadListViewItemDragHandle1" runat="server"

                                ToolTip="Drag to organize"></telerik:RadListViewItemDragHandle>

                            <div class="info">

                                <h3>

                                    <%# If(CType(Eval("TrackNumber"), Integer) > 0, Eval("TrackNumber"), "")%>

                                &nbsp;<%# Eval("Title") %></h3>

                                <div class="artist">

                                    <%# Server.HtmlEncode(Eval("Artist").ToString()) %>

                                </div>

                                <div class="album">

                                    <%# Eval("Album") %>

                                    <%# If(CType(Eval("Year"), Integer) > 0, Eval("Year"), "")%>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                    <EmptyDataTemplate>

                        <div class="noTracks">

                            No tracks in this section

                        </div>

                    </EmptyDataTemplate>

                </telerik:RadListView>

            </div>

            <div id="genreContainer">

                <asp:Repeater ID="GenresRepeater" runat="server">

                    <ItemTemplate>

                        <asp:LinkButton ID="GenreLink" runat="server" CommandName="ShowTracks" CommandArgument='<%# Eval("Key") %>'

                            onmouseover='this.className += " selected";' onmouseout='this.className = this.className.split(" selected").join("");'>

                            <%# If(Eval("Key").ToString() = "","Unsorted", Eval("Key")) %>&nbsp;

                            (<%# Eval("Value") %> items)

                        </asp:LinkButton>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

            <div class="clearFix">

            </div>

            <asp:Panel ID="ResultsPanel" runat="server" CssClass="result">

            </asp:Panel>

        </telerik:RadAjaxPanel>

    </div>

