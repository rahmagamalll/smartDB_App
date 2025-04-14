import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';

import 'package:software_project/features/tabels_database/logic/insert_data/insert_data_cubit.dart';
import 'package:software_project/features/tabels_database/ui/widgets/insert_data_screen/column_data_input.dart';

class InsertDataSetion extends StatelessWidget {
  const InsertDataSetion({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InsertDataCubit>();

    return BlocListener<InsertDataCubit, InsertDataState>(
        listener: (context, state) {
      if (state is InsertDataSuccess) {
        context.pop();
        CustomSnackBar.show(context, state.message);
      } else if (state is InsertDataError) {
        CustomSnackBar.show(context, state.message, isError: true);
      } else if (state is InsertDataLoading) {
        CustomSnackBar.show(context, 'inserting data...');
      }
    }, child: BlocBuilder<InsertDataCubit, InsertDataState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomDropDown(
              hint: 'Choose Table',
              selectedOption: cubit.selectedTable,
              itemsDrop: cubit.tableNames,
              onChanged: (value) {
                cubit.selectTable(value!);
              },
            ),
            verticalSpacing(20),
            if (cubit.selectedTable != null && cubit.columnNames.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.columnNames.length,
                  itemBuilder: (context, index) {
                    return ColumnDataInput(
                      columnName: cubit.columnNames[index],
                      columnType: cubit.columnNames[index],
                      controller: cubit.controllers[index],
                      onDataEntered: (data) {
                        print('Data for ${cubit.columnNames[index]}: $data');
                      },
                    );
                  },
                ),
              ),
            if (cubit.selectedTable == null || cubit.columnNames.isEmpty)
              Center(
                child: Text(
                  'Please select a table to load columns.',
                  style: TextStylesManager.font16MediumGrayRegular,
                ),
              ),
            verticalSpacing(10),
            if (cubit.selectedTable != null && cubit.columnNames.isNotEmpty)
              CustomElevationButton(
                title: 'Insert Data',
                onPressed: () {
                  cubit.insertData();
                },
              ),
          ],
        );
      },
    ));
  }
}
