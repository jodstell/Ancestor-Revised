<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="NewPage.aspx.vb" Inherits="EventManagerApplication.NewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">

        <h1>Add New Event</h1>


        <asp:Panel ID="Panel1" runat="server">


            <div class="col-md-8">
                                            <p>Select the brands that you wish to present at the event.</p>
                                            <div class="form-horizontal">

                                                <div class="form-group">
                                                    <div class="col-sm-9">
                                                        <telerik:RadListBox RenderMode="Lightweight" ID="SelectedBrandsList" runat="server" CheckBoxes="true" ShowCheckAll="true" Width="500px"
                                                            Height="350px" DataTextField="brandName" DataValueField="brandID" DataSourceID="getSupplierList"  AutoPostBack="true" OnClientItemChecked="OnClientItemChecked">
                                                        </telerik:RadListBox>

                                                        
                                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidationCriteria" 
                                                            ErrorMessage="Brand is required" CssClass="errorlabel" ValidationGroup="brands"></asp:CustomValidator> 

                                                        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock">
                                                            <script type="text/javascript"> 
                                                                function ValidationCriteria(source, args) 
                                                                { 
                                                                    var listbox = $find('<%= SelectedBrandsList.ClientID %>'); 
                                                                    var check = 0; 
                                                                    var items = listbox.get_items(); 
                                                                    for (var i = 0; i<= items.get_count()-1; i++) 
                                                                    { 
                                                                        var item = items.getItem(i); 
                                                                        if(item.get_checked()) 
                                                                        { 
                                                                            check = 1; 
                                                                        } 
                                                                    } 
                                                                    if(check) 
                                                                        args.IsValid =true; 
                                                                    else 
                                                                        args.IsValid = false; 
                                                                } 
                                                                </script> 
                                                        </telerik:RadScriptBlock>

                                                    </div>


                                                    <asp:SqlDataSource ID="getSupplierList" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                                        SelectCommand="SELECT * FROM [getBrandsbySupplier] WHERE ([supplierID] = @supplierID) ORDER BY [brandName]">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="supplierID" Name="supplierID" Type="Int32"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>

                                                <asp:Button ID="Button1" runat="server" Text="Button" />



                                                 <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-3 control-label">Attire</label>
                                                    <div class="col-sm-8">
                                                        <telerik:RadEditor ID="attireTextEditor" runat="server" RenderMode="Lightweight" ToolsFile="BasicTools.xml" EditModes="Design" Width="100%"></telerik:RadEditor>


                                                    </div>
                                                </div>




                                            </div>
                                        </div>



        </asp:Panel>




    </div>

    <script type="text/javascript">
            function OnClientItemChecked(sender, args) {
                    args.get_item().set_selected(args.get_item().get_checked());
            }
</script>
</asp:Content>
