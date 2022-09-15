<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Dashboard.Master" CodeBehind="EditMarket.aspx.vb" Inherits="EventManagerApplication.EditMarket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
            <div class="row">
            <div class="col-xs-12">
                <h2>Administration</h2>
                <br />

            </div>
        </div>

        <div class="row">
            <div class="col-md-3">

            </div>

             <div class="col-md-9">
                <h2>Edit Market</h2>
                 <hr />


                 <div class='col-sm-12'>
            <div>
               
                    <div class='form-group'>
                        <label class='control-label'>Name</label>

                        <input class='form-control' type='text' name='market[name]' id='name' value="Alabama">

                    </div>
                    <div class='form-group'>
                        <label class='control-label'>Active</label>
                        <select name='market[visible]' id='visible' class='form-control'>
                            <option value='f' >No</option>
                            <option value='t' SELECTED>Yes</option>
                        </select>
                    </div>

                    <div class='form-group'>
                        <label class='control-label'>Region</label>
                        <select name='market[regions_id]' id='regions_id' class='form-control'>
                                                            <option value='1' SELECTED>USA</option>
                                                    </select>
                    </div>


                    <div class='form-group'>
                        <label class='control-label'>Market Code</label>
                        <input class='form-control' type='text' maxlength=3 name='market[code]' id='code' value="">
                    </div>

                    <div class='form-group'>
                        <label class='control-label'>Parent Market</label>
                        <select name='market[parents_id]' id='' class='form-control'>
                        <option value=''>None</option>
                                                <option value='7435' >Arkansas</option>
                                                <option value='7164' >Atlanta, GA</option>
                                                <option value='7396' >Aurora, CO</option>
                                                <option value='7028' >Austin, TX</option>
                                                <option value='7387' >Boston, MA</option>
                                                <option value='7412' >Chicago</option>
                                                <option value='7033' >Chicago, IL</option>
                                                <option value='7398' >Colorado</option>
                                                <option value='7397' >Connecticut</option>
                                                <option value='7030' >Dallas/Ft. Worth, TX</option>
                                                <option value='7169' >DC/Virginia, Mid-Atlantic Market</option>
                                                <option value='7409' >Delaware</option>
                                                <option value='7170' >Denver, CO</option>
                                                <option value='7183' >Detroit, MI</option>
                                                <option value='7103' >El Paso , TX</option>
                                                <option value='7035' >Ft Lauderdale, FL</option>
                                                <option value='7154' >Harlingen, TX</option>
                                                <option value='7438' >Hawaii</option>
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
                                                <option value='7441' >Northern California</option>
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
                                                <option value='7414' >San Diego/LA</option>
                                                <option value='7038' >San Francisco, CA</option>
                                                <option value='7405' >Savannah, GA</option>
                                                <option value='7400' >Seattle, WA</option>
                                                <option value='7392' >South Carolina</option>
                                                <option value='7413' >South Florida</option>
                                                <option value='7389' >St. Louis, MO</option>
                                                <option value='7410' >Tampa, Florida</option>
                                                <option value='7401' >Tennessee</option>
                                                <option value='7448' >Upstate New York, NY</option>
                                                <option value='7403' >Wisconsin</option>
                                                <option value='7440' >Wyoming</option>
                                                </select>
                    </div>




                <legend>Associated States / Provinces</legend>

                    <div class='form-group'>
                        <label class='control-label'>States/Provinces</label>
                        <select name='market[states][]' id='states' multiple='multiple' class='form-control sidebyside'>
                                                <option value='2' >Alabama</option>
                                                <option value='1' >Alaska</option>
                                                <option value='54' >Alberta</option>
                                                <option value='4' >Arizona</option>
                                                <option value='5' >Arkansas</option>
                                                <option value='55' >British Columbia</option>
                                                <option value='6' >California</option>
                                                <option value='7' >Colorado</option>
                                                <option value='8' >Connecticut</option>
                                                <option value='9' >Delaware</option>
                                                <option value='10' >District of Columbia</option>
                                                <option value='11' >Florida</option>
                                                <option value='12' >Georgia</option>
                                                <option value='13' >Hawaii</option>
                                                <option value='14' >Idaho</option>
                                                <option value='15' >Illinois</option>
                                                <option value='16' >Indiana</option>
                                                <option value='17' >Iowa</option>
                                                <option value='18' >Kansas</option>
                                                <option value='19' >Kentucky</option>
                                                <option value='20' >Louisiana</option>
                                                <option value='21' >Maine</option>
                                                <option value='56' >Manitoba</option>
                                                <option value='22' >Maryland</option>
                                                <option value='23' >Massachusetts</option>
                                                <option value='24' >Michigan</option>
                                                <option value='25' >Minnesota</option>
                                                <option value='26' >Mississippi</option>
                                                <option value='27' >Missouri</option>
                                                <option value='28' >Montana</option>
                                                <option value='29' >Nebraska</option>
                                                <option value='30' >Nevada</option>
                                                <option value='57' >New Brunswick</option>
                                                <option value='58' >Newfoundland And Labrador</option>
                                                <option value='31' >New Hampshire</option>
                                                <option value='32' >New Jersey</option>
                                                <option value='33' >New Mexico</option>
                                                <option value='34' >New York</option>
                                                <option value='35' >North Carolina</option>
                                                <option value='36' >North Dakota</option>
                                                <option value='59' >Northwest Territories</option>
                                                <option value='60' >Nova Scotia</option>
                                                <option value='61' >Nunavut</option>
                                                <option value='37' >Ohio</option>
                                                <option value='38' >Oklahoma</option>
                                                <option value='62' >Ontario</option>
                                                <option value='39' >Oregon</option>
                                                <option value='40' >Pennsylvania</option>
                                                <option value='63' >Prince Edward Island</option>
                                                <option value='53' >Puerto Rico</option>
                                                <option value='64' >Quebec</option>
                                                <option value='41' >Rhode Island</option>
                                                <option value='65' >Saskatchewan</option>
                                                <option value='42' >South Carolina</option>
                                                <option value='43' >South Dakota</option>
                                                <option value='44' >Tennessee</option>
                                                <option value='45' >Texas</option>
                                                <option value='46' >Utah</option>
                                                <option value='47' >Vermont</option>
                                                <option value='48' >Virginia</option>
                                                <option value='49' >Washington</option>
                                                <option value='50' >West Virginia</option>
                                                <option value='51' >Wisconsin</option>
                                                <option value='52' >Wyoming</option>
                                                <option value='66' >Yukon Territory</option>
                                                </select>
                    </div>


                    <div class='form-group'>
                        <label></label>
                        <a href='/admin/viewregion.php?id=1' class='btn btn-default'>Cancel</a>
                        <input type='submit' class='btn btn-default btn-success' name='submit' value='Save'>
                    </div>

                </div>
                     </div>



            </div>

        </div>

        </div>

</asp:Content>
