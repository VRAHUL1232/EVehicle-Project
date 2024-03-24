class Location{
  final String name;
  final String address;
  final double latCord;
  final double longCord;
  final bool acType1;
  final bool acType2;
  final bool dc001;
  final bool ccs1;
  final bool ccs2;
  final bool bharatAc001;
  final bool bharatDc001;
  final bool ac001;
  final bool chademo;
  final bool teslaCharger;
  final bool gbt;
  final bool acplugpnt;
  final double powerRating;
  final double reviewRating;
  final bool acsource;
  final bool dcsource;

  Location({
    required this.name,
    required this.address,
    required this.latCord,
    required this.longCord,
    required this.acType1,
    required this.acType2,
    required this.dc001,
    required this.ccs1,
    required this.ccs2,
    required this.bharatAc001,
    required this.bharatDc001,
    required this.ac001,
    required this.chademo,
    required this.teslaCharger,
    required this.gbt,
    required this.acplugpnt,  
    required this.powerRating,
    required this.reviewRating,
    required this.acsource,
    required this.dcsource
  });
}