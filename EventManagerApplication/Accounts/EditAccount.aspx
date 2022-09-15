<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditAccount.aspx.vb" Inherits="EventManagerApplication.EditAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h2>Edit Account</h2>

                <asp:FormView ID="AccountFormView" runat="server" DataKeyNames="accountID" DataSourceID="GetAccount" Width="100%" DefaultMode="Edit">
                    <EditItemTemplate>

                        <div class='container'>
    <div class='row'>
        <div class='col-sm-12'><legend>Edit Venue</legend></div>
    </div>
    <div class='row'>
        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>Name*</label>
                <div>
               
                <asp:TextBox ID="accountNameTextBox" runat="server" Text='<%# Bind("accountName") %>' CssClass="form-control input-sm required" />
                
                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>Vpid</label>
                <div>

                <asp:TextBox ID="VpidTextBox" runat="server" Text='<%# Bind("Vpid")%>' CssClass="form-control input-sm required" />
               
                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>streetAddress1</label>
                <div>

                <asp:TextBox ID="streetAddress1TextBox" runat="server" Text='<%# Bind("streetAddress1") %>'  CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>
    </div>

    <div class='row'>
        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>streetAddress2</label>
                <div>

                <asp:TextBox ID="streetAddress2TextBox" runat="server" Text='<%# Bind("streetAddress2") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>city</label>
                <div>

                <asp:TextBox ID="city" runat="server" Text='<%# Bind("city") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>state</label>
                <div>

                <asp:TextBox ID="stateTextBox" runat="server" Text='<%# Bind("state") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>
    </div>

    <div class='row'>
        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>zipCode</label>
                <div>

                <asp:TextBox ID="zipCodeTextBox" runat="server" Text='<%# Bind("zipCode") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>phone</label>
                <div>

                <asp:TextBox ID="phoneTextBox" runat="server" Text='<%# Bind("Phone") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>accountTypeName</label>
                <div>

                <asp:TextBox ID="accountTypeNameTextBox" runat="server" Text='<%# Bind("accountTypeName") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>
    </div>

    <div class='row'>
        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>marketName</label>
                <div>

                <asp:TextBox ID="marketNameTextBox" runat="server" Text='<%# Bind("marketName") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>latitude</label>
                <div>

                    <asp:TextBox ID="latitudeTextBox" runat="server" Text='<%# Bind("latitude") %>' CssClass="form-control input-sm required" />
                
                </div>
            </div>
        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>longitude</label>
                <div>

                <asp:TextBox ID="longitudeTextBox" runat="server" Text='<%# Bind("longitude") %>' CssClass="form-control input-sm required" />

                </div>
            </div>
        </div>
    </div>

    <div class='row'>
        <div class='col-sm-8'>
            <div class='form-group'>
                <label class='control-label'>Address 1</label>
                <div>
                <input type='text' class='form-control input-sm' id='' name='data[street_address1]' value="975 Lincoln St">
                </div>
            </div>
            <div class='form-group'>
                <label class='control-label'>Address 2</label>
                <div>
                <input type='text' class='form-control input-sm' id='' name='data[street_address2]' value="">
                </div>
            </div>
            <div class='form-group'>

                <div class='row'>
                    <div class='col-sm-6'>
                        <div class='form-group'>
                            <label class='control-label'>City</label>
                            <div>
                                <input type='text' class='form-control input-sm' id='' name='data[city]' value="Denver">
                            </div>
                        </div>
                    </div>

                    <div class='col-md-2'>
                        <div class='form-group'>
                            <label class='control-label'>State</label>
                            <div>
                                <select class='form-control input-sm' id='' name='data[state]'>
                                    <option value=''></option>
                                                                            <option value='AK' >AK</option>
                                                                            <option value='AL' >AL</option>
                                                                            <option value='AR' >AR</option>
                                                                            <option value='AZ' >AZ</option>
                                                                            <option value='CA' >CA</option>
                                                                            <option value='CO' SELECTED>CO</option>
                                                                            <option value='CT' >CT</option>
                                                                            <option value='DC' >DC</option>
                                                                            <option value='DE' >DE</option>
                                                                            <option value='FL' >FL</option>
                                                                            <option value='GA' >GA</option>
                                                                            <option value='HI' >HI</option>
                                                                            <option value='IA' >IA</option>
                                                                            <option value='ID' >ID</option>
                                                                            <option value='IL' >IL</option>
                                                                            <option value='IN' >IN</option>
                                                                            <option value='KS' >KS</option>
                                                                            <option value='KY' >KY</option>
                                                                            <option value='LA' >LA</option>
                                                                            <option value='MA' >MA</option>
                                                                            <option value='MD' >MD</option>
                                                                            <option value='ME' >ME</option>
                                                                            <option value='MI' >MI</option>
                                                                            <option value='MN' >MN</option>
                                                                            <option value='MO' >MO</option>
                                                                            <option value='MS' >MS</option>
                                                                            <option value='MT' >MT</option>
                                                                            <option value='NC' >NC</option>
                                                                            <option value='ND' >ND</option>
                                                                            <option value='NE' >NE</option>
                                                                            <option value='NH' >NH</option>
                                                                            <option value='NJ' >NJ</option>
                                                                            <option value='NM' >NM</option>
                                                                            <option value='NV' >NV</option>
                                                                            <option value='NY' >NY</option>
                                                                            <option value='OH' >OH</option>
                                                                            <option value='OK' >OK</option>
                                                                            <option value='OR' >OR</option>
                                                                            <option value='PA' >PA</option>
                                                                            <option value='PR' >PR</option>
                                                                            <option value='RI' >RI</option>
                                                                            <option value='SC' >SC</option>
                                                                            <option value='SD' >SD</option>
                                                                            <option value='TN' >TN</option>
                                                                            <option value='TX' >TX</option>
                                                                            <option value='UT' >UT</option>
                                                                            <option value='VA' >VA</option>
                                                                            <option value='VT' >VT</option>
                                                                            <option value='WA' >WA</option>
                                                                            <option value='WI' >WI</option>
                                                                            <option value='WV' >WV</option>
                                                                            <option value='WY' >WY</option>
                                                                    </select>
                            </div>
                        </div>
                    </div>

                    <div class='col-md-4'>
                        <div class='form-group'>
                            <label class='control-label'>Zip</label>
                            <div>
                                <input type='text' class='form-control input-sm' id='' name='data[zip]' value="80203">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class='row'>
                <div class='col-sm-6'>
                    <div class='form-group'>
                    <label class='control-label'>Neighborhood</label>
                    <div>
                    <input type='text' class='form-control input-sm' id='' name='data[neighborhood]' value=''>
                    </div>
                </div>
                </div>
            </div>
            <div class='row'>
                <div class='col-sm-6'>
                    <div class='form-group'>
                        <label class='control-label'>Market*</label>
                        <div>
                        <select class='form-control input-sm required' id='' name='data[markets_id]' parsley-trigger='change click' required>
                            <option value=''></option>
                                                        <option value='7391' >Alabama</option>
                                                        <option value='7435' >Arkansas</option>
                                                        <option value='7164' >Atlanta, GA</option>
                                                        <option value='7396' >Aurora, CO</option>
                                                        <option value='7028' >Austin, TX</option>
                                                        <option value='7387' >Boston, MA</option>
                                                        <option value='7033' >Chicago, IL</option>
                                                        <option value='7398' SELECTED>Colorado</option>
                                                        <option value='7397' >Connecticut</option>
                                                        <option value='7030' >Dallas/Ft. Worth, TX</option>
                                                        <option value='7169' >DC/Virginia, Mid-Atlantic Market</option>
                                                        <option value='7409' >Delaware</option>
                                                        <option value='7170' >Denver, CO</option>
                                                        <option value='7183' >Detroit, MI</option>
                                                        <option value='7103' >El Paso , TX</option>
                                                        <option value='7035' >Ft Lauderdale, FL</option>
                                                        <option value='7154' >Harlingen, TX</option>
                                                        <option value='7031' >Houston, TX</option>
                                                        <option value='7182' >Indianapolis, IN</option>
                                                        <option value='7434' >Iowa</option>
                                                        <option value='7433' >Jacksonville, FL</option>
                                                        <option value='7394' >Kansas</option>
                                                        <option value='7187' >Kentucky</option>
                                                        <option value='7185' >Las Vegas, NV</option>
                                                        <option value='7029' >Los Angeles, CA</option>
                                                        <option value='7071' >Lubbock, TX</option>
                                                        <option value='7386' >Market</option>
                                                        <option value='7429' >Maryland</option>
                                                        <option value='7034' >Miami, FL</option>
                                                        <option value='7407' >Minnesota</option>
                                                        <option value='7436' >Mississippi</option>
                                                        <option value='7406' >Missouri</option>
                                                        <option value='7390' >Nebraska</option>
                                                        <option value='7395' >New Hampshire</option>
                                                        <option value='7393' >New Jersey</option>
                                                        <option value='7437' >New Mexico</option>
                                                        <option value='7388' >New Orleans, LA</option>
                                                        <option value='7039' >New York, NY</option>
                                                        <option value='7188' >North Carolina</option>
                                                        <option value='7408' >Ohio</option>
                                                        <option value='7439' >Oklahoma</option>
                                                        <option value='7167' >Orlando, FL</option>
                                                        <option value='7430' >Pennsylvania</option>
                                                        <option value='7432' >Pensacola, FL</option>
                                                        <option value='7402' >Phoenix, AZ</option>
                                                        <option value='7399' >Portland, OR</option>
                                                        <option value='7411' >Reno, NV</option>
                                                        <option value='7404' >Rhode Island</option>
                                                        <option value='7431' >Sacramento, CA</option>
                                                        <option value='7032' >San Antonio, TX</option>
                                                        <option value='7038' >San Francisco, CA</option>
                                                        <option value='7405' >Savannah, GA</option>
                                                        <option value='7400' >Seattle, WA</option>
                                                        <option value='7392' >South Carolina</option>
                                                        <option value='7389' >St. Louis, MO</option>
                                                        <option value='7410' >Tampa, Florida</option>
                                                        <option value='7401' >Tennessee</option>
                                                        <option value='7403' >Wisconsin</option>
                                                        <option value='7440' >Wyoming</option>
                                                    </select>
                        </div>
                    </div>
                </div>

                <div class='col-sm-6'>
                    <div class='form-group'>
                        <label class='control-label'>Venue Type*</label>
                        <div>
                        <select class='form-control input-sm required' id='' name='data[venues_types_id]' parsley-trigger='change click' required>
                            <option value=''></option>
                                                        <option value='301' >Bar/Nightclub</option>
                                                        <option value='303' >Fine Dining</option>
                                                        <option value='412' >Hotel</option>
                                                        <option value='309' >Retail/Off-Premise Account</option>
                                                        <option value='263' SELECTED>Venue</option>
                                                    </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class='row'>
                <div class='col-sm-6'>
                    <div class='form-group'>
                        <label class='control-label'>Account Status</label>
                        <div>
                        <select class='form-control input-sm' id='account_status' name='data[account_status]'>
                            <option value=''></option>
                            <option value='Active' >Active</option>
                            <option value='Previous Active' >Previous Active</option>
                            <option value='Pending' >Pending</option>
                            <option value='Target' >Target</option>
                        </select>
                        </div>
                    </div>
                </div>

                <div class='col-sm-6'>
                    <div class='form-group' id='inactive_reason_field' style='display:none;'>
                        <label class='control-label'>Inactive Reason</label>
                        <div>
                        <select class='form-control input-sm' id='inactive_reason' name='data[inactive_reason]'>
                            <option value=''></option>
                            <option value='Distributor Credit Hold' >Distributor Credit Hold</option>
                            <option value='Closed' >Closed</option>
                            <option value='Management Turnover' >Management Turnover</option>
                            <option value='Other' >Other</option>
                        </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class='row' id='inactive_reason_other_field' style='display:none;'>
                <div class=' col-sm-offset-6 col-sm-6'>
                    <div class='form-group'>
                        <label class='control-label'>Other Inactive Reason</label>
                        <div>
                        <input type='text' class='form-control input-sm' id='inactive_reason_other' name='data[inactive_reason_other]' value="">
                        </div>
                    </div>
                </div>
            </div>

            <div class='form-group'>
                <label class='control-label'>Notes</label>
                <div>
                <textarea class='form-control input-sm' id='' name='data[notes]'></textarea>
                </div>
            </div>




        </div>

        <div class='col-sm-4'>
            <div class='form-group'>
                <label class='control-label'>Capacity</label>
                <div>
                <input type='text' class='form-control input-xs' id='' name='data[capacity]' value="0" parsley-type='digits' parsley-trigger='change keyup'>
                </div>
            </div>
            <div class='form-group'>
                <label class='control-label'># of Bars</label>
                <div>
                <input type='text' class='form-control input-sm' id='' name='data[number_of_bars]' value="0" parsley-type='digits' parsley-trigger='change keyup'>
                </div>
            </div>
            <div class='form-group'>
                <label class='control-label'>Bartender Stations</label>
                <div>
                <input type='text' class='form-control input-sm' id='' name='data[num_bartender_stations]' value="0" parsley-type='digits' parsley-trigger='change keyup'>
                </div>
            </div>


        </div>
    </div>
    <div class='row'>
        <div class='col-sm-12'>
            <div class='form-group'>
                <div>
               
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Save" CssClass="btn btn-primary" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-default" />
                </div>
            </div>
        </div>
    </div>



