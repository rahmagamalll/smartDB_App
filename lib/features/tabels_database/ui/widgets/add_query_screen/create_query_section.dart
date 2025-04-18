import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';
import 'package:software_project/core/routing/routes.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';
import 'package:software_project/features/tabels_database/logic/add_query/add_query_cubit.dart';

class CreateQuerySection extends StatefulWidget {
  const CreateQuerySection({super.key});

  @override
  State<CreateQuerySection> createState() => _CreateQuerySectionState();
}

class _CreateQuerySectionState extends State<CreateQuerySection> {
  final TextEditingController whereClauseController = TextEditingController();
  List<String> tableNames = [];
  String? selectedTable;

  @override
  void initState() {
    super.initState();
    loadTables();
  }

  Future<void> loadTables() async {
    tableNames = await SqlDb().getAllTableNames();
    setState(() {});
  }

  @override
  void dispose() {
    whereClauseController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddQueryCubit, AddQueryState>(
      listener: (context, state) {
        if (state is AddQuerySuccess) {
          context.pushNamed(Routes.showQueryScreen, arguments: state.data);
        } else if (state is AddQueryFailuer) {
          CustomSnackBar.show(context, 'Error: ${state.errMessage}');
        } else if (state is AddQueryLoading) {
          CircularProgressIndicator();
        }
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropDown(
                  hint: 'Choose Table',
                  itemsDrop: tableNames,
                  selectedOption: selectedTable,
                  onChanged: (value) {
                    setState(() {
                      selectedTable = value;
                    });
                  },
                ),
                verticalSpacing(30),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.primaryColor.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: CustomTextFormField(
                    controller: whereClauseController,
                    hintStyle: TextStylesManager.font14MediumGrayRegular,
                    contentPadding: EdgeInsets.all(16.h),
                    borderRadius: BorderRadius.circular(10.r),
                    hintText: 'Enter your query',
                  ),
                ),
                verticalSpacing(30),
                if (selectedTable != null)
                  CustomElevationButton(
                    title: 'Show Query',
                    onPressed: () {
                      if (selectedTable == null) {
                        CustomSnackBar.show(context, 'Please select a table');
                        return;
                      }

                      context.read<AddQueryCubit>().AddQuery(
                            tableName: selectedTable!,
                            whereClause: whereClauseController.text,
                          );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
