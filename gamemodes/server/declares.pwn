#include	<a_samp>
#include	<a_sampdb>
#include    <sscanf2>
#include    <izcmd>
#include    <dof2>
#include    <foreach>
#include	<a_npc>
#include	<core>
#include	<file>
#include	<float>
#include	<streamer>
#include	<time>
#include    <removebuilding>
#include 	<mapandreas>
#include    <skinchanging>
#include    <crashdetect>
#include	<strlib>
#include    <jamelao>

#include	"gamemodes/db/db.pwn"

native IsValidVehicle(vehicleid);

//----------------------------------------------------------------//
//*************************** Defines ****************************//
//----------------------------------------------------------------//
// Vida e Colete
#define COR_TEXTDRAW00              0xFFFFFFFF
#define COR_TEXTDRAW01              0xFFFFFFFF

#define ANNOUNCE_URL                "monitor.sacnr.com/api/?Action=announce"
#define LOG_PREFIX                  "[SACNR Monitor] "

#define HTTP_CREATED                201
#define HTTP_FORBIDDEN				403
#define HTTP_UNPROCESSABLE_ENTITY   422
#define HTTP_TOO_MANY_REQUESTS      429

#undef MAX_VEHICLES
#define MAX_VEHICLES    		    1500
#define MAX_BOUGHT_VEHICLES 	    500

#undef MAX_PLAYERS
#define MAX_PLAYERS                 50

#define SITE_URL                    "www.blsrpg.com.br"
#define	GM_NAME			            "Brasil Life Simulation RPG"
#define GMVERSION		            "v2.2.6"
#define BUILT                       20170129
#define GMDATE  		            "29 de Janeiro de 2017"

#define APRE_FILE                   "/RPG/Carros/Apreendidos.ini"
#define RECORD_FILE                 "/RPG/logs/Recorde.ini"
#define ConfigFile                  "/RPG/logs/config.cfg"
#define ZonesFile                   "/RPG/logs/zones.ini"

#define PixFile                     "/RPG/piches/Saves.ini"
#define OrgDrugFile                 "/RPG/orgs/GangDrogas.ini"
#define GuerraFile                  "/RPG/orgs/GuerraFile.ini"

#define MAX_ORGS                    18
#define USE_COMMANDS   	            1

#define MAX_MODS     	            12
#define TEMPO_ESCONDENDO            120

#define HUD_INDEX   	            500
#define HUD_INDEX2  	            270

#define GasMax 			            100
#define RefuelWait 		            5000
#define CONTRACT_TIME               1800

#define MAX_LOGIN_FAILS             4

#define ROB_CASH_MIN                3000
#define ROB_CASH_MAX		        8000

#define ATM_CASH_MIN                3000
#define ATM_CASH_MAX                8000

#define LOTTO_NUM                   200

//Algumas Funções
#define public:do%0(%1) \
        forward%0(%1); \
        public%0(%1)

#define GetVehicleParamsNew(%0) \
        new engine, lights, alarm, doors, bonnet, boot, objective; \
        GetVehicleParamsEx(%0, engine, lights, alarm, doors, bonnet, boot, objective)

#define GetVehicleParams(%0) \
        GetVehicleParamsEx(%0, engine, lights, alarm, doors, bonnet, boot, objective)

new Float:KHM_MULTIPLIER  = 136.666667;