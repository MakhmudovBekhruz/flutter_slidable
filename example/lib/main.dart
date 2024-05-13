import 'package:another_flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Slidable Example',
        home: DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(140),
              child: AppBar(
                automaticallyImplyLeading: false,
                // foregroundColor: AppColors.transparent,
                // shadowColor: AppColors.transparent,
                // backgroundColor: AppColors.transparent,
                toolbarHeight: 100,
                title: const Text('Another flutter slidable'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            thickness: 1,
                          ),
                        ),
                      ),
                      TabBar(
                        onTap: (value) {
                          if (value == 1) {}
                        },
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const <Widget>[
                          Tab(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Tab 1',

                                  /// Keep the default `TextStyle` to apply text color from parent element
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Tab(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Tab 2',

                                  /// Keep the default `TextStyle` to apply text color from parent element
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              // physics: const NeverScrollableScrollPhysics(),

              children: <Widget>[
                ListView(
                  // controller: _scrollController,
                  children: [
                    Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      // startActionPane: ActionPane(
                      //   // A motion is a widget used to control how the pane animates.
                      //   motion: const ScrollMotion(),

                      //   // A pane can dismiss the Slidable.
                      //   dismissible: DismissiblePane(onDismissed: () {}),

                      //   // All actions are defined in the children parameter.
                      //   children: const [
                      //     // A SlidableAction can have an icon and/or a label.
                      //     SlidableAction(
                      //       onPressed: doNothing,
                      //       backgroundColor: Color(0xFFFE4A49),
                      //       foregroundColor: Colors.white,
                      //       icon: Icons.delete,
                      //       label: 'Delete',
                      //     ),
                      //     SlidableAction(
                      //       onPressed: doNothing,
                      //       backgroundColor: Color(0xFF21B7CA),
                      //       foregroundColor: Colors.white,
                      //       icon: Icons.share,
                      //       label: 'Share',
                      //     ),
                      //   ],
                      // ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: (_) => controller.openStartActionPane(),
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: (_) => controller.close(),
                            backgroundColor: const Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: const ListTile(title: Text('Slide me'))),
                    ),
                    Slidable(
                      controller: controller,
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(1),

                      // The start action pane is the one at the left or the top side.
                      // startActionPane: const ActionPane(
                      //   // A motion is a widget used to control how the pane animates.
                      //   motion: ScrollMotion(),

                      //   // All actions are defined in the children parameter.
                      //   children: [
                      //     // A SlidableAction can have an icon and/or a label.
                      //     SlidableAction(
                      //       onPressed: doNothing,
                      //       backgroundColor: Color(0xFFFE4A49),
                      //       foregroundColor: Colors.white,
                      //       icon: Icons.delete,
                      //       label: 'Delete',
                      //     ),
                      //     SlidableAction(
                      //       onPressed: doNothing,
                      //       backgroundColor: Color(0xFF21B7CA),
                      //       foregroundColor: Colors.white,
                      //       icon: Icons.share,
                      //       label: 'Share',
                      //     ),
                      //   ],
                      // ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: const [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: const ListTile(title: Text('Slide me 1')),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: const [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: (_) => controller.openEndActionPane(),
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: (_) => controller.close(),
                            backgroundColor: const Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: const ListTile(title: Text('Slide me2')),
                    ),
                    Slidable(
                      controller: controller,
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(1),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: const ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: ScrollMotion(),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          const SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: (c) {},
                            backgroundColor: const Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: const ListTile(title: Text('Slide me3')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  // _getActiveColor() {
  //   return _currentIndex == 0 ? AppColors.primary100 : AppColors.green;
  // }
}

void doNothing(BuildContext context) {}
