import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_awesome_web_names/flutter_font_awesome.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/remote_urls.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '/widgets/custom_image.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import 'controllers/about_us_cubit/about_us_cubit.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AboutUsCubit>().getAboutUs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
          titleText: Language.aboutUs.capitalizeByWord(),
          bgColor: scaffoldBGColor),
      body: BlocBuilder<AboutUsCubit, AboutUsState>(
        builder: (context, state) {
          if (state is AboutUsStateLoaded) {
            final aboutInfo = state.aboutInfo;
            print(
                'Testimonial Length is: ${state.aboutInfo.testimonials.length}');
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 0),
              children: [
                Text(Language.aboutUs.capitalizeByWord(),
                    style: GoogleFonts.inter(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                    textAlign: TextAlign.center),
                const SizedBox(height: 30.0),
                if (aboutInfo.aboutUsModel != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIntro(aboutInfo.aboutUsModel!.iconTwo,
                          aboutInfo.aboutUsModel!.titleTwo),
                      _buildIntro(aboutInfo.aboutUsModel!.iconThree,
                          aboutInfo.aboutUsModel!.titleThree),
                      _buildIntro(aboutInfo.aboutUsModel!.iconOne,
                          aboutInfo.aboutUsModel!.titleOne),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  CustomImage(
                      path: RemoteUrls.imageUrl(
                          aboutInfo.aboutUsModel!.bannerImage),
                      // height: 200,
                      fit: BoxFit.cover),
                  Html(
                    data: aboutInfo.aboutUsModel!.aboutUs,
                    style: {
                      "table": Style(
                        backgroundColor:
                            const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                      ),
                      "tr": Style(
                        border: const Border(
                            bottom: BorderSide(color: Colors.grey)),
                      ),
                      "th": Style(
                        // padding: const EdgeInsets.all(6),
                        fontSize: FontSize.medium,
                        backgroundColor: Colors.grey,
                      ),
                      "td": Style(
                        // padding: const EdgeInsets.all(6),
                        alignment: Alignment.topLeft,
                      ),
                      'h1': Style(
                        maxLines: 2,
                        margin: Margins.symmetric(horizontal: 10.0),
                        color: Colors.black,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        fontSize: FontSize.xLarge,
                        padding: HtmlPaddings.zero,
                      ),
                      'li': Style(
                          // color: Colors.green,
                          margin: Margins.zero),
                      'ul': Style(
                        // color: Colors.green,
                        margin: Margins.only(top: 14),
                        color: textGreyColor,
                        listStyleType: ListStyleType.none,
                      ),
                      'p': Style(
                        lineHeight: LineHeight.normal,
                        textAlign: TextAlign.justify,
                        margin: Margins.only(top: 4.0, left: 10.0, right: 10.0),
                        fontSize: FontSize.medium,
                        color: textGreyColor,
                      ),
                    },
                  ),
                  Text('Customer Review',
                      style: GoogleFonts.inter(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2),
                      textAlign: TextAlign.center),
                ],
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        aboutInfo.testimonials.length,
                        (index) {
                          final result = aboutInfo.testimonials[index];
                          int countRating = int.parse(result.rating);
                          return Container(
                            height: 240.0,
                            width: 200.0,
                            margin: const EdgeInsets.only(right: 20.0),
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                  color: Utils.dynamicPrimaryColor(context)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      ...List.generate(
                                          countRating,
                                          (index) => const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18.0,
                                              )),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        '(${result.rating})',
                                        style: GoogleFonts.inter(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            color: textGreyColor),
                                      )
                                    ]),
                                    const SizedBox(height: 10.0),
                                    SizedBox(
                                      height: 115.0,
                                      child: Text(result.comment,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.inter(
                                              fontSize: 12.0,
                                              color: textGreyColor,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          minRadius: 22,
                                          backgroundImage: NetworkImage(
                                              RemoteUrls.imageUrl(
                                                  result.image)),
                                        ),
                                        const SizedBox(width: 5.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(result.name,
                                                style: GoogleFonts.inter(
                                                    fontSize: 16.0,
                                                    color: blackColor,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(
                                              result.designation,
                                              style: GoogleFonts.inter(
                                                fontSize: 12.0,
                                                color: textGreyColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0)
              ],
            );
          } else if (state is AboutUsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AboutUsStateError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildIntro(String icon, String title) {
    return Column(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          margin: const EdgeInsets.only(bottom: 4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Utils.dynamicPrimaryColor(context),
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            icon,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        Text(title),
        // Expanded(child: Text(aboutInfo.descriptionOne)),
        // Html(data: aboutInfo.descriptionOne,style: {
        //   'tr':Style(
        //     fontSize: FontSize.medium
        //   ),
        //   'th':Style(
        //       fontSize: FontSize.medium
        //   ),
        //   'td':Style(
        //       fontSize: FontSize.medium
        //   ),
        // },)
      ],
    );
  }
}
