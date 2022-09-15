<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SiteConfigurationControl.ascx.vb" Inherits="EventManagerApplication.SiteConfigurationControl" %>


                                        <asp:FormView ID="SiteConfigurationFormView" runat="server" DefaultMode="edit" DataSourceID="getSiteConfiguration" Width="100%" DataKeyNames="ID">
                                            <EditItemTemplate>


                                                <asp:Button ID="btnSaveConfiguration" runat="server" Text="Save Changes" CssClass="btn btn-primary" CommandName="Update" />
                                                <asp:Button ID="ButtonSiteConfiguration" runat="server" Text="Back To Site Administration" CssClass="btn btn-default" CommandName="Cancel" />
                                                <br />
                                                <br />
                                                <div class="col-sm-12 col-md-12 col-lg-6">
                                                    <h3>Options</h3>

                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">From Email</label>
                                                                <asp:TextBox ID="FromEmailTextBox" runat="server" CssClass="form-control" Text='<%# Bind("DefaultFromAddress") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">From Name</label>
                                                                <asp:TextBox ID="FromNameTextBox" runat="server" CssClass="form-control" Text='<%# Bind("DeafultFromName") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Staff Address Change Alert Email</label>
                                                                <asp:TextBox ID="AlertEmailTextBox" runat="server" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Allow Expenses</label>
                                                                <select name="data[staffing_allow_expenses]" class="form-control input-sm">
                                                                    <option value="f">No</option>
                                                                    <option value="t" selected="">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Use RSVP Process</label>
                                                                <select name="data[staffing_use_rsvp]" class="form-control input-sm">
                                                                    <option value="f" selected="">No</option>
                                                                    <option value="t">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Filter Staff By Clients</label>
                                                                <select name="data[staffing_filter_by_clients]" class="form-control input-sm">
                                                                    <option value="f">No</option>
                                                                    <option value="t" selected="">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Filter Staff By Programs</label>
                                                                <select name="data[staffing_filter_by_programs]" class="form-control input-sm">
                                                                    <option value="f" selected="">No</option>
                                                                    <option value="t">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Filter Staff By Markets</label>
                                                                <select name="data[staffing_filter_by_markets]" class="form-control input-sm">
                                                                    <option value="f">No</option>
                                                                    <option value="t" selected="">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Filter Staff By Positions</label>
                                                                <select name="data[staffing_filter_by_positions]" class="form-control input-sm">
                                                                    <option value="f">No</option>
                                                                    <option value="t" selected="">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <div class="form-group">
                                                                <label class="control-label">Use Desired States Instead of Markets</label>
                                                                <select name="data[staffing_filter_by_markets]" class="form-control input-sm">
                                                                    <option value="f">No</option>
                                                                    <option value="t">Yes</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6">
                                                        </div>
                                                    </div>

                                                </div>




                                            </EditItemTemplate>

                                        </asp:FormView>

                                        <asp:LinqDataSource runat="server" EntityTypeName="" ID="getSiteConfiguration" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableUpdate="True" TableName="tblSiteSettings" Where="ID == @ID">
                                            <WhereParameters>
                                                <asp:Parameter DefaultValue="2" Name="ID" Type="Int32"></asp:Parameter>
                                            </WhereParameters>
                                        </asp:LinqDataSource>