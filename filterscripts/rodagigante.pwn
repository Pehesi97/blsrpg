/********************************************** Los Santos Ferris Wheel v1.2 ***
*
* Scriptname:
* -» Los Santos Ferris Wheel
*
* Author:
* -» Pablo_Borsellino

* Changelog:
* • v1.0 (3.10.2011)
* -» Initial Release
* • v1.1 (3.10.2011):
* -» Fixxed removing mistake
* • v1.2 (8.10.2011):
* -» Fixxed Object removing for /rcon CMD User
* -» Fixxed Object removing for Model 3751
*
* Need to use:
* -» Sa:Mp 0.3d or higher
*
* Language:
* -» English
*
* Description:
* -» This Filterscript let rotate the Los Santos Ferris Wheel
*
* Functions:
* -» n/a
*
* Public's:
* -» n/a
*
* Credit's:
* -» n/a
*											Copyright © 2011 by Pablo_Borsellino
*******************************************************************************/

//______________________________________________________________________________
#include <a_samp>

//______________________________________________________________________________
#define forEx(%0,%1) for(new %1=0;%1<%0;%1++)

//_____________________________________________________________________Setting's
#define FERRIS_WHEEL_WAIT_TIME 3000	//Wait Time to enter a Cage
#define FERRIS_WHEEL_SPEED 0.005	//Speed of turn (Standart 0.005)

//______________________________________________________________________________
new Float:gFerrisCageOffsets[10][3]={{0.0699,0.0600,-11.7500},{-6.9100,-0.0899,-9.5000},{11.1600,0.0000,-3.6300},{-11.1600,-0.0399,3.6499},{-6.9100,-0.0899,9.4799},{0.0699,0.0600,11.7500},{6.9599,0.0100,-9.5000},{-11.1600,-0.0399,-3.6300},{11.1600,0.0000,3.6499},{7.0399,-0.0200,9.3600}},
	FerrisWheelObjects[12],
	Float:FerrisWheelAngle=0.0,
	FerrisWheelAlternate=0;

//______________________________________________________________________________
forward RotateFerrisWheel();

//______________________________________________________________________________
public OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 6463, 389.7734, -2028.4688, 19.8047, 0.5);
	RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2035.3828, 29.9531, 50);
	RemoveBuildingForPlayer(playerid, 6298, 389.7734, -2028.4688, 19.8047, 0.5);
	RemoveBuildingForPlayer(playerid, 6461, 389.7734, -2028.5000, 20.1094, 0.5);
	RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2028.5000, 32.2266, 50);
	return 1;
}

//______________________________________________________________________________
public OnFilterScriptInit()
{
	FerrisWheelObjects[10]=CreateObject(18877,389.7734,-2028.4688,22,0,0,90,300);
	FerrisWheelObjects[11]=CreateObject(18878,389.7734,-2028.4688,22,0,0,90,300);
	forEx((sizeof FerrisWheelObjects)-2,x){
		FerrisWheelObjects[x]=CreateObject(18879,389.7734,-2028.4688,22,0,0,90,300);
		AttachObjectToObject(FerrisWheelObjects[x], FerrisWheelObjects[10],gFerrisCageOffsets[x][0],gFerrisCageOffsets[x][1],gFerrisCageOffsets[x][2],0.0, 0.0, 90, 0 );}
	SetTimer("RotateFerrisWheel",FERRIS_WHEEL_WAIT_TIME,false);
	forEx(MAX_PLAYERS,playerid){
		RemoveBuildingForPlayer(playerid, 6463, 389.7734, -2028.4688, 19.8047, 0.5);
		RemoveBuildingForPlayer(playerid, 3751, 389.8750, -2035.3828, 29.9531, 50);
		RemoveBuildingForPlayer(playerid, 6298, 389.7734, -2028.4688, 19.8047, 0.5);
		RemoveBuildingForPlayer(playerid, 6461, 389.7734, -2028.5000, 20.1094, 0.5);
		RemoveBuildingForPlayer(playerid, 3752, 389.8750, -2028.5000, 32.2266, 50);
	}
	return 1;
}

//______________________________________________________________________________
public OnFilterScriptExit()
{
	forEx(sizeof FerrisWheelObjects,x)DestroyObject(FerrisWheelObjects[x]);
	return 1;
}

//______________________________________________________________________________
public OnObjectMoved(objectid)
{
	if(objectid==FerrisWheelObjects[10])SetTimer("RotateFerrisWheel",FERRIS_WHEEL_WAIT_TIME,false);
	return 1;
}

//______________________________________________________________________________
public RotateFerrisWheel()
{
	FerrisWheelAngle+=36;
	if(FerrisWheelAngle>=360)FerrisWheelAngle=0;
	if(FerrisWheelAlternate)FerrisWheelAlternate=0;
	else FerrisWheelAlternate=1;
	new Float:FerrisWheelModZPos=0.0;
	if(FerrisWheelAlternate)FerrisWheelModZPos=0.05;
	MoveObject(FerrisWheelObjects[10],389.7734,-2028.4688,22.0+FerrisWheelModZPos,FERRIS_WHEEL_SPEED,0,FerrisWheelAngle,90);
}