</div>


                        <hr /><hr />





                               <label for="inputEmail3" class="col-sm-2 control-label"> accountName:</label>        
                        
                            

                       
                        
                        <br />
                        Vpid:
                        
                        <br />
                       
                        <br />
                        streetAddress1:
                        
                        <br />
                        streetAddress2:
                        
                        <br />
                        city:
                        <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' />
                        <br />
                       			state:
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("state") %>' />
                        <br />
                        zipCode:
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("zipCode") %>' />
                        <br />
                        phone:
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("phone") %>' />
                        <br />
                        accountTypeName:
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("accountTypeName") %>' />
                        <br />
                        marketName:
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("marketName") %>' />
                        <br />
                        latitude:
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("latitude") %>' />
                        <br />
                        longitude:
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("longitude") %>' />
                        <br />
                        
                    </EditItemTemplate>


                </asp:FormView>



                <asp:LinqDataSource ID="GetAccount" runat="server" ContextTypeName="EventManagerApplication.DataClassesDataContext" EnableDelete="True" EnableUpdate="True" EntityTypeName="" TableName="tblAccounts" Where="accountID == @accountID">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="accountID" QueryStringField="AccountID" Type="Int32" />
                    </WhereParameters>
                </asp:LinqDataSource>



            </div>
        </div>
    </div>


</asp:Content>
