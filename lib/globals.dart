library myApp.globals;

bool isLoggedIn = false;
String sk1 = "";
String sk2 = "";
String id = "";
String server = "production";
String CompanyType = "";

getUrl (String getUrl) {
  if(server == "production"){
    return "https://bulundum.com/api/v3/$getUrl";
  }else{
    return "https://dev.bulundum.com/api/v3/$getUrl";
  }
}