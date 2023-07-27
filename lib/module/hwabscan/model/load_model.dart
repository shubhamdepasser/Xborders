// To parse this JSON data, do
//
//     final loadModule = loadModuleFromJson(jsonString);

import 'dart:convert';

LoadModule loadModuleFromJson(String str) => LoadModule.fromJson(json.decode(str));

String loadModuleToJson(LoadModule data) => json.encode(data.toJson());

class LoadModule {
    LoadModule({
        this.htmlMessage,
        this.status,
    });

    String htmlMessage;
    String status;

    factory LoadModule.fromJson(Map<String, dynamic> json) => LoadModule(
        htmlMessage: json["html_message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_message": htmlMessage,
        "status": status,
    };
}


//  var output = await LoadDetailController.LoadData(barcodeScanRes,  controller.userModel.value == null
//                                                 ? ''
//                                                 : controller
//                                                     .userModel
//                                                     .value.omDataArray[0].bagId.toString()
                                                    
//           '9261290260113728188435'
//           );
//       print(output);
//       print('ggggg');
//      print(barcodeScanRes);
//       print(await invardDetailController.invardgetData("1", barcodeScanRes));
//       print("output");
      
//       if (output['html_message'] == 'Moved Into the Bag Already Done') {
//         print('print scanner herereeeeeeeeeeeeeeeee');
//         Get.toNamed(RoutesApp.Baglable);
        
//         }else if(output['html_message'] == 'Invalid Bag ID.' ){

//           ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content:
//                                       const Text('Invalid Bag ID.'),
//                                 ));; 
//         }
//         else if(output['html_message'] == 'Data Does Not Exist.'){
//            ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content:
//                                       const Text('Invalid Bag ID.'),
//                                 ));; 
//         }else {
//           return "";
//         }