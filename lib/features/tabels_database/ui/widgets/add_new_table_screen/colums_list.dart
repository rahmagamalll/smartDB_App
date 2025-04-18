import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';
import 'package:software_project/features/tabels_database/logic/add_new_table/add_new_table_cubit.dart';
import 'package:software_project/features/tabels_database/ui/widgets/add_new_table_screen/add_colum_in_table.dart';

class ColumnsList extends StatefulWidget {
  const ColumnsList({super.key});

  @override
  State<ColumnsList> createState() => _ColumnsListState();
}

class _ColumnsListState extends State<ColumnsList> {
  List<Map<String, String>> columns = [];
  final List<GlobalKey<AddColumInTableState>> fieldKeys = [];

  void addColumn() {
    setState(() {
      columns.add({'name': '', 'type': ''});
      fieldKeys.add(GlobalKey<AddColumInTableState>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewTableCubit, AddNewTableState>(
      listener: (context, state) {
        if (state is AddNewTableSuccess) {
          context.read<AddNewTableCubit>().tableNameController.clear();
          context.pop();
          CustomSnackBar.show(context, state.message);
        } else if (state is AddNewTableFailuer) {
          CustomSnackBar.show(context, state.errMessage, isError: true);
        } else if (state is AddNewTableLoading) {
          const CircularProgressIndicator();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: columns.length + 1,
              itemBuilder: (context, index) {
                if (index == columns.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomElevationButton(
                        widthOfButton: 120.w,
                        heightOfButton: 50,
                        borderRadiusGeometry: BorderRadius.circular(10.r),
                        title: 'Add Column',
                        onPressed: addColumn,
                      ),
                    ),
                  );
                }
                if (columns.length == fieldKeys.length) {
                  return AddColumInTable(
                    key: fieldKeys[index],
                    onColumnNameChanged: (value) {
                      columns[index]['name'] = value;
                    },
                    onDataTypeChanged: (value) {
                      columns[index]['type'] = value;
                    },
                  );
                }
                return null;
              },
            ),
          ),
          verticalSpacing(10),
          CustomElevationButton(
            title: 'Create Table',
            onPressed: () {
              bool isValid = true;

              for (var key in fieldKeys) {
                if (!key.currentState!.validate()) {
                  isValid = false;
                }
              }

              if (!isValid) {
                CustomSnackBar.show(context,
                    'Please complete all fields before creating the table.',
                    isError: true);
                return;
              }

              Map<String, String> columnMap = {
                for (var col in columns) col['name']!: col['type']!
              };

              context.read<AddNewTableCubit>().createTable(columnMap);
            },
          ),
        ],
      ),
    );
  }
}
