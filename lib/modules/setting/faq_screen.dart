import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../widgets/app_bar_leading.dart';
import 'component/faq_list_widget.dart';
import 'controllers/faq_cubit/faq_cubit.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<FaqCubit>().getFaqList();
    const double appBarHeight = 120;
    return Scaffold(
      backgroundColor: scaffoldBGColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // expandedHeight: appBarHeight,

            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: scaffoldBGColor),
            title: Text(
              Language.faq,
              style: const TextStyle(color: blackColor),
            ),
            titleSpacing: 0,
            leading: const AppbarLeading(),
            // flexibleSpace: const FaqAppBar(height: appBarHeight),
          ),
          //const SliverToBoxAdapter(child: SizedBox(height: 30)),
          BlocBuilder<FaqCubit, FaqCubitState>(
            builder: (context, state) {
              if (state is FaqCubitStateLoaded) {
                return FaqListWidget(faqList: state.faqList);
              } else if (state is FaqCubitStateLoading) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is FaqCubitStateError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: redColor),
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),
        ],
      ),
    );
  }

  Widget buildBody(double appBarHeight) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: appBarHeight,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: scaffoldBGColor),
          title: Text(
            Language.faq,
            style: const TextStyle(color: blackColor),
          ),
          titleSpacing: 0,
          leading: const AppbarLeading(),
          // flexibleSpace: const FaqAppBar(height: appBarHeight),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
