import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:taskmanager/app/core/utils/extensions.dart';
import 'package:taskmanager/app/modules/details/widgets/doing_list.dart';
import 'package:taskmanager/app/modules/details/widgets/done_list.dart';
import 'package:taskmanager/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task?.color ?? '#FFFFFF');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
      
                        homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                        homeCtrl.editCtrl.clear();
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0.wp,
                ),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        task?.icon ?? Icons.help_outline.codePoint,
                        fontFamily: 'MaterialIcons',
                      ),
                    color: color,
                    ),
                    SizedBox(width: 4.0.wp,),
                    Text(task?.title ?? 'Task',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ))
                  ],
                ),
              ),
              Obx(() {
                var totalTodos = homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16.0.wp,
                    right: 16.0.wp,
                    top: 4.0.wp,
          
                  ),
                  child: Row(
                    children: [
                      Text('$totalTodos Tasks',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: Colors.grey,
                        )),
                        SizedBox(width: 4.0.wp,),
                        Expanded(child: 
                        StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeCtrl.doneTodos.length,
                          size : 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.5), color],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!],
                          ),
                        )
                        )
          
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0.wp,
                  horizontal: 4.0.wp,
                  ),
                child: TextFormField(
                  controller: homeCtrl.editCtrl,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if(homeCtrl.formKey.currentState!.validate()) {
                          var success = homeCtrl.addTodo(homeCtrl.editCtrl.text);
                          if(success){
                            EasyLoading.showSuccess('Todo Item Add Success');
                          } else{
                            EasyLoading.showError('Todo Item Already Exist');
                          }
                          homeCtrl.editCtrl.clear();
                        }
                      },
                      icon: const Icon(Icons.done),)),
                  validator: (value) {
                    if(value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        )),
    );
  }
}