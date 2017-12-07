//Eleição
new VotacaoPickup,
    Text3D:VotacaoText,
    VotacaoID,
    bool:VotacaoAberta;

enum CandidatoInf
{
    candNome[MAX_PLAYER_NAME],
    candNumero,
    candVotos
}
new CandidatoInfo[25][CandidatoInf];
