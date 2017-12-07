// Milestones
#define DIALOG_MILESTONES   28679
#define DIALOG_REPMILESTONE 28680
#define DIALOG_INFMILESTONE 28681

#define MilNonRepGrana   	2000
#define MilNonRepResp       3
#define MilNonRepCash       0

#define Mil1Grana   		1000
#define Mil1Resp            1
#define Mil1Cash            0

#define Mil2Grana   		2500
#define Mil2Resp            2
#define Mil2Cash            0

#define Mil3Grana   		6000
#define Mil3Resp      		3
#define Mil3Cash            0

#define Mil4Grana   		10000
#define Mil4Resp            4
#define Mil4Cash    		100

forward CompletarNonRepMilestone(playerid, id);

enum nonRepeatInfo
{
	milTask[48],
	milHint[128]
}

new MilNonRepeatTasks[5][nonRepeatInfo] = {
	{ "Usar o Pacote Iniciante", "Use o comando /pacoteiniciante para receber seu presente!"},
	{ "Usar o GPS com sucesso", "Use o comando /gps para ir até a Prefeitura." },
	{ "Conseguir um emprego", "Você pode fazer isso na Prefeitura. /gps -> Locais Importantes -> Prefeitura" },
	{ "Passar no teste de direção terrestre", "Você pode fazer isso na AutoEscola. /gps -> Locais Importantes -> Auto Escola" },
	{ "Entrar em uma organização", "Compre uma agenda e um celular na 24-7, depois ligue para um líder de organização." }
};

/*new Text:Milestone = Text:INVALID_TEXT_DRAW;
new Text:MilTask1 = Text:INVALID_TEXT_DRAW;
new Text:MilTask2 = Text:INVALID_TEXT_DRAW;*/

enum milInfo
{
	task1[30],
	task2[30],
}

/*new Mil1Tasks[6][milInfo] = {
	{ "Dominar um", "Territorio" },
	{ "Colocar neon", "em um veiculo" },
	{ "Matar Inimigo", "em gz" },
	{ "Gastar R$2000", "em tuning" },
	{ "Abastecer 80+", "Litros" },
	{ "Consertar Um", "Veiculo" }
};*/