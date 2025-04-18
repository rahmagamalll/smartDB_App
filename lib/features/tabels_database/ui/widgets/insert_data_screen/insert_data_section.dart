import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';
import 'package:software_project/features/tabels_database/logic/insert_data/insert_data_cubit.dart';
import 'package:software_project/features/tabels_database/ui/widgets/insert_data_screen/column_data_input.dart';

class InsertDataSetion extends StatefulWidget {
  const InsertDataSetion({super.key});

  @override
  State<InsertDataSetion> createState() => _InsertDataSetionState();
}

class _InsertDataSetionState extends State<InsertDataSetion> {
  List<String> tableNames = [];
  List<String> columnNames = [];
  List<String> columntypes = [];
  List<TextEditingController> controllers = [];
  String? selectedTable;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    tableNames = await SqlDb().getAllTableNames();
    setState(() {});
  }

  Future<void> loadTableColumns(String tableName) async {
    columnNames = await SqlDb().getTableColumns(tableName);
    columntypes = await SqlDb().getTableColumnsTypes(tableName);
    controllers =
        List.generate(columnNames.length, (_) => TextEditingController());
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InsertDataCubit, InsertDataState>(
      listener: (context, state) {
        if (state is InsertDataSuccess) {
          context.pop();
          CustomSnackBar.show(context, state.message);
        } else if (state is InsertDataFailuer) {
          CustomSnackBar.show(context, state.message, isError: true);
        } else if (state is InsertDataLoading) {
            CircularProgressIndicator();
        }
      },
      child: Column(
        children: [
          CustomDropDown(
            hint: 'Choose Table',
            selectedOption: selectedTable,
            itemsDrop: tableNames,
            onChanged: (value) async {
              selectedTable = value;
              await loadTableColumns(selectedTable!);
            },
          ),
          verticalSpacing(20),
          if (selectedTable == null)
            Center(
              child: Text(
                'Please select a table.',
                style: TextStylesManager.font16MediumGrayRegular,
              ),
            )
          else if (columnNames.isEmpty)
            Center(
              child: Text(
                'No columns found for this table.',
                style: TextStylesManager.font16MediumGrayRegular,
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: columnNames.length,
                itemBuilder: (context, index) {
                  return ColumnDataInput(
                    columnName: columnNames[index],
                    columnType: columntypes[index],
                    controller: controllers[index],
                    onDataEntered: (data) {
                      print('Data for ${columnNames[index]}: $data');
                    },
                  );
                },
              ),
            ),
          verticalSpacing(10),
          if (selectedTable != null && columnNames.isNotEmpty)
            CustomElevationButton(
              title: 'Insert Data',
              onPressed: () {
                bool allValid = true;
                for (int i = 0; i < columnNames.length; i++) {
                  String value = controllers[i].text;
                  String type = columntypes[i];
                  if (!isValidInput(value, type)) {
                    allValid = false;
                    CustomSnackBar.show(
                      context,
                      'Invalid input for column "${columnNames[i]}": expected $type',
                      isError: true,
                    );
                    break;
                  }
                }
                data = {
                  for (int i = 0; i < columnNames.length; i++)
                    columnNames[i]: controllers[i].text,
                };
                if (allValid) {
                  context
                      .read<InsertDataCubit>()
                      .insertData(table: selectedTable!, data: data);
                }
              },
            ),
        ],
      ),
    );
  }
}

bool isValidInput(String input, String type) {
  switch (type.toUpperCase()) {
    case 'INTEGER':
      return int.tryParse(input) != null;
    case 'REAL':
    case 'DOUBLE':
    case 'FLOAT':
      return double.tryParse(input) != null;
    case 'TEXT':
    case 'VARCHAR':
      return true;
    case 'BOOLEAN':
      return input.toLowerCase() == 'true' || input.toLowerCase() == 'false';
    default:
      return true;
  }
}
