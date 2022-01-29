class StringFormatDate{

  String dataFormat(String data){

    List<String> MMddyy = data.split("/");

    if( MMddyy[1].length < 2) MMddyy[1] = "0"+MMddyy[1];

    if(MMddyy[0].length < 2) MMddyy[0] = "0"+MMddyy[0];

    data = MMddyy[1]+"/"+MMddyy[0]+"/20"+MMddyy[2];
    return data;
  }
}