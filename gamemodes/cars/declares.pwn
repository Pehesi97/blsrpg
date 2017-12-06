enum vehInfo {
    // Banco
    vId,
    vModel,
    vType,
    vPrice,
    vCashPrice,
    vName,
    vOwner,
    vHouse,
    vOrg,
    Float:cx,
    Float:cy,
    Float:cz,
    Float:ca,
    vColor1,
    vColor2,
    vPaintJob,
    bool:vBusted,
    vPlate[32],
    bool:vParked,
    vRadio[80],
    bool:vUseGas,
    vWindows,
    vGalons,

    //Runtime
    vEngine,
    vGas
}
new Vehicles[MAX_VEHICLES][vehInfo];

