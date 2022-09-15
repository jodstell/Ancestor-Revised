
var originalMsg = "";

 

function itemDragStarted(sender, args)

{

    var title = args.get_dataKeyValues().Title;

    var artist = args.get_dataKeyValues().Artist;

 

    showAction(title, artist);

}

 

function itemDragging(sender, args)

{

    var evt = args.get_domEvent();

    var genreContainer = $get("genreContainer");

    var itemIndex = sender._itemDrag._draggedItemIndex;

    var clientKeys = sender.get_clientDataKeyValue()[itemIndex];

    var title = clientKeys.Title;

    var artist = clientKeys.Artist

 

    if ($telerik.isMouseOverElementEx(genreContainer, evt))

    {

        var target = evt.srcElement || evt.originalTarget;

        var genre = target.className;

 

        showAction(title, artist, genre.split(' ')[0]);

    }

    else

    {

        showAction(title, artist);

    }

}

 

function showAction(title, artist, genre)

{

    var titleDiv = title ? String.format("<div class='track'><b>{0}</b><br />{1}</div>", title, artist) : "";

    var arrowDiv = genre ? "<div class='arrow'></div>" : "";

    var genreDiv = genre ? String.format("<div class='genre {0}'>{0}</div>", genre) : "";

 

    resultsPanel.innerHTML = String.format("{0}{1}{2}", titleDiv, genreDiv, arrowDiv);

}

 

function trackDropping(sender, args)

{

    var dest = args.get_destinationElement();

    if (!dest || !dest.id || dest.id.indexOf("GenreLink") < 0)

    {

        args.set_cancel(true);

    }

 

    showAction();

}