#define MAX_DRUGS                   3500
#define DRUG_PRICE                  7000

#define FAZENDADROGAS1              14
#define FAZENDADROGAS2              15
#define FAZENDADROGAS3              13

enum plantInfo
{
    plantTime,
    plantAmount,
    Float:plantPos[3],
    plantChance,
    plantPlace
}
new Plantacao[10][plantInfo] = {
//Montanha
{-1, 3, {-1418.3978, -949.86834, 201.0937}, 10, FAZENDADROGAS1},
{-1, 1, {-1431.4990, -956.83148, 200.9474},  6, FAZENDADROGAS1},
{-1, 3, {-1422.9287, -963.55572, 200.7872}, 10, FAZENDADROGAS1},
//Chilliad
{-1, 2, {-2822.0036, -1512.2075, 139.2890}, 16, FAZENDADROGAS2},
{-1, 1, {-2825.7204, -1512.3270, 139.2890}, 14, FAZENDADROGAS2},
{-1, 4, {-2828.5805, -1520.5915, 139.1290}, 20, FAZENDADROGAS2},
//Rodovia
{-1, 2, {1582.89196, 25.9893640, 23.97161}, 10, FAZENDADROGAS3},
{-1, 1, {1583.41699, 33.0118710, 24.39581},  8, FAZENDADROGAS3},
{-1, 1, {1563.86169, 30.6187530, 24.16406},  8, FAZENDADROGAS3},
{-1, 3, {1550.95324, 17.7707950, 24.13581}, 12, FAZENDADROGAS3}
};

new PlantacaoObj[21],
    Float:PlantacaoObjFinalPos[sizeof(PlantacaoObj)][3],
    Text3D:PlantacaoText[sizeof(Plantacao)];