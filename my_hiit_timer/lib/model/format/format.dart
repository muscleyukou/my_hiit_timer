String formatType(Duration duration){
  String minutes=(duration.inSeconds).toString().padLeft(2,'0');
  String seconds=(duration.inSeconds%60).toString().padLeft(2,'0');
     return '$minutes:$seconds';
}