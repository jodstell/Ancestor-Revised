
var interval = 500;

 

function FilterData(evt)

{

    if (evt.keyCode == "13")

    {

        //prevent event bubbling

        evt.cancelBubble = true;

        evt.returnValue = false;

 

        if (evt.stopPropagation)

        {

            evt.stopPropagation();

            evt.preventDefault();

        }

 

        if ($('div[id*=numericBoxValueDiv]')[0].style.display != 'none' && numericBox.get_value() == "")

        {

            return false;

        }

 

        //trigger an ajax request to apply the selected filter expression

        btnSearch.click();

    }

}

 

function btnSearchClick(evt)

{

 

    if ($('div[id*=numericBoxValueDiv]')[0].style.display != 'none' && numericBox.get_value() == "")

    {

        //prevent event bubbling

        evt.cancelBubble = true;

        evt.returnValue = false;

 

        if (evt.stopPropagation)

        {

            evt.stopPropagation();

            evt.preventDefault();

        }

        return false;

    }

}

 

function NoFilterChosen()

{

    //hide the UI filter data controls

    $('div[id*=radioButtonDiv2]').hide(interval);

    $('div[id*=radioButtonDiv1]').hide(interval, hideRemainingControls);

 

    //trigger an ajax request to rebind the RadListView

    setTimeout(function () { btnShowAll.click() }, interval * 2);

 

}

 

function fieldComboSelectedIndexChanged(sender, args)

{

    if (args.get_item().get_text() == "Choose Filter")

    {

        NoFilterChosen();

    }

    else if (args.get_item().get_value().split('_')[1] != 'System.String')

    {

 

        //replace the regular TextBox control with a RadNumericTextBox   

        $('div[id*=boxValueDiv]').hide(0);

        $('div[id*=numericBoxValueDiv]').show(0);

 

        //hide the UI filter data controls for the string-type fields

        $('div[id*=radioButtonDiv2]').hide(interval);

 

        //show the UI filter data controls for the nonstring-type fields

        $('div[id*=radioButtonDiv1]').show(interval, showRemainingControls);

 

        //set a default filter function

        $('table[id*=filterFunctionsList1] input[type=radio]')[0].checked = true;

 

        //clear the filter value box controls

        $('input[id*=boxValue]')[0].value = '';

        numericBox.clear();

    }

    else

    {

 

        //replace the RadNumericTextBox with a regular TextBox control    

        $('div[id*=numericBoxValueDiv]').hide(0);

        $('div[id*=boxValueDiv]').show(0);

 

        //hide the UI filter data controls for the nonstring-type fields

        $('div[id*=radioButtonDiv1]').hide(interval);

 

        //show the UI filter data controls for the nonstring-type fields    

        $('div[id*=radioButtonDiv2]').show(interval, showRemainingControls);

 

        //set a default filter function

        $('table[id*=filterFunctionsList2] input[type=radio]')[0].checked = true;

 

        //clear the filter value box controls

        $('input[id*=boxValue]')[0].value = '';

        numericBox.clear();

    }

}

 

function showRemainingControls()

{

    //show the UI filter button controls

    $('div[id*=buttonsDiv]').fadeIn(interval);

}

 

 

function hideRemainingControls()

{

    //hide all the UI filter data controls

    $('div[id*=boxValueDiv]').fadeOut(interval);

    $('div[id*=numericBoxValueDiv]').fadeOut(interval);

    $('div[id*=buttonsDiv]').fadeOut(interval);

}