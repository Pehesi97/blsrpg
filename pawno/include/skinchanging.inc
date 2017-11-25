//
// Admin player skin changer using previews. For SA-MP 0.3x and above.
// - Kye 2012
//

#include <a_samp>

#define Binco_BackColor 0x4A5A6BBB
#define Binco_SkinColor 0x88888899
#define Binco_TextColor 0xACCBF1FF

#define TOTAL_ITEMS         225
#define SELECTION_ITEMS 	21
#define ITEMS_PER_LINE  	7

#define HEADER_TEXT "Skins"
#define NEXT_TEXT   "Prox"
#define PREV_TEXT   "Voltar"

#define DIALOG_BASE_X   	75.0
#define DIALOG_BASE_Y   	130.0
#define DIALOG_WIDTH    	550.0
#define DIALOG_HEIGHT   	180.0
#define SPRITE_DIM_X    	60.0
#define SPRITE_DIM_Y    	70.0

new gTotalItems = TOTAL_ITEMS;
new PlayerText:gCurrentPageTextDrawId[MAX_PLAYERS];
new PlayerText:gHeaderTextDrawId[MAX_PLAYERS];
new PlayerText:gBackgroundTextDrawId[MAX_PLAYERS];
new PlayerText:gNextButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gPrevButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gSelectionItems[MAX_PLAYERS][SELECTION_ITEMS];
new gSelectionItemsTag[MAX_PLAYERS][SELECTION_ITEMS];
new gItemAt[MAX_PLAYERS];

new gItemList[TOTAL_ITEMS] = {
0,2,7,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,43,44,45,46,48,49,
50,51,52,53,54,55,56,57,58,59,60,62,63,64,66,67,68,69,70,71,72,73,75,76,77,78,79,80,81,82,83,84,85,87,88,89,90,91,92,93,94,95,96,
97,99,101,117,118,121,122,124,125,127,128,129,130,131,
132,133,134,135,136,137,138,139,140,141,143,144,145,146,148,150,151,154,155,156,157,158,159,160,161,162,163,164,165,166,
167,168,169,171,176,177,178,179,180,181,182,183,185,186,187,188,190,191,192,193,195,196,197,198,199,200,201,
202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,224,225,226,227,229,230,231,232,233,234,235,236,
237,238,239,240,241,243,244,245,246,249,250,251,252,253,255,256,257,258,259,260,261,262,263,264,268,
274,275,276,277,278,279,288,290,292,293,297,298
};

//------------------------------------------------

GetNumberOfPages()
{
	if((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
	{
		return (gTotalItems / SELECTION_ITEMS);
	}
	else return (gTotalItems / SELECTION_ITEMS) + 1;
}

//------------------------------------------------

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, Binco_TextColor);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------
// Creates a button textdraw and returns the textdraw ID.

PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x00000000);//0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 1); // shadow
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, Binco_TextColor);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtInit, 0);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, Binco_TextColor);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                            ~n~"); // enough space for everyone
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, Binco_BackColor);
	PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
	PlayerTextDrawFont(playerid, txtBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, Binco_BackColor);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

//------------------------------------------------
// Creates a model preview sprite

PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, 5);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, Binco_SkinColor);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

//------------------------------------------------

DestroyPlayerModelPreviews(playerid)
{
	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
			gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

//------------------------------------------------

ShowPlayerModelPreviews(playerid)
{
    new x = 0;
	new Float:BaseX = DIALOG_BASE_X;
	new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33); // down a bit
	new linetracker = 0;

	new itemat = GetPVarInt(playerid, "skinc_page") * SELECTION_ITEMS;

	// Destroy any previous ones created
	DestroyPlayerModelPreviews(playerid);

	while(x != SELECTION_ITEMS && itemat < gTotalItems) {
	    if(linetracker == 0) {
	        BaseX = DIALOG_BASE_X + 25.0; // in a bit from the box
	        BaseY += SPRITE_DIM_Y + 1.0; // move on the Y for the next line
		}
  		gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
  		gSelectionItemsTag[playerid][x] = gItemList[itemat];
		BaseX += SPRITE_DIM_X + 1.0; // move on the X for the next sprite
		linetracker++;
		if(linetracker == ITEMS_PER_LINE) linetracker = 0;
		itemat++;
		x++;
	}
}

//------------------------------------------------

UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"skinc_page") + 1, GetNumberOfPages());
	PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}

//------------------------------------------------

CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + 15.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, PREV_TEXT);

    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}

//------------------------------------------------

DestroySelectionMenu(playerid)
{
	DestroyPlayerModelPreviews(playerid);

	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);

	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

//------------------------------------------------

forward Binco_OnPlayerConnect(playerid);
public Binco_OnPlayerConnect(playerid)
{
	// Init all of the textdraw related globals
    gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

    for(new x=0; x < SELECTION_ITEMS; x++) {
        gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}

	gItemAt[playerid] = 0;

	return 1; // Allow other scripts to keep processing OnPlayerConnect
}

//-------------------------------------------
// Even though only Player* textdraws are used in this script,
// OnPlayerClickTextDraw is still required to handle ESC

forward Binco_OnPlayerClickTextDraw(playerid, Text:clickedid);
public Binco_OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   	if(GetPVarInt(playerid, "skinc_active") == 0) return 0;

	// Handle: They cancelled (with ESC)
	if(clickedid == Text:INVALID_TEXT_DRAW) {
        DestroySelectionMenu(playerid);
        SetPVarInt(playerid, "skinc_active", 0);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        return 1;
	}

	return 0;
}

//------------------------------------------------

forward Binco_OPCPTDraw(playerid, PlayerText:playertextid);
public Binco_OPCPTDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "skinc_active") == 0) return 0;

	new curpage = GetPVarInt(playerid, "skinc_page");

	// Handle: next button
	if(playertextid == gNextButtonTextDrawId[playerid]) {
	    if(curpage < (GetNumberOfPages() - 1)) {
	        SetPVarInt(playerid, "skinc_page", curpage + 1);
	        ShowPlayerModelPreviews(playerid);
         	UpdatePageTextDraw(playerid);
         	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}

	// Handle: previous button
	if(playertextid == gPrevButtonTextDrawId[playerid]) {
	    if(curpage > 0) {
	    	SetPVarInt(playerid, "skinc_page", curpage - 1);
	    	ShowPlayerModelPreviews(playerid);
	    	UpdatePageTextDraw(playerid);
	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}

	// Search in the array of textdraws used for the items
	new x = 0;
	while(x != SELECTION_ITEMS) {
	    if(playertextid == gSelectionItems[playerid][x]) {
	        HandlePlayerItemSelection(playerid, x);
	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	        DestroySelectionMenu(playerid);
	        CancelSelectTextDraw(playerid);
        	SetPVarInt(playerid, "skinc_active", 0);
        	return 1;
		}
		x++;
	}

	return 0;
}

stock StartSkinChange(playerid)
{
    // If there was a previously created selection menu, destroy it
    DestroySelectionMenu(playerid);

    SetPVarInt(playerid, "skinc_active", 1);
    //SetPVarInt(playerid, "skinc_page", 0); // will reset the page back to the first

    CreateSelectionMenu(playerid);
    SelectTextDraw(playerid, 0xACCBF1FF);
    return 1;
}
