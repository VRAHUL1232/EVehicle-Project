class Car{
  final String name;
  final bool ac;
  final bool dc;
  final carType type;
  const Car({required this.name,required this.type, required this.ac, required this.dc});
}

enum carType{
    AC_TYPE_1 ,
    AC_Type_2,
    DC001,
    CCS_1,
    CCS_2,
    Bharat_AC001,
    Bharat_DC001,
    AC_PLUG_PNT,
    CHAdeMO,
    Tesla_Charger,
    GBT
}

Map<carType, String> carTypeMap = {
    carType.AC_TYPE_1: "AC Type 1",
    carType.AC_Type_2: "AC Type 2",
    carType.DC001: "DC001",
    carType.CCS_1: "CCS 1",
    carType.CCS_2: "CCS 2",
    carType.Bharat_AC001: "Bharat AC001",
    carType.Bharat_DC001: "Bharat DC001",
    carType.AC_PLUG_PNT: "AC Plug Point",
    carType.CHAdeMO: "CHAdeMo",
    carType.Tesla_Charger: "Tesla Charger",
    carType.GBT: "GB/T"
};