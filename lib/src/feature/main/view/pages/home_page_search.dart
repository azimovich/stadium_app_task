import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stadium_app_task/src/feature/main/view/widgets/home_page_search_card_widget.dart';
import 'package:stadium_app_task/src/feature/main/view_model/home_vm.dart';

class HomePageSearch extends ConsumerWidget {
  const HomePageSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox.expand(
      child: Consumer(
        builder: (context, ref, _) {
          final ctr = ref.watch(homeFetchData);
          return ctr.when(
            data: (date) => ListView.separated(
              padding: REdgeInsets.all(25),
              itemBuilder: (_, i) => HomePageSearchCardWidget(
                stadiumModel: ref.watch(homeVM).stadiumList[i],
              ),
              separatorBuilder: (_, i) => 10.verticalSpace,
              itemCount: ref.watch(homeVM).stadiumList.length,
            ),
            error: (error, stackTrace) => Text("Error: $error"),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
