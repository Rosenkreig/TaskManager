import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/app/core/utils/extensions.dart';
import 'package:taskmanager/app/core/values/colors.dart';
import 'package:taskmanager/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty ?
        ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.0.wp,
              ),
              child: Text('Completed(${homeCtrl.doneTodos.length})',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color : Colors.grey,
                )),
            ),
              ...homeCtrl.doneTodos
              .map((element) => Dismissible(
                key: ObjectKey(element),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(0.9),
                        Colors.red.withOpacity(0.5),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 4.0.wp),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.0.wp,
                    horizontal: 8.0.wp,
                  ),
                  child: Row(children: [
                    const SizedBox(width: 20, height: 20,
                    child: Icon(
                      Icons.done,
                      color: blue,
                      ),),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0.wp,
                      ),
                      child: Text(element['title'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough
                        )),
                    ),
                  ],),
                ),
              )).toList()
          ],
        ) : Container()
    );
  }
}